package com.mountaintour.mountain.schedule;

import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;


@Component
public class InactiveUserBatch {

 
    
    //@Scheduled(cron="0 0 0 1/1 * ? ")  //  매일 자정에 동작 
    @Scheduled(cron="0 50 10 1/1 * ? ")
    public void execute() {
      
    }
    
}
