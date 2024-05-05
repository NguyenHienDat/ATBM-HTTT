alter session set "_oracle_script"=true;
ALTER SESSION SET CONTAINER = PDBProject;
ALTER DATABASE OPEN;

-- CS#1
Create role NhanVienCoBan;

Create or replace view ATBM.v_NhanVien as
Select *
From ATBM.NHANSU
Where MANV = SYS_CONTEXT ('userenv', 'session_user');

Create or replace view ATBM.v2_NhanVien as
Select DT
From ATBM.NHANSU
Where MANV = SYS_CONTEXT ('userenv', 'session_user');

Grant select on ATBM.v_NhanVien to NhanVienCoBan;
Grant update on ATBM.v2_NhanVien to NhanVienCoBan;
Grant select on ATBM.SINHVIEN to NhanVienCoBan;
Grant select on ATBM.DONVI to NhanVienCoBan;
Grant select on ATBM.HOCPHAN to NhanVienCoBan;
Grant select on ATBM.KHMO to NhanVienCoBan;
-- CS#2 
Create role GiangVien;

Create or replace view ATBM.v_GiangVien as
Select *
From ATBM.PHANCONG
Where MAGV = SYS_CONTEXT ('userenv', 'session_user');

Create or replace view ATBM.v2_GiangVien as
Select *
From ATBM.DANGKY
Where MAGV = SYS_CONTEXT ('userenv', 'session_user');

Create or replace view ATBM.v3_GiangVien as
Select DIEMTH,DIEMQT,DIEMCK,DIEMTK
From ATBM.DANGKY
Where MAGV = SYS_CONTEXT ('userenv', 'session_user');

Grant NhanVienCoBan to GiangVien;
Grant select on ATBM.v_GiangVien to GiangVien;
Grant select on ATBM.v2_GiangVien to GiangVien;
Grant update(DIEMTH, DIEMQT, DIEMCK, DIEMTK) on ATBM.v2_GiangVien to GiangVien;

-- CS#3
Create role GiaoVu;


create or replace function vpd_giaovu_phancong
(p_schema varchar2, p_obj varchar2)
return varchar2
as
    user_id varchar2(10);
    vaitro nvarchar2(50);
begin
    user_id := SYS_CONTEXT('USERENV', 'SESSION_USER');
    SELECT VAITRO INTO vaitro FROM ATBM.NHANSU WHERE MANV = user_id;
    if vaitro = 'Giao vu' then
        return 'MAHP in (select hp.MAHP from ATBM.HOCPHAN hp where MADV = ''DV001'')';
    end if;
    return null;
end;
/


CREATE OR REPLACE FUNCTION vpd_giaovu_dangky(p_schema varchar2, p_obj varchar2)
RETURN VARCHAR2 
AS
    current_date DATE;
    user_id varchar2(10);
    vaitro nvarchar2(50);
    day NUMBER;
    month NUMBER;
    year NUMBER;
    hocki VARCHAR2(10);
    result VARCHAR2(4000);
