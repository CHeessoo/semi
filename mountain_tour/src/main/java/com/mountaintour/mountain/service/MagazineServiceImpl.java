package com.mountaintour.mountain.service;

import java.io.File;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.stream.Collectors;

import javax.servlet.http.HttpServletRequest;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.mountaintour.mountain.dao.MagazineMapper;
import com.mountaintour.mountain.dto.MagazineDto;
import com.mountaintour.mountain.dto.MagazineMultiDto;
import com.mountaintour.mountain.dto.MagazineStarDto;
import com.mountaintour.mountain.dto.ProductDto;
import com.mountaintour.mountain.util.MagazineFileUtils;
import com.mountaintour.mountain.util.MyPageUtils;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class MagazineServiceImpl implements MagazineService {
  
  private final MagazineMapper magazineMapper;
  private final MyPageUtils myPageUtils;
  private final MagazineFileUtils magazineFileUtils; 
  
  @Transactional(readOnly=true)
  @Override
  public Map<String, Object> getMagazineList(HttpServletRequest request) {
    Optional<String> opt = Optional.of(request.getParameter("page"));
    int page = Integer.parseInt(opt.orElse("1"));
    int total = magazineMapper.getMagazineCount();
    int display = 6;
    
    myPageUtils.setPaging(page, total, display);
    
    Map<String, Object> map = Map.of("begin", myPageUtils.getBegin()
        , "end", myPageUtils.getEnd());

    List<MagazineDto> magazineList = magazineMapper.magazineList(map);
    
    return Map.of("magazineList", magazineList
    , "totalPage", myPageUtils.getTotalPage());
    
  }
  @Transactional(readOnly=true)
  @Override
  public Map<String, Object> loadProductNo() {
    
    List<ProductDto> list = magazineMapper.getProductNo();
    System.out.println(list);
    return Map.of("list", list);
  }
  
  @Override
  public Map<String, Integer> firstUpload(HttpServletRequest request)  {
    
    String title = request.getParameter("title");
    String contents = request.getParameter("contents");
    int userNo = Integer.parseInt(request.getParameter("userNo"));
    int productNo = Integer.parseInt(request.getParameter("productNo"));
    
    MagazineDto magazine = MagazineDto.builder()
                                        .userNo(userNo)
                                        .title(title)
                                        .contents(contents)
                                        .productNo(productNo)
                                        .build();
    int addResult = magazineMapper.insertMagazineOne(magazine);
    
    //매거진 작성시 사용한 이미지 목록(jsoup 라이브러리 사용)
   
      for(String editorImage : getEditorImageList(contents)) {
        MagazineMultiDto magazineMulti = MagazineMultiDto.builder()
                                        .magazineNo(magazine.getMagazineNo())
                                        .multiPath(magazineFileUtils.getMagazineImagePath())
                                        .filesysName(editorImage)
                                        .build();
        magazineMapper.insertMagazineMulti(magazineMulti);
      }
      
     
                          
    return Map.of("addResult",addResult,"magazineNo", magazine.getMagazineNo());
  }
  @Transactional(readOnly=true)
  @Override
  public List<String> getEditorImageList(String contents) {
    List<String> editorImageList = new ArrayList<>();
      
      Document document = Jsoup.parse(contents);
      Elements elements =  document.getElementsByTag("img");
      
      if(elements != null) {
        for(Element element : elements) {
          String src = element.attr("src");
          String filesysName = src.substring(src.lastIndexOf("/") + 1);
          editorImageList.add(filesysName);
        }
      }
      
      return editorImageList;

  }
  
  /**
   * CK에디터로 저장되는 사진(글쓸때)
   */
  @Override
  public Map<String, Object> imageUpload(MultipartHttpServletRequest multipartRequest) {
   
    //이미지가 저장될 경로
    String imagePath = magazineFileUtils.getMagazineImagePath();
    File dir = new File(imagePath);
    if(!dir.exists()) {
     dir.mkdirs(); 
    }
    // 이미지 파일
    MultipartFile upload = multipartRequest.getFile("upload");
    
    //이미지가 저장될 경로 
    String originalFileName = upload.getOriginalFilename();
    String filesysName = magazineFileUtils.getFilesystemName(originalFileName);
    
    File file = new File(dir, filesysName);
    
    try {
      upload.transferTo(file);
    } catch (Exception e) {
      e.printStackTrace();
    }
 // url: "http://localhost:8080/myhome/blog/2023/10/27/파일명"
 // sevlet-context.xml에
 // /blog/** 주소 요청을 /blog 디렉터리로 연결하는 <resources> 태그를 추가해야 함

    return Map.of("uploaded", true
         , "url", multipartRequest.getContextPath() + imagePath + "/" + filesysName); 
    
  }
  /**
   * 썸네일 넣을 때(글쓸때이어서) 
   * 
   */
  @Override
  public boolean addThumbnail(MultipartHttpServletRequest multipartRequest) throws Exception{
    
    String summary = multipartRequest.getParameter("summary");
    int magazineNo = Integer.parseInt(multipartRequest.getParameter("magazineNo")); 
    
    MagazineDto magazine = MagazineDto.builder()
                                    .magazineNo(magazineNo)
                                    .summary(summary)
                                    .build();
    
    int updateResult = magazineMapper.insertMagazineTwo(magazine);
    
    List<MultipartFile> files = multipartRequest.getFiles("files");
    
    // 첨부 없을 때 : [MultipartFile[field="files", filename=, contentType=application/octet-stream, size=0]]
    // 첨부 1개     : [MultipartFile[field="files", filename="animal1.jpg", contentType=image/jpeg, size=123456]]
    
    int attachCount;
    if(files.get(0).getSize() == 0) {
      attachCount = 1;
    } else {
      attachCount = 0;
    }
    
    for(MultipartFile multipartFile : files) {
      
      if(multipartFile != null && !multipartFile.isEmpty()) {
        
        String path = magazineFileUtils.getUploadPath();
        File dir = new File(path);
        if(!dir.exists()) {
          dir.mkdirs();
        }
        
        String filesysName = magazineFileUtils.getFilesystemName(multipartFile.getOriginalFilename());
        File file = new File(dir, filesysName);
        
        multipartFile.transferTo(file);
               
        int isThumbnail = Integer.parseInt(multipartRequest.getParameter("isThumbnail"));
                
        MagazineMultiDto magazineMulti = MagazineMultiDto.builder()
            .magazineNo(magazineNo)
            .filesysName(filesysName)
            .multiPath(path)
            .isThumbnail(isThumbnail)
            .build();
                      
        attachCount += magazineMapper.insertMagazineMulti(magazineMulti);
        
        }  // if
        
        }  // for
        
        return (updateResult == 1) && (files.size() == attachCount);
                

  }
  @Transactional(readOnly=true)
  @Override
  public void loadMagazine(int magazineNo, Model model) {
    model.addAttribute("magazine", magazineMapper.getMagazine(magazineNo));
    model.addAttribute("like", magazineMapper.countLike(magazineNo));
  }
  
  @Override
  public int deleteMagazine(HttpServletRequest request) {
    int magazineNo = Integer.parseInt(request.getParameter("magazineNo")); 
    int deleteResult = magazineMapper.deleteMagazine(magazineNo);       
    return deleteResult;
  }
  /**
   *
   */
  @Override
  public Map<String, Object> firstModify(HttpServletRequest request) {
    String title = request.getParameter("title");
    String contents = request.getParameter("contents");
    int magazineNo = Integer.parseInt(request.getParameter("magazineNo"));
    int productNo = Integer.parseInt(request.getParameter("productNo"));
    
    MagazineDto magazine = MagazineDto.builder()
                                      .magazineNo(magazineNo) 
                                      .title(title)
                                      .contents(contents)
                                      .productNo(productNo)
                                      .build();
    
    int resultModifyOne = magazineMapper.updateModifyOne(magazine);
    
    MagazineDto thumbnail = magazineMapper.getThumbnailInfo(magazineNo);
    
 // DB에 저장된 기존 이미지 가져오기
    // 1. blogImageDtoList : BlogImageDto를 요소로 가지고 있음
    // 2. blogImageList    : 이미지 이름(filesystemName)을 요소로 가지고 있음
    List<MagazineMultiDto> magazineMultiDtoList = magazineMapper.getMagazineMultiList(magazineNo);
    List<String> magazineMultiList = magazineMultiDtoList.stream()
                                          .map(magazineMultiDto -> magazineMultiDto.getFilesysName())
                                          .collect(Collectors.toList());
        
        
      for(int i = 0; i < magazineMultiDtoList.size() ; i++) {
        if( magazineMultiDtoList.get(i).getIsThumbnail() == 0) {
          magazineMapper.updateIsThumbnail(magazineNo);
        }        
      }
        
    // Editor에 포함된 이미지 이름(filesystemName)
    List<String> editorImageList = getEditorImageList(contents);

    // Editor에 포함되어 있으나 기존 이미지에 없는 이미지는 BLOG_IMAGE_T에 추가해야 함
    editorImageList.stream()
      .filter(editorImage -> !magazineMultiList.contains(editorImage))         // 조건 : Editor에 포함되어 있으나 기존 이미지에 포함되어 있지 않다.
      .map(editorImage -> MagazineMultiDto.builder()                           // 변환 : Editor에 포함된 이미지 이름을 BlogImageDto로 변환한다.
                            .magazineNo(magazineNo)
                            .multiPath(magazineFileUtils.getMagazineImagePath())
                            .filesysName(editorImage)
                            .build())     
      .forEach(magazineMultiDto -> magazineMapper.insertMagazineMulti(magazineMultiDto));  // 순회 : 변환된 BlogImageDto를 BLOG_IMAGE_T에 추가한다.
    
    System.out.println(magazineNo+"/"+ magazineFileUtils.getMagazineImagePath()+"/"+ editorImageList );
    
    // 기존 이미지에 있으나 Editor에 포함되지 않은 이미지는 삭제해야 함
    List<MagazineMultiDto> removeList = magazineMultiDtoList.stream()
                                      .filter(magazineMultiDto -> !editorImageList.contains(magazineMultiDto.getFilesysName()))  // 조건 : 기존 이미지 중에서 Editor에 포함되어 있지 않다.
                                      .collect(Collectors.toList());                                                        // 조건을 만족하는 blogImageDto를 리스트로 반환한다.

    for(MagazineMultiDto magazineMultiDto : removeList) {
      // BLOG_IMAGE_T에서 삭제
      if(magazineMultiDto.getIsThumbnail() != 1 ) {
        magazineMapper.deleteMagazineMulti(magazineMultiDto.getFilesysName());
        File file = new File(magazineMultiDto.getMultiPath(), magazineMultiDto.getFilesysName());
        if(file.exists()) {
          file.delete();
        }// 파일명은 UUID로 만들어졌으므로 파일명의 중복은 없다고 생각하면 된다.        
      }
      
      // 파일 삭제
      
    }
    
    return Map.of("resultModify", resultModifyOne, "magazine", thumbnail);
  }
  
  @Override
  public int finalModify(MultipartHttpServletRequest multipartRequest) throws Exception {
    
    String summary = multipartRequest.getParameter("summary");
    int magazineNo = Integer.parseInt(multipartRequest.getParameter("magazineNo"));
    
    MagazineDto magazine = MagazineDto.builder()
                                   .magazineNo(magazineNo)
                                   .summary(summary)
                                   .build();
    
    int modifyResult = magazineMapper.updateModifyTwo(magazine);
    
    List<MultipartFile> files = multipartRequest.getFiles("files");
    
    // 첨부 없을 때 : [MultipartFile[field="files", filename=, contentType=application/octet-stream, size=0]]
    // 첨부 1개     : [MultipartFile[field="files", filename="animal1.jpg", contentType=image/jpeg, size=123456]]
    
    int attachCount;
    if(files.get(0).getSize() == 0) {
      attachCount = 1;
    } else {
      attachCount = 0;
    }
    
      if(files != null && ! files.isEmpty()) {
        
        String path = magazineFileUtils.getUploadPath();
        File dir = new File(path);
        if(!dir.exists()) {
          dir.mkdirs();
        }
        Optional<String> opt = Optional.ofNullable(multipartRequest.getParameter("filesysName"));
        String getMultiName = opt.orElse("****");
        List<MagazineMultiDto> magazineMulti = magazineMapper.getMagazineMultiList(magazineNo);
        String MultiName = magazineMulti.get(0).getFilesysName();
        String filesysName;
        
        if(!getMultiName.equals(MultiName)) {
          
          filesysName = magazineFileUtils.getFilesystemName(files.get(0).getOriginalFilename());
          File file = new File(dir, filesysName);
          
          files.get(0).transferTo(file);
        } else {
          
          filesysName = getMultiName;
        }
        
        int isThumbnail = Integer.parseInt(multipartRequest.getParameter("isThumbnail"));
                
        MagazineMultiDto magazineMultiDto = MagazineMultiDto.builder()
            .magazineNo(magazineNo)
            .filesysName(filesysName)
            .multiPath(path)
            .isThumbnail(isThumbnail)
            .build();
                      
        attachCount += magazineMapper.updateThumbnailFinal(magazineMultiDto);
        
        }  // if
    
        return modifyResult;
  }
  
  @Override
  public int increaseHit(int magazineNo) {  
    return magazineMapper.updateHit(magazineNo);
  }
  
  @Override
  public Map<String, Integer> addLike(HttpServletRequest request) {
    int magazineNo = Integer.parseInt(request.getParameter("magazineNo"));
    int userNo = Integer.parseInt(request.getParameter("userNo"));
    
    MagazineStarDto magazineStarDto = MagazineStarDto.builder()
                                         .magazineNo(magazineNo)
                                         .userNo(userNo)
                                         .build();
    
    int existMaUser = magazineMapper.selectCountLike(magazineStarDto);
    
    if(existMaUser == 1) {
       magazineMapper.deleteLike(magazineStarDto);
    } else {
       magazineMapper.insertLike(magazineStarDto);
    }
    int countLike = magazineMapper.countLike(magazineNo);
    
    
    
    return Map.of("existMaUser", existMaUser, "countLike", countLike);
  }
  
  
}
