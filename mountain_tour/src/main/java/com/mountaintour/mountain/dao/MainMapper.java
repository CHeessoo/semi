package com.mountaintour.mountain.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.mountaintour.mountain.dto.ProductDto;

@Mapper
public interface MainMapper {
  public List<ProductDto> selectCountBest();
  public Map<String, ProductDto> selectGetProduct(Map<String, Object> map);
}
