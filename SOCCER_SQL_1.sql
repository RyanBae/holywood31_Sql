desc player;
create view pla as
select 
    player_id pid,
    PLAYER_NAME pname,
    TEAM_ID tid,
    E_PLAYER_NAME epname, 
    NICKNAME nname,
    JOIN_YYYY joy,
    POSITION pos,
    BACK_NO bano,
    NATION nat,
    BIRTH_DATE bdate,
    SOLAR sol,
    HEIGHT hei,
    WEIGHT wei
from player;
select * from pla;
select * from player;
select * from team;
desc team;
create view tea as
select 
    TEAM_ID tid,
    REGION_NAME rname, 
    TEAM_NAME tname,
    E_TEAM_NAME etn,
    ORIG_YYYY ory,
    STADIUM_ID sid,
    ZIP_CODE1 zcd1,
    ZIP_CODE2 zcd2,
    ADDRESS adr,
    DDD,
    TEL,
    FAX,
    HOMEPAGE hop,
    OWNER own
from team;
 select * from tea;

-- SQL_TEST_001
-- ��ü �౸�� ���. �̸� ��������

select t.tname "��ü �౸�� ���"
from tea t 
order by t.TNAME asc;

-- SQL_TEST_002
-- ������ ����(�ߺ�����,������ �����)

select distinct pos ������ 
from pla;

-- SQL_TEST_003
-- ������ ����(�ߺ�����,������ �������� ����)
-- nvl2()���

select distinct nvl2(pos ,pos,'����') ������ 
from pla;


-- SQL_TEST_004
-- ������(ID: K02)��Ű��
select * from tea;
select rname from tea;
select tid from tea; -- tid 
select * from pla;

select p.pname ����
from pla p
where p.tid like 'K02';

select p.pname �̸�, p.TID ID 
from pla p
where p.pname like '�����';

select p.pname �̸�
from pla p
where p.tid like 'K02'; 

-- �� 
select p.pname �̸� 
from pla p
where p.pos like 'GK' and p.tid like 'K02'
order by p.pname asc;


-- SQL_TEST_005
-- ������(ID: K02)Ű�� 170 �̻� ����
-- �̸鼭 ���� ������ ����
select * from pla;

select p.POS ������, p.pname �̸�
from pla p
where p.tid like 'K02' and p.HEI >= 170 and p.pname like '��%' ;


-- SQL_TEST_006
-- ������(ID: K02) ������ �̸�,
-- Ű�� ������ ����Ʈ (���� cm �� kg ����)
-- Ű�� �����԰� ������ "0" ǥ��
-- Ű ��������
select * from pla;

select concat(p.PNAME,'����')�̸�, 
    to_char (nvl2(p.hei,p.hei,'0')||'cm') Ű, 
    to_char (nvl2(p.wei,p.wei,'0')||'kg' ) ������
from pla p
where p.tid like 'K02'
order by p.hei desc;


-- SQL_TEST_007
-- ������(ID: K02) ������ �̸�,
-- Ű�� ������ ����Ʈ (���� cm �� kg ����)
-- Ű�� �����԰� ������ "0" ǥ��
-- BMI���� 
-- Ű ��������
--nvl2(weight,weight,'0')'kg'
select concat(player_name,'����')�̸�, 
    to_char (nvl2(height,height,'0')||'cm') Ű, 
    to_char (nvl2(weight,weight,'0')||'kg') ������,
    round(WEIGHT/(HEIGHT*HEIGHT)*10000, 2) "BMI ����"
from (select player_name, height, weight
      from player 
      where team_id like 'K02')
order by height desc;

-- SQL_TEST_008
-- ������(ID: K02) �� ������(ID: K10)������ �� 
--  �������� GK ��  ����
-- ����, ����� ��������

SELECT T.TEAM_NAME, P.POSITION, P.PLAYER_NAME 
FROM PLAYER P
    JOIN TEAM T
    ON P.TEAM_ID LIKE T.TEAM_ID
WHERE T.TEAM_ID IN('K02','K10') AND POSITION LIKE 'GK'
ORDER BY T.TEAM_NAME, P.PLAYER_NAME;

-- SQL_TEST_009
-- ������(ID: K02) �� ������(ID: K10)������ �� ��
-- Ű�� 180 �̻� 183 ������ ������
-- Ű, ����, ����� ��������

SELECT T.TEAM_NAME ����, P.PLAYER_NAME �̸�,  to_char(P.HEIGHT||'cm') Ű 
FROM (SELECT T.TEAM_ID, T.TEAM_NAME
      FROM TEAM T WHERE T.TEAM_ID IN('K02','K10')) T
    JOIN PLAYER P 
        ON T.TEAM_ID LIKE P.TEAM_ID
WHERE P.HEIGHT BETWEEN 180 AND 183
ORDER BY P.HEIGHT, T.TEAM_NAME, P.PLAYER_NAME ;


-- SOCCER_SQL_010
-- ��� ������ ��
-- �������� �������� ���� �������� ���� �̸�
-- ����, ����� ��������

