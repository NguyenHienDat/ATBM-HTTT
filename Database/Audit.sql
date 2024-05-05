ALTER SESSION SET CONTAINER = PDBProject;
ALTER SYSTEM SET audit_sys_operations=true SCOPE=spfile;
alter system set audit_trail=db,extended scope=spfile;

Audit all on ATBM.NHANSU by access whenever not successful;
Audit all on ATBM.SINHVIEN by access whenever not successful;
Audit all on ATBM.HOCPHAN by access whenever not successful;
Audit all on ATBM.PHANCONG by access whenever not successful;
Audit all on ATBM.DANGKY by access whenever not successful;
Audit all on ATBM.KHMO by access whenever not successful;
--Audit all on sys.p_connect_users by access whenever not successful;
--Audit all on sys.p_revoke_users by access whenever not successful;
--Audit all on sys.p_create_user_multi_nhanvien by access whenever not successful;
--Audit all on sys.p_create_user_multi_benhnhan by access whenever not successful;



CREATE OR REPLACE FUNCTION get_vaitro(manv_in VARCHAR2)
RETURN NVARCHAR2 AS
vaitro NVARCHAR2(50);
BEGIN
    SELECT VAITRO INTO vaitro FROM ATBM.NHANSU WHERE MANV = manv_in;
    DBMS_OUTPUT.PUT_LINE(vaitro);
    RETURN vaitro;
END;

begin
    dbms_fga.add_policy(
        object_schema => 'ATBM',
        object_name => 'DANGKY',
        policy_name => 'audit_score',
        audit_column => 'DIEMTH, DIEMQT, DIEMCK, DIEMTK',
        audit_condition => 'get_vaitro(SYS_CONTEXT(''USERENV'', ''SESSION_USER'')) != ''Giang vien''',
        statement_types => 'SELECT,UPDATE',
        enable => true);
end;

begin
    dbms_fga.add_policy(
        object_schema => 'ATBM',
        object_name => 'NHANSU',
        policy_name => 'audit_nhansu',
        statement_types => 'SELECT',
        enable => true);
end;

begin
dbms_fga.drop_policy('ATBM', 'NHANSU', 'audit_nhansu');
end;
-- Query view DBA_AUDIT_TRAIL:
select * from dba_fga_audit_trail;
select timestamp,username, owner, obj_name, action_name, sql_text,returncode from SYS.dba_audit_trail;

select * from ATBM.NHANSU;

select * from UNIFIED_AUDIT_TRAIL where AUDIT_TYPE = 'FineGrainedAudit';
SHOW PARAMETER AUDIT_TRAIL;

grant select, update on ATBM.DANGKY to NV001;
commit;