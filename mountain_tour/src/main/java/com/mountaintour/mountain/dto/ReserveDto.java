package com.mountaintour.mountain.dto;

import java.sql.Date;
import java.util.List;

import com.fasterxml.jackson.annotation.JsonManagedReference;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
@Builder
public class ReserveDto {
  private int reserveNo;
  private Date reserveDate;
  private String request;
  private int agree;
  private String pickupLoc;
  private int reserveStatus;
  private String reserveStart;
  private int reservePerson;
  private UserDto userDto;       // private int userNo;
  private ProductDto productDto; // private int productNo;
  
  @JsonManagedReference
  private List<TouristDto> touristList;
}
