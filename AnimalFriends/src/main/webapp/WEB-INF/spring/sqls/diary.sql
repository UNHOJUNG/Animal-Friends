-- 입양일기 테이블
DROP TABLE DIARY CASCADE CONSTRAINTS;
DROP SEQUENCE DNOSEQ;

CREATE SEQUENCE DNOSEQ;
CREATE TABLE DIARY(
    DNO NUMBER PRIMARY KEY, 
    MNO NUMBER NOT NULL, 
    DCONTENT VARCHAR2(2000) NOT NULL,
    DDATE DATE NOT NULL, 
    DIARYIMG VARCHAR2(2000) NOT NULL, 
    DIARYTHUMBIMG VARCHAR2(2000) NOT NULL,
    DIARYLIKECNT NUMBER NOT NULL,

    CONSTRAINT FK_MNO_DIARY FOREIGN KEY(MNO) REFERENCES MEMBER(MNO)
);

--프로필 사진 테이블(나의 입양일기)
DROP TABLE PROFILETABLE CASCADE CONSTRAINTS;

CREATE TABLE PROFILETABLE(
    MNO NUMBER NOT NULL, 
    PROFILEIMG VARCHAR2(4000) NOT NULL, 
    PROFILETHUMBIMG VARCHAR2(4000) NOT NULL,

    CONSTRAINT FK_MNO_PROFILEIMG FOREIGN KEY(MNO) REFERENCES MEMBER(MNO)
);


SELECT * 
FROM DIARY;

SELECT * 
FROM PROFILETABLE;





-- 댓글, 대댓글 구현 관련
DROP TABLE DIARYREPLY CASCADE CONSTRAINTS;
DROP SEQUENCE DRNOSEQ;
DROP SEQUENCE DRGROUPNOSEQ;

CREATE SEQUENCE DRNOSEQ;
CREATE SEQUENCE DRGROUPNOSEQ;
CREATE TABLE DIARYREPLY(
    DRNO NUMBER PRIMARY KEY, 
    DNO NUMBER NOT NULL, 
    DRGROUPNO NUMBER NOT NULL,
    DRTITLETAB NUMBER NOT NULL, 
    DRGROUPSQ NUMBER NOT NULL, 
    MNO NUMBER NOT NULL, 
    DRCONTENT VARCHAR2(2000) NOT NULL, 
    DRDATE DATE NOT NULL, 
    
    CONSTRAINT FK_DNO_DIARYREPLY FOREIGN KEY(DNO) REFERENCES DIARY(DNO) ON DELETE CASCADE, 
    CONSTRAINT FK_MNO_DIARYREPLY FOREIGN KEY(MNO) REFERENCES MEMBER(MNO)
);

SELECT * 
FROM DIARYREPLY;

--마이다이어리 글 삭제 시 해당 댓글 함께 삭제되는 제약 조건 수정 및 추가
ALTER TABLE DIARYREPLY DROP CONSTRAINT FK_DNO_DIARYREPLY;

ALTER TABLE DIARYREPLY ADD CONSTRAINT FK_DNO_DIARYREPLY FOREIGN KEY(DNO) 
REFERENCES DIARY(DNO) ON DELETE CASCADE;

commit

-- 댓글, 대댓글 구현 관련
DROP TABLE DIARYREPLY CASCADE CONSTRAINTS;
DROP SEQUENCE DRNOSEQ;
DROP SEQUENCE DRGROUPNOSEQ;

CREATE SEQUENCE DRNOSEQ;
CREATE SEQUENCE DRGROUPNOSEQ;
CREATE TABLE DIARYREPLY(
    DRNO NUMBER PRIMARY KEY, 
    DNO NUMBER NOT NULL, 
    DRGROUPNO NUMBER NOT NULL,
    DRTITLETAB NUMBER NOT NULL, 
    DRGROUPSQ NUMBER NOT NULL, 
    MNO NUMBER NOT NULL, 
    DRCONTENT VARCHAR2(2000) NOT NULL, 
    DRDATE DATE NOT NULL, 

    CONSTRAINT FK_DNO_DIARYREPLY FOREIGN KEY(DNO) REFERENCES DIARY(DNO) ON DELETE CASCADE, 
    CONSTRAINT FK_MNO_DIARYREPLY FOREIGN KEY(MNO) REFERENCES MEMBER(MNO)
);


SELECT * FROM DIARYREPLY;


-- 좋아요 테이블
DROP TABLE LIKETABLE;
DROP SEQUENCE LIKENOSEQ;

CREATE SEQUENCE LIKENOSEQ;
CREATE TABLE LIKETABLE(
    LIKENO NUMBER PRIMARY KEY, 
    DNO NUMBER NOT NULL, 
    MNO NUMBER NOT NULL, 
    LIKEYN VARCHAR2(10) NOT NULL, 

    CONSTRAINT FK_MNO_LIKE FOREIGN KEY(MNO) REFERENCES MEMBER(MNO), 
    CONSTRAINT FK_DNO_LIKE FOREIGN KEY(DNO) REFERENCES DIARY(DNO) ON DELETE CASCADE, 
    CONSTRAINT LIKEYN_CHK CHECK(LIKEYN IN('Y','N'))
);

INSERT INTO LIKETABLE
VALUES(LIKENOSEQ.NEXTVAL, 3, 1, 'Y');

SELECT *
FROM LIKETABLE;


COMMIT
-----------------
SELECT *
	FROM LIKETABLE
	WHERE dno=3 AND mno=1
	
UPDATE LIKETABLE
		SET LIKEYN = 'N'
		WHERE DNO=3 AND MNO=1
	
UPDATE LIKETABLE
		SET LIKEYN = 'Y'
		WHERE DNO=3 AND MNO=1
	
	
	
INSERT INTO LIKETABLE
  		VALUES(LIKENOSEQ.NEXTVAL,
  				3,
  				2,
  				'Y'
  		)	
	
UPDATE DIARY
		SET DIARYLIKECNT = DIARYLIKECNT +1
		WHERE DNO=3
		
SELECT *
		FROM (
				SELECT ROW_NUMBER() OVER (ORDER BY DDATE DESC) NUM, DNO, MNO, DCONTENT,
						DDATE, TO_CHAR(DDATE, 'YYYY-MM-DD HH24:MI') AS ddateToChar, MNICK,
						DIARYIMG, DIARYTHUMBIMG, DIARYLIKECNT
				FROM DIARY A JOIN MEMBER USING(MNO)
				ORDER BY DDATE DESC
		)
		WHERE DNO = 3	


commit
		
