package com.mountaintour.mountain.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
@Builder
public class MagazineDto {
  private int magazineNo;
  private int userNo;
  private String title;
  private String contents;
  private String summary;
  private int hit;
  private String createAt;
  private int productNo;
  private MagazineMultiDto magazineMultiDto;
}
