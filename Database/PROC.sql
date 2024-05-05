ALTER SESSION SET CONTAINER = PDBProject;

--CREATE OR REPLACE PROCEDURE p_get_vaitro(
--    manv_in IN VARCHAR2,
--    vaitro_out OUT NVARCHAR2
--) AS
--BEGIN
--    SELECT VAITRO INTO vaitro_out FROM ATBM.NHANSU WHERE MANV = manv_in;
--END;
--/



CREATE OR REPLACE PROCEDURE get_table(table_idx INT, p_cursor OUT SYS_REFCURSOR, vaitro varchar2) AS
BEGIN
    IF table_idx = 0 and vaitro != 'Truong khoa' then
        OPEN p_cursor FOR SELECT * FROM ATBM.v_NhanVien;
    elsif table_idx = 0 and vaitro = 'Truong khoa' then
        OPEN p_cursor FOR SELECT * FROM ATBM.NHANSU;
    ELSIF table_idx = 1 then
        OPEN p_cursor FOR SELECT * FROM ATBM.SINHVIEN;
    ELSIF table_idx = 2 then
        OPEN p_cursor FOR SELECT * FROM ATBM.DONVI;
    ELSIF table_idx = 3 then
        OPEN p_cursor FOR SELECT * FROM ATBM.HOCPHAN;
    ELSIF table_idx = 4 then
        OPEN p_cursor FOR SELECT * FROM ATBM.KHMO;
    ELSIF table_idx = 5 and (vaitro = 'Giang vien') then
        OPEN p_cursor FOR SELECT * FROM ATBM.v_GiangVien;
    ELSIF table_idx = 5 and (vaitro = 'Truong don vi' ) then
        OPEN p_cursor FOR SELECT * FROM ATBM.v_GiangVien UNION SELECT * FROM ATBM.v2_TruongDonVi;
    ELSIF table_idx = 5 and (vaitro = 'Giao vu'  or vaitro = 'Truong khoa') then
        OPEN p_cursor FOR SELECT * FROM ATBM.PHANCONG;
     ELSIF table_idx = 6 and (vaitro = 'Giang vien'  or vaitro = 'Truong don vi' ) then
        OPEN p_cursor FOR SELECT * FROM ATBM.v2_GiangVien;
    ELSIF table_idx = 6 and vaitro = 'Truong khoa' then
         OPEN p_cursor FOR SELECT * FROM ATBM.DANGKY;
    END IF;
END;
/
CREATE OR REPLACE PROCEDURE update_NHANSU(sdt varchar2)
as
begin
    update ATBM.v2_NhanVien set DT = sdt;
    commit;
end;

CREATE OR REPLACE PROCEDURE p_update_gv_DANGKY(p_diemth NUMBER, p_diemqt NUMBER, p_diemck NUMBER, p_diemtk NUMBER, p_masv varchar2, p_mahp varchar2, p_hk varchar2, p_nam varchar2, p_mact varchar2)
AS
BEGIN
    UPDATE ATBM.v2_GiangVien set DIEMTH = p_diemth, DIEMQT = p_diemqt, DIEMCK = p_diemck, DIEMTK = p_diemtk where MASV = p_masv and HK = p_hk and MAHP = p_mahp and NAM = p_nam and MACT = p_mact;
END;

CREATE OR REPLACE PROCEDURE p_edit_phancong(p_magv varchar2, p_mahp varchar2, p_hk varchar2, p_nam varchar2, p_mact varchar2, p_mode INT)
AS 
BEGIN
    if p_mode = 0 then
        insert into ATBM.v_TruongDonVi values(p_magv, p_mahp, p_hk, p_nam, p_mact);
    elsif p_mode =1 then
        update ATBM.v_TruongDonVi set  HK = p_hk, NAM = p_nam, MACT = p_mact where MAGV = p_magv and MAHP = p_mahp;
    elsif p_mode = 2 then
        delete from ATBM.v_TruongDonVi where MAGV = p_magv and MAHP = p_mahp and HK = p_hk and NAM = p_nam and MACT = p_mact;
    end if;
    commit;
END;

CREATE OR REPLACE PROCEDURE p_edit_phancong_tk(p_magv varchar2, p_mahp varchar2, p_hk varchar2, p_nam varchar2, p_mact varchar2, p_mode INT, new_gv varchar2)
AS 
BEGIN
    if p_mode = 0 then
        insert into  ATBM.v_TruongKhoa values(p_magv, p_mahp, p_hk, p_nam, p_mact);
    elsif p_mode =1 then
        update  ATBM.v_TruongKhoa set  MAGV = new_gv where  HK = p_hk and NAM = p_nam and MACT = p_mact and MAGV = p_magv and MAHP = p_mahp;
    elsif p_mode = 2 then
        delete from  ATBM.v_TruongKhoa where MAGV = p_magv and MAHP = p_mahp;
    end if;
    commit;
END;


CREATE OR REPLACE PROCEDURE p_edit_nhansu_tk(p_manv varchar2, p_hoten varchar2, p_phai varchar2, p_ngsinh varchar2, p_phucap varchar2, p_dt varchar2, p_vaitro varchar2, p_madv varchar2, p_mode INT)
as
begin
    if p_mode = 0 then
        insert into ATBM.NHANSU values(p_manv, p_hoten,p_phai, TO_DATE(p_ngsinh, 'YYYY-MM-DD'), p_phucap, p_dt, p_vaitro, p_madv);
    elsif p_mode =1 then
        update  ATBM.NHANSU set HOTEN = p_hoten, PHAI = p_phai, NGSINH = TO_DATE(p_ngsinh, 'YYYY-MM-DD'), DT = p_dt, VAITRO = p_vaitro, MADV = p_madv where MANV = p_manv;
    elsif p_mode = 2 then
        delete from  ATBM.NHANSU where MANV = p_manv;
    end if;
    commit;
end;

CREATE OR REPLACE PROCEDURE p_update_phancong_vpd(
p_magv varchar2, 
p_mahp varchar2, 
p_hk varchar2, 
p_nam varchar2, 
p_mact varchar2,
new_magv varchar2,
vaitro varchar2)
AS 
BEGIN
    update ATBM.PHANCONG set  MAGV = new_magv where HK = p_hk and NAM = p_nam and MACT = p_mact and MAGV = p_magv and MAHP = p_mahp;
    commit;
END;
;

CREATE OR REPLACE PROCEDURE p_searchsv_gv(p_masv varchar2, p_cursor OUT SYS_REFCURSOR)
as
begin
        OPEN p_cursor FOR SELECT * FROM ATBM.DANGKY where MASV = p_masv ;
end;




grant execute on sys.get_table to NhanVienCoBan;
grant execute on sys.get_table to SinhVien;
grant execute on sys.update_NHANSU to NhanVienCoBan;
grant execute on sys.p_update_gv_DANGKY to GiangVien;
grant execute on sys.p_edit_phancong to TruongDonVi;
grant execute on sys.p_edit_phancong_tk to NV097;
grant execute on sys.p_edit_nhansu_tk to NV097;
grant execute on sys.p_update_phancong_vpd to GiaoVu;
grant execute on sys.p_searchsv_gv to GiaoVu;







