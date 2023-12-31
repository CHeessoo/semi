-- 시퀀스 삭제
DROP SEQUENCE USER_SEQ;

DROP SEQUENCE PRODUCT_SEQ;
DROP SEQUENCE MOUNTAIN_SEQ;
DROP SEQUENCE REVIEW_SEQ;
DROP SEQUENCE IMAGE_SEQ;

DROP SEQUENCE MAGAZINE_SEQ;

DROP SEQUENCE RESERVE_SEQ;
DROP SEQUENCE TOURIST_SEQ;
DROP SEQUENCE PAY_SEQ;

DROP SEQUENCE INQUIRY_SEQ;
DROP SEQUENCE ANSWER_SEQ;
DROP SEQUENCE FAQ_SEQ;

DROP SEQUENCE NOTICE_SEQ;

-- 시퀀스 생성
CREATE SEQUENCE USER_SEQ NOCACHE;

CREATE SEQUENCE PRODUCT_SEQ NOCACHE;
CREATE SEQUENCE MOUNTAIN_SEQ NOCACHE;
CREATE SEQUENCE REVIEW_SEQ NOCACHE;
CREATE SEQUENCE IMAGE_SEQ NOCACHE;

CREATE SEQUENCE MAGAZINE_SEQ NOCACHE;

CREATE SEQUENCE RESERVE_SEQ NOCACHE;
CREATE SEQUENCE TOURIST_SEQ NOCACHE;
CREATE SEQUENCE PAY_SEQ NOCACHE;

CREATE SEQUENCE INQUIRY_SEQ NOCACHE;
CREATE SEQUENCE ANSWER_SEQ NOCACHE;
CREATE SEQUENCE FAQ_SEQ NOCACHE;

CREATE SEQUENCE NOTICE_SEQ NOCACHE;


-- 테이블 삭제
DROP TABLE NOTICE_T;

DROP TABLE FAQ_T;
DROP TABLE INQUIRY_ANSWER_T;
DROP TABLE INQUIRY_T;

DROP TABLE REVIEW_T;

DROP TABLE PAYMENT_T;
DROP TABLE TOURIST_T;
DROP TABLE RESERVE_T;

DROP TABLE MAGAZINE_STAR_T;
DROP TABLE MAGAZINE_MULTI_T;
DROP TABLE MAGAZINE_T;

DROP TABLE HEART_T;
DROP TABLE IMAGE_T;
DROP TABLE PRODUCT_T;
DROP TABLE MOUNTAIN_T;

DROP TABLE LEAVE_USER_T;
DROP TABLE ACCESS_T;
DROP TABLE USER_T;



--테이블

--**********************************************************************************

-- 가입한 사용자
CREATE TABLE USER_T (
    USER_NO        NUMBER              NOT NULL,        -- 회원번호 (PK)
    EMAIL          VARCHAR2(100 BYTE)  NOT NULL UNIQUE, -- 이메일을 아이디로 사용
    PW             VARCHAR2(64 BYTE),                   -- SHA-256 암호화 방식 사용
    NAME           VARCHAR2(50 BYTE),                   -- 이름
    GENDER         VARCHAR2(2 BYTE),                    -- M, F, NO
    MOBILE         VARCHAR2(15 BYTE),                   -- 하이픈 제거 후 저장
    POSTCODE       VARCHAR2(5 BYTE),                    -- 우편번호
    ROAD_ADDRESS   VARCHAR2(100 BYTE),                  -- 도로명주소
    JIBUN_ADDRESS  VARCHAR2(100 BYTE),                  -- 지번주소
    DETAIL_ADDRESS VARCHAR2(100 BYTE),                  -- 상세주소
    AGREE          NUMBER              NOT NULL,        -- 서비스 동의 여부(0:필수, 1:이벤트)
    STATE          NUMBER,                              -- (자동로그인)가입형태(0:정상, 1:네이버)
    AUTH           NUMBER,                              -- 사용자 권한 (관리자:0, 회원:1)
    PW_MODIFIED_AT DATE,                                -- 비밀번호 수정일
    JOINED_AT      DATE,                                -- 가입일
    CONSTRAINT PK_USER PRIMARY KEY(USER_NO)
);

-- 접속 기록
CREATE TABLE ACCESS_T (
    EMAIL    VARCHAR2(100 BYTE) NOT NULL,  -- 접속한 사용자 (FK)
    LOGIN_AT DATE,                         -- 로그인 일시
    CONSTRAINT FK_USER_ACCESS FOREIGN KEY(EMAIL) REFERENCES USER_T(EMAIL) ON DELETE CASCADE
);

-- 탈퇴한 사용자
CREATE TABLE LEAVE_USER_T (
    EMAIL     VARCHAR2(100 BYTE) NOT NULL,  -- 탈퇴한 사용자 이메일
    JOINED_AT DATE,                         -- 가입일
    LEAVED_AT DATE,                         -- 탈퇴일
    CONSTRAINT PK_LEAVE_USER PRIMARY KEY(EMAIL)
);


--**********************************************************************************

-- 산 테이블
CREATE TABLE MOUNTAIN_T (
	MOUNTAIN_NO	  NUMBER		     NOT NULL,  -- 산 번호 
	MOUNTAIN_NAME VARCHAR2(150 BYTE) NOT NULL,  -- 산이름
	IMPORMATION	  VARCHAR2(500 BYTE) NOT NULL,  -- 산정보 
	LOCATION	  VARCHAR2(100 BYTE) NOT NULL,  -- 산위치(ex 강원도, 제주도..)
    CONSTRAINT PK_MOUNTAIN_T PRIMARY KEY(MOUNTAIN_NO)
);

