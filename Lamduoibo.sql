create database SQLLam;
use SQLLam;

create table Khoa(
	MaKhoa					varchar(10) primary key,
	TenKhoa					varchar(30) not null,
	DienThoai				char(10)
);

create table GiangVien(
	Magv					int identity primary key,
	HoTengv					nvarchar(50) not null,
	Luong					decimal(5,2) not null,
	MaKhoa					varchar(10)
);

create table SinhVien(
	Masv					int identity primary key,
	HoTensv					nvarchar(50) not null,
	MaKhoa					varchar(10) not null,
	NamSinh					date,
	QueQuan					nvarchar(50)
);

create table DeTai(
	Madt					char(10) primary key,
	Tendt					varchar(50) not null,
	Kinhphi					int not null,
	NoiThucTap				nvarchar(50) not null,
);

create table HuongDan(
	Masv					int primary key,
	Madt					char(10) not null,
	Magv					int,
	KetQua					decimal(5,2) not null
);

insert into Khoa(MaKhoa, TenKhoa, DienThoai) values ('K1','Địa lý','039456849'),
													('K2','Quản lý tài nguyên','094574839'),
													('K3','Ngôn ngữ Anh','094587489'),
													('K4','Ngôn ngữ Trung','039485767'),
													('K5','Công nghệ thông tin','094888576'),
													('K6','Toán','039998789'),
													('K7','Công nghệ sinh học','098496859');

insert into GiangVien(HoTengv,Luong,MaKhoa) values ('Phạm Đồng','15.2','K1'),
												   ('Nguyễn Văn Tạo','14.3','K1'), 
												   ('Mai Hữu Khuê','15.6','K2'),
												   ('Lê Văn Toàn','15.3','K2'),
												   (' Lương Xuân Quỳ','17.2','K4'), 
												   ('Nguyễn Đình Hương','21.2','K4'), 
												   ('Trần Thọ Đạt','23.5','K3'),
												   ('Nguyễn Văn Thường','26.3','K3'),
												   (' Nguyễn Văn Nam','12.5','K6'),
												   ('Phạm Hồng Chương','15.6','K7');  

insert into SinhVien(HoTensv,MaKhoa,NamSinh,QueQuan) values ('Lê Việt Trung','K1','2000-02-02','Hải Phòng'),
															('Lê Hoàng Lâm','K4','2001-09-09','Nam Định'),
															('Trịnh Thị Tú','K2','1999-12-03','Đà Nẵng'),
															('Nguyễn Đức','K3','1998-09-04','Bạc Liêu'),
															('Vũ Thị Ngọc','K5','1997-06-06','Hà Nội'),
															('Trịnh Hoàng','K3','2001-01-01','Vĩnh Phúc'),
															('Phạm Thị Thanh','K1','2002-05-12','Ninh Bình'),
															('Phạm Thị Ngọc','K2','2001-12-04','Quảng Ngãi'),
															('Trần Thị Hương','K6','2000-04-12','Lai Châu'),
															('Tạ Tiến Anh','K4','2001-04-19','Vinh'),
															('Chu Văn','K3','2002-12-04','Huế'),
															('Nguyễn Hương','K4','2000-09-09','Hà Giang'),
															('Lê Thị Thu','K3','2000-12-19','Vĩnh Phúc'),
															('Phan Huyền','K1','2000-12-11','Điện Biên'),
															('Lê Văn Sơn','K2','2000-04-01','Quảng Ninh'),
															('Dương Vũ Thành','K2','2001-03-09','Lai Châu');

insert into DeTai(Madt,Tendt,Kinhphi,NoiThucTap) values ('DT001','Đề tài thực tập 01','10000','Công Ty VTI'),
														('DT002','Đề tài thực tập 02','12000','Công Ty FPT'),
														('DT003','Đề tài thực tập 03','11100','Công Ty Apple'),
														('DT004','Đề tài thực tập 04','13400','Công Ty Google'),
														('DT005','Đề tài thực tập 05','15300','Công Ty Facebook');



insert into HuongDan(Masv,Madt,Magv,KetQua) values('1','DT001','1','10'),
												  ('3','DT002','3','8.65'),
												  ('5','DT003','2','9.75'),
												  ('7','DT004','3','8.65'),
												  ('8','DT005','6','32'),
												  ('9','DT001','4','9.75'),
												  ('10','DT003','5','8.65');

