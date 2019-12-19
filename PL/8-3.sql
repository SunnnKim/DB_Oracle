create table t_update_before_each_row (
  txt varchar2(10)
);

create table log (
  txt varchar2(20)
);


-- insert는 :OLD 가 없습니다. 
-- delete는 :NEW 가 없습니다. 
-- :NEW, :OLD가 둘다 있는 경우는 update 때 입니다.
-- FOR EACH ROW 각 row에 대해서 적용됩니다. 
create or replace trigger update_before_each_row 
  before update on t_update_before_each_row -- before : SQL 문장이 실행되기 전 트리거가 먼저 실행됨
  for each row
  
begin
  :new.txt := upper(:new.txt);  -- 대문자로 변환하는 처리

  insert into log values ('old: ' || :old.txt); -- log 테이블에 추가 old: 문자열과 합친다 
  insert into log values ('new: ' || :new.txt); -- log 테이블에 추가 new: 문자열과 합친다

end update_before_each_row;
/

insert into t_update_before_each_row values('one');
insert into t_update_before_each_row values('two');
insert into t_update_before_each_row values('three');
insert into t_update_before_each_row values('four');

select * from t_update_before_each_row;     -- 확인해 본다

select * from log;  -- 확인해 본다

update t_update_before_each_row set txt = txt || txt    -- Trigger가 동작하여 대문자로 바뀌게 된다
where substr(txt,1,1) = 't';

select * from t_update_before_each_row;

select * from log;

drop table t_update_before_each_row;
drop table log;