-- 여행지(상품) 테이블
CREATE TABLE PRODUCT_T(
   PRODUCT_NO     NUMBER             NOT NULL,  -- 상품 번호 
   USER_NO        NUMBER             NOT NULL,  -- 작성자(관리자) 번호
   MOUNTAIN_NO    NUMBER             NOT NULL,  -- 산 번호
   TRIP_NAME      VARCHAR2(255 BYTE) NOT NULL,  -- 여행이름(제목)
   TRIP_CONTENTS  CLOB               NULL,      -- 여행내용(설명)
   GUIDE          VARCHAR2(100 BYTE) NULL,      -- 가이드 정보
   TIMETAKEN      VARCHAR2(100 BYTE) NULL,      -- 여행일정(소요시간 ex 당일)
   PRICE          NUMBER             NULL,      -- 가격
   DANGER         VARCHAR2(500 BYTE) NULL,      -- 주의사항
   REGISTERED_AT  DATE               NULL,      -- 등록일
   MODIFIED_DATE  DATE               NULL,      -- 수정일
   PEOPLE         NUMBER             NULL,      -- 최대인원수
   HIT            NUMBER             DEFAULT 0, -- 조회수
   PLAN           VARCHAR2(255 BYTE) NULL,      -- 여행계획
   STATUS         NUMBER             NULL,      -- 상품상태 (예약가능:0, 예약불가:1)
   TERM_USE      VARCHAR2(500 BYTE)  NULL,      -- 이용약관 (동의체크X, 약관내용을 DB에 저장해놓는 용도)
   CONSTRAINT PK_PRODUCT PRIMARY KEY(PRODUCT_NO),
   CONSTRAINT FK_USER_PRODUCT     FOREIGN KEY(USER_NO)     REFERENCES USER_T(USER_NO)         ON DELETE CASCADE,
   CONSTRAINT FK_MOUNTAIN_PRODUCT FOREIGN KEY(MOUNTAIN_NO) REFERENCES MOUNTAIN_T(MOUNTAIN_NO) ON DELETE CASCADE
);



-- 상품사진첨부 테이블      
CREATE TABLE IMAGE_T(
    IMAGE_PATH        VARCHAR2(300 BYTE)  NOT NULL,  -- 첨부 사진 경로
    FILESYSTEM_NAME   VARCHAR2(300 BYTE)  NOT NULL,  -- 저장 파일명
    THUMBNAIL         NUMBER              NULL,      -- 썸네일이미지
    PRODUCT_NO        NUMBER              NOT NULL,  -- 상품 번호
    CONSTRAINT FK_PRODUCT_IMAGE FOREIGN KEY(PRODUCT_NO) REFERENCES PRODUCT_T(PRODUCT_NO) ON DELETE CASCADE
);

-- 상품 찜 
CREATE TABLE HEART_T ( 
	USER_NO	   NUMBER  NOT NULL,  -- 회원 번호
	PRODUCT_NO NUMBER  NOT NULL,  -- 상품 번호
    CONSTRAINT FK_USER_HEART    FOREIGN KEY(USER_NO)    REFERENCES USER_T(USER_NO)       ON DELETE CASCADE,
    CONSTRAINT FK_PRODUCT_HEART FOREIGN KEY(PRODUCT_NO) REFERENCES PRODUCT_T(PRODUCT_NO) ON DELETE CASCADE
);


--**********************************************************************************
-- 매거진 테이블
CREATE TABLE MAGAZINE_T (
    MAGAZINE_NO NUMBER	            NOT NULL,  -- 매거진 번호
    USER_NO	    NUMBER		        NOT NULL,  -- 회원 번호
    TITLE	    VARCHAR2(100 BYTE)  NOT NULL,  -- 매거진 제목
    CONTENTS	CLOB		        NOT NULL,  -- 매거진 내용
    SUMMARY     VARCHAR2(2000 BYTE) NULL,      -- (리스트용) 요약
    HIT	        NUMBER		        DEFAULT 0, -- 매거진 조회수
    CREATE_AT	DATE	            NULL,      -- 매거진 작성날짜
    PRODUCT_NO	NUMBER		        NOT NULL,  -- 상품 번호
    CONSTRAINT PK_MAGAZINE_NO PRIMARY KEY(MAGAZINE_NO),
    CONSTRAINT FK_USER_MAGAZIN    FOREIGN KEY(USER_NO) REFERENCES USER_T(USER_NO)          ON DELETE SET NULL,
    CONSTRAINT FK_PRODUCT_MAGAZIN FOREIGN KEY(PRODUCT_NO) REFERENCES PRODUCT_T(PRODUCT_NO) ON DELETE SET NULL
);

-- 매거진 멀티미디어
CREATE TABLE MAGAZINE_MULTI_T (
	MAGAZINE_NO	 NUMBER	            NULL,  -- 매거진 번호
	MULTI_PATH	 VARCHAR2(100 BYTE) NULL,  -- 멀티미디어 경로
	FILESYS_NAME VARCHAR2(100 BYTE) NULL,  -- 파일 이름
    IS_THUMBNAIL NUMBER             NULL,  -- 썸네일로 쓰이는 사진 구분
  CONSTRAINT FK_MAGAZINE_MULTI FOREIGN KEY(MAGAZINE_NO) REFERENCES MAGAZINE_T(MAGAZINE_NO) ON DELETE SET NULL  
);

-- 매거진 좋아요 
CREATE TABLE MAGAZINE_STAR_T (
  MAGAZINE_NO NUMBER NOT NULL,  -- 매거진 번호
  USER_NO	  NUMBER NOT NULL,  -- 회원 번호
  CONSTRAINT FK_MAGAZINE_STAR FOREIGN KEY(MAGAZINE_NO) REFERENCES MAGAZINE_T(MAGAZINE_NO) ON DELETE CASCADE,
  CONSTRAINT FK_USER_STAR FOREIGN KEY(USER_NO) REFERENCES USER_T(USER_NO) ON DELETE SET NULL
);


--**********************************************************************************


-- 예약 테이블
CREATE TABLE RESERVE_T (
    RESERVE_NO      NUMBER              NOT NULL,   -- 예약번호(PK)
    RESERVE_DATE    DATE                NOT NULL,   -- 예약일
    REQUEST         VARCHAR2(4000 BYTE) NULL,       -- 요청사항
    AGREE           NUMBER              NOT NULL,   -- 0:필수동의, 1:선택까지동의
    PICKUP_LOC      VARCHAR2(100 BYTE)  NULL,       -- 버스 탑승지
    RESERVE_STATUS  NUMBER              DEFAULT 0,  -- 0:정상, 1:대기, 2:불가
    RESERVE_START   VARCHAR2(30 BYTE)   NULL,       -- 예약시작일
    RESERVE_PERSON  NUMBER              NULL,       -- 예약한 총 인원수
    USER_NO         NUMBER              NULL,       -- 유저번호(FK)
    PRODUCT_NO      NUMBER              NOT NULL,   -- 상품번호(FK)    
    CONSTRAINT PK_RES PRIMARY KEY(RESERVE_NO),
    CONSTRAINT FK_USER_RES FOREIGN KEY(USER_NO) REFERENCES USER_T(USER_NO) ON DELETE SET NULL,
    CONSTRAINT FK_PRODUCT_RES FOREIGN KEY(PRODUCT_NO) REFERENCES PRODUCT_T(PRODUCT_NO) ON DELETE CASCADE
);

