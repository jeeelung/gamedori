-- 회원 테이블

CREATE TABLE member(

member_no NUMBER PRIMARY KEY,

member_name varchar2(30) NOT NULL,

member_id varchar2(20) UNIQUE NOT NULL,

member_pw varchar2(16) NOT NULL,

member_nick varchar2(24) NOT NULL UNIQUE,

member_phone varchar(11) NOT NULL,

member_auth varchar(9) NOT NULL CHECK(member_auth IN('일반', '우수', '관리자')),
member_point NUMBER,
member_join_date DATE DEFAULT sysdate NOT NULL,
member_login_date DATE
);
-- 회원 시퀀스
CREATE SEQUENCE member_seq nocache;
INSERT INTO MEMBER values(member_seq.nextval, '관리자', 'manager', 'manager','manager','01011112222','관리자',0,sysdate,sysdate);

 

-- 게임 테이블

CREATE TABLE game(

game_no NUMBER PRIMARY KEY,

member_no REFERENCES MEMBER(member_no) ON DELETE SET NULL,

game_name varchar2(60) NOT NULL,

game_relese DATE NOT NULL,

game_intro varchar2(4000),

game_play NUMBER DEFAULT 0 NOT NULL,

game_read number DEFAULT 0 NOT NULL

);

 

-- 게임 테이블 항목 수정

ALTER TABLE game DROP (game_relese);

ALTER TABLE game ADD game_date DATE DEFAULT sysdate NOT NULL; 

SELECT * FROM GAME g ;

 

-- 게임 이미지

CREATE TABLE game_img(

game_no REFERENCES game(game_no) ON DELETE CASCADE,

game_img_no NUMBER PRIMARY KEY,

game_img_name varchar2(256) NOT NULL,

game_img_type varchar2(30) NOT NULL,

game_img_size NUMBER NOT NULL

);

 

-- 게임 이미지 시퀀스

CREATE SEQUENCE game_img_seq nocache;

-- 게임 시퀀스

CREATE SEQUENCE game_seq nocache;

 

-- 장르 테이블

CREATE TABLE genre(

genre_no NUMBER PRIMARY KEY,

genre_type varchar2(15) NOT NULL

);

 

-- 장르 시퀀스

CREATE SEQUENCE genre_seq nocache;

 

-- 포인트 유형 테이블

CREATE TABLE point(

point_no NUMBER PRIMARY KEY,

point_type varchar2(90) NOT NULL,

point_score NUMBER NOT NULL

);

INSERT INTO point values(point_seq.nextval, '회원가입', 100000);

-- 포인트 유형 시퀀스

CREATE SEQUENCE point_seq nocache;

 

-- 포인트 변동내역 테이블

CREATE TABLE point_variance(

point_vari_no number PRIMARY KEY,

member_no REFERENCES member(member_no) ON DELETE CASCADE,

point_no REFERENCES point(point_no) ON DELETE SET NULL,

point_vari_date DATE DEFAULT sysdate NOT NULL

);

 

-- 포인트 변동내역 시퀀스

CREATE SEQUENCE point_vari_seq nocache;

 

-- 회원 관심분야 테이블

CREATE TABLE member_favorite(

member_favorite_no NUMBER PRIMARY KEY,

genre_no REFERENCES genre(genre_no) ON DELETE CASCADE,

member_no REFERENCES member(member_no) ON DELETE CASCADE

);

 

-- 회원 관심분야 시퀀스

CREATE SEQUENCE member_favorite_seq nocache;

 

-- 게임 장르 테이블

CREATE TABLE game_genre(

game_genre_no NUMBER PRIMARY KEY,

genre_no REFERENCES genre(genre_no) ON DELETE CASCADE,

game_no REFERENCES game(game_no) ON DELETE CASCADE

);

INSERT INTO genre values(genre_seq.nextval,'액션');

INSERT INTO genre values(genre_seq.nextval,'슈팅');

INSERT INTO genre values(genre_seq.nextval,'아케이드');

INSERT INTO genre values(genre_seq.nextval,'스포츠');

INSERT INTO genre values(genre_seq.nextval,'퍼즐/보드');

INSERT INTO genre values(genre_seq.nextval,'전략/시뮬');

INSERT INTO genre values(genre_seq.nextval,'어드벤처');

INSERT INTO genre values(genre_seq.nextval,'기타');

-- 게임 장르 시퀀스

CREATE SEQUENCE game_genre_seq nocache;

-- 커뮤니티 테이블

CREATE TABLE community(

commu_no NUMBER PRIMARY KEY,

member_no REFERENCES member(member_no) ON DELETE SET NULL,

commu_head varchar2(12) NOT NULL CHECK(commu_head IN ('공략', '유머', '자유')),

commu_title varchar2(300) NOT NULL,

commu_content varchar2(4000) NOT NULL,

commu_date DATE DEFAULT sysdate NOT NULL,

commu_read NUMBER DEFAULT 0 NOT NULL,

commu_replycount number DEFAULT 0 NOT NULL,

commu_super_no REFERENCES community(commu_no) ON DELETE CASCADE,

commu_group_no number NOT NULL,

commu_depth number NOT NULL

);

 

