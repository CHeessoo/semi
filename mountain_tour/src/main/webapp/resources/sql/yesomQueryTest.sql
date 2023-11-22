--시퀀스
DROP SEQUENCE USER_SEQ;

CREATE SEQUENCE USER_SEQ NOCACHE;

--테이블
DROP TABLE LEAVE_USER_T;
DROP TABLE ACCESS_T;
DROP TABLE USER_T;

-- 가입한 사용자
CREATE TABLE USER_T (
    USER_NO        NUMBER              NOT NULL,        -- PK
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
    PW_MODIFIED_AT DATE,                                -- 비밀번호 수정일
    JOINED_AT      DATE,                                -- 가입일
    CONSTRAINT PK_USER PRIMARY KEY(USER_NO)
);

-- 접속 기록
CREATE TABLE ACCESS_T (
    EMAIL    VARCHAR2(100 BYTE) NOT NULL,  -- 접속한 사용자
    LOGIN_AT DATE,                          -- 로그인 일시
    CONSTRAINT FK_USER_ACCESS FOREIGN KEY(EMAIL) REFERENCES USER_T(EMAIL) ON DELETE CASCADE
);

-- 탈퇴한 사용자
CREATE TABLE LEAVE_USER_T (
    EMAIL     VARCHAR2(50 BYTE) NOT NULL UNIQUE,  -- 탈퇴한 사용자 이메일
    JOINED_AT DATE,                               -- 가입일
    LEAVED_AT DATE,                                -- 탈퇴일
    CONSTRAINT PK_LEAVE_USER PRIMARY KEY(EMAIL)
);

-----------------------------------------------------------------------------------------------
-- 회원정보 삽입
INSERT INTO USER_T VALUES(USER_SEQ.NEXTVAL, 'user1@naver.com', STANDARD_HASH('1111', 'SHA256'), '사용자1', 'M', '01011111111', '11111', '디지털로', '가산동', '101동 101호', 0, 0, 1, TO_DATE('20231001', 'YYYYMMDD'), TO_DATE('20220101', 'YYYYMMDD'));
INSERT INTO USER_T VALUES(USER_SEQ.NEXTVAL, 'user2@naver.com', STANDARD_HASH('2222', 'SHA256'), '사용자2', 'F', '01022222222', '22222', '디지털로', '가산동', '102동 102호', 0, 0, 1, TO_DATE('20231002', 'YYYYMMDD'), TO_DATE('20220102', 'YYYYMMDD'));
INSERT INTO USER_T VALUES(USER_SEQ.NEXTVAL, 'user3@naver.com', STANDARD_HASH('3333', 'SHA256'), '사용자3', 'M', '01033333333', '33333', '디지털로', '가산동', '103동 103호', 0, 0, 1, TO_DATE('20231003', 'YYYYMMDD'), TO_DATE('20220103', 'YYYYMMDD'));
INSERT INTO USER_T VALUES(USER_SEQ.NEXTVAL, 'user4@naver.com', STANDARD_HASH('4444', 'SHA256'), '사용자4', 'F', '01044444444', '44444', '디지털로', '가산동', '104동 104호', 0, 0, 1, TO_DATE('20231004', 'YYYYMMDD'), TO_DATE('20220104', 'YYYYMMDD'));
COMMIT;

-- 회원정보 업데이트
UPDATE USER_T
   SET NAME='나예솜'
 WHERE USER_NO = '1';
 
-- 회원정보 조회
SELECT COUNT(*)
  FROM USER_T;

SELECT USER_NO, EMAIL, PW, NAME, GENDER, MOBILE, POSTCODE, ROAD_ADDRESS, JIBUN_ADDRESS, DETAIL_ADDRESS, AGREE, STATE, AUTH, PW_MODIFIED_AT, JOINED_AT
  FROM USER_T;
  
SELECT USER_NO, EMAIL, PW, NAME, GENDER, MOBILE, POSTCODE, ROAD_ADDRESS, JIBUN_ADDRESS, DETAIL_ADDRESS, AGREE, STATE, AUTH, PW_MODIFIED_AT, JOINED_AT
  FROM USER_T
 WHERE USER_NO = 2;

-- trigger before
CREATE OR REPLACE TRIGGER BEFORE_DELETE
    BEFORE 
    DELETE 
    ON USER_T
    FOR EACH ROW    
BEGIN
    INSERT INTO LEAVE_USER_T(
        EMAIL
        , JOINED_AT
        , LEAVED_AT
        ) VALUES(
        :OLD.EMAIL
        , :OLD.JOINED_AT
        , SYSDATE
    );
END;

-- 회원정보 삭제
DELETE 
  FROM USER_T
 WHERE NAME='나예솜';

--
SELECT U.USER_NO, H.PRODUCT_NO, P.TRIP_NAME, P.TRIP_CONTENTS
  FROM USER_T U INNER JOIN HEART_T H
    ON U.USER_NO = H.USER_NO INNER JOIN PRODUCT_T P
    ON H.PRODUCT_NO = P.PRODUCT_NO;

--
    SELECT A.USER_NO, A.PRODUCT_NO, A.TRIP_NAME, A.TRIP_CONTENTS
       FROM (SELECT ROW_NUMBER() OVER(ORDER BY U.USER_NO DESC) AS RN, U.USER_NO, H.PRODUCT_NO, P.TRIP_NAME, P.TRIP_CONTENTS
               FROM USER_T U INNER JOIN HEART_T H
                    ON U.USER_NO = H.USER_NO INNER JOIN PRODUCT_T P
                    ON H.PRODUCT_NO = P.PRODUCT_NO) A
       WHERE A.RN BETWEEN 1 AND 10
       
       
       
       