-- 실제 여행자 테이블
CREATE TABLE TOURIST_T (
    TOURIST_NO   NUMBER             NOT NULL,     -- 실제 여행객 번호(PK)
    NAME         VARCHAR2(100 BYTE) NULL,         -- 이름
    BIRTH_DATE   VARCHAR2(30 BYTE)  NULL,         -- 생년월일
    GENDER       VARCHAR2(2 BYTE)   NULL,         -- 성별
    CONTACT      VARCHAR2(30 BYTE)  NULL,         -- 연락처
    AGE_CASE     NUMBER             NULL,         -- 0:성인, 1:소아, 2:유아
    RESERVE_NO   NUMBER             NOT NULL,     -- 예약번호
    CONSTRAINT PK_TOUR PRIMARY KEY(TOURIST_NO),
    CONSTRAINT FK_RES_TOUR FOREIGN KEY(RESERVE_NO) REFERENCES RESERVE_T(RESERVE_NO) ON DELETE CASCADE
);


-- 결제 테이블
CREATE TABLE PAYMENT_T (
    PAYMENT_NO   NUMBER             NOT NULL,  -- 결제번호(PK)
    PAY_YN       VARCHAR2(50 BYTE)  NULL,      -- 결제여부
    PAY_KIND     VARCHAR2(100 BYTE) NULL,      -- 결제방식
    PAY_BANK     VARCHAR2(100 BYTE) NULL,      -- 결제은행
    PAY_APPROVAL VARCHAR2(100 BYTE) NULL,      -- 결제승인
    PAY_DATE     VARCHAR2(100 BYTE) NULL,      -- 결제일
    RESERVE_NO   NUMBER             NULL,      -- 예약번호(FK)
    CONSTRAINT PK_PAY PRIMARY KEY(PAYMENT_NO),
    CONSTRAINT FK_RESERVE_PAY FOREIGN KEY(RESERVE_NO) REFERENCES RESERVE_T(RESERVE_NO) ON DELETE SET NULL
);


--*************************************상품 리뷰 테이블*********************************************

-- 리뷰 테이블
CREATE TABLE REVIEW_T (
	REVIEW_NO	NUMBER		       NOT NULL,  -- 리뷰번호
	PRODUCT_NO	NUMBER		       NOT NULL,  -- 상품번호
    RESERVE_NO  NUMBER             NOT NULL,  -- 예약번호
	USER_NO	    NUMBER		       NOT NULL,  -- 회원번호
	CONTENTS	VARCHAR2(300 BYTE) NULL,      -- 리뷰내용
	CREATED_AT	DATE		       NOT NULL,  -- 작성일
	MODIFIED_AT	DATE		       NOT NULL,  -- 수정일
	STATUS	    NUMBER             NOT NULL,  -- 댓글상태(삭제여부, 0:미삭제, 1:삭제)
	STAR	    NUMBER             NULL,      -- 별점
    CONSTRAINT PK_REVIEW PRIMARY KEY(REVIEW_NO),
    CONSTRAINT FK_USER_REVIEW FOREIGN KEY(USER_NO) REFERENCES USER_T(USER_NO) ON DELETE CASCADE,
    CONSTRAINT FK_PRODUCT_REVIEW FOREIGN KEY(PRODUCT_NO) REFERENCES PRODUCT_T(PRODUCT_NO) ON DELETE CASCADE,
    CONSTRAINT FK_RESERVE_REVIEW FOREIGN KEY(RESERVE_NO) REFERENCES RESERVE_T(RESERVE_NO) ON DELETE CASCADE
);

--**********************************************************************************

-- 문의하기 테이블
CREATE TABLE INQUIRY_T (
    INQUIRY_NO       NUMBER             NOT NULL,   -- 문의번호         (PK)
    USER_NO          NUMBER             NOT NULL,   -- 회원번호(작성자) (FK)
    PRODUCT_NO       NUMBER             NULL,       -- 상품번호         (FK)
    INQUIRY_TITLE    VARCHAR2(100 BYTE) NULL,       -- 제목
    INQUIRY_CONTENTS CLOB               NULL,       -- 내용
    IP               VARCHAR2(30 BYTE)  NULL,       -- IP주소
    CREATED_AT       DATE               NULL,       -- 작성일
    CONSTRAINT PK_INQUIRY PRIMARY KEY(INQUIRY_NO),
    CONSTRAINT FK_USER_INQUIRY FOREIGN KEY(USER_NO) REFERENCES USER_T(USER_NO) ON DELETE CASCADE,
    CONSTRAINT FK_PRODUCT_INQUIRY FOREIGN KEY(PRODUCT_NO) REFERENCES PRODUCT_T(PRODUCT_NO) ON DELETE SET NULL
);


-- 문의하기-답변 테이블
CREATE TABLE INQUIRY_ANSWER_T (
    ANSWER_NO   NUMBER             NOT NULL,   -- 답변번호           (PK)
    INQUIRY_NO  NUMBER             NOT NULL,   -- 문의번호           (FK)
    USER_NO     NUMBER             NULL,       -- 작성자(관리자)번호 (FK)
    CONTENTS    CLOB               NULL,       -- 내용
    CREATED_AT  DATE               NULL,       -- 작성일
    MODIFIED_AT DATE               NULL,       -- 수정일
    CONSTRAINT PK_ANSWER PRIMARY KEY(ANSWER_NO),
    CONSTRAINT FK_INQUIRY_ANSWER FOREIGN KEY(INQUIRY_NO) REFERENCES INQUIRY_T(INQUIRY_NO) ON DELETE CASCADE,
    CONSTRAINT FK_USER_ANSWER FOREIGN KEY(USER_NO) REFERENCES USER_T(USER_NO) ON DELETE SET NULL
);

