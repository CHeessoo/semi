package com.mountaintour.mountain.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
@Builder
public class PaymentDto {
  private int paymentNo;
  private String payYn;
  private String payKind;
  private String payBank;
  private String payApproval;
  private String payDate;
  private ReserveDto reserveDto; // private int reserveNo;
}
