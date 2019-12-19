create table t_update_before_each_row (
  txt varchar2(10)
);

create table log (
  txt varchar2(20)
);


-- insert�� :OLD �� �����ϴ�. 
-- delete�� :NEW �� �����ϴ�. 
-- :NEW, :OLD�� �Ѵ� �ִ� ���� update �� �Դϴ�.
-- FOR EACH ROW �� row�� ���ؼ� ����˴ϴ�. 
create or replace trigger update_before_each_row 
  before update on t_update_before_each_row -- before : SQL ������ ����Ǳ� �� Ʈ���Ű� ���� �����
  for each row
  
begin
  :new.txt := upper(:new.txt);  -- �빮�ڷ� ��ȯ�ϴ� ó��

  insert into log values ('old: ' || :old.txt); -- log ���̺� �߰� old: ���ڿ��� ��ģ�� 
  insert into log values ('new: ' || :new.txt); -- log ���̺� �߰� new: ���ڿ��� ��ģ��

end update_before_each_row;
/

insert into t_update_before_each_row values('one');
insert into t_update_before_each_row values('two');
insert into t_update_before_each_row values('three');
insert into t_update_before_each_row values('four');

select * from t_update_before_each_row;     -- Ȯ���� ����

select * from log;  -- Ȯ���� ����

update t_update_before_each_row set txt = txt || txt    -- Trigger�� �����Ͽ� �빮�ڷ� �ٲ�� �ȴ�
where substr(txt,1,1) = 't';

select * from t_update_before_each_row;

select * from log;

drop table t_update_before_each_row;
drop table log;


