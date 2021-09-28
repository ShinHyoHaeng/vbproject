drop table institution;

create table if not exists institution(
	p_appDate DATE, 
	p_instAddress1 VARCHAR(50),
	p_instAddress2 VARCHAR(50),
	p_instAddress3 VARCHAR(50),
	p_instAddress4 VARCHAR(50),
	p_instName VARCHAR(50),
	p_instPhone VARCHAR(20),
	p_instWorkHour TEXT
)default charset=utf8;

select * from institution;

/* 기관 이름(p_instName)을 primary key로 지정 */
alter table institution add primary key(p_instName);

/* 테스트를 위한 데이터 입력 */
insert into institution values('2021-01-01', '대구광역시', '동구', '검사동', '1005-8', '동구보건소','053-662-3201','평일 09:00 - 18:00. 주말 및 공휴일 휴무');
insert into institution values('2021-01-01', '대구광역시', '동구', '효목동', '1084', '동구 예방접종센터','053-951-3300','평일 09:00 - 18:00. 주말 및 공휴일 휴무');


/* instTBL = institution table + vaccine table */
CREATE TABLE instTBL 
	SELECT I.p_appDate, I.p_instName, I.p_instAddress1, I.p_instAddress2, I.p_instAddress3, I.p_instAddress4, I.p_instPhone, I.p_instWorkHour, V.vac_time, V.vac_mdnTotal, V.vac_mdnUse, V.vac_pfzrTotal, V.vac_pfzrUse
		FROM institution I 
			JOIN vaccine V 
				ON I.p_instName=V.vac_inst;
			
select * from instTBL;
drop table instTBL;
select * from  institution where p_instAddress3 = '검사동';


/* 임시 저장 테이블(구조 복사) */
drop table instTBL;
drop table tmpInstTBL;
create table if not exists tmpInstTBL like instTBL;
select * from tmpInstTBL;

