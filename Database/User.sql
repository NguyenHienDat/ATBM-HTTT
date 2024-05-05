ALTER SESSION SET CONTAINER = PDBProject;
create or replace procedure p_create_user (par_username in varchar2, par_password in varchar2) 
As
begin
  execute immediate ('alter session set "_oracle_script"=true');
  execute immediate ('create user '     || par_username ||
                     '  identified by ' || par_password);
  execute immediate ('grant create session to ' || par_username);
  execute immediate ('grant unlimited tablespace to ' || par_username);
end;
/
-- Nhan vien co ban
exec  p_create_user ('NV001','123');
exec  p_create_user ('NV002','123');
exec  p_create_user ('NV003','123');
exec  p_create_user ('NV004','123');
exec  p_create_user ('NV005','123');
exec  p_create_user ('NV006','123');
exec  p_create_user ('NV007','123');
exec  p_create_user ('NV008','123');
exec  p_create_user ('NV009','123');
exec  p_create_user ('NV010','123');
-- Giang vien
exec  p_create_user ('NV011','123');
exec  p_create_user ('NV012','123');
exec  p_create_user ('NV013','123');
exec  p_create_user ('NV014','123');
exec  p_create_user ('NV015','123');
exec  p_create_user ('NV016','123');
exec  p_create_user ('NV017','123');
exec  p_create_user ('NV018','123');
exec  p_create_user ('NV019','123');
exec  p_create_user ('NV020','123');
exec  p_create_user ('NV021','123');
exec  p_create_user ('NV022','123');
exec  p_create_user ('NV023','123');
exec  p_create_user ('NV024','123');
exec  p_create_user ('NV025','123');
exec  p_create_user ('NV026','123');
exec  p_create_user ('NV027','123');
exec  p_create_user ('NV028','123');
exec  p_create_user ('NV029','123');
exec  p_create_user ('NV030','123');
exec  p_create_user ('NV031','123');
exec  p_create_user ('NV032','123');
exec  p_create_user ('NV033','123');
exec  p_create_user ('NV034','123');
exec  p_create_user ('NV035','123');
exec  p_create_user ('NV036','123');
exec  p_create_user ('NV037','123');
exec  p_create_user ('NV038','123');
exec  p_create_user ('NV039','123');
exec  p_create_user ('NV040','123');
exec  p_create_user ('NV041','123');
exec  p_create_user ('NV042','123');
exec  p_create_user ('NV043','123');
exec  p_create_user ('NV044','123');
exec  p_create_user ('NV045','123');
exec  p_create_user ('NV046','123');
exec  p_create_user ('NV047','123');
exec  p_create_user ('NV048','123');
exec  p_create_user ('NV049','123');
exec  p_create_user ('NV050','123');
exec  p_create_user ('NV051','123');
exec  p_create_user ('NV052','123');
exec  p_create_user ('NV053','123');
exec  p_create_user ('NV054','123');
exec  p_create_user ('NV055','123');
exec  p_create_user ('NV056','123');
exec  p_create_user ('NV057','123');
exec  p_create_user ('NV058','123');
exec  p_create_user ('NV059','123');
exec  p_create_user ('NV060','123');
exec  p_create_user ('NV061','123');
exec  p_create_user ('NV062','123');
exec  p_create_user ('NV063','123');
exec  p_create_user ('NV064','123');
exec  p_create_user ('NV065','123');
exec  p_create_user ('NV066','123');
exec  p_create_user ('NV067','123');
exec  p_create_user ('NV068','123');
exec  p_create_user ('NV069','123');
exec  p_create_user ('NV070','123');
exec  p_create_user ('NV071','123');
exec  p_create_user ('NV072','123');
exec  p_create_user ('NV073','123');
exec  p_create_user ('NV074','123');
exec  p_create_user ('NV075','123');
exec  p_create_user ('NV076','123');
exec  p_create_user ('NV077','123');
exec  p_create_user ('NV078','123');
exec  p_create_user ('NV079','123');
exec  p_create_user ('NV080','123');
-- Truong don vi
exec  p_create_user ('NV081','123');
exec  p_create_user ('NV082','123');
exec  p_create_user ('NV083','123');
exec  p_create_user ('NV084','123');
exec  p_create_user ('NV085','123');
exec  p_create_user ('NV086','123');
-- Giao vu
exec  p_create_user ('NV087','123');
exec  p_create_user ('NV088','123');
exec  p_create_user ('NV089','123');
exec  p_create_user ('NV090','123');
exec  p_create_user ('NV091','123');
exec  p_create_user ('NV092','123');
exec  p_create_user ('NV093','123');
exec  p_create_user ('NV094','123');
exec  p_create_user ('NV095','123');
exec  p_create_user ('NV096','123');
-- Truong khoa
exec  p_create_user ('NV097','123');
--Sinh vien
exec  p_create_user ('SV001','123');

