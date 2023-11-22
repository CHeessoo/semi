package com.mountaintour.mountain.service;

import javax.servlet.http.HttpServletRequest;

import org.springframework.ui.Model;

import com.mountaintour.mountain.dto.NoticeDto;

public interface NoticeService{
  public void loadNoticeList(HttpServletRequest request, Model model);
  public NoticeDto getNotice(int noticeNo);
  public int addNotice(HttpServletRequest request);
  public int modifyNotice(HttpServletRequest request);
  public int removeNotice(int NoticeNo);
  public void LoadSearchList(HttpServletRequest request, Model model);
}