-- 자주묻는질문 테이블
CREATE TABLE FAQ_T (
    FAQ_NO      NUMBER             NOT NULL,   -- 글번호  (PK)
    TITLE       VARCHAR2(100 BYTE) NULL,       -- 제목
    CONTENTS    CLOB               NULL,       -- 내용
    CREATED_AT  DATE               NULL,       -- 작성일
    MODIFIED_AT DATE               NULL,       -- 수정일
    CONSTRAINT PK_FAQ PRIMARY KEY(FAQ_NO)
);


--**********************************************************************************

-- 공지사항 테이블
CREATE TABLE NOTICE_T (
    NOTICE_NO       NUMBER               NOT NULL, -- 공지 번호
    TITLE           VARCHAR2(100 BYTE),            -- 공지 제목
    CONTENTS        CLOB,                          -- 공지 내용
    CREATED_AT      DATE,                          -- 공지 작성일
    MODIFIED_AT     DATE,                          -- 공지 수정일
    CONSTRAINT PK_NOTICE_T PRIMARY KEY(NOTICE_NO)
); 


INSERT INTO USER_T VALUES(USER_SEQ.NEXTVAL, 'user1@naver.com', STANDARD_HASH('1111', 'SHA256'), '사용자1', 'M', '01011111111', '11111', '디지털로', '가산동', '101동 101호', 0, 0, 1, TO_DATE('20231001', 'YYYYMMDD'), TO_DATE('20220101', 'YYYYMMDD'));
INSERT INTO USER_T VALUES(USER_SEQ.NEXTVAL, 'user2@naver.com', STANDARD_HASH('1111', 'SHA256'), '사용자2', 'M', '01011123111', '11111', '디지털로', '가산동', '101동 101호', 0, 0, 1, TO_DATE('20231001', 'YYYYMMDD'), TO_DATE('20220101', 'YYYYMMDD'));
INSERT INTO USER_T VALUES(USER_SEQ.NEXTVAL, 'user3@naver.com', STANDARD_HASH('1111', 'SHA256'), '사용자2', 'M', '01011123111', '11111', '디지털로', '가산동', '101동 101호', 0, 0, 1, TO_DATE('20231001', 'YYYYMMDD'), TO_DATE('20220101', 'YYYYMMDD'));
INSERT INTO USER_T VALUES(USER_SEQ.NEXTVAL, 'user4@naver.com', STANDARD_HASH('1111', 'SHA256'), '사용자2', 'M', '01011123111', '11111', '디지털로', '가산동', '101동 101호', 0, 0, 0, TO_DATE('20231001', 'YYYYMMDD'), TO_DATE('20220101', 'YYYYMMDD'));

INSERT INTO MOUNTAIN_T VALUES(MOUNTAIN_SEQ.NEXTVAL, '한라산', '멋있음', '제주도');
INSERT INTO MOUNTAIN_T VALUES(MOUNTAIN_SEQ.NEXTVAL, '한라산2', '멋있음11', '제주도2');
INSERT INTO PRODUCT_T VALUES(PRODUCT_SEQ.NEXTVAL, 1, 1, '우당탕탕한라산', '엄청나요', '김세콩', '당일', 28000, '주의사항', TO_DATE('20231101', 'YYYYMMDD'), TO_DATE('20231201', 'YYYYMMDD'), 30, 14, '오전, 오후', 0, '약관동의');
INSERT INTO PRODUCT_T VALUES(PRODUCT_SEQ.NEXTVAL, 1, 2, '우당탕탕한라산2', '엄청나요!!!!', '김콩콩', '당일', 33000, '주의사항', TO_DATE('20230801', 'YYYYMMDD'), TO_DATE('20231021', 'YYYYMMDD'), 30, 55, '오전, 오후', 0, '약관동의');
INSERT INTO IMAGE_T VALUES('사진.jpg', '한라산사진', 0, 1);
INSERT INTO IMAGE_T VALUES('사진2.jpg', '한라산2사진',1, 2);
INSERT INTO HEART_T VALUES(1, 1);
INSERT INTO HEART_T VALUES(2, 2);
INSERT INTO HEART_T VALUES(2, 2);

-------------------------------------------------------------------

