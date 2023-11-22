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
public class ReviewDto {
    private int reviewNo;
    private ProductDto productDto;
    private int reserveNo;
    private String contents;
    private Date createdAt;
    private Date modifiedAt;
    private String status;
    private int star;
    private UserDto userDto;

}