-- Phan role
-- Nhan vien co ban
Grant NhanVienCoBan to NV001;
Grant NhanVienCoBan to NV002;
Grant NhanVienCoBan to NV003;
Grant NhanVienCoBan to NV004;
Grant NhanVienCoBan to NV005;
Grant NhanVienCoBan to NV006;
Grant NhanVienCoBan to NV007;
Grant NhanVienCoBan to NV008;
Grant NhanVienCoBan to NV009;
Grant NhanVienCoBan to NV010;
-- Giang Vien
Grant GiangVien to NV011;
Grant GiangVien to NV012;
Grant GiangVien to NV013;
Grant GiangVien to NV014;
Grant GiangVien to NV015;
Grant GiangVien to NV016;
Grant GiangVien to NV017;
Grant GiangVien to NV018;
Grant GiangVien to NV019;
Grant GiangVien to NV020;
Grant GiangVien to NV021;
Grant GiangVien to NV022;
Grant GiangVien to NV023;
Grant GiangVien to NV024;
Grant GiangVien to NV025;
Grant GiangVien to NV026;
Grant GiangVien to NV027;
Grant GiangVien to NV028;
Grant GiangVien to NV029;
Grant GiangVien to NV030;
Grant GiangVien to NV031;
Grant GiangVien to NV032;
Grant GiangVien to NV033;
Grant GiangVien to NV034;
Grant GiangVien to NV035;
Grant GiangVien to NV036;
Grant GiangVien to NV037;
Grant GiangVien to NV038;
Grant GiangVien to NV039;
Grant GiangVien to NV040;
Grant GiangVien to NV041;
Grant GiangVien to NV042;
Grant GiangVien to NV043;
Grant GiangVien to NV044;
Grant GiangVien to NV045;
Grant GiangVien to NV046;
Grant GiangVien to NV047;
Grant GiangVien to NV048;
Grant GiangVien to NV049;
Grant GiangVien to NV050;
Grant GiangVien to NV051;
Grant GiangVien to NV052;
Grant GiangVien to NV053;
Grant GiangVien to NV054;
Grant GiangVien to NV055;
Grant GiangVien to NV056;
Grant GiangVien to NV057;
Grant GiangVien to NV058;
Grant GiangVien to NV059;
Grant GiangVien to NV060;
Grant GiangVien to NV061;
Grant GiangVien to NV062;
Grant GiangVien to NV063;
Grant GiangVien to NV064;
Grant GiangVien to NV065;
Grant GiangVien to NV066;
Grant GiangVien to NV067;
Grant GiangVien to NV068;
Grant GiangVien to NV069;
Grant GiangVien to NV070;
Grant GiangVien to NV071;
Grant GiangVien to NV072;
Grant GiangVien to NV073;
Grant GiangVien to NV074;
Grant GiangVien to NV075;
Grant GiangVien to NV076;
Grant GiangVien to NV077;
Grant GiangVien to NV078;
Grant GiangVien to NV079;
Grant GiangVien to NV080;
-- Truong don vi
Grant TruongDonVi to NV081;
Grant TruongDonVi to NV082;
Grant TruongDonVi to NV083;
Grant TruongDonVi to NV084;
Grant TruongDonVi to NV085;
Grant TruongDonVi to NV086;
--Giao vu
Grant GiaoVu to NV088;
Grant Giaovu to NV087;
--Sinh vien
Grant SinhVien to SV001;