INSERT INTO MAGAZINE_T (MAGAZINE_NO, USER_NO, TITLE, CONTENTS, SUMMARY, CREATE_AT, PRODUCT_NO) VALUES(MAGAZINE_SEQ.NEXTVAL, 1, '설악산1', '떠나요 설악산1', '설악산에는 눈이와요. 정말 많이 와요.1', TO_DATE(SYSDATE, 'YYYY-MM-DD HH24:MI:SS'), 1);
INSERT INTO MAGAZINE_T (MAGAZINE_NO, USER_NO, TITLE, CONTENTS, SUMMARY, CREATE_AT, PRODUCT_NO) VALUES(MAGAZINE_SEQ.NEXTVAL, 2, '설악산2', '떠나요 설악산2', '설악산에는 눈이와요. 정말 많이 와요.2', TO_DATE(SYSDATE, 'YYYY-MM-DD HH24:MI:SS'), 1);
INSERT INTO MAGAZINE_T (MAGAZINE_NO, USER_NO, TITLE, CONTENTS, SUMMARY, CREATE_AT, PRODUCT_NO) VALUES(MAGAZINE_SEQ.NEXTVAL, 1, '설악산3', '떠나요 설악산3', '설악산에는 눈이와요. 정말 많이 와요.3', TO_DATE(SYSDATE, 'YYYY-MM-DD HH24:MI:SS'), 2);
INSERT INTO MAGAZINE_T (MAGAZINE_NO, USER_NO, TITLE, CONTENTS, SUMMARY, CREATE_AT, PRODUCT_NO) VALUES(MAGAZINE_SEQ.NEXTVAL, 1, '설악산4', '떠나요 설악산3', '설악산에는 눈이와요. 정말 많이 와요.3', TO_DATE(SYSDATE, 'YYYY-MM-DD HH24:MI:SS'), 2);
INSERT INTO MAGAZINE_T (MAGAZINE_NO, USER_NO, TITLE, CONTENTS, SUMMARY, CREATE_AT, PRODUCT_NO) VALUES(MAGAZINE_SEQ.NEXTVAL, 1, '설악산5', '떠나요 설악산3', '설악산에는 눈이와요. 정말 많이 와요.3', TO_DATE(SYSDATE, 'YYYY-MM-DD HH24:MI:SS'), 2);
INSERT INTO MAGAZINE_T (MAGAZINE_NO, USER_NO, TITLE, CONTENTS, SUMMARY, CREATE_AT, PRODUCT_NO) VALUES(MAGAZINE_SEQ.NEXTVAL, 1, '설악산6', '떠나요 설악산3', '설악산에는 눈이와요. 정말 많이 와요.3', TO_DATE(SYSDATE, 'YYYY-MM-DD HH24:MI:SS'), 2);
INSERT INTO MAGAZINE_T (MAGAZINE_NO, USER_NO, TITLE, CONTENTS, SUMMARY, CREATE_AT, PRODUCT_NO) VALUES(MAGAZINE_SEQ.NEXTVAL, 1, '설악산7', '떠나요 설악산3', '설악산에는 눈이와요. 정말 많이 와요.3', TO_DATE(SYSDATE, 'YYYY-MM-DD HH24:MI:SS'), 2);
INSERT INTO MAGAZINE_T (MAGAZINE_NO, USER_NO, TITLE, CONTENTS, SUMMARY, CREATE_AT, PRODUCT_NO) VALUES(MAGAZINE_SEQ.NEXTVAL, 1, '설악산8', '떠나요 설악산3', '설악산에는 눈이와요. 정말 많이 와요.3', TO_DATE(SYSDATE, 'YYYY-MM-DD HH24:MI:SS'), 2);
INSERT INTO MAGAZINE_T (MAGAZINE_NO, USER_NO, TITLE, CONTENTS, SUMMARY, CREATE_AT, PRODUCT_NO) VALUES(MAGAZINE_SEQ.NEXTVAL, 1, '설악산9', '떠나요 설악산3', '설악산에는 눈이와요. 정말 많이 와요.3', TO_DATE(SYSDATE, 'YYYY-MM-DD HH24:MI:SS'), 2);
INSERT INTO MAGAZINE_T (MAGAZINE_NO, USER_NO, TITLE, CONTENTS, SUMMARY, CREATE_AT, PRODUCT_NO) VALUES(MAGAZINE_SEQ.NEXTVAL, 1, '설악산10', '떠나요 설악산3', '설악산에는 눈이와요. 정말 많이 와요.3', TO_DATE(SYSDATE, 'YYYY-MM-DD HH24:MI:SS'), 2);
INSERT INTO USER_T VALUES(USER_SEQ.NEXTVAL, 'user7@naver.com', STANDARD_HASH('7777', 'SHA256'), '사용자4', 'F', '01012341234', '88888', '디지털로', '가산동', '104동 104호', 0, 1, 1, TO_DATE('20231004', 'YYYYMMDD'), TO_DATE('20220104', 'YYYYMMDD'));
INSERT INTO MAGAZINE_MULTI_T VALUES(1, 'MAGAZINE/PICTURE/', 'ABC.JPG', 0);
INSERT INTO MAGAZINE_MULTI_T VALUES(1, 'MAGAZINE/PICTURE/', 'ABC-1.JPG', 1);
INSERT INTO MAGAZINE_MULTI_T VALUES(2, 'MAGAZINE/PICTURE/', 'ABC1.JPG', 0);
INSERT INTO MAGAZINE_MULTI_T VALUES(2, 'MAGAZINE/PICTURE/', 'ABC1-1.JPG', 1);
INSERT INTO MAGAZINE_MULTI_T VALUES(3, 'MAGAZINE/PICTURE/', 'ABC2.JPG', 0);
INSERT INTO MAGAZINE_MULTI_T VALUES(4, 'MAGAZINE/PICTURE/', 'ABC2-1.JPG', 1);
INSERT INTO MAGAZINE_MULTI_T VALUES(5, 'MAGAZINE/PICTURE/', 'ABC2-1.JPG', 1);
INSERT INTO MAGAZINE_MULTI_T VALUES(6, 'MAGAZINE/PICTURE/', 'ABC2-1.JPG', 1);
INSERT INTO MAGAZINE_MULTI_T VALUES(7, 'MAGAZINE/PICTURE/', 'ABC2-1.JPG', 1);
INSERT INTO MAGAZINE_MULTI_T VALUES(8, 'MAGAZINE/PICTURE/', 'ABC2-1.JPG', 1);
INSERT INTO MAGAZINE_MULTI_T VALUES(9, 'MAGAZINE/PICTURE/', 'ABC2-1.JPG', 1);
INSERT INTO MAGAZINE_MULTI_T VALUES(10, 'MAGAZINE/PICTURE/', 'ABC2-1.JPG', 1);
INSERT INTO MAGAZINE_MULTI_T VALUES(3, 'MAGAZINE/PICTURE/', 'ABC2-1.JPG', 1);
INSERT INTO MAGAZINE_MULTI_T VALUES(3, 'MAGAZINE/PICTURE/', 'ABC2-1.JPG', 1);

INSERT INTO MOUNTAIN_T VALUES(MOUNTAIN_SEQ.NEXTVAL, '한라산', '멋있음', '제주도');
INSERT INTO MOUNTAIN_T VALUES(MOUNTAIN_SEQ.NEXTVAL, '한라산2', '멋있음11', '제주도2');
INSERT INTO PRODUCT_T VALUES(PRODUCT_SEQ.NEXTVAL, 1, 1, '우당탕탕한라산', '엄청나요', '김세콩', '당일', 28000, '주의사항', TO_DATE('20231101', 'YYYYMMDD'), TO_DATE('20231201', 'YYYYMMDD'), 30, 14, '오전, 오후', 0, '약관동의');
INSERT INTO PRODUCT_T VALUES(PRODUCT_SEQ.NEXTVAL, 1, 2, '우당탕탕한라산2', '엄청나요!!!!', '김콩콩', '당일', 33000, '주의사항', TO_DATE('20230801', 'YYYYMMDD'), TO_DATE('20231021', 'YYYYMMDD'), 30, 55, '오전, 오후', 0, '약관동의');


