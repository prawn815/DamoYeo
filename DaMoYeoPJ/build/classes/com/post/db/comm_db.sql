
--테이블 및 시퀀스 초기화
DROP SEQUENCE COMM_BOARDSEQ;
DROP SEQUENCE ANSBOARDSEQ;
DROP TABLE COMM_BOARD;
DROP TABLE ANSBOARD;
DROP TABLE CHOICEBOARD;

--테이블 및 시퀀스 생성
CREATE SEQUENCE COMM_BOARDSEQ;
CREATE SEQUENCE ANSBOARDSEQ;

SELECT BOARDSEQ, MYID, BOARDNO, TITLE, CONTENT, REGDATE, VISITCNT, ADDR, R
FROM (SELECT BOARDSEQ, MYID, BOARDNO, TITLE, CONTENT, REGDATE, VISITCNT, ADDR, ROWNUM R
	  FROM (SELECT * FROM COMM_BOARD WHERE BOARDSEQ IN (SELECT DISTINCT BOARDSEQ FROM ANSBOARD WHERE MYID = 'bbqq0108') ORDER BY BOARDSEQ DESC)
	  WHERE ROWNUM <= 1*10)
WHERE R > ((1-1)*10);

SELECT COUNT(*) FROM (SELECT DISTINCT BOARDSEQ FROM ANSBOARD WHERE MYID = 'bbqq0108');

SELECT DISTINCT BOARDSEQ FROM ANSBOARD WHERE MYID = 'bbqq0108';

CREATE TABLE COMM_BOARD(
	BOARDSEQ NUMBER PRIMARY KEY,
	MYID VARCHAR2(100) NOT NULL,
	BOARDNO NUMBER NOT NULL,
	TITLE VARCHAR2(1000) NOT NULL,
	CONTENT VARCHAR2(4000) NOT NULL,
	REGDATE DATE NOT NULL,
	VISITCNT NUMBER,
	ADDR VARCHAR2(4000)
);
CREATE TABLE ANSBOARD(
	BOARDSEQ NUMBER NOT NULL,
	MYID VARCHAR2(100) NOT NULL,
	ANSNO NUMBER NOT NULL,
	GROUPNO NUMBER NOT NULL,
	GROUPSQ NUMBER NOT NULL,
	TTAB NUMBER NOT NULL,
	ANSCONTENT VARCHAR2(4000) NOT NULL,
	ANSREGDATE DATE NOT NULL
);
--CHOICE는 기본값으로 'N'을 받고 누르면 'Y,N'을 바꺼가면서 업데이트
CREATE TABLE CHOICEBOARD(
	BOARDSEQ NUMBER NOT NULL,
	MYID VARCHAR2(100) NOT NULL,
	CHOICE VARCHAR2(2) NOT NULL
);

--권한 변경 
ALTER TABLE COMM_BOARD ADD CONSTRAINT COMM_BOARD_FK FOREIGN KEY(MYID) REFERENCES LOGINBOARD(MYID);
ALTER TABLE ANSBOARD ADD CONSTRAINT ANSBOARD_FK FOREIGN KEY(BOARDSEQ) REFERENCES COMM_BOARD(BOARDSEQ);
ALTER TABLE ANSBOARD ADD CONSTRAINT ANSBOARD_FK2 FOREIGN KEY(MYID) REFERENCES LOGINBOARD(MYID);
ALTER TABLE CHOICEBOARD ADD CONSTRAINT CHOICEBOARD_FK FOREIGN KEY(BOARDSEQ) REFERENCES COMM_BOARD(BOARDSEQ);
ALTER TABLE CHOICEBOARD ADD CONSTRAINT CHOICEBOARD_FK2 FOREIGN KEY(MYID) REFERENCES LOGINBOARD(MYID);




--TEST
INSERT INTO LOGINBOARD VALUES('KH','KH');
INSERT INTO LOGINBOARD VALUES('SEWANG','SEWANG');
INSERT INTO LOGINBOARD VALUES('555','555');
INSERT INTO COMM_BOARD VALUES(COMM_BOARDSEQ.NEXTVAL, 'KH', 1, '1번은 무슨게시판?', '내용', SYSDATE, 0, 0, 0, '');
INSERT INTO COMM_BOARD VALUES(COMM_BOARDSEQ.NEXTVAL, 'KH', 2, '2번은 무슨게시판?', '내용', SYSDATE, 0, 0, 0, '');
INSERT INTO COMM_BOARD VALUES(COMM_BOARDSEQ.NEXTVAL, 'SEWANG', 2, '2번은 무슨게시판?', '수정 삭제 테스티 입니다.!!!!11111', SYSDATE, 0, 0, 0, '');
INSERT INTO COMM_BOARD VALUES(COMM_BOARDSEQ.NEXTVAL, 'SEWANG', 2, '1번은 무슨게시판?', '수정 삭제 테스티 입니다.!!!!2222222', SYSDATE, 0, 0, 0, '');
INSERT INTO ANSBOARD VALUES(5, 'SEWANG', ANSBOARDSEQ.NEXTVAL, 0, 0, 0, '안뇽??', SYSDATE);
INSERT INTO ANSBOARD VALUES(4, 'KH', ANSBOARDSEQ.NEXTVAL, 0, 0, 0, '안뇽??', SYSDATE);
INSERT INTO CHOICEBOARD VALUES(4, 'KH', 'Y');

SELECT BOARDSEQ, MYID, BOARDNO, TITLE, CONTENT, REGDATE, VISITCNT, ADDR FROM COMM_BOARD ORDER BY BOARDSEQ DESC
SELECT COUNT(*) FROM COMM_BOARD

SELECT COUNT(*) FROM ANSBOARD WHERE BOARDSEQ=5
SELECT * FROM CHOICEBOARD;
SELECT * FROM ANSBOARD;


INSERT INTO LOGINBOARD VALUES('tet','123456','최승언','M', 940502,'수원시 장안구','010-5577-4896','chldjs@naver.com','Y','ADMIN');
INSERT INTO LOGINBOARD VALUES('bbqq0108','123456','최승언','M', 940502,'수원시 장안구','010-5577-2','12@naver.com','Y','USER');

DELETE FROM ANSBOARD WHERE MYID='bbqq0108';
DELETE FROM CHOICEBOARD WHERE MYID='bbqq0108';
DELETE FROM COMM_BOARD WHERE MYID='bbqq0108';

--페이징 DB 코드 pagenum은 선택한 페이지수, pageview는 한 페이지에 보여질 갯수
SELECT BOARDSEQ, MYID, BOARDNO, TITLE, CONTENT, REGDATE, VISITCNT, GOODCNT, NOTGOODCNT, ADDR, R
FROM (SELECT BOARDSEQ, MYID, BOARDNO, TITLE, CONTENT, REGDATE, VISITCNT, GOODCNT, NOTGOODCNT, ADDR, ROWNUM R
	  FROM (SELECT * FROM COMM_BOARD ORDER BY BOARDSEQ DESC)
	  WHERE ROWNUM <= pagenum*pageview)
WHERE R > ((pagenum-1)*pageview)
