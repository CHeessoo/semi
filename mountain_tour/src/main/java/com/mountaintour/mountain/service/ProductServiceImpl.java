package com.mountaintour.mountain.service;

import java.io.File;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.stream.Collectors;

import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import javax.servlet.http.HttpServletRequest;


import org.jsoup.Jsoup;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.mountaintour.mountain.dao.ProductMapper;
import com.mountaintour.mountain.dto.HeartDto;
import com.mountaintour.mountain.dto.ImageDto;
import com.mountaintour.mountain.dto.MountainDto;
import com.mountaintour.mountain.dto.ProductDto;
import com.mountaintour.mountain.dto.ReviewDto;
import com.mountaintour.mountain.dto.UserDto;
import com.mountaintour.mountain.util.MyPageUtils;
import com.mountaintour.mountain.util.MyProductFileUtils;

import lombok.RequiredArgsConstructor;
import net.coobird.thumbnailator.Thumbnails;

@RequiredArgsConstructor
@Service
public class ProductServiceImpl implements ProductService {

	private final ProductMapper productMapper;
	private final MyProductFileUtils myFileUtils;
	private final MyPageUtils myPageUtils;
	
	@Override
	public Map<String, Object> addThumbnail(MultipartHttpServletRequest multipartRequest) throws Exception {
	    
	    List<MultipartFile> files =  multipartRequest.getFiles("files");
	    
	    int thumbnailCount;
	    if(files.get(0).getSize() == 0) {
	        thumbnailCount = 1;
	    } else {
	        thumbnailCount = 0;
	    }
	    
	    for(MultipartFile multipartFile : files) {
	        
	        if(multipartFile != null && !multipartFile.isEmpty()) {
	            
	            String path = myFileUtils.getUploadPath();
	            File dir = new File(path);
	            if(!dir.exists()) {
	                dir.mkdirs();
	            }
	            
	            String filesystemName = myFileUtils.getFilesystemName(multipartFile.getOriginalFilename());
	            File file = new File(dir, filesystemName);
	            
	            multipartFile.transferTo(file);
	            
	            String contentType = Files.probeContentType(file.toPath());
	            int thumbnail = (contentType != null && contentType.startsWith("image")) ? 1 : 0;
	            
	            if(thumbnail == 1) {
	                File hasthumbnail = new File(dir, "s_" + filesystemName);
	                Thumbnails.of(file)
	                            .size(100, 100)
	                            .toFile(hasthumbnail);
	            }
	            
	            ImageDto attach = ImageDto.builder()
	                            .productNo(Integer.parseInt(multipartRequest.getParameter("productNo")))   
	                            .imagePath(path)
	                            .filesystemName(filesystemName)
	                            .thumbnail(thumbnail)
	                            .build();
	            
	            thumbnailCount += productMapper.insertThumbnail(attach);
	            
	        }  // if
	        
	    }  // for
	    
	    return Map.of("thumbnailResult", files.size() == thumbnailCount);
	    
	}
	
	
	@Override
	public Map<String, Object> imageUpload(MultipartHttpServletRequest multipartRequest) {
	    // 이미지가 저장될 경로
	    String imagePath = myFileUtils.getProductImagePath();
	    File dir = new File(imagePath);
	    if (!dir.exists()) {
	        dir.mkdirs();
	    }

	    // 이미지 파일 (CKEditor는 이미지를 upload라는 이름으로 보냄)
	    MultipartFile upload = multipartRequest.getFile("upload");

	    // 이미지가 저장될 이름
	    String filesystemName = myFileUtils.getFilesystemName(upload.getOriginalFilename());

	    // 이미지 File 객체
	    File file = new File(dir, filesystemName);
	    // 저장
	    try {
	        upload.transferTo(file);
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    // CKEditor로 저장된 이미지의 경로를 JSON 형식으로 반환해야 함
	    return Map.of("uploaded", true
	            , "url", multipartRequest.getContextPath() + imagePath + "/" + filesystemName);
	}

	@Transactional(readOnly=true)
	@Override
	public ImageDto getThumbnail(int productNo) {
	  return productMapper.getThumbnail(productNo);
	  }
	
	@Override
	public int addProduct(MultipartHttpServletRequest multipartRequest) throws Exception {
	    String tripContents = multipartRequest.getParameter("tripContents");

	    try {
	        String userNoStr = multipartRequest.getParameter("userNo");
	        if (userNoStr == null || userNoStr.isEmpty()) {
	            return 0; // Invalid user number
	        }

	        int userNo = Integer.parseInt(userNoStr);

	        // 다른 파라미터들에 대한 유사한 방어 코드 추가

	        // ProductDto 생성
	        ProductDto product = ProductDto.builder()
	        		.userDto(UserDto.builder()
                            .userNo(userNo)
                            .build())
	                .mountainDto(MountainDto.builder().mountainNo(1).build())
	                .tripName(multipartRequest.getParameter("tripName"))
	                .tripContents(tripContents)
	                .guide(multipartRequest.getParameter("guide"))
	                .timetaken(multipartRequest.getParameter("timetaken"))
	                .price(Integer.parseInt(multipartRequest.getParameter("price")))
	                .danger(multipartRequest.getParameter("danger"))
	                .plan(multipartRequest.getParameter("plan"))
	                .termUse(multipartRequest.getParameter("termUse"))
	                .build();

	        int addResult = productMapper.insertProduct(product);

	        // CKEditor 이미지 처리
	        List<String> editorImages = getEditorImageList(tripContents);
	        for (String editorImage : editorImages) {
	            ImageDto productImage = ImageDto.builder()
	                    .productNo(product.getProductNo())
	                    .imagePath(myFileUtils.getProductImagePath())
	                    .filesystemName(editorImage)
	                    .thumbnail(0) // CKEditor 이미지는 썸네일이 필요 없다고 가정
	                    .build();
	            productMapper.insertProductImage(productImage);
	        }

	        // 파일 업로드 및 이미지 처리
	        List<MultipartFile> files = multipartRequest.getFiles("files");

	        int thumbnailCount = 0;
	        for (MultipartFile multipartFile : files) {
	            if (multipartFile != null && !multipartFile.isEmpty()) {
	                String path = myFileUtils.getUploadPath();
	                File dir = new File(path);
	                if (!dir.exists()) {
	                    dir.mkdirs();
	                }

	                String filesystemName = myFileUtils.getFilesystemName(multipartFile.getOriginalFilename());
	                File file = new File(dir, filesystemName);

	                multipartFile.transferTo(file);

	                String contentType = Files.probeContentType(file.toPath());
	                int thumbnail = (contentType != null && contentType.startsWith("image")) ? 1 : 0;

	                if (thumbnail == 1) {
	                    File thumbnailFile = new File(dir, "s_" + filesystemName);
	                    Thumbnails.of(file).size(100, 100).toFile(thumbnailFile);
	                }

	                try {
	                    ImageDto attach = ImageDto.builder()
	                            .productNo(product.getProductNo())
	                            .imagePath(path)
	                            .filesystemName(filesystemName)
	                            .thumbnail(thumbnail)
	                            .build();

	                    thumbnailCount += productMapper.insertThumbnail(attach);

	                } catch (Exception e) {
	                    e.printStackTrace();

	                }
	            }
	        }

	        // 성공 시 1, 실패 시 0 반환
	        return addResult == 1 && files.size() == thumbnailCount ? 1 : 0;
	    } catch (NumberFormatException e) {
	        e.printStackTrace();
	        return 0; // Invalid number format
	    }
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
		     String filesystemName = src.substring(src.lastIndexOf("/") + 1);
		      editorImageList.add(filesystemName);
		  }
		 }
		    