INSERT INTO RESERVE_T VALUES(RESERVE_SEQ.NEXTVAL, TO_DATE('20231004', 'YYYYMMDD'), '예약하기 어렵다', 0, '서울역', 0, '2023/11/11', 3, 1, 1);
INSERT INTO RESERVE_T VALUES(RESERVE_SEQ.NEXTVAL, TO_DATE('20231004', 'YYYYMMDD'), '이건 요구사항입니다', 0, '동대문', 0, '2023/11/11', 2, 1, 1);
INSERT INTO RESERVE_T VALUES(RESERVE_SEQ.NEXTVAL, TO_DATE('20231004', 'YYYYMMDD'), '저는 유저4입니다', 0, '서울역', 0, '2023/11/11', 2, 4, 1);
INSERT INTO RESERVE_T VALUES(RESERVE_SEQ.NEXTVAL, TO_DATE('20231004', 'YYYYMMDD'), '나는 유저2', 0, '동대문', 0, '2023/11/11', 2, 2, 1);
INSERT INTO RESERVE_T VALUES(RESERVE_SEQ.NEXTVAL, TO_DATE('20231004', 'YYYYMMDD'), '저는 유저3이다', 0, '동대문', 0, '2023/11/11', 2, 3, 1);

INSERT INTO RESERVE_T VALUES(RESERVE_SEQ.NEXTVAL, TO_DATE('20231004', 'YYYYMMDD'), '예약하기 어렵다', 0, '서울역', 0, '2023/11/11', 3, 1, 2);
INSERT INTO RESERVE_T VALUES(RESERVE_SEQ.NEXTVAL, TO_DATE('20231004', 'YYYYMMDD'), '이건 요구사항입니다', 0, '동대문', 0, '2023/11/11', 2, 1, 2);
INSERT INTO RESERVE_T VALUES(RESERVE_SEQ.NEXTVAL, TO_DATE('20231004', 'YYYYMMDD'), '저는 유저4입니다', 0, '서울역', 0, '2023/11/11', 2, 4, 2);
INSERT INTO RESERVE_T VALUES(RESERVE_SEQ.NEXTVAL, TO_DATE('20231004', 'YYYYMMDD'), '나는 유저2', 0, '동대문', 0, '2023/11/11', 2, 2, 2);
INSERT INTO RESERVE_T VALUES(RESERVE_SEQ.NEXTVAL, TO_DATE('20231004', 'YYYYMMDD'), '저는 유저3이다', 0, '동대문', 0, '2023/11/11', 2, 3, 2);

INSERT INTO RESERVE_T VALUES(RESERVE_SEQ.NEXTVAL, TO_DATE('20231004', 'YYYYMMDD'), '예약하기 어렵다', 0, '서울역', 0, '2023/11/11', 3, 1, 3);
INSERT INTO RESERVE_T VALUES(RESERVE_SEQ.NEXTVAL, TO_DATE('20231004', 'YYYYMMDD'), '이건 요구사항입니다', 0, '동대문', 0, '2023/11/11', 2, 1, 3);
INSERT INTO RESERVE_T VALUES(RESERVE_SEQ.NEXTVAL, TO_DATE('20231004', 'YYYYMMDD'), '저는 유저4입니다', 0, '서울역', 0, '2023/11/11', 2, 4, 3);
INSERT INTO RESERVE_T VALUES(RESERVE_SEQ.NEXTVAL, TO_DATE('20231004', 'YYYYMMDD'), '나는 유저2', 0, '동대문', 0, '2023/11/11', 2, 2, 3);
INSERT INTO RESERVE_T VALUES(RESERVE_SEQ.NEXTVAL, TO_DATE('20231004', 'YYYYMMDD'), '저는 유저3이다', 0, '동대문', 0, '2023/11/11', 2, 3, 3);
INSERT INTO RESERVE_T VALUES(RESERVE_SEQ.NEXTVAL, TO_DATE('20231004', 'YYYYMMDD'), '예약하기 어렵다', 0, '서울역', 0, '2023/11/11', 3, 1, 3);
INSERT INTO RESERVE_T VALUES(RESERVE_SEQ.NEXTVAL, TO_DATE('20231004', 'YYYYMMDD'), '이건 요구사항입니다', 0, '동대문', 0, '2023/11/11', 2, 1, 3);
INSERT INTO RESERVE_T VALUES(RESERVE_SEQ.NEXTVAL, TO_DATE('20231004', 'YYYYMMDD'), '저는 유저4입니다', 0, '서울역', 0, '2023/11/11', 2, 4, 3);
INSERT INTO RESERVE_T VALUES(RESERVE_SEQ.NEXTVAL, TO_DATE('20231004', 'YYYYMMDD'), '나는 유저2', 0, '동대문', 0, '2023/11/11', 2, 2, 3);
INSERT INTO RESERVE_T VALUES(RESERVE_SEQ.NEXTVAL, TO_DATE('20231004', 'YYYYMMDD'), '저는 유저3이다', 0, '동대문', 0, '2023/11/11', 2, 3, 3);
INSERT INTO RESERVE_T VALUES(RESERVE_SEQ.NEXTVAL, TO_DATE('20231004', 'YYYYMMDD'), '예약하기 어렵다', 0, '서울역', 0, '2023/11/11', 3, 1, 3);
INSERT INTO RESERVE_T VALUES(RESERVE_SEQ.NEXTVAL, TO_DATE('20231004', 'YYYYMMDD'), '이건 요구사항입니다', 0, '동대문', 0, '2023/11/11', 2, 1, 3);
INSERT INTO RESERVE_T VALUES(RESERVE_SEQ.NEXTVAL, TO_DATE('20231004', 'YYYYMMDD'), '저는 유저4입니다', 0, '서울역', 0, '2023/11/11', 2, 4, 3);
INSERT INTO RESERVE_T VALUES(RESERVE_SEQ.NEXTVAL, TO_DATE('20231004', 'YYYYMMDD'), '나는 유저2', 0, '동대문', 0, '2023/11/11', 2, 2, 3);
INSERT INTO RESERVE_T VALUES(RESERVE_SEQ.NEXTVAL, TO_DATE('20231004', 'YYYYMMDD'), '저는 유저3이다', 0, '동대문', 0, '2023/11/11', 2, 3, 3);
INSERT INTO RESERVE_T VALUES(RESERVE_SEQ.NEXTVAL, TO_DATE('20231004', 'YYYYMMDD'), '예약하기 어렵다', 0, '서울역', 0, '2023/11/11', 3, 1, 3);
INSERT INTO RESERVE_T VALUES(RESERVE_SEQ.NEXTVAL, TO_DATE('20231004', 'YYYYMMDD'), '이건 요구사항입니다', 0, '동대문', 0, '2023/11/11', 2, 1, 3);
INSERT INTO RESERVE_T VALUES(RESERVE_SEQ.NEXTVAL, TO_DATE('20231004', 'YYYYMMDD'), '저는 유저4입니다', 0, '서울역', 0, '2023/11/11', 2, 4, 3);
INSERT INTO RESERVE_T VALUES(RESERVE_SEQ.NEXTVAL, TO_DATE('20231004', 'YYYYMMDD'), '나는 유저2', 0, '동대문', 0, '2023/11/11', 2, 2, 3);
INSERT INTO RESERVE_T VALUES(RESERVE_SEQ.NEXTVAL, TO_DATE('20231004', 'YYYYMMDD'), '저는 유저3이다', 0, '동대문', 0, '2023/11/11', 2, 3, 3);