-- 커뮤니티 시퀀스

CREATE SEQUENCE commu_seq nocache;

 

--공지사항 테이블

CREATE TABLE notice(

notice_no NUMBER PRIMARY KEY,

member_no REFERENCES member(member_no) ON DELETE SET null,

notice_title varchar2(300) NOT null,

notice_content varchar2(4000) NOT NULL,

notice_date DATE DEFAULT sysdate NOT NULL,

notice_read NUMBER DEFAULT 0 NOT null

);

 

-- 공지 시퀀스

CREATE SEQUENCE notice_seq nocache;

 

-- 이벤트 테이블

CREATE TABLE event(

event_no number PRIMARY KEY,

member_no REFERENCES MEMBER(member_no) ON DELETE SET NULL,

event_title varchar2(300) NOT NULL,

event_content varchar2(4000),

event_date date DEFAULT sysdate NOT NULL,

event_read number DEFAULT 0 NOT NULL

);

 

-- 이벤트 시퀀스

CREATE SEQUENCE event_seq nocache;

-- 이벤트 응모내역 테이블

CREATE TABLE event_partici(

event_partici_no NUMBER PRIMARY KEY,

member_no REFERENCES member(member_no) ON DELETE CASCADE,

event_no REFERENCES event(event_no) ON DELETE CASCADE,

event_partici_date DATE DEFAULT sysdate NOT NULL

);

 

-- 응모내역 시퀀스

CREATE SEQUENCE event_partici_seq nocache;

 

--faq

CREATE TABLE faq(

faq_no NUMBER PRIMARY KEY,

member_no REFERENCES member(member_no) ON DELETE SET NULL,

faq_head char(12) check(faq_head IN('회원문의','게임문의')),

faq_title varchar2(300) NOT NULL,

faq_content varchar2(4000) NOT NULL

);

ALTER TABLE faq MODIFY (faq_head CHAR(18));

-- faq 시퀀스

CREATE SEQUENCE faq_seq nocache;



 

CREATE TABLE qna(

qna_no number PRIMARY KEY,

member_no REFERENCES member(member_no) ON DELETE CASCADE,

qna_head varchar2(6) CHECK(qna_head IN('회원', '게임', '포인트')),

qna_title varchar2(300) NOT NULL,

qna_content varchar2(4000) NOT NULL,

qna_email varchar2(40) NOT NULL,

qna_date date DEFAULT sysdate NOT NULL,

qna_answer varchar2(4000) DEFAULT NULL

);

 

 

-- 일대일 문의 시퀀스

CREATE SEQUENCE qna_seq nocache;

--댓글 테이블

CREATE TABLE reply(

reply_no NUMBER PRIMARY KEY,

member_no REFERENCES member(member_no) ON DELETE SET NULL,

reply_content varchar2(4000) NOT null,

reply_date DATE DEFAULT SYSDATE NOT NULL,

origin_no NUMBER NOT NULL

);

 

--댓글 테이블 수정

ALTER TABLE reply DROP (reply_super_no);

ALTER TABLE reply DROP (reply_group_no);

ALTER TABLE reply DROP (reply_depth);

ALTER TABLE reply ADD origin_no number NOT NULL;

 

-- 댓글 시퀀스

CREATE SEQUENCE reply_seq nocache;

 

-- 게임 리뷰 테이블

CREATE TABLE review(

review_no NUMBER PRIMARY KEY,

game_no REFERENCES game(game_no) ON DELETE CASCADE NOT NULL,

member_no REFERENCES member(member_no) ON DELETE SET NULL,

review_score NUMBER NOT NULL,

review_content varchar2(4000) NOT NULL,

review_date DATE DEFAULT sysdate NOT NULL,

review_super_no REFERENCES review(review_no) ON DELETE CASCADE,

review_group_no number NOT NULL,

review_depth number NOT NULL

);

 

-- 게임 리뷰 시퀀스

CREATE SEQUENCE review_seq nocache;

-- 좋아요(게임) 테이블

CREATE TABLE game_like(

game_like_no NUMBER PRIMARY KEY,

member_no REFERENCES member(member_no) ON DELETE CASCADE,

game_no REFERENCES game(game_no) ON DELETE CASCADE

);

 

-- 좋아요(게임) 시퀀스

CREATE SEQUENCE game_like_seq nocache;

 

-- 좋아요(리뷰) 테이블

CREATE TABLE review_like(

review_like_no number PRIMARY KEY,

review_no REFERENCES review(review_no) ON DELETE CASCADE,

member_no REFERENCES member(member_no) ON DELETE CASCADE

);

 

-- 좋아요(리뷰) 시퀀스