SELECT T.TEAM_NAME ����, P.PLAYER_NAME �̸�
FROM (SELECT P.TEAM_ID, P.PLAYER_NAME 
        FROM PLAYER P WHERE P.POSITION IS NULL) P
    JOIN TEAM T
        ON P.TEAM_ID LIKE T.TEAM_ID
ORDER BY T.TEAM_NAME, P.PLAYER_NAME;

-- SOCCER_SQL_011
-- ���� ��Ÿ����� �����Ͽ�
-- ���̸�, ��Ÿ��� �̸� ���
 
SELECT T.TEAM_NAME ����, S.STADIUM_NAME ��Ÿ���
FROM TEAM T
    JOIN STADIUM S
    ON T.STADIUM_ID LIKE S.STADIUM_ID
ORDER BY T.TEAM_NAME ;



-- SOCCER_SQL_012
-- ���� ��Ÿ���, �������� �����Ͽ�
-- 2012�� 3�� 17�Ͽ� ���� �� ����� 
-- ���̸�, ��Ÿ���, ������� �̸� ���
-- �������̺� join �� ã�Ƽ� �ذ��Ͻÿ�

SELECT * FROM SCHEDULE;
SELECT * FROM TEAM;
SELECT * FROM STADIUM;

SELECT T.TEAM_NAME ����, S.STADIUM_NAME ��Ÿ���, 
        J.AWAYTEAM_ID "������ ID", J.SCHE_DATE �����ٳ�¥  
FROM STADIUM S
    JOIN SCHEDULE J 
    ON S.STADIUM_ID LIKE J.STADIUM_ID
    JOIN TEAM T 
    ON J.STADIUM_ID LIKE T.STADIUM_ID
WHERE J.SCHE_DATE LIKE '20120317'
ORDER BY T.TEAM_NAME; 

-- SOCCER_SQL_013
-- 2012�� 3�� 17�� ��⿡ 
-- ���� ��ƿ���� �Ҽ� ��Ű��(GK)
-- ����, ������,���� (����������), 
-- ��Ÿ���, ��⳯¥�� ���Ͻÿ�
-- �������� ���̸��� ������ ���ÿ�

SELECT P.PLAYER_NAME ������, P.POSITION ������,
       T.REGION_NAME||' '||T.TEAM_NAME ����, 
       S.STADIUM_NAME ��Ÿ���, J.SCHE_DATE �����ٳ�¥
       
FROM ( SELECT J.SCHE_DATE, J.HOMETEAM_ID, J.STADIUM_ID
       FROM SCHEDULE J
       WHERE J.SCHE_DATE LIKE '20120317' AND HOMETEAM_ID LIKE 'K03') J
    JOIN (SELECT S.STADIUM_ID, S.STADIUM_NAME
            FROM STADIUM S) S
        ON J.STADIUM_ID LIKE S.STADIUM_ID
    JOIN TEAM T 
        ON S.STADIUM_ID LIKE T.STADIUM_ID
    JOIN (SELECT P.TEAM_ID, P.POSITION, P.PLAYER_NAME
            FROM PLAYER P
            WHERE POSITION LIKE 'GK') P 
        ON T.TEAM_ID LIKE P.TEAM_ID
ORDER BY P.PLAYER_NAME; 


-- SOCCER_SQL_014
-- Ȩ���� 3���̻� ���̷� �¸��� ����� 
-- ����� �̸�, ��� ����
-- Ȩ�� �̸��� ������ �̸���
-- ���Ͻÿ�
SELECT * FROM SCHEDULE;
SELECT * FROM TEAM;
SELECT * FROM STADIUM;

SELECT * 
FROM SCHEDULE C
WHERE (C.HOME_SCORE-C.AWAY_SCORE) >=3 
ORDER BY C.HOME_SCORE DESC;

SELECT STADIUM_NAME ��Ÿ���, SCHE_DATE ��⳯¥ , 
       (T.REGION_NAME||' '|| T.TEAM_NAME) Ȩ��,
       (T.REGION_NAME ||' '||
       (SELECT T.TEAM_NAME
       FROM TEAM T
       WHERE C.AWAYTEAM_ID LIKE T.TEAM_ID
       ))������,
       HOME_SCORE "Ȩ�� ����", AWAY_SCORE "������ ����"
FROM (SELECT SCHE_DATE, HOME_SCORE, AWAY_SCORE, STADIUM_ID,
        HOMETEAM_ID, AWAYTEAM_ID
      FROM SCHEDULE C
      WHERE(C.HOME_SCORE-C.AWAY_SCORE) >=3 ) C
      JOIN STADIUM S
      ON C.STADIUM_ID LIKE S.STADIUM_ID
      JOIN TEAM T 
      ON S.HOMETEAM_ID LIKE T.TEAM_ID
ORDER BY HOME_SCORE DESC;


-- SOCCER_SQL_015
-- STADIUM �� ��ϵ� ��� �߿���
-- Ȩ���� ���� �������� ���� ��������
-- ī��Ʈ ���� 20

