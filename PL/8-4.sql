create table t_update_after_each_row (
  txt varchar2(10)
);

create table log (
  txt varchar2(20)
);


create or replace trigger update_after_each_row 
  after update on t_update_after_each_row -- after SQL 문장이 실행된 다음 트리거가 실행됨
  for each row
begin  
  -- :new.txt := upper(:old.txt); -- ORA-04084: cannot change NEW values for this trigger type
                                -- 이 트리거 유형에 트리거 NEW 값을 변경할 수 없습니다" 
                                -- New trigger variables can only be changed in before row
                                -- insert or update triggers.
                                -- 새 트리거 변수는 행 insert 또는 update 트리거 이전(before)에서만 변경 될 수 있습니다.

  insert into log values ('old: ' || :old.txt);
  insert into log values ('new: ' || :new.txt);

end update_after_each_row;
/

insert into t_update_after_each_row values('one');
insert into t_update_after_each_row values('two');
insert into t_update_after_each_row values('three');
insert into t_update_after_each_row values('four');

update t_update_after_each_row 
set txt = txt || txt 
where substr(txt,1,1) = 't';

select * from t_update_after_each_row;

select * from log;

drop table t_update_after_each_row;
drop table log;