BEGIN
  -- Get the current date
    SELECT SYSDATE INTO current_date FROM dual;
    SELECT
        EXTRACT(DAY FROM current_date),
        EXTRACT(MONTH FROM current_date),
        EXTRACT(YEAR from current_date)
    INTO day, month, year
    FROM dual; 
    
    user_id := SYS_CONTEXT('USERENV', 'SESSION_USER');
    DBMS_OUTPUT.PUT_LINE('User ID: ' || user_id);
    SELECT VAITRO INTO vaitro FROM ATBM.NHANSU WHERE MANV = user_id;
    DBMS_OUTPUT.PUT_LINE('vai tro: ' || vaitro);
    if vaitro = 'Giao vu' then
        if month = 1 or month = 5 or month = 9 then
          

            if day - 1 <= 14 then
                if month = 1 then
                    hocki := 'HK1';
                elsif month = 5 then
                    DBMS_OUTPUT.PUT_LINE(month);
                    hocki := 'HK2';
                elsif month = 9 then
                    hocki := 'HK3';
                end if;
                result:= 'HK = ''' || hocki || ''' and NAM = ''' || TO_CHAR(year) || '''';
            else
                result:='1=0';
            end if;
        else
             result:= '1=0';
        end if;
    end if; 
    DBMS_OUTPUT.PUT_LINE(result);
    return result;
END;




--BEGIN
--DBMS_RLS.ADD_POLICY(
--
--    object_schema => 'ATBM',
--    object_name => 'NHANSU',
--    policy_name => 'policy_giaovu_nhansu',
--    policy_function => 'policy_giaovu_nhansu',
--    statement_types => 'SELECT, UPDATE',
--    update_check      => true
--);
--END;



BEGIN
DBMS_RLS.ADD_POLICY(

    object_schema => 'ATBM',
    object_name => 'PHANCONG',
    policy_name => 'vpd_giaovu_phancong',
    policy_function => 'vpd_giaovu_phancong',
    statement_types => 'UPDATE',
    update_check      => true
);
END;



BEGIN
DBMS_RLS.ADD_POLICY(

    object_schema => 'ATBM',
    object_name => 'DANGKY',
    policy_name => 'vpd_giaovu_dangky',
    policy_function => 'vpd_giaovu_dangky',
    statement_types => 'INSERT, DELETE',
    update_check      => true
);
END;

grant NhanVienCoBan to GiaoVu;
grant select, update on ATBM.PHANCONG to GiaoVu;
grant select, insert, update, delete on ATBM.DANGKY to GiaoVu;

GRANT SELECT, INSERT, UPDATE ON ATBM.SINHVIEN TO GiaoVu;
GRANT SELECT, INSERT, UPDATE ON ATBM.DONVI TO GiaoVu;
GRANT SELECT, INSERT, UPDATE ON ATBM.HOCPHAN TO GiaoVu;
GRANT SELECT, INSERT, UPDATE ON ATBM.KHMO TO GiaoVu;

-- CS#4
Create role TruongDonVi;

Create or replace view ATBM.v_TruongDonVi as
Select pc.*
From ATBM.PHANCONG pc,ATBM.HOCPHAN hp,ATBM.DONVI dvi
Where pc.MAHP = hp.MAHP and hp.MADV = dvi.MADV and dvi.TRGDV = SYS_CONTEXT ('userenv', 'session_user');

Create or replace view ATBM.v2_TruongDonVi as
Select pc.*
From ATBM.PHANCONG pc,ATBM.NHANSU ns,ATBM.DONVI dvi
Where pc.MAGV = ns.MANV and ns.MADV = dvi.MADV and dvi.TRGDV = SYS_CONTEXT ('userenv', 'session_user');


Grant GiangVien to TruongDonVi;
Grant select,insert,update,delete on ATBM.v_TruongDonVi to TruongDonVi;
Grant select on ATBM.v2_TruongDonVi to TruongDonVi;
-- CS#5
Create or replace view ATBM.v_TruongKhoa as
Select pc.*
From ATBM.PHANCONG pc,ATBM.HOCPHAN hp
Where pc.MAHP = hp.MAHP and hp.MADV = 'DV001';

Grant GiangVien to NV097;
Grant select,insert,delete,update on ATBM.v_TruongKhoa to NV097;
Grant select,insert,delete,update on ATBM.NHANSU to NV097;
Grant select on ATBM.NHANSU to NV097;
Grant select on ATBM.SINHVIEN to NV097;
Grant select on ATBM.DONVI to NV097;
Grant select on ATBM.HOCPHAN to NV097;
Grant select on ATBM.KHMO to NV097;
Grant select on ATBM.PHANCONG to NV097;
Grant select on ATBM.DANGKY to NV097;
--CS#6
create role SinhVien;

CREATE OR REPLACE FUNCTION check_access (
    p_schema     IN VARCHAR2,
    p_object     IN VARCHAR2)
  RETURN VARCHAR2
IS
  v_condition VARCHAR2(4000);
  v_user_exists NUMBER;
BEGIN
     SELECT COUNT(*) INTO v_user_exists FROM ATBM.NHANSU WHERE MANV = SYS_CONTEXT('USERENV', 'SESSION_USER');
    IF v_user_exists = 0 then 
        v_condition := 'MASV = SYS_CONTEXT(''USERENV'', ''SESSION_USER'')';
    END IF;
  RETURN v_condition;
END check_access;


BEGIN
  DBMS_RLS.ADD_POLICY (
    object_schema  => 'ATBM', 
    object_name    => 'SINHVIEN',
    policy_name    => 'sv_policy',
    policy_function=> 'check_access',
    statement_types=> 'SELECT, UPDATE',
    update_check   => TRUE
    );
END;
/

grant select on ATBM.SINHVIEN to SinhVien;
grant update(DT, DIACHI) on ATBM.SINHVIEN to SinhVien;

--- Sinh viên ch? xem danh sách t?t c? h?c ph?n (HOCPHAN), k? ho?ch m? môn (KHMO) c?a ch??ng trình ?ào t?o mà sinh viên ?ang theo h?c

grant select on ATBM.HOCPHAN to SinhVien;

CREATE OR REPLACE FUNCTION check_access_1 (
    p_schema     IN VARCHAR2,
    p_object     IN VARCHAR2)
  RETURN VARCHAR2
IS
    v_user_exists NUMBER;
  v_condition VARCHAR2(4000);
BEGIN
SELECT COUNT(*) INTO v_user_exists FROM ATBM.NHANSU WHERE MANV = SYS_CONTEXT('USERENV', 'SESSION_USER');
    IF v_user_exists = 0 then 
     v_condition := 'MACT in (select MACT from ATBM.SINHVIEN where MASV = SYS_CONTEXT(''USERENV'', ''SESSION_USER''))';
  end if;
  RETURN v_condition;
END check_access_1;


BEGIN
  DBMS_RLS.ADD_POLICY (
    object_schema  => 'ATBM',
    object_name    => 'KHMO',
    policy_name    => 'xem_KHMO',
    policy_function=> 'check_access_1',
    statement_types=> 'SELECT'
  );
END;
/

grant select on ATBM.KHMO to SinhVien;


--Ko thoa yeu cau
--- Thêm, Xóa các dòng d? li?u ??ng ký h?c ph?n (?ANGKY) liên quan ??n chính sinh viên ?ó trong h?c k? c?a n?m h?c hi?n t?i (n?u th?i ?i?m hi?u ch?nh ??ng ký còn h?p ?)
--CREATE OR REPLACE FUNCTION check_access_2 (
--    p_schema     IN VARCHAR2,
--    p_object     IN VARCHAR2)
--  RETURN VARCHAR2
--IS
--  v_condition VARCHAR2(4000);
--BEGIN
--    IF SUBSTR(SYS_CONTEXT('USERENV', 'SESSION_USER'), 1, 1) = 'S' then 
--        v_condition := 'DANGKY.MASV = SYS_CONTEXT(''USERENV'', ''SESSION_USER'') AND DANGKY.NAM = EXTRACT(YEAR FROM SYSDATE)';
--        RETURN v_condition;
--    end if;
--END check_access_2;


--BEGIN
--  DBMS_RLS.ADD_POLICY (
--    object_schema  => 'ATBM',
--    object_name    => 'DANGKY',
--    policy_name    => 'hieu_chinh_DANGKY',
--    policy_function=> 'check_access_2',
--    statement_types=> 'INSERT, DELETE',
--    update_check => TRUE
--  );
--END;
--/

--begin
--    DBMS_RLS.DROP_POLICY('ATBM', 'DANGKY', 'xem_thong_tin');
--end;


--- Sinh viên ???c Xem t?t c? thông tin trên quan h? ?ANGKY t?i các dòng d? li?u liên quan ??n chính sinh viên.
CREATE OR REPLACE FUNCTION check_access_4 (
    p_schema     IN VARCHAR2,
    p_object     IN VARCHAR2)
  RETURN VARCHAR2
IS
  v_condition VARCHAR2(4000);
      v_user_exists NUMBER;

BEGIN
    IF SUBSTR(SYS_CONTEXT('USERENV', 'SESSION_USER'), 1, 1) = 'S' then 
      v_condition := 'MASV = SYS_CONTEXT(''USERENV'', ''SESSION_USER'')';
        RETURN v_condition;
    end if;
END check_access_4;

BEGIN
  DBMS_RLS.ADD_POLICY (
    object_schema  => 'ATBM',
    object_name    => 'DANGKY',
    policy_name    => 'xem_thong_tin',
    policy_function=> 'check_access_4',
    statement_types=> 'SELECT'
  );
END;
/

grant select on ATBM.DANGKY to SinhVien;