	 return editorImageList;
	}
	
	  @Transactional(readOnly=true)
	  public void productImageBatch() {
	    
	    // 1. 어제 작성된 블로그의 이미지 목록 (DB)
	    List<ImageDto> productImageList = productMapper.getProductImageInYesterday();
	    
	    // 2. List<productImageDto> -> List<Path> (Path는 경로+파일명으로 구성)
	    List<Path> productImagePathList = productImageList.stream()
	                                                .map(productImageDto -> new File(productImageDto.getImagePath(), productImageDto.getFilesystemName()).toPath())
	                                                .collect(Collectors.toList());
	    
	    // 3. 어제 저장된 블로그 이미지 목록 (디렉토리)
	    File dir = new File(myFileUtils.getProductImagePathInYesterday());
	    
	    // 4. 삭제할 File 객체들
	    File[] targets = dir.listFiles(file -> !productImagePathList.contains(file.toPath()));

	    // 5. 삭제
	    if(targets != null && targets.length != 0) {
	      for(File target : targets) {
	        target.delete();
	      }
	    }
	    
	  }
	
	
	@Transactional(readOnly=true)
	@Override
	public Map<String, Object> getProductList(HttpServletRequest request) {
		
		Optional<String> opt = Optional.ofNullable(request.getParameter("page"));
	    int page = Integer.parseInt(opt.orElse("1"));
	    int total = productMapper.getProductCount();
	    int display = 9;
	    
	    myPageUtils.setPaging(page, total, display);
	    
	    Map<String, Object> map = Map.of("begin", myPageUtils.getBegin()
	                                   , "end", myPageUtils.getEnd());
	    	   	    
	    List<ProductDto> productList = productMapper.getProductList(map);
	    return Map.of("productList", productList
	                , "totalPage", myPageUtils.getTotalPage());
	    
	}
	@Transactional(readOnly=true)
	@Override
    public int getTotalProductCount() {
        return productMapper.getProductCount();
    }
	
	@Transactional(readOnly=true)
	@Override
	public ProductDto getProduct(int productNo) {
	  return productMapper.getProduct(productNo);
	}
	
	@Override
	public int increseHit(int productNo) {
	  return productMapper.productHit(productNo);
	}
	
	@Override
	public int modifyProduct(HttpServletRequest request) {
		//** 수정된 메소드 **//
	    
	    // 수정할 제목/내용/블로그번호
		    int productNo = Integer.parseInt(request.getParameter("productNo"));
		    int price = Integer.parseInt(request.getParameter("price"));
		    String tripContents = request.getParameter("tripContents");
		    
	    List<ImageDto> productImageDtoList = productMapper.getProductImageList(productNo);
	    List<String> productImageList = productImageDtoList.stream()
	                                  .map(productImageDto -> productImageDto.getFilesystemName())
	                                  .collect(Collectors.toList());
	        
	    // Editor에 포함된 이미지 이름(filesystemName)
	    List<String> editorImageList = getEditorImageList(tripContents);

	    // Editor에 포함되어 있으나 기존 이미지에 없는 이미지는 IMAGE_T에 추가해야 함
	    editorImageList.stream()
	      .filter(editorImage -> !productImageList.contains(editorImage))        
	      .map(editorImage -> ImageDto.builder()                      
	                            .productNo(productNo)
	                            .imagePath(myFileUtils.getProductImagePath())
	                            .filesystemName(editorImage)
	                            .build())
	      .forEach(productImageDto -> productMapper.insertProductImage(productImageDto)); 
	    	   
	    // 기존 이미지에 있으나 Editor에 포함되지 않은 이미지는 삭제해야 함
	    List<ImageDto> removeList = productImageDtoList.stream()
	                                      .filter(productImageDto -> !editorImageList.contains(productImageDto.getFilesystemName())) 
	                                      .collect(Collectors.toList());                                                       

	    for(ImageDto productImageDto : removeList) {
	      // IMAGE_T에서 삭제
	      productMapper.deleteProductImage(productImageDto.getFilesystemName());  // 파일명은 UUID로 만들어졌으므로 파일명의 중복은 없다고 생각하면 된다.
	      // 파일 삭제
	      File file = new File(productImageDto.getImagePath(), productImageDto.getFilesystemName());
	      if(file.exists()) {
	        file.delete();
	      }
	    }
	    
	    
	    ProductDto product = ProductDto.builder()
			                .tripName(request.getParameter("tripName"))
			                .tripContents(tripContents)
			                .guide(request.getParameter("guide"))
			                .timetaken(request.getParameter("timetaken"))
			                .price(price)
			                .danger(request.getParameter("danger"))
			                .plan(request.getParameter("plan"))
			                .termUse(request.getParameter("termUse"))
			                .productNo(productNo)
			                .build();
	    
	    
	    int modifyResult = productMapper.updateProduct(product);
	    
	    return modifyResult;
	    
	}	

	@Override
	public int removeProduct(int productNo) {	  
	     
	  List<ImageDto> productImageList = productMapper.getProductImageList(productNo);
	    for(ImageDto productImage : productImageList) {
	      File file = new File(productImage.getImagePath(), productImage.getFilesystemName());
	      if(file.exists()) {
	        file.delete();
	      }
	    }	    
	    
	    productMapper.deleteProductImageList(productNo);
	    
	    return productMapper.deleteProduct(productNo);
	}
	
