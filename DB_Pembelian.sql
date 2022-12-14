USE [master]
GO
/****** Object:  Database [DB_PEMBELIAN]    Script Date: 2022-11-11 오전 10:35:45 ******/
CREATE DATABASE [DB_PEMBELIAN]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'DB_PEMBELIAN', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\DB_PEMBELIAN.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'DB_PEMBELIAN_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\DB_PEMBELIAN_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [DB_PEMBELIAN] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [DB_PEMBELIAN].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [DB_PEMBELIAN] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [DB_PEMBELIAN] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [DB_PEMBELIAN] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [DB_PEMBELIAN] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [DB_PEMBELIAN] SET ARITHABORT OFF 
GO
ALTER DATABASE [DB_PEMBELIAN] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [DB_PEMBELIAN] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [DB_PEMBELIAN] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [DB_PEMBELIAN] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [DB_PEMBELIAN] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [DB_PEMBELIAN] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [DB_PEMBELIAN] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [DB_PEMBELIAN] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [DB_PEMBELIAN] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [DB_PEMBELIAN] SET  DISABLE_BROKER 
GO
ALTER DATABASE [DB_PEMBELIAN] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [DB_PEMBELIAN] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [DB_PEMBELIAN] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [DB_PEMBELIAN] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [DB_PEMBELIAN] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [DB_PEMBELIAN] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [DB_PEMBELIAN] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [DB_PEMBELIAN] SET RECOVERY FULL 
GO
ALTER DATABASE [DB_PEMBELIAN] SET  MULTI_USER 
GO
ALTER DATABASE [DB_PEMBELIAN] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [DB_PEMBELIAN] SET DB_CHAINING OFF 
GO
ALTER DATABASE [DB_PEMBELIAN] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [DB_PEMBELIAN] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [DB_PEMBELIAN] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'DB_PEMBELIAN', N'ON'
GO
ALTER DATABASE [DB_PEMBELIAN] SET QUERY_STORE = OFF
GO
USE [DB_PEMBELIAN]
GO
/****** Object:  Table [dbo].[DetailPembelian]    Script Date: 2022-11-11 오전 10:35:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DetailPembelian](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[nama_barang] [varchar](50) NOT NULL,
	[harga] [bigint] NOT NULL,
	[quantity] [int] NOT NULL,
	[pb_id] [int] NOT NULL,
 CONSTRAINT [PK_DetailPembelian] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Karyawan]    Script Date: 2022-11-11 오전 10:35:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Karyawan](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[nama] [varchar](50) NOT NULL,
	[alamat] [varchar](100) NOT NULL,
	[no_hp] [varchar](13) NOT NULL,
 CONSTRAINT [PK_Karyawan] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Pembelian]    Script Date: 2022-11-11 오전 10:35:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Pembelian](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[kwitansi] [varchar](10) NOT NULL,
	[kry_id] [int] NOT NULL,
	[status] [int] NOT NULL,
 CONSTRAINT [PK_Pembelian] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[DetailPembelian]  WITH CHECK ADD  CONSTRAINT [FK_DetailPembelian_Pembelian] FOREIGN KEY([pb_id])
REFERENCES [dbo].[Pembelian] ([id])
GO
ALTER TABLE [dbo].[DetailPembelian] CHECK CONSTRAINT [FK_DetailPembelian_Pembelian]
GO
ALTER TABLE [dbo].[Pembelian]  WITH CHECK ADD  CONSTRAINT [FK_Pembelian_Karyawan] FOREIGN KEY([kry_id])
REFERENCES [dbo].[Karyawan] ([id])
GO
ALTER TABLE [dbo].[Pembelian] CHECK CONSTRAINT [FK_Pembelian_Karyawan]
GO
/****** Object:  StoredProcedure [dbo].[sp_DeleteKaryawan]    Script Date: 2022-11-11 오전 10:35:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_DeleteKaryawan]
	@id		int
AS
BEGIN
	DELETE FROM Karyawan WHERE id = @id
END
GO
/****** Object:  StoredProcedure [dbo].[sp_DeletePembelian]    Script Date: 2022-11-11 오전 10:35:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_DeletePembelian]
	@id		int
AS
BEGIN
	DELETE FROM DetailPembelian WHERE pb_id = @id
	DELETE FROM Pembelian WHERE id = @id
END
GO
/****** Object:  StoredProcedure [dbo].[sp_getDataDetailTransaksi]    Script Date: 2022-11-11 오전 10:35:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[sp_getDataDetailTransaksi]
AS
BEGIN
	SET NOCOUNT ON;

	SELECT id, nama_barang, harga, quantity, (harga * quantity) AS total_beli FROM DetailPembelian WHERE pb_id = 1
END
GO
/****** Object:  StoredProcedure [dbo].[sp_getDataForDetailPembelian]    Script Date: 2022-11-11 오전 10:35:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_getDataForDetailPembelian]
	@id int
AS
BEGIN
	SET NOCOUNT ON;
	SELECT id, ROW_NUMBER() OVER (ORDER BY id ASC) AS rownum, nama_barang, harga, quantity 
	FROM DetailPembelian
	WHERE pb_id = @id
END
GO
/****** Object:  StoredProcedure [dbo].[sp_getDataForUpdateKaryawan]    Script Date: 2022-11-11 오전 10:35:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_getDataForUpdateKaryawan]
	@id int
AS
BEGIN
	SET NOCOUNT ON;
	SELECT nama, alamat, no_hp FROM Karyawan WHERE id = @id;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_getDataKaryawan]    Script Date: 2022-11-11 오전 10:35:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_getDataKaryawan]
	@query VARCHAR(MAX)
AS
BEGIN
	SET NOCOUNT ON;

	SELECT id, ROW_NUMBER() OVER (ORDER BY id ASC) AS rownum, nama, alamat, no_hp 
	FROM Karyawan
	WHERE nama LIKE '%' + @query + '%';
END
GO
/****** Object:  StoredProcedure [dbo].[sp_getDataPembelian]    Script Date: 2022-11-11 오전 10:35:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [dbo].[sp_getDataPembelian]
	@query VARCHAR(MAX)
AS
BEGIN
	SET NOCOUNT ON;
	SELECT p.id AS id, ROW_NUMBER() OVER (ORDER BY p.id ASC) AS rownum, p.kwitansi, k.nama AS namaKaryawan, 
		   SUM(dp.quantity) AS jumlahBarang, SUM(dp.harga * dp.quantity) AS totalHarga 
	FROM Pembelian p
	INNER JOIN DetailPembelian dp ON dp.pb_id = p.id
	INNER JOIN Karyawan k ON k.id = p.kry_id
	WHERE p.kwitansi LIKE '%' + @query + '%'
	GROUP BY p.id, p.kwitansi, k.nama
END
GO
/****** Object:  StoredProcedure [dbo].[sp_getLastIDPembelian]    Script Date: 2022-11-11 오전 10:35:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [dbo].[sp_getLastIDPembelian]
AS
BEGIN 
	SELECT TOP 1 id FROM Pembelian ORDER BY id DESC
END
GO
/****** Object:  StoredProcedure [dbo].[sp_getTotalFromDetailTransaksi]    Script Date: 2022-11-11 오전 10:35:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [dbo].[sp_getTotalFromDetailTransaksi]
AS
BEGIN
	SET NOCOUNT ON;

	SELECT SUM(harga * quantity) AS total_transaksi FROM DetailPembelian WHERE pb_id = 1
END
GO
/****** Object:  StoredProcedure [dbo].[sp_InsertDetailPembelian]    Script Date: 2022-11-11 오전 10:35:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[sp_InsertDetailPembelian]
	@nama_barang	varchar(50),
	@harga			bigint,
	@quantity		int,
	@pb_id			int
AS
BEGIN
	INSERT INTO DetailPembelian(nama_barang, harga, quantity, pb_id) VALUES(@nama_barang, @harga, @quantity, @pb_id)
END
GO
/****** Object:  StoredProcedure [dbo].[sp_InsertKaryawan]    Script Date: 2022-11-11 오전 10:35:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_InsertKaryawan]
	@nama				varchar(50),
	@alamat				varchar(100),
	@no_hp				int	
AS
BEGIN
	INSERT INTO Karyawan (nama, alamat, no_hp)
	VALUES(@nama, @alamat, @no_hp)
END
GO
/****** Object:  StoredProcedure [dbo].[sp_InsertPembelian]    Script Date: 2022-11-11 오전 10:35:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[sp_InsertPembelian]
	@kwitansi	varchar(10),
	@kry_id		int
AS
BEGIN
	INSERT INTO Pembelian(kwitansi, kry_id) VALUES(@kwitansi, @kry_id)
END
GO
/****** Object:  StoredProcedure [dbo].[sp_UpdateKaryawan]    Script Date: 2022-11-11 오전 10:35:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [dbo].[sp_UpdateKaryawan]
	@id		int,
	@nama	varchar(50),
	@alamat varchar(100),
	@no_hp	varchar(13)
AS
BEGIN 
	UPDATE Karyawan
	SET nama = @nama,
		alamat = @alamat,
		no_hp = @no_hp
	WHERE id = @id
END
GO
USE [master]
GO
ALTER DATABASE [DB_PEMBELIAN] SET  READ_WRITE 
GO
