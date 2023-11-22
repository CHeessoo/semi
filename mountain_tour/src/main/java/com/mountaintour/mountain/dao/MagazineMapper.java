package com.mountaintour.mountain.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.mountaintour.mountain.dto.MagazineDto;
import com.mountaintour.mountain.dto.MagazineMultiDto;
import com.mountaintour.mountain.dto.MagazineStarDto;
import com.mountaintour.mountain.dto.ProductDto;

@Mapper
public interface MagazineMapper {
  public List<MagazineDto> magazineList(Map<String, Object> map);
  public int getMagazineCount();
  public List<ProductDto> getProductNo();
  public int insertMagazineOne(MagazineDto magazineDto);
  public int insertMagazineMulti(MagazineMultiDto magazineMultiDto);
  public int insertMagazineTwo(MagazineDto magazineDto);
  public MagazineDto getMagazine(int magazineNo);
  public int countLike(int magazineNo);
  public int deleteMagazine(int magazineNo);
  public int updateModifyOne(MagazineDto magazineDto);
  public int updateModifyTwo(MagazineDto magazineDto);
  public int updateThumbnailFinal(MagazineMultiDto magazineMultiDto);
  public List<MagazineMultiDto> getMagazineMultiList(int magazineNo);
  public int deleteMagazineMulti(String filesysName);
  public MagazineDto getThumbnailInfo(int magazineNo);
  public int updateIsThumbnail(int magazineNo);
  public int updateHit(int magazineNo);
  public int deleteLike(MagazineStarDto magazineStarDto);
  public int insertLike(MagazineStarDto magazineStarDto);
  public int selectCountLike(MagazineStarDto magazineStarDto);

  
}