INSERT INTO TOURIST_T VALUES(TOURIST_SEQ.NEXTVAL, '이종혁', '19930212', 'M', '01011111111', 0, 1);
INSERT INTO TOURIST_T VALUES(TOURIST_SEQ.NEXTVAL, '홍초딩', '20131111', 'F', '01022222222', 1, 1);
INSERT INTO TOURIST_T VALUES(TOURIST_SEQ.NEXTVAL, '박초딩', '20131111', 'F', '01012341234', 1, 1);
--예약번호2
INSERT INTO TOURIST_T VALUES(TOURIST_SEQ.NEXTVAL, '동대장', '20131111', 'F', '01022223333', 0, 2);
INSERT INTO TOURIST_T VALUES(TOURIST_SEQ.NEXTVAL, '동동대장','20131111', 'M', '01044444444', 0, 2);
INSERT INTO TOURIST_T VALUES(TOURIST_SEQ.NEXTVAL, '동동대장','20131111', 'M', '01044444444', 0, 2);
INSERT INTO TOURIST_T VALUES(TOURIST_SEQ.NEXTVAL, '동동대장','20131111', 'M', '01044444444', 0, 2);
INSERT INTO TOURIST_T VALUES(TOURIST_SEQ.NEXTVAL, '동동대장','20131111', 'M', '01044444444', 0, 2);
INSERT INTO TOURIST_T VALUES(TOURIST_SEQ.NEXTVAL, '동동대장','20131111', 'M', '01044444444', 0, 2);
INSERT INTO TOURIST_T VALUES(TOURIST_SEQ.NEXTVAL, '동동대장','20131111', 'M', '01044444444', 0, 2);
INSERT INTO TOURIST_T VALUES(TOURIST_SEQ.NEXTVAL, '동동대장','20131111', 'M', '01044444444', 0, 2);
INSERT INTO TOURIST_T VALUES(TOURIST_SEQ.NEXTVAL, '동동대장','20131111', 'M', '01044444444', 0, 2);
INSERT INTO TOURIST_T VALUES(TOURIST_SEQ.NEXTVAL, '동동대장','20131111', 'M', '01044444444', 0, 2);

--예약번호3
INSERT INTO TOURIST_T VALUES(TOURIST_SEQ.NEXTVAL, '유저4본인', '20131111', 'F', '01099999999', 0, 3);
INSERT INTO TOURIST_T VALUES(TOURIST_SEQ.NEXTVAL, '유저4동행','20131111', 'F', '01088888888', 0, 3);
--예약번호4
INSERT INTO TOURIST_T VALUES(TOURIST_SEQ.NEXTVAL, '유저2엄마', '19660101', 'F', '01098769876', 0, 4);
INSERT INTO TOURIST_T VALUES(TOURIST_SEQ.NEXTVAL, '유저2아빠','19660202', 'M', '01067896789', 0, 4);
INSERT INTO TOURIST_T VALUES(TOURIST_SEQ.NEXTVAL, '유저2아빠','19660202', 'M', '01067896789', 0, 4);
INSERT INTO TOURIST_T VALUES(TOURIST_SEQ.NEXTVAL, '유저2아빠','19660202', 'M', '01067896789', 0, 4);
INSERT INTO TOURIST_T VALUES(TOURIST_SEQ.NEXTVAL, '유저2아빠','19660202', 'M', '01067896789', 0, 4);
INSERT INTO TOURIST_T VALUES(TOURIST_SEQ.NEXTVAL, '유저2아빠','19660202', 'M', '01067896789', 0, 4);
INSERT INTO TOURIST_T VALUES(TOURIST_SEQ.NEXTVAL, '유저2아빠','19660202', 'M', '01067896789', 0, 4);
INSERT INTO TOURIST_T VALUES(TOURIST_SEQ.NEXTVAL, '유저2아빠','19660202', 'M', '01067896789', 0, 4);
INSERT INTO TOURIST_T VALUES(TOURIST_SEQ.NEXTVAL, '유저2아빠','19660202', 'M', '01067896789', 0, 4);
--예약번호5
INSERT INTO TOURIST_T VALUES(TOURIST_SEQ.NEXTVAL, '유저3형', '19900101', 'M', '01088888888', 0, 5);
INSERT INTO TOURIST_T VALUES(TOURIST_SEQ.NEXTVAL, '유저3동생', '19990101', 'M', '01088888888', 0, 5);

-- 결제내역 
INSERT INTO PAYMENT_T VALUES(PAY_SEQ.NEXTVAL, 'Y', 'card', 'kookmin', '승인_어쩌구저쩌구', '20231004', 1);
INSERT INTO PAYMENT_T VALUES(PAY_SEQ.NEXTVAL, 'Y', 'card', 'WOORI', '승인_어쩌구저쩌구', '20231004', 2);
INSERT INTO PAYMENT_T VALUES(PAY_SEQ.NEXTVAL, 'Y', 'card', 'SHINHAN', '승인_어쩌구저쩌구', '20231004', 3);
COMMIT;


INSERT INTO MAGAZINE_STAR_T VALUES(1, 1);
INSERT INTO MAGAZINE_STAR_T VALUES(1, 2);
INSERT INTO MAGAZINE_STAR_T VALUES(1, 3);
INSERT INTO MAGAZINE_STAR_T VALUES(2, 1);
INSERT INTO MAGAZINE_STAR_T VALUES(3, 2);

