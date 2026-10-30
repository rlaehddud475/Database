Create database movieDB;
use movieDB;
create table movieTBL(movie_id int,
movie_title varchar(30),
movie_director varchar(20),
movie_star varchar(20),
movie_script longtext,
movie_film longblob)default charset = utf8mb4;
INSERT INTO movieTBL VALUES (1, '쉰들러 리스트', '스필버그', '리암 니슨', 
LOAD_FILE('C:\SQL\movies\Schindler.txt'), LOAD_FILE('C:\SQL\movies\Schindler.mp4'));
SELECT * FROM movieTBL;
SHOW variables LIKE 'max_allowed_packet';
SHOW variables LIKE 'secure_file_priv';


TRUNCATE movieTBL;

INSERT INTO movieTBL VALUES (1, '쉰들러 리스트', '스필버그', '리암 니슨', 
  LOAD_FILE('C:/SQL/Movies/Schindler.txt'), LOAD_FILE('C:/SQL/Movies/Schindler.mp4'));

INSERT INTO movieTBL VALUES (2, '쇼생크 탈출', '프랭크 다라본트', '팀 로빈스', 
  LOAD_FILE('C:/SQL/Movies/Shawshank.txt'), LOAD_FILE('C:/SQL/Movies/Shawshank.mp4'));

INSERT INTO movieTBL VALUES (3, '라스트 모히칸', '마이클 만', '다니엘 데이 루이스', 
  LOAD_FILE('C:/SQL/Movies/Mohican.txt'), LOAD_FILE('C:/SQL/Movies/Mohican.mp4'));

SELECT * FROM movieTBL;

SELECT movie_script FROM movieTBL WHERE movie_id=1
  INTO OUTFILE 'C:/SQL/Movies/Schindler_out.txt'
  LINES TERMINATED BY '\n';
  
  SELECT movie_film FROM movieTBL WHERE movie_id=3
  INTO DUMPFILE 'C:/Temp/movie/Mohican_out.mp4';