CREATE SEQUENCE review_like_seq nocache;

 

-- 즐겨찾기 테이블

CREATE TABLE bookmark(

bookmark_no NUMBER PRIMARY KEY,

member_no REFERENCES member(member_no) ON DELETE CASCADE,

game_no REFERENCES game(game_no) ON DELETE CASCADE,

game_link varchar2(4000) NOT NULL

);

 

-- 즐겨찾기 시퀀스

CREATE SEQUENCE bookmark_seq nocache;

 

 

-- 추천인 테이블

CREATE TABLE recommend(

rc_no number PRIMARY KEY,

rc_recommend REFERENCES member(member_no) ON DELETE CASCADE,

rc_recommended REFERENCES MEMBER(member_no) ON DELETE CASCADE,

rc_date date DEFAULT sysdate NOT NULL

);

 

-- 추천인 시퀀스

CREATE SEQUENCE rc_seq nocache;

 

-- 파일 테이블

CREATE TABLE files(

file_no NUMBER PRIMARY KEY,

file_name varchar2(256) NOT NULL,

file_size NUMBER NOT NULL,

file_type varchar2(30)NOT NULL

);

-- 파일 시퀀스

CREATE SEQUENCE file_seq nocache;

 

------ 파일 연결 테이블

-- 공지 파일 연결 테이블

CREATE TABLE notice_file(

notice_no REFERENCES notice(notice_no) ON DELETE CASCADE,

file_no REFERENCES files(file_no) ON DELETE CASCADE
);

 

-- 커뮤니티 파일 연결 테이블

CREATE TABLE community_file(
commu_no REFERENCES community(commu_no) ON DELETE CASCADE,
file_no REFERENCES files(file_no) ON DELETE CASCADE
);

 

 

-- faq 파일 연결 테이블

CREATE TABLE faq_file(
faq_no REFERENCES faq(faq_no) ON DELETE CASCADE,
file_no REFERENCES files(file_no) ON DELETE CASCADE
);

 

-- 일대일 문의 파일 연결 테이블

CREATE TABLE qna_file(
qna_no REFERENCES qna(qna_no) ON DELETE CASCADE,
file_no REFERENCES files(file_no) ON DELETE CASCADE
);

 

-- 이벤트 파일 연결 테이블

CREATE TABLE event_file(
event_no REFERENCES event(event_no) ON DELETE CASCADE,
file_no REFERENCES files(file_no) ON DELETE CASCADE
);

 

-- 게임 파일 연결 테이블
CREATE TABLE game_file(
game_no REFERENCES game(game_no) ON DELETE CASCADE,
file_no REFERENCES files(file_no) ON DELETE CASCADE
);

 

------ 댓글 연결 테이블
-- 커뮤니티 댓글 연결 테이블

CREATE TABLE community_reply(

commu_no REFERENCES community(commu_no) ON DELETE CASCADE,

reply_no REFERENCES reply(reply_no) ON DELETE CASCADE

);

 

-- 일대일 문의 답글 테이블

CREATE TABLE qna_reply(

qna_no REFERENCES qna(qna_no) ON DELETE CASCADE,

reply_no REFERENCES reply(reply_no) ON DELETE CASCADE

);

CREATE VIEW game_writer AS SELECT g.*, m.member_nick FROM game g INNER JOIN MEMBER m ON g.MEMBER_NO = m.MEMBER_NO ;

CREATE VIEW commu_writer AS SELECT c.*, m.member_nick FROM MEMBER m INNER JOIN COMMUNITY c ON c.member_no = m.member_no;

CREATE VIEW member_genre_type AS SELECT mf.MEMBER_NO,g.genre_type, g.GENRE_NO FROM GENRE g INNER JOIN member_favorite mf ON g.GENRE_NO = mf.genre_no;

-- 뷰

CREATE VIEW game_list AS SELECT gg.genre_no, gg.genre_type, a.* FROM game_genre_type gg INNER JOIN (select gw.member_no, gw.member_nick, gw.game_name, gw.game_date, gi.* from

game_writer gw inner join game_img gi on gw.game_no = gi.game_no)a ON gg.game_no = a.game_no;

CREATE VIEW game_popular AS SELECT gl.*, g.GAME_READ FROM game_list gl INNER JOIN game g ON gl.GAME_NO = g.game_no ORDER BY g.game_read DESC, gl.GAME_DATE DESC;

CREATE VIEW game_genre_type AS SELECT g.genre_no, g.genre_type, gg.game_no FROM game_genre gg INNER JOIN genre g ON gg.genre_no = g.genre_no;

 

CREATE TABLE point_history(

point_his_no NUMBER PRIMARY KEY,

member_no REFERENCES member(member_no) ON DELETE CASCADE,

point_no REFERENCES point(point_no) ON DELETE CASCADE,

point_his_date DATE DEFAULT sysdate NOT null

);

CREATE SEQUENCE point_his_seq nocache;