package com.mountaintour.mountain.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
@Builder
public class MagazineMultiDto {
  private int magazineNo; 
  private String multiPath;
  private String filesysName;
  private int isThumbnail;
 
}