alter table GiangVien add constraint frk_GiangVien_Khoa foreign key (MaKhoa) references Khoa(MaKhoa);
alter table SinhVien add constraint frk_SinhVien_Khoa foreign key (MaKhoa) references Khoa(MaKhoa);
alter table HuongDan add constraint frk_HuongDan_SinhVien foreign key (Masv) references SinhVien(Masv);
alter table HuongDan add constraint frk_HuongDan_GiangVien foreign key (Magv) references GiangVien(Magv);
alter table HuongDan add constraint frk_HuongDan_DeTai foreign key (Madt) references DeTai(Madt);

-- Bài tập
-- Bài tập thống kê
-- Đưa ra thông tin gồm mã số, họ tên và tên khoa của tất cả các giảng viên
select g.*, k.TenKhoa from GiangVien g inner join Khoa k on g.MaKhoa = k.MaKhoa;

-- Đưa ra thông tin gồm mã số, họ tên và tên khoa của các giảng viên của khoa 'Địa lý' và 'Quản lý tài nguyên'
select g.*, k.TenKhoa from GiangVien g inner join Khoa k on g.MaKhoa = k.MaKhoa where k.TenKhoa = 'Địa lý' or k.TenKhoa = 'Quản lý tài nguyên';

-- Cho biết số giảng viên của khoa 'Công nghệ sinh học'
select k.TenKhoa, count(g.Magv) as 'Số giảng viên' from Khoa k inner join GiangVien g on k.MaKhoa = g.MaKhoa group by k.MaKhoa having k.TenKhoa = 'Công nghệ sinh học';

-- Cho biết sinh viên không tham gia thực tập
select * from SinhVien where Masv not in (select s.Masv from SinhVien s inner join HuongDan h on s.Masv = h.Masv) order by Masv asc;

-- Đưa ra mã khoa, tên khoa và số giảng viên của mỗi khoa
select k.MaKhoa, k.TenKhoa, count(g.Magv) from Khoa k left join GiangVien g on k.MaKhoa = g.MaKhoa group by k.MaKhoa order by count(g.Magv) asc;

-- Cho biết số điện thoại của khoa mà sinh viên có tên 'Lê Văn Sơn' đang theo học
select k.TenKhoa, k.DienThoai from Khoa k inner join SinhVien s on k.MaKhoa = s.MaKhoa where s.HoTensv = 'Lê Văn Sơn';
-- 
-- Bài tập view
-- Đưa ra  danh sách gồm mã số, họ tên và tuổi của các sinh viên khoa 'Toán'
create view view1 as select s.*, k.TenKhoa from SinhVien s inner join Khoa k on s.MaKhoa = k.MaKhoa where k.TenKhoa = 'Toán';
select * from view1;

-- Cho biết số sinh viên của khoa 'Công nghệ sinh học'
create view view2 as select k.TenKhoa, count(s.Masv) as 'Số sinh viên' from SinhVien s inner join Khoa k on k.MaKhoa = s.MaKhoa group by k.MaKhoa having k.TenKhoa = 'Công nghệ sinh học';
select * from view2;

-- Đưa ra mã số, họ tên và điểm của các sinh viên khoa 'Địa lý' và 'Quản lý tài nguyên'
create view view3 as select s.Masv, s.HoTensv, h.KetQua from SinhVien s inner join Khoa k on s.MaKhoa = k.MaKhoa inner join HuongDan h on s.Masv = h.Masv where  k.TenKhoa = 'Địa lý' or k.TenKhoa = 'Quản lý tài nguyên';

-- Đưa ra tên khoa, số lượng sinh viên của mỗi khoa
create view view4 as select k.TenKhoa, count(s.Masv) as 'Số sinh viên' from Khoa k inner join SinhVien s on k.MaKhoa = s.MaKhoa order by k.MaKhoa;

-- Đưa ra danh sách gồm mã số, họ tên các sinh viên có điểm thực tập bằng 0
create view view5 as select s.Masv, s.HoTensv from SinhVien s inner join HuongDan h on s.Masv = h.Masv where h.KetQua = '0';

-- Đưa ra mã số, tên đề tài của những đề tài có kinh phí cao nhất
create view view6 as select * from DeTai order by Kinhphi;

