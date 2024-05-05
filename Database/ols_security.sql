-- CONNECT = ADMIN_OLS

-- Chuyen sang pdb
alter session set "_oracle_script"=true;
alter session set container = PDBProject;

-- Tao policy
execute SA_SYSDBA.drop_POLICY(policy_name => 'ols_policy');
execute SA_SYSDBA.CREATE_POLICY(policy_name => 'ols_policy',column_name => 'ols_label');
execute SA_SYSDBA.ENABLE_POLICY ('ols_policy'); 
-- Enable xong thi tat oracle roi mo lai

-- Tao level
execute SA_COMPONENTS.CREATE_LEVEL('ols_policy',600,'TK','Truong khoa');
execute SA_COMPONENTS.CREATE_LEVEL('ols_policy',500,'TDV','Truong don vi');
execute SA_COMPONENTS.CREATE_LEVEL('ols_policy',400,'GV','Giang vien');
execute SA_COMPONENTS.CREATE_LEVEL('ols_policy',300,'GVu','Giao vu');
execute SA_COMPONENTS.CREATE_LEVEL('ols_policy',200,'NV','Nhan vien');
execute SA_COMPONENTS.CREATE_LEVEL('ols_policy',100,'SV','Sinh vien');

-- Tao compartment
execute SA_COMPONENTS.CREATE_COMPARTMENT('ols_policy',200,'HTTT','He thong thong tin'); 
execute SA_COMPONENTS.CREATE_COMPARTMENT('ols_policy',180,'CNPM','Cong nghe phan mem'); 
execute SA_COMPONENTS.CREATE_COMPARTMENT('ols_policy',160,'KHMT','Khoa hoc may tinh');
execute SA_COMPONENTS.CREATE_COMPARTMENT('ols_policy',140,'CNTT','Cong nghe thong tin');
execute SA_COMPONENTS.CREATE_COMPARTMENT('ols_policy',120,'TGMT','Thi giac may tinh');
execute SA_COMPONENTS.CREATE_COMPARTMENT('ols_policy',100,'MMT','Mang may tinh');

-- Tao group
execute SA_COMPONENTS.CREATE_GROUP('ols_policy',40,'CS1','Co so 1');
execute SA_COMPONENTS.CREATE_GROUP('ols_policy',20,'CS2','Co so 2');

-- Tao bang Thong bao
drop table Thongbao cascade constraints;
Create table Thongbao(
MaTB int PRIMARY KEY,
NoiDung nvarchar2(150)
);

Insert into Thongbao values(1,'Thong bao cho Truong Khoa');
Insert into Thongbao values(2,'Thong bao cho toan bo Giao vu');
Insert into Thongbao values(3,'Thong bao cho tat ca Truong bo mon');
Insert into Thongbao values(4,'Thong bao cho Sinh vien thuoc nganh HTTT o co so 1');
Insert into Thongbao values(5,'Thong bao cho Truong bo mon KHMT o co so 1');
Insert into Thongbao values(6,'Thong bao cho Truong bo mon KHMT o co so 1 va co so 2');
Insert into Thongbao values(7,'Thong bao cho Sinh vien thuoc nganh CNPM o co so 2');
Insert into Thongbao values(8,'Thong bao cho Truong bo mon TGMT o co so 2');
Insert into Thongbao values(9,'Thong bao cho Giang vien KHMT o co so 1');
Insert into Thongbao values(10,'Thong bao cho Giao vu o co so 1');

-- Cap nhap nhan trong bang
begin
 SA_POLICY_ADMIN.APPLY_TABLE_POLICY (
 POLICY_NAME => 'OLS_POLICY',
 SCHEMA_NAME => 'admin_ols',
 TABLE_NAME => 'Thongbao',
 TABLE_OPTIONS => 'NO_CONTROL'
 ); 
end;

-- Tao nhan 
Update Thongbao
set ols_label = char_to_label('ols_policy','TK')
where MaTB = 1;

Update Thongbao
set ols_label = char_to_label('ols_policy','GVu')
where MaTB = 2;

Update Thongbao
set ols_label = char_to_label('ols_policy','TDV')
where MaTB = 3;

Update Thongbao
set ols_label = char_to_label('ols_policy','SV:HTTT:CS1')
where MaTB = 4;