@Override
	public int addHeart(HttpServletRequest request) {
	
	String userNoString = request.getParameter("userNo");
	  int userNo = 0;
	  if (userNoString != null && !userNoString.isEmpty()) {
	      try {
	          userNo = Integer.parseInt(userNoString);
	      } catch (NumberFormatException e) {
	          e.printStackTrace(); 
	      }
	  }

	  String productNoString = request.getParameter("productNo");
	  int productNo = 0; // 기본값을 0으로 설정
	  if (productNoString != null && !productNoString.isEmpty()) {
	      try {
	          productNo = Integer.parseInt(productNoString);
	      } catch (NumberFormatException e) {
	          e.printStackTrace(); 
	      }
	  }
    
    HeartDto heart = HeartDto.builder()
		    		.productDto(ProductDto.builder()
		                    .productNo(productNo)
		                    .build())
		    		.userNo(userNo)
		            .build();
	return productMapper.heartProduct(heart);
	}

	@Override
	public Map<String, Object> getHit(HttpServletRequest request) {
				
		 Optional<String> opt = Optional.ofNullable(request.getParameter("page"));
	        int page = Integer.parseInt(opt.orElse("1"));
	        int total = productMapper.getProductCount();
	        int display = 9;

	        myPageUtils.setPaging(page, total, display);

	        Map<String, Object> map = Map.of("begin", myPageUtils.getBegin(),
	                                        "end", myPageUtils.getEnd());

	        List<ProductDto> hitList = productMapper.getHitList(map);
	        return Map.of("hitList", hitList,
	                      "totalPage", myPageUtils.getTotalPage());
	    }
	@Transactional(readOnly=true)
	@Override
	public Map<String, Object> getReviewProductList(HttpServletRequest request) {
		
		 Optional<String> opt = Optional.ofNullable(request.getParameter("page"));
	        int page = Integer.parseInt(opt.orElse("1"));
	        int total = productMapper.getProductCount();
	        int display = 9;

	        myPageUtils.setPaging(page, total, display);

	        Map<String, Object> map = Map.of("begin", myPageUtils.getBegin(),
	                                        "end", myPageUtils.getEnd());

	        List<ProductDto> reviewProductList = productMapper.getProductReviewList(map);
	        System.out.println("ㅇ낭나잉ㅇ" + reviewProductList);
	        return Map.of("reviewProductList", reviewProductList,
	                      "totalPage", myPageUtils.getTotalPage());
	    }
	
	@Override
	public Map<String, Object> addReview(HttpServletRequest request) {
	
	  String contents = request.getParameter("contents");
	  String userNoString = request.getParameter("userNo");
	  int userNo = 0;
	  if (userNoString != null && !userNoString.isEmpty()) {
	      try {
	          userNo = Integer.parseInt(userNoString);
	      } catch (NumberFormatException e) {
	          e.printStackTrace(); 
	      }
	  }

	  String productNoString = request.getParameter("productNo");
	  int productNo = 0; // 기본값을 0으로 설정
	  if (productNoString != null && !productNoString.isEmpty()) {
	      try {
	          productNo = Integer.parseInt(productNoString);
	      } catch (NumberFormatException e) {
	          e.printStackTrace(); 
	      }
	  }


	 // int reserveNo = Integer.parseInt(request.getParameter("reserveNo"));
	  
	  ReviewDto review = ReviewDto.builder()
	                        .contents(contents)
	                        .userDto(UserDto.builder()
	                                  .userNo(userNo)
	                                  .build())
	                        .productDto(ProductDto.builder()
	    		                    .productNo(productNo)
	    		                    .build())
	                        
	                        .build();

	  int addReviewResult = productMapper.insertReview(review);
	  
	  return Map.of("addReviewResult", addReviewResult);
	  
	}
	
	@Transactional(readOnly=true)
	@Override
	public Map<String, Object> loadReviewList(HttpServletRequest request) {
	
		
	  int productNo = Integer.parseInt(request.getParameter("productNo") != null ? request.getParameter("productNo") : "0");

	  
	  String pageParameter = request.getParameter("page");
	  int page = 1;  // 기본값 설정
	  if (pageParameter != null && !pageParameter.isEmpty()) {
	      try {
	          page = Integer.parseInt(pageParameter);
	      } catch (NumberFormatException e) {
	          // 예외 처리: 유효한 숫자가 아닌 경우
	          e.printStackTrace();  // 또는 적절한 로깅
	      }
	  }
	  int total = productMapper.getReviewCount(productNo);
	  int display = 10;
	  
	  myPageUtils.setPaging(page, total, display);
	  
	  Map<String, Object> map = Map.of("productNo", productNo
	                                 , "begin", myPageUtils.getBegin()
	                                 , "end", myPageUtils.getEnd());
	  
	  List<ReviewDto> reviewList = productMapper.getReviewList(map);
	  String paging = myPageUtils.getAjaxPaging();
	  Map<String, Object> result = new HashMap<String, Object>();
	  result.put("reviewList", reviewList);
	  result.put("paging", paging);
	  return result;
	  
	}
	
	@Override
	  public Map<String, Object> removeReview(int reviewNo) {
	    int removeResult = productMapper.deleteReview(reviewNo);
	    return Map.of("removeResult", removeResult);
	  }
}	
