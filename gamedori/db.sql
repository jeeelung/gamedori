-- 회원 테이블
CREATE TABLE member(
member_no NUMBER PRIMARY KEY,
member_name varchar2(30) NOT NULL,
member_id varchar2(20) UNIQUE NOT NULL,
member_pw varchar2(16) NOT NULL,
member_nick varchar2(24) NOT NULL UNIQUE,
member_phone char(11) NOT NULL,
member_auth char(9) NOT NULL CHECK(member_auth IN('일반', '우수', '관리자')),
member_point NUMBER,
member_join_date DATE DEFAULT sysdate NOT NULL,
member_login_date DATE
);

-- 회원 시퀀스
CREATE SEQUENCE member_seq nocache;

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
CREATE SEQUENCE community_seq nocache;

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

-- faq 테이블
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
-- 일대일 문의 테이블
CREATE TABLE qna(
qna_no number PRIMARY KEY,
member_no REFERENCES member(member_no) ON DELETE CASCADE,
qna_head varchar2(6) CHECK(qna_head IN('회원', '게임', '포인트')),
qna_title varchar2(300) NOT NULL,
qna_content varchar2(4000) NOT NULL,
qna_date date DEFAULT sysdate NOT NULL,
qna_email varchar2(40) NOT NULL
);

-- 일대일 문의 시퀀스
CREATE SEQUENCE qna_seq nocache;

--댓글 테이블
CREATE TABLE reply(
reply_no NUMBER PRIMARY KEY,
member_no REFERENCES member(member_no) ON DELETE SET NULL,
reply_content varchar2(4000) NOT null,
reply_date DATE DEFAULT SYSDATE NOT NULL,
reply_super_no REFERENCES reply(reply_no) ON DELETE CASCADE NOT NULL,
reply_group_no NUMBER NOT NULL,
reply_depth NUMBER NOT NULL
);

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
CREATE SEQUENCE bookmark nocache;


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
CREATE TABLE faq_file_temporary(
faq_file_no number primary key,
faq_file_name varchar2(256) not null,
faq_file_size number not null check(faq_file_size>0),
faq_file_type char(10) not null,
faq_no references faq(faq_no) on delete cascade
);
create sequence faq_file_temporary_seq nocache;
SELECT faq_file_temporary_seq.nextval FROM dual;
SELECT f.member_no,f.FAQ_NO, f.FAQ_HEAD ,f.FAQ_TITLE, m.member_nick FROM member m INNER JOIN faq f ON m.member_no = f.member_no
select * from (select rownum rn, T.* from(SELECT * FROM FAQ
WHERE instr(#1, ?) > 0
ORDER BY FAQ_no desc)T )where rn between ? and ?
------ 파일 연결 테이블
-- 공지 파일 연결 테이블
CREATE TABLE notice_file(
notice_no REFERENCES notice(notice_no) ON DELETE CASCADE,
file_no REFERENCES files(file_no) ON DELETE CASCADE
);

-- 커뮤니티 파일 연결 테이블
CREATE TABLE community_file(
community_no REFERENCES community(commu_no) ON DELETE CASCADE,
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
SELECT * FROM MEMBER;