Update Thongbao
set ols_label = char_to_label('ols_policy','TDV:KHMT:CS1')
where MaTB = 5;

Update Thongbao
set ols_label = char_to_label('ols_policy','TDV:KHMT:CS1,CS2')
where MaTB = 6;

Update Thongbao
set ols_label = char_to_label('ols_policy','SV:CNPM:CS2')
where MaTB = 7;

Update Thongbao
set ols_label = char_to_label('ols_policy','TDV:TGMT:CS2')
where MaTB = 8;

Update Thongbao
set ols_label = char_to_label('ols_policy','GV:KHMT:CS1')
where MaTB = 9;

Update Thongbao
set ols_label = char_to_label('ols_policy','GVu::CS1')
where MaTB = 10;

-- Ap dung ols vao bang
BEGIN
SA_POLICY_ADMIN.REMOVE_TABLE_POLICY(
policy_name => 'ols_policy',
schema_name => 'ADMIN_OLS',
table_name  => 'Thongbao'
);
SA_POLICY_ADMIN.APPLY_TABLE_POLICY (
policy_name => 'ols_policy',
schema_name => 'ADMIN_OLS',
table_name => 'Thongbao',
table_options => 'READ_CONTROL'
);
END;

-- Goi update label
UPDATE thongbao
SET matb = matb; 
commit;

execute SA_USER_ADMIN.SET_USER_LABELS('ols_policy','TruongKhoa','TK'); 
execute SA_USER_ADMIN.SET_USER_LABELS('ols_policy','TruongKhoa','GVu');
execute SA_USER_ADMIN.SET_USER_LABELS('ols_policy','TruongKhoa','TDV'); 
execute SA_USER_ADMIN.SET_USER_LABELS('ols_policy','TruongKhoa','SV:HTTT:CS1'); 
execute SA_USER_ADMIN.SET_USER_LABELS('ols_policy','TruongKhoa','TDV:KHMT:CS1'); 
execute SA_USER_ADMIN.SET_USER_LABELS('ols_policy','TruongKhoa','TDV:KHMT:CS1,CS2');  
execute SA_USER_ADMIN.SET_USER_LABELS('ols_policy','TruongKhoa','SV:CNPM:CS2'); 
execute SA_USER_ADMIN.SET_USER_LABELS('ols_policy','TruongKhoa','TDV:TGMT:CS2'); 
execute SA_USER_ADMIN.SET_USER_LABELS('ols_policy','TruongKhoa','GV:KHMT:CS1'); 
execute SA_USER_ADMIN.SET_USER_LABELS('ols_policy','TruongKhoa','GVu::CS1');

commit;


-- Gan label cho user

-- Truong Khoa thay duoc toan bo thong bao
execute SA_USER_ADMIN.SET_USER_LABELS('ols_policy','TruongKhoa','TK:HTTT,CNPM,KHMT,CNTT,TGMT,MMT:CS1,CS2'); 
-- Truong Bo mon KHMT o co so 1
execute SA_USER_ADMIN.SET_USER_LABELS('ols_policy','TruongBM_KHMT_CS1','TDV:KHMT:CS1'); 
-- Truong Bo mon TGMT o co so 2
execute SA_USER_ADMIN.SET_USER_LABELS('ols_policy','TruongBM_TGMT_CS2','TDV:TGMT:CS2'); 
-- Giao vu o co so 2 thay duoc toan bo thong bao danh cho giao vu
execute SA_USER_ADMIN.SET_USER_LABELS('ols_policy','GiaoVu_CS2','GVu:HTTT,CNPM,KHMT,CNTT,TGMT,MMT:CS1,CS2');
-- Giang vien KHMT o co so 1
execute SA_USER_ADMIN.SET_USER_LABELS('ols_policy','GiangVien_KHMT_CS1','GV:KHMT:CS1');
-- Sinh vien HTTT o co so 1 
execute SA_USER_ADMIN.SET_USER_LABELS('ols_policy','SinhVien_HTTT_CS1','SV:HTTT:CS1');
-- Sinh vien CNPM o co so 2
execute SA_USER_ADMIN.SET_USER_LABELS('ols_policy','SinhVien_CNPM_CS2','SV:CNPM:CS2');

select * from admin_ols.thongbao;