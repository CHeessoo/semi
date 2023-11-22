package com.mountaintour.mountain.dto;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
@Builder
public class ProductDto {
    private int productNo;
    private MountainDto mountainDto;
    private String tripName;
    private String tripContents; // 여행내용
    private String guide;        // 가이드정보
    private String timetaken;    // 소요시간
    private int price;		     // 상품가격
    private String danger;       // 주의사항
    private Date registeredAt;   // 등록일자
    private Date modifiedDate;   // 수정일자
    private int people;		     // 인원수
    private int hit;		     // 조회수
    private String plan;         // 여행일정
    private int status;		
    private String termUse;      // 이용약관
    private UserDto userDto;
	
    
    private ImageDto imageDto;  // imageDto 속성 추가
    private ProductDto productDto;
    
    public ImageDto getImageDto() {
        return imageDto;
    }
    public ProductDto getProductDto() {
        return this.productDto;
    }

}