commit;

SELECT M.TITLE, MM.FILESYS_NAME, MM.FILESYS_NAME, M.SUMMARY, MM.IS_THUMBNAIL
  FROM MAGAZINE_T M LEFT OUTER JOIN MAGAZINE_MULTI_T MM
    ON M.MAGAZINE_NO = MM.MAGAZINE_NO
 WHERE M.MAGAZINE_NO BETWEEN 1 AND 6
        AND MM.IS_THUMBNAIL = 1
  ORDER BY M.MAGAZINE_NO DESC;   


SELECT TITLE, MULTI_PATH, FILESYS_NAME, SUMMARY, IS_THUMBNAIL, HIT, CREATE_AT
  FROM (SELECT ROW_NUMBER() OVER(ORDER BY M.MAGAZINE_NO DESC) AS RN, 
        M.TITLE, MM.MULTI_PATH, MM.FILESYS_NAME, M.SUMMARY, MM.IS_THUMBNAIL, M.HIT, M.CREATE_AT
        FROM MAGAZINE_T M LEFT OUTER JOIN MAGAZINE_MULTI_T MM
          ON M.MAGAZINE_NO = MM.MAGAZINE_NO)
 WHERE IS_THUMBNAIL = 1 AND RN BETWEEN 1 AND 6;
 




SELECT MAX(MAGAZINE_NO) FROM MAGAZINE_T;

  
SELECT COUNT(*)
  FROM MAGAZINE_T;
  
SELECT MAGAZINE_NO, USER_NO, TITLE, CONTENTS, SUMMARY, CREATE_AT, PRODUCT_NO
  FROM MAGAZINE_T
    WHERE MAGAZINE_NO = 1;

SELECT COUNT(*)
  FROM MAGAZINE_STAR_T
 WHERE MAGAZINE_NO = 1; 


SELECT PRODUCT_NO
     FROM PRODUCT_T
    ORDER BY PRODUCT_NO DESC;
    
INSERT INTO MAGAZINE_T (MAGAZINE_NO, USER_NO, TITLE, CONTENTS, SUMMARY, CREATE_AT, PRODUCT_NO) 
     VALUES (MAGAZINE_SEQ.NEXTVAL, 1, '설악산1', '떠나요 설악산1', '설악산에는 눈이와요. 정말 많이 와요.1', TO_DATE(SYSDATE, 'YYYY-MM-DD HH24:MI:SS'), 1);
INSERT INTO MAGAZINE_MULTI_T (MAGAZINE_NO, MULTI_PATH, FILESYS_NAME, IS_THUMBNAIL) VALUES (3, 'MAGAZINE/PICTURE/', '555.JPG', 0);  

UPDATE MAGAZINE_T SET SUMMARY= 'dfk' where MAGAZINE_NO = 12;

DELETE FROM MAGAZINE_T WHERE MAGAZINE_NO = 10;

 SELECT MAGAZINE_NO, TITLE, MULTI_PATH, FILESYS_NAME, SUMMARY, IS_THUMBNAIL, HIT, CREATE_AT
  	 FROM (SELECT ROW_NUMBER() OVER(ORDER BY M.MAGAZINE_NO DESC) AS RN, 
           M.MAGAZINE_NO, M.TITLE, MM.MULTI_PATH, MM.FILESYS_NAME, M.SUMMARY, MM.IS_THUMBNAIL, M.HIT, M.CREATE_AT
           FROM MAGAZINE_T M LEFT OUTER JOIN MAGAZINE_MULTI_T MM
             ON M.MAGAZINE_NO = MM.MAGAZINE_NO
			 WHERE IS_THUMBNAIL = 1)
    WHERE RN BETWEEN 7 AND 10;
 
UPDATE MAGAZINE_T SET 
	TITLE = '수정1',
	CONTENTS = '수정1',
	PRODUCT_NO = 9
	WHERE MAGAZINE_NO = 1;
	
DELETE FROM MAGAZINE_MULTI_T WHERE MAGAZINE_NO = 1;	

SELECT MAGAZINE_NO, SUMMARY, MULTI_PATH, FILESYS_NAME, IS_THUMBNAIL
  FROM (SELECT M.MAGAZINE_NO, M.SUMMARY, MM.MULTI_PATH, MM.FILESYS_NAME, MM.IS_THUMBNAIL
   FROM MAGAZINE_T M LEFT OUTER JOIN MAGAZINE_MULTI_T MM
    ON M.MAGAZINE_NO = MM.MAGAZINE_NO
 WHERE IS_THUMBNAIL = 1)
 WHERE MAGAZINE_NO = 3;	
 
 UPDATE MAGAZINE_MULTI_T SET
   IS_THUMBNAIL = 0
   WHERE MAGAZINE_NO = 18 AND IS_THUMBNAIL IS NULL;

UPDATE MAGAZINE_MULTI_T SET
	MAGAZINE_NO = 1, 
	MULTI_PATH ="123", 
	FILESYS_NAME ="1234", 
	IS_THUMBNAIL = 0
WHERE MAGAZINE_NO = 1;	

UPDATE MAGAZINE_T SET 
	HIT = HIT+1
	WHERE MAGAZINE_NO = 1;	
    
DELETE FROM MAGAZINE_STAR_T WHERE USER_NO = 1 AND MAGAZINE_NO=1;

INSERT INTO MAGAZINE_STAR_T(MAGAZINE_NO, USER_NO) VALUES (1, 1);

SELECT COUNT(*) FROM MAGAZINE_STAR_T WHERE MAGAZINE_NO = 1 AND USER_NO =1;


SELECT PRODUCT_NO
FROM (
    SELECT PRODUCT_NO, RANK() OVER (ORDER BY SUM(RESERVE_PERSON) DESC) AS RN
    FROM RESERVE_T
    GROUP BY PRODUCT_NO
) 
WHERE RN BETWEEN 1 AND 3;

    
SELECT TRIP_NAME, LOCATION
  FROM PRODUCT_T P LEFT OUTER JOIN MOUNTAIN_T M
    ON P.MOUNTAIN_NO = M.MOUNTAIN_NO
  WHERE PRODUCT_NO = 1;
  
    


	