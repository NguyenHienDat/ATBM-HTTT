-- CONNECT = SYS

SELECT VALUE FROM v$option WHERE parameter = 'Oracle Label Security';
SELECT status FROM dba_ols_status WHERE name = 'OLS_CONFIGURE_STATUS';

-- Neu chua bat OLS thi chay 2 dong nay
EXEC LBACSYS.CONFIGURE_OLS;
EXEC LBACSYS.OLS_ENFORCEMENT.ENABLE_OLS;

-- Unlock lbacsys
alter session set "_oracle_script"=true;
ALTER USER lbacsys IDENTIFIED BY lbacsys ACCOUNT UNLOCK;


-- Open pdb
ALTER PLUGGABLE DATABASE PDBProject OPEN READ WRITE;

-- Chuyen sang pdb
alter session set container = PDBProject;
ALTER DATABASE OPEN;

-- Tao user admin_ols
drop user admin_ols cascade;
CREATE USER ADMIN_OLS IDENTIFIED BY 123;
GRANT CONNECT,RESOURCE TO ADMIN_OLS; 
GRANT UNLIMITED TABLESPACE TO ADMIN_OLS; 
GRANT SELECT ANY DICTIONARY TO ADMIN_OLS; 
grant create session to admin_ols;
GRANT EXECUTE ON LBACSYS.SA_COMPONENTS TO ADMIN_OLS WITH GRANT OPTION;
GRANT EXECUTE ON LBACSYS.sa_user_admin TO ADMIN_OLS WITH GRANT OPTION;
GRANT EXECUTE ON LBACSYS.sa_label_admin TO ADMIN_OLS WITH GRANT OPTION;
GRANT EXECUTE ON sa_policy_admin TO ADMIN_OLS WITH GRANT OPTION;
GRANT EXECUTE ON char_to_label TO ADMIN_OLS WITH GRANT OPTION;

GRANT LBAC_DBA TO ADMIN_OLS;
GRANT EXECUTE ON sa_sysdba TO ADMIN_OLS;
GRANT EXECUTE ON TO_LBAC_DATA_LABEL TO ADMIN_OLS; 
Grant alter session to admin_ols container=all;
Grant set container to admin_ols container=all;
Grant create table to admin_ols;
Grant unlimited tablespace to admin_ols;
Grant create user to admin_ols;

-- Tao user trong pdb
Grant create session to TruongKhoa identified by 123;
Grant create session to TruongBM_KHMT_CS1 identified by 123;
Grant create session to TruongBM_TGMT_CS2 identified by 123;
Grant create session to GiaoVu_CS2 identified by 123;
Grant create session to GiangVien_KHMT_CS1 identified by 123;
Grant create session to SinhVien_HTTT_CS1 identified by 123;
Grant create session to SinhVien_CNPM_CS2 identified by 123;

-- Cap quyen doc bang Thongbao
Grant select on admin_ols.Thongbao to TruongKhoa;
Grant select on admin_ols.Thongbao to TruongBM_KHMT_CS1;
Grant select on admin_ols.Thongbao to TruongBM_TGMT_CS2;
Grant select on admin_ols.Thongbao to GiaoVu_CS2;
Grant select on admin_ols.Thongbao to GiangVien_KHMT_CS1;
Grant select on admin_ols.Thongbao to SinhVien_HTTT_CS1;
Grant select on admin_ols.Thongbao to SinhVIen_CNPM_CS2;

grant select on ATBM.DANGKY to A;
revoke select on ATBM.DANGKY from A;
SELECT * FROM USER_TAB_PRIVS;