SELECT * FROM STADIUM;
SELECT * FROM TEAM;

SELECT COUNT(*) FROM STADIUM;

SELECT S.STADIUM_NAME, S.STADIUM_ID, S.SEAT_COUNT, 
       S.HOMETEAM_ID, S.HOMETEAM_ID, T.E_TEAM_NAME
FROM STADIUM S
     LEFT JOIN TEAM T
     ON S.STADIUM_ID LIKE T.STADIUM_ID;
     
SELECT S.STADIUM_NAME, S.STADIUM_ID, S.SEAT_COUNT, 
       S.HOMETEAM_ID, S.HOMETEAM_ID, 
       (SELECT T.E_TEAM_NAME
        FROM TEAM T
        WHERE T.STADIUM_ID LIKE S.STADIUM_ID) TEAM_NAME
FROM STADIUM S ;


-- SOCCER_SQL_016
-- ���Ű�� ��õ ������Ƽ������ ���Ű ���� ���� ���� 
-- ��ID, ����, ���Ű ����

SELECT * FROM PLAYER;
SELECT * FROM TEAM;
SELECT T.TEAM_ID, T.TEAM_NAME, P.PLAYER_NAME, P.HEIGHT
FROM PLAYER P
    JOIN TEAM T
    ON P.TEAM_ID LIKE T.TEAM_ID
WHERE P.TEAM_ID LIKE 'K04'
GROUP BY AVG(P.HEIGHT);    
--WHERE AVG(TEAM_ID);

SELECT * 
FROM PLAYER 
WHERE TEAM_ID LIKE 'K04';

SELECT AVG(HEIGHT)
      FROM PLAYER 
      WHERE TEAM_ID LIKE 'K04';

SELECT AVG(HEIGHT)
FROM PLAYER

GROUP BY TEAM_ID
ORDER BY TEAM_ID;

SELECT TEAM_ID, COUNT(TEAM_ID), ROUND(AVG(HEIGHT),2)
FROM PLAYER 
GROUP BY TEAM_ID
HAVING AVG(HEIGHT) < 180.51
ORDER BY AVG(HEIGHT);

--�� 
SELECT T.TEAM_ID �����̵�, T.TEAM_NAME ����, 
        TO_CHAR("ROUND(AVG(P.HEIGHT),2)") ���Ű
FROM (SELECT P.TEAM_ID, COUNT(P.TEAM_ID), ROUND(AVG(P.HEIGHT),2)
        FROM PLAYER P
        GROUP BY P.TEAM_ID
        HAVING AVG(P.HEIGHT) < 180.51
        ORDER BY AVG(P.HEIGHT)) P
       JOIN TEAM T
       ON P.TEAM_ID LIKE T.TEAM_ID
ORDER BY TO_CHAR("ROUND(AVG(P.HEIGHT),2)");



-- SOCCER_SQL_017
-- �������� MF �� ��������  �Ҽ����� �� ������, ��ѹ� ���

SELECT T.TEAM_NAME ����, P.PLAYER_NAME ������, P.BACK_NO ��ѹ� 
FROM (
       SELECT *
       FROM PLAYER 
       WHERE POSITION LIKE 'MF') P
      JOIN TEAM T
      ON P.TEAM_ID LIKE T.TEAM_ID
ORDER BY P.PLAYER_NAME;


-- SOCCER_SQL_018
-- ���� Űū ���� 5 ����, ����Ŭ, �� Ű ���� ������ ����

SELECT * FROM PLAYER;
SELECT HEIGHT
FROM PLAYER
WHERE HEIGHT IS NOT NULL
ORDER BY HEIGHT DESC; 

SELECT PLAYER_NAME ������, BACK_NO ��ѹ�, POSITION ������, HEIGHT Ű
FROM (
       SELECT HEIGHT, PLAYER_NAME, BACK_NO, POSITION
       FROM PLAYER
       WHERE HEIGHT IS NOT NULL
       ORDER BY HEIGHT DESC )
WHERE ROWNUM <= 5;       

SELECT PLAYER_NAME ������, BACK_NO ��ѹ�, POSITION ������, 
       (SELECT HEIGHT 
       FROM PLAYER P
       WHERE P.HEIGHT IS NOT NULL
       ORDER BY P.HEIGHT DESC ) Ű
FROM PLAYER P;
--WHERE ROWNUM P.HEIGHT <= 5;       

-- SOCCER_SQL_019
-- ���� �ڽ��� ���� ���� ���Ű���� ���� ���� ���� ���



-- SOCCER_SQL_020
-- 2012�� 5�� �Ѵް� ��Ⱑ �ִ� ����� ��ȸ
-- EXISTS ������ �׻� ���������� ����Ѵ�.
-- ���� �ƹ��� ������ �����ϴ� ���� ���� ���̶�
-- ������ �����ϴ� 1�Ǹ� ã���� �߰����� �˻��� �������� �ʴ´