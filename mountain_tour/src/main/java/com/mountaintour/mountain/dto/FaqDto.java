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
public class FaqDto {
  
  private int faqNo;
  private String title;
  private String contents;
  private Date createdAt;
  private Date modifiedAt;

}

