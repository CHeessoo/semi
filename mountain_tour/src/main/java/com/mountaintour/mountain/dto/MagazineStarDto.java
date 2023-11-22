package com.mountaintour.mountain.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
@Builder
public class MagazineStarDto {
  private int magazineNo;
  private int userNo;
}
