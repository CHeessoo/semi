package com.mountaintour.mountain.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.mountaintour.mountain.dto.ReserveDto;
import com.mountaintour.mountain.dto.TouristDto;

@Mapper
public interface ReserveMapper {
  
  public int insertReserve(ReserveDto reserve);
  public int insertTourist(TouristDto tourist);
  
  
  public ReserveDto getReserve(int reserveNo);
  public int getReserveCount();
  public List<ReserveDto> getReserveList(Map<String, Object> map);
  
  public List<TouristDto> getTourists(int reserveNo);
  
  public int updateReserve(ReserveDto reserve);
  
  public int deleteReserve(int reserveNo);
  
  
  
}
