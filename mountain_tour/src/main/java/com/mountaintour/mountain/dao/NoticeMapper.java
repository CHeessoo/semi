package com.mountaintour.mountain.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.mountaintour.mountain.dto.NoticeDto;

@Mapper
public interface NoticeMapper {
  public List<NoticeDto> getNoticeList(Map<String, Object> map);
  public NoticeDto getNotice(int noticeNo);
  public int getNoticeCount();
  public int insertNotice(NoticeDto notice);
  public int deleteNotice(int NoticeNo);
  public int updateNotice(NoticeDto notice);
  public int getSearchCount(Map<String, Object> map);
  public List<NoticeDto> getSearchList(Map<String, Object> map);
}
