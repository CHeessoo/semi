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

