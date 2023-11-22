package com.mountaintour.mountain.dto;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
@Builder
public class InquiryDto {
  
  private int inquiryNo;
  private String inquiryTitle;
  private String inquiryContents;
  private String ip;
  private Date createdAt;
  private int answerNo;
  private UserDto userDto;       // int userNo
  private ProductDto productDto; // int productNo

}

