create table t_update_after_each_row (
  txt varchar2(10)
);

create table log (
  txt varchar2(20)
);


create or replace trigger update_after_each_row 
  after update on t_update_after_each_row -- after SQL ������ ����� ���� Ʈ���Ű� �����
  for each row
begin  
  -- :new.txt := upper(:old.txt); -- ORA-04084: cannot change NEW values for this trigger type
                                -- �� Ʈ���� ������ Ʈ���� NEW ���� ������ �� �����ϴ�" 
                                -- New trigger variables can only be changed in before row
                                -- insert or update triggers.
                                -- �� Ʈ���� ������ �� insert �Ǵ� update Ʈ���� ����(before)������ ���� �� �� �ֽ��ϴ�.

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
