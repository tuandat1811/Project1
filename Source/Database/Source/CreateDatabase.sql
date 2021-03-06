USE [master]
GO
/****** Object:  Database [BKOD]    Script Date: 5/19/2019 3:47:51 PM ******/
CREATE DATABASE [BKOD]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'BKOD', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS\MSSQL\DATA\BKOD.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'BKOD_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS\MSSQL\DATA\BKOD_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [BKOD] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [BKOD].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [BKOD] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [BKOD] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [BKOD] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [BKOD] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [BKOD] SET ARITHABORT OFF 
GO
ALTER DATABASE [BKOD] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [BKOD] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [BKOD] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [BKOD] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [BKOD] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [BKOD] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [BKOD] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [BKOD] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [BKOD] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [BKOD] SET  DISABLE_BROKER 
GO
ALTER DATABASE [BKOD] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [BKOD] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [BKOD] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [BKOD] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [BKOD] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [BKOD] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [BKOD] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [BKOD] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [BKOD] SET  MULTI_USER 
GO
ALTER DATABASE [BKOD] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [BKOD] SET DB_CHAINING OFF 
GO
ALTER DATABASE [BKOD] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [BKOD] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [BKOD] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [BKOD] SET QUERY_STORE = OFF
GO
USE [BKOD]
GO
/****** Object:  User [bkod]    Script Date: 5/19/2019 3:47:52 PM ******/
CREATE USER [bkod] FOR LOGIN [bkod] WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_owner] ADD MEMBER [bkod]
GO
/****** Object:  Table [dbo].[Building]    Script Date: 5/19/2019 3:47:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Building](
	[BuildingId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](40) NOT NULL,
	[SubName] [nvarchar](40) NULL,
	[Location] [geometry] NOT NULL,
	[Note] [nvarchar](100) NULL,
 CONSTRAINT [PK_Building] PRIMARY KEY CLUSTERED 
(
	[BuildingId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Building2Classroom]    Script Date: 5/19/2019 3:47:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Building2Classroom](
	[BuildingId] [int] NOT NULL,
	[ClassroomId] [int] NOT NULL,
 CONSTRAINT [PK_Building2Classroom] PRIMARY KEY CLUSTERED 
(
	[BuildingId] ASC,
	[ClassroomId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Classroom]    Script Date: 5/19/2019 3:47:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Classroom](
	[ClassroomId] [int] IDENTITY(1,1) NOT NULL,
	[Floor] [tinyint] NOT NULL,
	[Name] [varchar](40) NOT NULL,
	[SubName] [nvarchar](100) NULL,
	[Note] [nvarchar](100) NULL,
 CONSTRAINT [PK_Classroom] PRIMARY KEY CLUSTERED 
(
	[ClassroomId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Manager]    Script Date: 5/19/2019 3:47:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Manager](
	[ManagerId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](40) NOT NULL,
	[Gender] [tinyint] NOT NULL,
	[Birthday] [date] NOT NULL,
	[Email] [varchar](100) NOT NULL,
	[PhoneNumber] [varchar](15) NOT NULL,
 CONSTRAINT [PK_Manager] PRIMARY KEY CLUSTERED 
(
	[ManagerId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Message]    Script Date: 5/19/2019 3:47:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Message](
	[SenderId] [int] NOT NULL,
	[RecieverId] [int] NOT NULL,
	[MessageId] [int] IDENTITY(1,1) NOT NULL,
	[mContent] [nvarchar](500) NOT NULL,
	[Time] [datetime] NOT NULL,
 CONSTRAINT [PK_Message] PRIMARY KEY CLUSTERED 
(
	[SenderId] ASC,
	[RecieverId] ASC,
	[MessageId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[News]    Script Date: 5/19/2019 3:47:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[News](
	[NewsId] [int] IDENTITY(1,1) NOT NULL,
	[ImageUrl] [varchar](300) NULL,
	[Title] [nvarchar](100) NOT NULL,
	[Url] [nvarchar](300) NOT NULL,
	[Summary] [nvarchar](100) NOT NULL,
	[IsShowing] [bit] NOT NULL,
 CONSTRAINT [PK_News] PRIMARY KEY CLUSTERED 
(
	[NewsId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Setting]    Script Date: 5/19/2019 3:47:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Setting](
	[FormUrl] [nvarchar](300) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Timesheet]    Script Date: 5/19/2019 3:47:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Timesheet](
	[TimesheetId] [int] IDENTITY(1,1) NOT NULL,
	[StartTime] [time](7) NOT NULL,
	[EndTime] [time](7) NOT NULL,
 CONSTRAINT [PK_Timesheet] PRIMARY KEY CLUSTERED 
(
	[TimesheetId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Timesheet2Classroom]    Script Date: 5/19/2019 3:47:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Timesheet2Classroom](
	[TimesheetId] [int] NOT NULL,
	[ClassroomId] [int] NOT NULL,
	[ManagerId] [int] NOT NULL,
 CONSTRAINT [PK_Timesheet2Classroom_1] PRIMARY KEY CLUSTERED 
(
	[TimesheetId] ASC,
	[ManagerId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Tour]    Script Date: 5/19/2019 3:47:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tour](
	[TourId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[State] [bit] NOT NULL,
	[ImageUrl] [nvarchar](300) NULL,
	[Date] [date] NOT NULL,
	[MapImageUrl] [nvarchar](300) NULL,
 CONSTRAINT [PK_Tour] PRIMARY KEY CLUSTERED 
(
	[TourId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Tour2Member]    Script Date: 5/19/2019 3:47:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tour2Member](
	[TourId] [int] NOT NULL,
	[UserId] [int] NOT NULL,
	[mFunction] [tinyint] NOT NULL,
	[mLocation] [geometry] NULL,
	[Note] [nvarchar](100) NULL,
 CONSTRAINT [PK_Tour2Member_1] PRIMARY KEY CLUSTERED 
(
	[TourId] ASC,
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Tour2Timesheet]    Script Date: 5/19/2019 3:47:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tour2Timesheet](
	[TourId] [int] NOT NULL,
	[TimesheetId] [int] NOT NULL,
 CONSTRAINT [PK_Tour2Timesheet_1] PRIMARY KEY CLUSTERED 
(
	[TourId] ASC,
	[TimesheetId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[User]    Script Date: 5/19/2019 3:47:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[User](
	[UserId] [int] IDENTITY(1,1) NOT NULL,
	[Username] [varchar](40) NOT NULL,
	[Password] [char](64) NOT NULL,
	[Fullname] [nvarchar](50) NOT NULL,
	[Birthday] [date] NOT NULL,
	[Gender] [tinyint] NOT NULL,
	[School] [nvarchar](100) NULL,
	[Class] [nvarchar](20) NULL,
	[PhoneNumber] [varchar](15) NULL,
	[IsCounselor] [bit] NOT NULL,
	[State] [tinyint] NOT NULL,
 CONSTRAINT [PK_User] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Building] ON 

INSERT [dbo].[Building] ([BuildingId], [Name], [SubName], [Location], [Note]) VALUES (3, N'C9', NULL, 0x00000000010C2B8881AE7D0135404B766C04E2755A40, NULL)
INSERT [dbo].[Building] ([BuildingId], [Name], [SubName], [Location], [Note]) VALUES (4, N'C2', NULL, 0x00000000010C9F73B7EBA50135408F52094FE8755A40, NULL)
INSERT [dbo].[Building] ([BuildingId], [Name], [SubName], [Location], [Note]) VALUES (5, N'C1', NULL, 0x00000000010C399D64ABCB0135403BC780ECF5755A40, NULL)
INSERT [dbo].[Building] ([BuildingId], [Name], [SubName], [Location], [Note]) VALUES (6, N'C3', NULL, 0x00000000010CC1FEEBDCB4013540C9224DBC03765A40, NULL)
INSERT [dbo].[Building] ([BuildingId], [Name], [SubName], [Location], [Note]) VALUES (7, N'C4', NULL, 0x00000000010C2F17F19D9801354010CF126404765A40, NULL)
INSERT [dbo].[Building] ([BuildingId], [Name], [SubName], [Location], [Note]) VALUES (8, N'C5', NULL, 0x00000000010C3D27BD6F7C013540915F3FC406765A40, NULL)
INSERT [dbo].[Building] ([BuildingId], [Name], [SubName], [Location], [Note]) VALUES (9, N'C10', NULL, 0x00000000010CA2B2614D650135406EA301BC05765A40, NULL)
INSERT [dbo].[Building] ([BuildingId], [Name], [SubName], [Location], [Note]) VALUES (10, N'HITECH', NULL, 0x00000000010CB3D1393FC50135404A99D4D006765A40, NULL)
INSERT [dbo].[Building] ([BuildingId], [Name], [SubName], [Location], [Note]) VALUES (11, N'ITMS', N'Palm Landscape, Tòa nhà ITIMS', 0x00000000010CF6402B30640135404FEB36A8FD755A40, NULL)
INSERT [dbo].[Building] ([BuildingId], [Name], [SubName], [Location], [Note]) VALUES (13, N'D2', N'', 0x00000000010C3737A6272C0135409C6B98A1F1755A40, NULL)
INSERT [dbo].[Building] ([BuildingId], [Name], [SubName], [Location], [Note]) VALUES (16, N'D2A', N'', 0x00000000010C263ACB2C42013540FE43FAEDEB755A40, NULL)
INSERT [dbo].[Building] ([BuildingId], [Name], [SubName], [Location], [Note]) VALUES (24, N'D6', N'', 0x00000000010C0932022A1C013540BC067DE9ED755A40, NULL)
INSERT [dbo].[Building] ([BuildingId], [Name], [SubName], [Location], [Note]) VALUES (25, N'D4', N'', 0x00000000010C0FEF39B01C013540FC56EBC4E5755A40, NULL)
INSERT [dbo].[Building] ([BuildingId], [Name], [SubName], [Location], [Note]) VALUES (26, N'D6-8', N'', 0x00000000010C2C836A83130135406B48DC63E9755A40, NULL)
INSERT [dbo].[Building] ([BuildingId], [Name], [SubName], [Location], [Note]) VALUES (27, N'D8', N'', 0x00000000010C48179B560A01354093A7ACA6EB755A40, NULL)
INSERT [dbo].[Building] ([BuildingId], [Name], [SubName], [Location], [Note]) VALUES (33, N'Thư viện Tạ Quang Bửu', N'', 0x00000000010CFA9CBB5D2F013540F16778B306765A40, NULL)
INSERT [dbo].[Building] ([BuildingId], [Name], [SubName], [Location], [Note]) VALUES (34, N'D9', N'', 0x00000000010CCC4065FCFB003540A4FE7A8505765A40, NULL)
INSERT [dbo].[Building] ([BuildingId], [Name], [SubName], [Location], [Note]) VALUES (35, N'Hồ Tiền', N'', 0x00000000010C76FF58880E0135405187156EF9755A40, NULL)
INSERT [dbo].[Building] ([BuildingId], [Name], [SubName], [Location], [Note]) VALUES (36, N'D7', N'', 0x00000000010CBE13B35E0C013540AE6186C613765A40, NULL)
INSERT [dbo].[Building] ([BuildingId], [Name], [SubName], [Location], [Note]) VALUES (37, N'D5', N'', 0x00000000010C92CD55F31C013540B55208E412765A40, NULL)
INSERT [dbo].[Building] ([BuildingId], [Name], [SubName], [Location], [Note]) VALUES (38, N'D3', N'', 0x00000000010CD6E3BED53A01354043AB933314765A40, NULL)
INSERT [dbo].[Building] ([BuildingId], [Name], [SubName], [Location], [Note]) VALUES (39, N'C8', N'Bộ môn Kỹ thuật hàng không vũ trụ', 0x00000000010CE31C75745C0135400745F30016765A40, NULL)
INSERT [dbo].[Building] ([BuildingId], [Name], [SubName], [Location], [Note]) VALUES (40, N'C7', N'', 0x00000000010CAFCE31207B0135406781768714765A40, NULL)
INSERT [dbo].[Building] ([BuildingId], [Name], [SubName], [Location], [Note]) VALUES (41, N'C6', N'', 0x00000000010CDCF0BBE996013540D21DC4CE14765A40, NULL)
INSERT [dbo].[Building] ([BuildingId], [Name], [SubName], [Location], [Note]) VALUES (42, N'CFL', N'Trung tâm Ngoại ngữ CFL', 0x00000000010C2DE92807B3013540F19E03CB11765A40, NULL)
INSERT [dbo].[Building] ([BuildingId], [Name], [SubName], [Location], [Note]) VALUES (43, N'Phòng TN Động cơ đốt trong', N'Phòng thí nghiệm Động cơ đốt trong', 0x00000000010C7976F9D6870135404B3B35971B765A40, NULL)
INSERT [dbo].[Building] ([BuildingId], [Name], [SubName], [Location], [Note]) VALUES (44, N'B8', N'', 0x00000000010CDA722EC5550135407653CA6B25765A40, NULL)
INSERT [dbo].[Building] ([BuildingId], [Name], [SubName], [Location], [Note]) VALUES (45, N'B7BIS', N'', 0x00000000010C0070ECD973013540105A0F5F26765A40, NULL)
INSERT [dbo].[Building] ([BuildingId], [Name], [SubName], [Location], [Note]) VALUES (46, N'B7', N'', 0x00000000010C0B24287E8C013540459BE3DC26765A40, NULL)
INSERT [dbo].[Building] ([BuildingId], [Name], [SubName], [Location], [Note]) VALUES (47, N'B6', N'', 0x00000000010C0AF65FE7A60135403A07CF8426765A40, NULL)
INSERT [dbo].[Building] ([BuildingId], [Name], [SubName], [Location], [Note]) VALUES (48, N'B5', N'', 0x00000000010CC3499A3FA6013540EB387EA834765A40, NULL)
INSERT [dbo].[Building] ([BuildingId], [Name], [SubName], [Location], [Note]) VALUES (49, N'B9', N'', 0x00000000010C9BE447FC8A01354074081C0934765A40, NULL)
INSERT [dbo].[Building] ([BuildingId], [Name], [SubName], [Location], [Note]) VALUES (50, N'D3-5', N'', 0x00000000010C05172B6A30013540ED9A90D618765A40, NULL)
SET IDENTITY_INSERT [dbo].[Building] OFF
INSERT [dbo].[Building2Classroom] ([BuildingId], [ClassroomId]) VALUES (33, 26)
INSERT [dbo].[Building2Classroom] ([BuildingId], [ClassroomId]) VALUES (33, 27)
INSERT [dbo].[Building2Classroom] ([BuildingId], [ClassroomId]) VALUES (33, 28)
INSERT [dbo].[Building2Classroom] ([BuildingId], [ClassroomId]) VALUES (33, 29)
INSERT [dbo].[Building2Classroom] ([BuildingId], [ClassroomId]) VALUES (33, 30)
INSERT [dbo].[Building2Classroom] ([BuildingId], [ClassroomId]) VALUES (33, 31)
INSERT [dbo].[Building2Classroom] ([BuildingId], [ClassroomId]) VALUES (33, 32)
INSERT [dbo].[Building2Classroom] ([BuildingId], [ClassroomId]) VALUES (34, 13)
INSERT [dbo].[Building2Classroom] ([BuildingId], [ClassroomId]) VALUES (34, 14)
INSERT [dbo].[Building2Classroom] ([BuildingId], [ClassroomId]) VALUES (34, 15)
INSERT [dbo].[Building2Classroom] ([BuildingId], [ClassroomId]) VALUES (34, 21)
INSERT [dbo].[Building2Classroom] ([BuildingId], [ClassroomId]) VALUES (34, 22)
INSERT [dbo].[Building2Classroom] ([BuildingId], [ClassroomId]) VALUES (34, 24)
INSERT [dbo].[Building2Classroom] ([BuildingId], [ClassroomId]) VALUES (36, 10)
INSERT [dbo].[Building2Classroom] ([BuildingId], [ClassroomId]) VALUES (36, 11)
INSERT [dbo].[Building2Classroom] ([BuildingId], [ClassroomId]) VALUES (36, 12)
INSERT [dbo].[Building2Classroom] ([BuildingId], [ClassroomId]) VALUES (36, 19)
INSERT [dbo].[Building2Classroom] ([BuildingId], [ClassroomId]) VALUES (36, 20)
INSERT [dbo].[Building2Classroom] ([BuildingId], [ClassroomId]) VALUES (36, 25)
INSERT [dbo].[Building2Classroom] ([BuildingId], [ClassroomId]) VALUES (37, 6)
INSERT [dbo].[Building2Classroom] ([BuildingId], [ClassroomId]) VALUES (37, 7)
INSERT [dbo].[Building2Classroom] ([BuildingId], [ClassroomId]) VALUES (38, 1)
INSERT [dbo].[Building2Classroom] ([BuildingId], [ClassroomId]) VALUES (38, 2)
INSERT [dbo].[Building2Classroom] ([BuildingId], [ClassroomId]) VALUES (38, 3)
INSERT [dbo].[Building2Classroom] ([BuildingId], [ClassroomId]) VALUES (38, 4)
INSERT [dbo].[Building2Classroom] ([BuildingId], [ClassroomId]) VALUES (38, 5)
INSERT [dbo].[Building2Classroom] ([BuildingId], [ClassroomId]) VALUES (38, 8)
INSERT [dbo].[Building2Classroom] ([BuildingId], [ClassroomId]) VALUES (38, 9)
INSERT [dbo].[Building2Classroom] ([BuildingId], [ClassroomId]) VALUES (50, 16)
INSERT [dbo].[Building2Classroom] ([BuildingId], [ClassroomId]) VALUES (50, 17)
INSERT [dbo].[Building2Classroom] ([BuildingId], [ClassroomId]) VALUES (50, 18)
SET IDENTITY_INSERT [dbo].[Classroom] ON 

INSERT [dbo].[Classroom] ([ClassroomId], [Floor], [Name], [SubName], [Note]) VALUES (1, 1, N'101', N'Giảng đường D3-101', NULL)
INSERT [dbo].[Classroom] ([ClassroomId], [Floor], [Name], [SubName], [Note]) VALUES (2, 1, N'102', N'Giảng đường D3-102', NULL)
INSERT [dbo].[Classroom] ([ClassroomId], [Floor], [Name], [SubName], [Note]) VALUES (3, 1, N'103', N'Giảng đường D3-103', NULL)
INSERT [dbo].[Classroom] ([ClassroomId], [Floor], [Name], [SubName], [Note]) VALUES (4, 2, N'201', N'Giảng đường D3-201', NULL)
INSERT [dbo].[Classroom] ([ClassroomId], [Floor], [Name], [SubName], [Note]) VALUES (5, 2, N'202', N'Giảng đường D3-202', NULL)
INSERT [dbo].[Classroom] ([ClassroomId], [Floor], [Name], [SubName], [Note]) VALUES (6, 2, N'202', N'Giảng đường D5-202', NULL)
INSERT [dbo].[Classroom] ([ClassroomId], [Floor], [Name], [SubName], [Note]) VALUES (7, 2, N'203', N'Giảng đường D5-203', NULL)
INSERT [dbo].[Classroom] ([ClassroomId], [Floor], [Name], [SubName], [Note]) VALUES (8, 2, N'203', N'Phòng thí nghiệm Vật lý đại cương D3-203', NULL)
INSERT [dbo].[Classroom] ([ClassroomId], [Floor], [Name], [SubName], [Note]) VALUES (9, 2, N'204', N'Phòng thí nghiệm Vật lý đại cương D3-204', NULL)
INSERT [dbo].[Classroom] ([ClassroomId], [Floor], [Name], [SubName], [Note]) VALUES (10, 1, N'104', N'Giảng đường D7-104', NULL)
INSERT [dbo].[Classroom] ([ClassroomId], [Floor], [Name], [SubName], [Note]) VALUES (11, 2, N'201', N'Giảng đường D7-201', NULL)
INSERT [dbo].[Classroom] ([ClassroomId], [Floor], [Name], [SubName], [Note]) VALUES (12, 2, N'202', N'Giảng đường D7-202', NULL)
INSERT [dbo].[Classroom] ([ClassroomId], [Floor], [Name], [SubName], [Note]) VALUES (13, 2, N'202', N'Giảng đường D9-202', NULL)
INSERT [dbo].[Classroom] ([ClassroomId], [Floor], [Name], [SubName], [Note]) VALUES (14, 2, N'203', N'Giảng đường D9-203', NULL)
INSERT [dbo].[Classroom] ([ClassroomId], [Floor], [Name], [SubName], [Note]) VALUES (15, 2, N'204', N'Giảng đường D9-204', NULL)
INSERT [dbo].[Classroom] ([ClassroomId], [Floor], [Name], [SubName], [Note]) VALUES (16, 3, N'302', N'Giảng đường D3-5 302', NULL)
INSERT [dbo].[Classroom] ([ClassroomId], [Floor], [Name], [SubName], [Note]) VALUES (17, 2, N'201', N'Giảng đường D3-5 201', NULL)
INSERT [dbo].[Classroom] ([ClassroomId], [Floor], [Name], [SubName], [Note]) VALUES (18, 2, N'202', N'Giảng đường D3-5 202', NULL)
INSERT [dbo].[Classroom] ([ClassroomId], [Floor], [Name], [SubName], [Note]) VALUES (19, 2, N'402', N'Giảng đường D7 402', NULL)
INSERT [dbo].[Classroom] ([ClassroomId], [Floor], [Name], [SubName], [Note]) VALUES (20, 2, N'401', N'Giảng đường D7 401', NULL)
INSERT [dbo].[Classroom] ([ClassroomId], [Floor], [Name], [SubName], [Note]) VALUES (21, 2, N'403', N'Giảng đường D9 403', NULL)
INSERT [dbo].[Classroom] ([ClassroomId], [Floor], [Name], [SubName], [Note]) VALUES (22, 3, N'303', N'Giảng đường D9 303', NULL)
INSERT [dbo].[Classroom] ([ClassroomId], [Floor], [Name], [SubName], [Note]) VALUES (24, 3, N'301', N'Giảng đường D9 301', NULL)
INSERT [dbo].[Classroom] ([ClassroomId], [Floor], [Name], [SubName], [Note]) VALUES (25, 3, N'302', N'Giảng đường D7 302', NULL)
INSERT [dbo].[Classroom] ([ClassroomId], [Floor], [Name], [SubName], [Note]) VALUES (26, 1, N'102', N'Phòng mượn sách tham khảo 102 Thư viện Tạ Quang Bửu', NULL)
INSERT [dbo].[Classroom] ([ClassroomId], [Floor], [Name], [SubName], [Note]) VALUES (27, 1, N'111', N'Phòng mượn sách tham khảo 111 Thư viện Tạ Quang Bửu', NULL)
INSERT [dbo].[Classroom] ([ClassroomId], [Floor], [Name], [SubName], [Note]) VALUES (28, 2, N'204', N'Văn phòng 204 Thư viện Tạ Quang Bửu', NULL)
INSERT [dbo].[Classroom] ([ClassroomId], [Floor], [Name], [SubName], [Note]) VALUES (29, 2, N'213', N'Ban quản trị toà nhà 213 Thư viện Tạ Quang Bửu', NULL)
INSERT [dbo].[Classroom] ([ClassroomId], [Floor], [Name], [SubName], [Note]) VALUES (30, 2, N'220A', N'Phòng thông tin thư mục 220A Thư viện Tạ Quang Bửu', NULL)
INSERT [dbo].[Classroom] ([ClassroomId], [Floor], [Name], [SubName], [Note]) VALUES (31, 2, N'227', N'Phòng 227 - Hướng dẫn sử dụng Thư viện Tạ Quang Bửu', NULL)
INSERT [dbo].[Classroom] ([ClassroomId], [Floor], [Name], [SubName], [Note]) VALUES (32, 3, N'320', N'Phòng truyền thống ĐHBKHN 320 Thư viện Tạ Quang Bửu', NULL)
SET IDENTITY_INSERT [dbo].[Classroom] OFF
SET IDENTITY_INSERT [dbo].[Manager] ON 

INSERT [dbo].[Manager] ([ManagerId], [Name], [Gender], [Birthday], [Email], [PhoneNumber]) VALUES (1, N'Nguyễn Văn Tân', 0, CAST(N'1990-04-21' AS Date), N'tannv210491@gmail.com', N'0345642688')
INSERT [dbo].[Manager] ([ManagerId], [Name], [Gender], [Birthday], [Email], [PhoneNumber]) VALUES (2, N'Đỗ Thị Mai', 2, CAST(N'1991-01-12' AS Date), N'maidt109154@gmail.com', N'0343896478')
INSERT [dbo].[Manager] ([ManagerId], [Name], [Gender], [Birthday], [Email], [PhoneNumber]) VALUES (3, N'Trần Lương Bằng', 1, CAST(N'1992-11-16' AS Date), N'bangtl136854@gmail.com', N'0358974280')
INSERT [dbo].[Manager] ([ManagerId], [Name], [Gender], [Birthday], [Email], [PhoneNumber]) VALUES (4, N'Lê Thanh Nghị', 3, CAST(N'1991-10-03' AS Date), N'nghilt1656863@gmail.com', N'0385794738')
INSERT [dbo].[Manager] ([ManagerId], [Name], [Gender], [Birthday], [Email], [PhoneNumber]) VALUES (5, N'Trần Thị Thanh Thuỷ', 2, CAST(N'1992-06-08' AS Date), N'thuyttt234685@gmail.com', N'0388448478')
SET IDENTITY_INSERT [dbo].[Manager] OFF
SET IDENTITY_INSERT [dbo].[Message] ON 

INSERT [dbo].[Message] ([SenderId], [RecieverId], [MessageId], [mContent], [Time]) VALUES (3, 2, 2069, N'Chào bạn', CAST(N'2019-05-15T11:51:06.847' AS DateTime))
INSERT [dbo].[Message] ([SenderId], [RecieverId], [MessageId], [mContent], [Time]) VALUES (3, 4, 2070, N'Xin chào!', CAST(N'2019-05-15T11:52:44.010' AS DateTime))
INSERT [dbo].[Message] ([SenderId], [RecieverId], [MessageId], [mContent], [Time]) VALUES (3, 4, 2072, N'Bạn học lớp nào?', CAST(N'2019-05-15T11:54:16.440' AS DateTime))
INSERT [dbo].[Message] ([SenderId], [RecieverId], [MessageId], [mContent], [Time]) VALUES (3, 15, 2076, N'tốt tốt', CAST(N'2019-05-17T15:57:01.180' AS DateTime))
INSERT [dbo].[Message] ([SenderId], [RecieverId], [MessageId], [mContent], [Time]) VALUES (3, 28, 2068, N' Xin chào', CAST(N'2019-05-15T11:49:01.743' AS DateTime))
INSERT [dbo].[Message] ([SenderId], [RecieverId], [MessageId], [mContent], [Time]) VALUES (3, 28, 2074, N'chào', CAST(N'2019-05-17T15:53:41.923' AS DateTime))
INSERT [dbo].[Message] ([SenderId], [RecieverId], [MessageId], [mContent], [Time]) VALUES (3, 28, 2075, N'em xin tiền', CAST(N'2019-05-17T15:53:49.633' AS DateTime))
INSERT [dbo].[Message] ([SenderId], [RecieverId], [MessageId], [mContent], [Time]) VALUES (4, 3, 2071, N'Hello!', CAST(N'2019-05-15T11:54:02.103' AS DateTime))
INSERT [dbo].[Message] ([SenderId], [RecieverId], [MessageId], [mContent], [Time]) VALUES (4, 3, 2073, N'Mình học lớp 12A4', CAST(N'2019-05-15T11:54:58.887' AS DateTime))
SET IDENTITY_INSERT [dbo].[Message] OFF
SET IDENTITY_INSERT [dbo].[News] ON 

INSERT [dbo].[News] ([NewsId], [ImageUrl], [Title], [Url], [Summary], [IsShowing]) VALUES (1, N'https://scontent.fhan2-4.fna.fbcdn.net/v/t1.0-9/54002580_2543684798980184_3448726273306656768_o.jpg?_nc_cat=105&_nc_oc=AQmSAqJqjFxCMk0ArceGRvtyDFBpYdFVbR4eXalDDYz3P0W9NC7GWKXSQfju0_1aqRk&_nc_ht=scontent.fhan2-4.fna&oh=de241f8a12b8c5eb2a3b19fad32db367&oe=5D073350&dl=1', N'Bach Khoa Open Day', N'https://www.facebook.com/BachKhoaOpenDay/photos/rpp.597627783585905/2543684792313518/?type=3&theater', N'Các khu vực tư vấn chuyên sâu sẽ kết thúc vào 17h chiều nay. Hẹn gặp lại các em', 1)
INSERT [dbo].[News] ([NewsId], [ImageUrl], [Title], [Url], [Summary], [IsShowing]) VALUES (2, N'https://scontent.fhan2-4.fna.fbcdn.net/v/t1.0-9/53855836_2543578245657506_7286016455471005696_o.jpg?_nc_cat=100&_nc_oc=AQlmCWahxQrHancuqLn0Al5FYf4irHYg3-I33Z4_Sdklff3VAn8SYZJdcPrnFiBwH4A&_nc_ht=scontent.fhan2-4.fna&oh=0f7317537f10be462424e312237bfa08&oe=5D06C6BF&dl=1', N'BACH KHOA OPEN 2019', N'https://www.facebook.com/BachKhoaOpenDay/photos/a.597677753580908/2543578238990840/?type=3&theater', N'Chờ đợi một buổi chiều BÙNG NỔ. Khu photozone - chụp ảnh & nhận ảnh miễn phí sẽ trở lại vào 13h30 ', 1)
INSERT [dbo].[News] ([NewsId], [ImageUrl], [Title], [Url], [Summary], [IsShowing]) VALUES (3, N'https://scontent.fhan2-4.fna.fbcdn.net/v/t1.0-9/54002580_2543684798980184_3448726273306656768_o.jpg?_nc_cat=105&_nc_oc=AQmSAqJqjFxCMk0ArceGRvtyDFBpYdFVbR4eXalDDYz3P0W9NC7GWKXSQfju0_1aqRk&_nc_ht=scontent.fhan2-4.fna&oh=de241f8a12b8c5eb2a3b19fad32db367&oe=5D073350&dl=1', N'Bach Khoa Open Day', N'https://www.facebook.com/BachKhoaOpenDay/photos/rpp.597627783585905/2543684792313518/?type=3&theater', N'Các khu vực tư vấn chuyên sâu sẽ kết thúc vào 17h chiều nay. Hẹn gặp lại các em', 1)
INSERT [dbo].[News] ([NewsId], [ImageUrl], [Title], [Url], [Summary], [IsShowing]) VALUES (4, N'https://scontent.fhan2-4.fna.fbcdn.net/v/t1.0-9/54002580_2543684798980184_3448726273306656768_o.jpg?_nc_cat=105&_nc_oc=AQmSAqJqjFxCMk0ArceGRvtyDFBpYdFVbR4eXalDDYz3P0W9NC7GWKXSQfju0_1aqRk&_nc_ht=scontent.fhan2-4.fna&oh=de241f8a12b8c5eb2a3b19fad32db367&oe=5D073350&dl=1', N'Bach Khoa Open Day', N'https://www.facebook.com/BachKhoaOpenDay/photos/rpp.597627783585905/2543684792313518/?type=3&theater', N'Các khu vực tư vấn chuyên sâu sẽ kết thúc vào 17h chiều nay. Hẹn gặp lại các em', 1)
INSERT [dbo].[News] ([NewsId], [ImageUrl], [Title], [Url], [Summary], [IsShowing]) VALUES (5, N'https://scontent.fhan2-4.fna.fbcdn.net/v/t1.0-9/53855836_2543578245657506_7286016455471005696_o.jpg?_nc_cat=100&_nc_oc=AQlmCWahxQrHancuqLn0Al5FYf4irHYg3-I33Z4_Sdklff3VAn8SYZJdcPrnFiBwH4A&_nc_ht=scontent.fhan2-4.fna&oh=0f7317537f10be462424e312237bfa08&oe=5D06C6BF&dl=1', N'BACH KHOA OPEN 2019', N'https://www.facebook.com/BachKhoaOpenDay/photos/a.597677753580908/2543578238990840/?type=3&theater', N'Chờ đợi một buổi chiều BÙNG NỔ. Khu photozone - chụp ảnh & nhận ảnh miễn phí sẽ trở lại vào 13h30 ', 1)
INSERT [dbo].[News] ([NewsId], [ImageUrl], [Title], [Url], [Summary], [IsShowing]) VALUES (6, N'https://scontent.fhan2-4.fna.fbcdn.net/v/t1.0-9/53855836_2543578245657506_7286016455471005696_o.jpg?_nc_cat=100&_nc_oc=AQlmCWahxQrHancuqLn0Al5FYf4irHYg3-I33Z4_Sdklff3VAn8SYZJdcPrnFiBwH4A&_nc_ht=scontent.fhan2-4.fna&oh=0f7317537f10be462424e312237bfa08&oe=5D06C6BF&dl=1', N'BACH KHOA OPEN 2019', N'https://www.facebook.com/BachKhoaOpenDay/photos/a.597677753580908/2543578238990840/?type=3&theater', N'Chờ đợi một buổi chiều BÙNG NỔ. Khu photozone - chụp ảnh & nhận ảnh miễn phí sẽ trở lại vào 13h30 ', 1)
INSERT [dbo].[News] ([NewsId], [ImageUrl], [Title], [Url], [Summary], [IsShowing]) VALUES (7, N'https://scontent.fhan2-4.fna.fbcdn.net/v/t1.0-9/54002580_2543684798980184_3448726273306656768_o.jpg?_nc_cat=105&_nc_oc=AQmSAqJqjFxCMk0ArceGRvtyDFBpYdFVbR4eXalDDYz3P0W9NC7GWKXSQfju0_1aqRk&_nc_ht=scontent.fhan2-4.fna&oh=de241f8a12b8c5eb2a3b19fad32db367&oe=5D073350&dl=1', N'Bach Khoa Open Day', N'https://www.facebook.com/BachKhoaOpenDay/photos/rpp.597627783585905/2543684792313518/?type=3&theater', N'Các khu vực tư vấn chuyên sâu sẽ kết thúc vào 17h chiều nay. Hẹn gặp lại các em', 1)
INSERT [dbo].[News] ([NewsId], [ImageUrl], [Title], [Url], [Summary], [IsShowing]) VALUES (8, N'https://scontent.fhan2-4.fna.fbcdn.net/v/t1.0-9/53855836_2543578245657506_7286016455471005696_o.jpg?_nc_cat=100&_nc_oc=AQlmCWahxQrHancuqLn0Al5FYf4irHYg3-I33Z4_Sdklff3VAn8SYZJdcPrnFiBwH4A&_nc_ht=scontent.fhan2-4.fna&oh=0f7317537f10be462424e312237bfa08&oe=5D06C6BF&dl=1', N'BACH KHOA OPEN 2019', N'https://www.facebook.com/BachKhoaOpenDay/photos/a.597677753580908/2543578238990840/?type=3&theater', N'Chờ đợi một buổi chiều BÙNG NỔ. Khu photozone - chụp ảnh & nhận ảnh miễn phí sẽ trở lại vào 13h30 ', 1)
INSERT [dbo].[News] ([NewsId], [ImageUrl], [Title], [Url], [Summary], [IsShowing]) VALUES (9, N'https://scontent.fhan2-4.fna.fbcdn.net/v/t1.0-9/54002580_2543684798980184_3448726273306656768_o.jpg?_nc_cat=105&_nc_oc=AQmSAqJqjFxCMk0ArceGRvtyDFBpYdFVbR4eXalDDYz3P0W9NC7GWKXSQfju0_1aqRk&_nc_ht=scontent.fhan2-4.fna&oh=de241f8a12b8c5eb2a3b19fad32db367&oe=5D073350&dl=1', N'Bach Khoa Open Day', N'https://www.facebook.com/BachKhoaOpenDay/photos/rpp.597627783585905/2543684792313518/?type=3&theater', N'Các khu vực tư vấn chuyên sâu sẽ kết thúc vào 17h chiều nay. Hẹn gặp lại các em', 1)
INSERT [dbo].[News] ([NewsId], [ImageUrl], [Title], [Url], [Summary], [IsShowing]) VALUES (10, N'https://scontent.fhan2-4.fna.fbcdn.net/v/t1.0-9/54002580_2543684798980184_3448726273306656768_o.jpg?_nc_cat=105&_nc_oc=AQmSAqJqjFxCMk0ArceGRvtyDFBpYdFVbR4eXalDDYz3P0W9NC7GWKXSQfju0_1aqRk&_nc_ht=scontent.fhan2-4.fna&oh=de241f8a12b8c5eb2a3b19fad32db367&oe=5D073350&dl=1', N'Bach Khoa Open Day', N'https://www.facebook.com/BachKhoaOpenDay/photos/rpp.597627783585905/2543684792313518/?type=3&theater', N'Các khu vực tư vấn chuyên sâu sẽ kết thúc vào 17h chiều nay. Hẹn gặp lại các em', 1)
INSERT [dbo].[News] ([NewsId], [ImageUrl], [Title], [Url], [Summary], [IsShowing]) VALUES (11, N'https://scontent.fhan2-4.fna.fbcdn.net/v/t1.0-9/53855836_2543578245657506_7286016455471005696_o.jpg?_nc_cat=100&_nc_oc=AQlmCWahxQrHancuqLn0Al5FYf4irHYg3-I33Z4_Sdklff3VAn8SYZJdcPrnFiBwH4A&_nc_ht=scontent.fhan2-4.fna&oh=0f7317537f10be462424e312237bfa08&oe=5D06C6BF&dl=1', N'BACH KHOA OPEN 2019', N'https://www.facebook.com/BachKhoaOpenDay/photos/a.597677753580908/2543578238990840/?type=3&theater', N'Chờ đợi một buổi chiều BÙNG NỔ. Khu photozone - chụp ảnh & nhận ảnh miễn phí sẽ trở lại vào 13h30 ', 1)
INSERT [dbo].[News] ([NewsId], [ImageUrl], [Title], [Url], [Summary], [IsShowing]) VALUES (12, N'https://scontent.fhan2-4.fna.fbcdn.net/v/t1.0-9/53855836_2543578245657506_7286016455471005696_o.jpg?_nc_cat=100&_nc_oc=AQlmCWahxQrHancuqLn0Al5FYf4irHYg3-I33Z4_Sdklff3VAn8SYZJdcPrnFiBwH4A&_nc_ht=scontent.fhan2-4.fna&oh=0f7317537f10be462424e312237bfa08&oe=5D06C6BF&dl=1', N'BACH KHOA OPEN 2019', N'https://www.facebook.com/BachKhoaOpenDay/photos/a.597677753580908/2543578238990840/?type=3&theater', N'Chờ đợi một buổi chiều BÙNG NỔ. Khu photozone - chụp ảnh & nhận ảnh miễn phí sẽ trở lại vào 13h30 ', 1)
SET IDENTITY_INSERT [dbo].[News] OFF
INSERT [dbo].[Setting] ([FormUrl]) VALUES (N'http://bit.ly/DangKyTraiNghiemHUST
')
SET IDENTITY_INSERT [dbo].[Timesheet] ON 

INSERT [dbo].[Timesheet] ([TimesheetId], [StartTime], [EndTime]) VALUES (19, CAST(N'00:00:00' AS Time), CAST(N'01:00:00' AS Time))
INSERT [dbo].[Timesheet] ([TimesheetId], [StartTime], [EndTime]) VALUES (20, CAST(N'01:00:00' AS Time), CAST(N'02:00:00' AS Time))
INSERT [dbo].[Timesheet] ([TimesheetId], [StartTime], [EndTime]) VALUES (21, CAST(N'02:00:00' AS Time), CAST(N'03:00:00' AS Time))
INSERT [dbo].[Timesheet] ([TimesheetId], [StartTime], [EndTime]) VALUES (22, CAST(N'03:00:00' AS Time), CAST(N'04:00:00' AS Time))
INSERT [dbo].[Timesheet] ([TimesheetId], [StartTime], [EndTime]) VALUES (23, CAST(N'04:00:00' AS Time), CAST(N'05:00:00' AS Time))
INSERT [dbo].[Timesheet] ([TimesheetId], [StartTime], [EndTime]) VALUES (24, CAST(N'05:00:00' AS Time), CAST(N'06:00:00' AS Time))
INSERT [dbo].[Timesheet] ([TimesheetId], [StartTime], [EndTime]) VALUES (1, CAST(N'06:00:00' AS Time), CAST(N'07:00:00' AS Time))
INSERT [dbo].[Timesheet] ([TimesheetId], [StartTime], [EndTime]) VALUES (2, CAST(N'07:00:00' AS Time), CAST(N'08:00:00' AS Time))
INSERT [dbo].[Timesheet] ([TimesheetId], [StartTime], [EndTime]) VALUES (3, CAST(N'08:00:00' AS Time), CAST(N'09:00:00' AS Time))
INSERT [dbo].[Timesheet] ([TimesheetId], [StartTime], [EndTime]) VALUES (4, CAST(N'09:00:00' AS Time), CAST(N'10:00:00' AS Time))
INSERT [dbo].[Timesheet] ([TimesheetId], [StartTime], [EndTime]) VALUES (5, CAST(N'10:00:00' AS Time), CAST(N'11:00:00' AS Time))
INSERT [dbo].[Timesheet] ([TimesheetId], [StartTime], [EndTime]) VALUES (6, CAST(N'11:00:00' AS Time), CAST(N'12:00:00' AS Time))
INSERT [dbo].[Timesheet] ([TimesheetId], [StartTime], [EndTime]) VALUES (7, CAST(N'12:00:00' AS Time), CAST(N'13:00:00' AS Time))
INSERT [dbo].[Timesheet] ([TimesheetId], [StartTime], [EndTime]) VALUES (8, CAST(N'13:00:00' AS Time), CAST(N'14:00:00' AS Time))
INSERT [dbo].[Timesheet] ([TimesheetId], [StartTime], [EndTime]) VALUES (9, CAST(N'14:00:00' AS Time), CAST(N'15:00:00' AS Time))
INSERT [dbo].[Timesheet] ([TimesheetId], [StartTime], [EndTime]) VALUES (10, CAST(N'15:00:00' AS Time), CAST(N'16:00:00' AS Time))
INSERT [dbo].[Timesheet] ([TimesheetId], [StartTime], [EndTime]) VALUES (11, CAST(N'16:00:00' AS Time), CAST(N'17:00:00' AS Time))
INSERT [dbo].[Timesheet] ([TimesheetId], [StartTime], [EndTime]) VALUES (12, CAST(N'17:00:00' AS Time), CAST(N'18:00:00' AS Time))
INSERT [dbo].[Timesheet] ([TimesheetId], [StartTime], [EndTime]) VALUES (13, CAST(N'18:00:00' AS Time), CAST(N'19:00:00' AS Time))
INSERT [dbo].[Timesheet] ([TimesheetId], [StartTime], [EndTime]) VALUES (14, CAST(N'19:00:00' AS Time), CAST(N'20:00:00' AS Time))
INSERT [dbo].[Timesheet] ([TimesheetId], [StartTime], [EndTime]) VALUES (15, CAST(N'20:00:00' AS Time), CAST(N'21:00:00' AS Time))
INSERT [dbo].[Timesheet] ([TimesheetId], [StartTime], [EndTime]) VALUES (16, CAST(N'21:00:00' AS Time), CAST(N'22:00:00' AS Time))
INSERT [dbo].[Timesheet] ([TimesheetId], [StartTime], [EndTime]) VALUES (17, CAST(N'22:00:00' AS Time), CAST(N'23:00:00' AS Time))
INSERT [dbo].[Timesheet] ([TimesheetId], [StartTime], [EndTime]) VALUES (18, CAST(N'23:00:00' AS Time), CAST(N'00:00:00' AS Time))
SET IDENTITY_INSERT [dbo].[Timesheet] OFF
INSERT [dbo].[Timesheet2Classroom] ([TimesheetId], [ClassroomId], [ManagerId]) VALUES (1, 1, 1)
INSERT [dbo].[Timesheet2Classroom] ([TimesheetId], [ClassroomId], [ManagerId]) VALUES (2, 2, 4)
INSERT [dbo].[Timesheet2Classroom] ([TimesheetId], [ClassroomId], [ManagerId]) VALUES (3, 3, 1)
INSERT [dbo].[Timesheet2Classroom] ([TimesheetId], [ClassroomId], [ManagerId]) VALUES (4, 4, 2)
INSERT [dbo].[Timesheet2Classroom] ([TimesheetId], [ClassroomId], [ManagerId]) VALUES (5, 5, 5)
INSERT [dbo].[Timesheet2Classroom] ([TimesheetId], [ClassroomId], [ManagerId]) VALUES (6, 6, 1)
INSERT [dbo].[Timesheet2Classroom] ([TimesheetId], [ClassroomId], [ManagerId]) VALUES (7, 7, 2)
INSERT [dbo].[Timesheet2Classroom] ([TimesheetId], [ClassroomId], [ManagerId]) VALUES (8, 10, 3)
INSERT [dbo].[Timesheet2Classroom] ([TimesheetId], [ClassroomId], [ManagerId]) VALUES (9, 9, 2)
INSERT [dbo].[Timesheet2Classroom] ([TimesheetId], [ClassroomId], [ManagerId]) VALUES (10, 10, 5)
INSERT [dbo].[Timesheet2Classroom] ([TimesheetId], [ClassroomId], [ManagerId]) VALUES (11, 11, 5)
INSERT [dbo].[Timesheet2Classroom] ([TimesheetId], [ClassroomId], [ManagerId]) VALUES (12, 12, 5)
INSERT [dbo].[Timesheet2Classroom] ([TimesheetId], [ClassroomId], [ManagerId]) VALUES (13, 15, 4)
INSERT [dbo].[Timesheet2Classroom] ([TimesheetId], [ClassroomId], [ManagerId]) VALUES (14, 14, 4)
INSERT [dbo].[Timesheet2Classroom] ([TimesheetId], [ClassroomId], [ManagerId]) VALUES (15, 15, 3)
INSERT [dbo].[Timesheet2Classroom] ([TimesheetId], [ClassroomId], [ManagerId]) VALUES (16, 27, 5)
INSERT [dbo].[Timesheet2Classroom] ([TimesheetId], [ClassroomId], [ManagerId]) VALUES (17, 17, 3)
INSERT [dbo].[Timesheet2Classroom] ([TimesheetId], [ClassroomId], [ManagerId]) VALUES (18, 10, 4)
INSERT [dbo].[Timesheet2Classroom] ([TimesheetId], [ClassroomId], [ManagerId]) VALUES (19, 19, 4)
INSERT [dbo].[Timesheet2Classroom] ([TimesheetId], [ClassroomId], [ManagerId]) VALUES (20, 6, 2)
INSERT [dbo].[Timesheet2Classroom] ([TimesheetId], [ClassroomId], [ManagerId]) VALUES (21, 20, 2)
INSERT [dbo].[Timesheet2Classroom] ([TimesheetId], [ClassroomId], [ManagerId]) VALUES (22, 26, 1)
INSERT [dbo].[Timesheet2Classroom] ([TimesheetId], [ClassroomId], [ManagerId]) VALUES (23, 12, 4)
INSERT [dbo].[Timesheet2Classroom] ([TimesheetId], [ClassroomId], [ManagerId]) VALUES (24, 32, 1)
SET IDENTITY_INSERT [dbo].[Tour] ON 

INSERT [dbo].[Tour] ([TourId], [Name], [State], [ImageUrl], [Date], [MapImageUrl]) VALUES (1, N' Tham quan trường Đại học Bách Khoa Hà Nội', 1, N'https://scontent.fhan2-2.fna.fbcdn.net/v/t1.0-9/53881582_2543685265646804_4142767128342167552_o.jpg?_nc_cat=110&_nc_oc=AQm8i-mVHEZ0rcYR6NRBRw8bzbXaR1HUM2U5ev8iRmEtMBNUIG3pY3DHqh6FF5wz-R4&_nc_ht=scontent.fhan2-2.fna&oh=8971779b6015bf850dd9abc581c425cf&oe=5D01D6FC&dl=1', CAST(N'2019-05-17' AS Date), N'http://htqt.hust.edu.vn/imgs/maphnen.jpg')
INSERT [dbo].[Tour] ([TourId], [Name], [State], [ImageUrl], [Date], [MapImageUrl]) VALUES (2, N'Bách Khoa Open Day 2019', 1, N'https://scontent.fhan2-4.fna.fbcdn.net/v/t1.0-9/53855836_2543578245657506_7286016455471005696_o.jpg?_nc_cat=100&_nc_oc=AQnAaFR-iTLR3A0oGZqZw47RMzeQ9oAtlAojLRk-m2PH3FG7UNg2Gb2G3ORIvjHU_zc&_nc_ht=scontent.fhan2-4.fna&oh=817fd8480de7d58b37b685069b6cce9e&oe=5D06C6BF&dl=1', CAST(N'2019-06-01' AS Date), N'http://htqt.hust.edu.vn/seminar2016/imgs/mapbken.jpg')
INSERT [dbo].[Tour] ([TourId], [Name], [State], [ImageUrl], [Date], [MapImageUrl]) VALUES (3, N'BK Open Day', 0, N'https://scontent.fhan2-2.fna.fbcdn.net/v/t1.0-9/54727808_2539129712769026_3596918712491311104_n.jpg?_nc_cat=110&_nc_oc=AQkPYNU0wE1jjp3jiHsKCTioHdBbnHEbAGqZgmzXloU6GBg69i7E1SteOO18gFbSHII&_nc_ht=scontent.fhan2-2.fna&oh=ac962ac37df113b774bfb03762b85901&oe=5D0CBB9C&dl=1', CAST(N'2019-06-01' AS Date), N'http://htqt.hust.edu.vn/imgs/maphnen.jpg')
INSERT [dbo].[Tour] ([TourId], [Name], [State], [ImageUrl], [Date], [MapImageUrl]) VALUES (4, N'BKOD', 1, N'https://scontent.fhan2-3.fna.fbcdn.net/v/t1.0-9/49650749_2433709176644414_7417508249332613120_n.jpg?_nc_cat=107&_nc_oc=AQmZsY4iWwnN37f_9qifMuwVw7AzOKuB31U9GaI2r-NtQmffH0_lJM78011XDp1RLh8&_nc_ht=scontent.fhan2-3.fna&oh=809a2e2b27a1e750a5bcf6405133c04c&oe=5D197C45&dl=1', CAST(N'2019-06-01' AS Date), N'http://htqt.hust.edu.vn/seminar2016/imgs/mapbken.jpg')
SET IDENTITY_INSERT [dbo].[Tour] OFF
INSERT [dbo].[Tour2Member] ([TourId], [UserId], [mFunction], [mLocation], [Note]) VALUES (1, 2, 0, NULL, NULL)
INSERT [dbo].[Tour2Member] ([TourId], [UserId], [mFunction], [mLocation], [Note]) VALUES (1, 3, 0, 0x00000000010C0A0A28791A01354000A8E2C62D765A40, NULL)
INSERT [dbo].[Tour2Member] ([TourId], [UserId], [mFunction], [mLocation], [Note]) VALUES (1, 4, 0, 0x00000000010C5D03B6DECA0735402A8991CA39725A40, NULL)
INSERT [dbo].[Tour2Member] ([TourId], [UserId], [mFunction], [mLocation], [Note]) VALUES (1, 5, 0, 0x00000000010C9FB0C403CA1A35405401F73C7F7C5A40, NULL)
INSERT [dbo].[Tour2Member] ([TourId], [UserId], [mFunction], [mLocation], [Note]) VALUES (1, 10, 0, 0x00000000010C384A5E9D633435405401F73C7F7C5A40, NULL)
INSERT [dbo].[Tour2Member] ([TourId], [UserId], [mFunction], [mLocation], [Note]) VALUES (1, 13, 0, NULL, NULL)
INSERT [dbo].[Tour2Member] ([TourId], [UserId], [mFunction], [mLocation], [Note]) VALUES (1, 15, 0, NULL, NULL)
INSERT [dbo].[Tour2Member] ([TourId], [UserId], [mFunction], [mLocation], [Note]) VALUES (1, 19, 3, NULL, NULL)
INSERT [dbo].[Tour2Member] ([TourId], [UserId], [mFunction], [mLocation], [Note]) VALUES (1, 20, 1, 0x00000000010C6B7D91D09667354087342A70B24F5A40, NULL)
INSERT [dbo].[Tour2Member] ([TourId], [UserId], [mFunction], [mLocation], [Note]) VALUES (1, 23, 2, NULL, NULL)
INSERT [dbo].[Tour2Member] ([TourId], [UserId], [mFunction], [mLocation], [Note]) VALUES (2, 3, 0, 0x00000000010C0A0A28791A01354000A8E2C62D765A40, NULL)
INSERT [dbo].[Tour2Member] ([TourId], [UserId], [mFunction], [mLocation], [Note]) VALUES (2, 4, 0, 0x00000000010C5D03B6DECA0735402A8991CA39725A40, NULL)
INSERT [dbo].[Tour2Member] ([TourId], [UserId], [mFunction], [mLocation], [Note]) VALUES (2, 5, 0, 0x00000000010CD2E3F736FD4D354087342A70B24F5A40, NULL)
INSERT [dbo].[Tour2Member] ([TourId], [UserId], [mFunction], [mLocation], [Note]) VALUES (2, 10, 0, NULL, NULL)
INSERT [dbo].[Tour2Member] ([TourId], [UserId], [mFunction], [mLocation], [Note]) VALUES (2, 13, 1, NULL, NULL)
INSERT [dbo].[Tour2Member] ([TourId], [UserId], [mFunction], [mLocation], [Note]) VALUES (2, 15, 2, NULL, NULL)
INSERT [dbo].[Tour2Member] ([TourId], [UserId], [mFunction], [mLocation], [Note]) VALUES (2, 19, 0, NULL, NULL)
INSERT [dbo].[Tour2Member] ([TourId], [UserId], [mFunction], [mLocation], [Note]) VALUES (3, 3, 1, 0x00000000010C0A0A28791A01354000A8E2C62D765A40, NULL)
INSERT [dbo].[Tour2Member] ([TourId], [UserId], [mFunction], [mLocation], [Note]) VALUES (3, 4, 0, 0x00000000010C5D03B6DECA0735402A8991CA39725A40, NULL)
INSERT [dbo].[Tour2Member] ([TourId], [UserId], [mFunction], [mLocation], [Note]) VALUES (3, 5, 2, NULL, NULL)
INSERT [dbo].[Tour2Member] ([TourId], [UserId], [mFunction], [mLocation], [Note]) VALUES (3, 10, 0, NULL, NULL)
INSERT [dbo].[Tour2Member] ([TourId], [UserId], [mFunction], [mLocation], [Note]) VALUES (3, 15, 0, NULL, NULL)
INSERT [dbo].[Tour2Timesheet] ([TourId], [TimesheetId]) VALUES (1, 5)
INSERT [dbo].[Tour2Timesheet] ([TourId], [TimesheetId]) VALUES (1, 6)
INSERT [dbo].[Tour2Timesheet] ([TourId], [TimesheetId]) VALUES (1, 7)
INSERT [dbo].[Tour2Timesheet] ([TourId], [TimesheetId]) VALUES (1, 9)
INSERT [dbo].[Tour2Timesheet] ([TourId], [TimesheetId]) VALUES (1, 10)
INSERT [dbo].[Tour2Timesheet] ([TourId], [TimesheetId]) VALUES (1, 11)
INSERT [dbo].[Tour2Timesheet] ([TourId], [TimesheetId]) VALUES (1, 12)
INSERT [dbo].[Tour2Timesheet] ([TourId], [TimesheetId]) VALUES (2, 3)
INSERT [dbo].[Tour2Timesheet] ([TourId], [TimesheetId]) VALUES (2, 8)
INSERT [dbo].[Tour2Timesheet] ([TourId], [TimesheetId]) VALUES (2, 15)
INSERT [dbo].[Tour2Timesheet] ([TourId], [TimesheetId]) VALUES (2, 16)
INSERT [dbo].[Tour2Timesheet] ([TourId], [TimesheetId]) VALUES (2, 23)
INSERT [dbo].[Tour2Timesheet] ([TourId], [TimesheetId]) VALUES (3, 3)
INSERT [dbo].[Tour2Timesheet] ([TourId], [TimesheetId]) VALUES (3, 4)
INSERT [dbo].[Tour2Timesheet] ([TourId], [TimesheetId]) VALUES (3, 5)
INSERT [dbo].[Tour2Timesheet] ([TourId], [TimesheetId]) VALUES (3, 6)
INSERT [dbo].[Tour2Timesheet] ([TourId], [TimesheetId]) VALUES (3, 16)
INSERT [dbo].[Tour2Timesheet] ([TourId], [TimesheetId]) VALUES (4, 7)
INSERT [dbo].[Tour2Timesheet] ([TourId], [TimesheetId]) VALUES (4, 8)
INSERT [dbo].[Tour2Timesheet] ([TourId], [TimesheetId]) VALUES (4, 9)
INSERT [dbo].[Tour2Timesheet] ([TourId], [TimesheetId]) VALUES (4, 10)
INSERT [dbo].[Tour2Timesheet] ([TourId], [TimesheetId]) VALUES (4, 11)
INSERT [dbo].[Tour2Timesheet] ([TourId], [TimesheetId]) VALUES (4, 17)
INSERT [dbo].[Tour2Timesheet] ([TourId], [TimesheetId]) VALUES (4, 18)
SET IDENTITY_INSERT [dbo].[User] ON 

INSERT [dbo].[User] ([UserId], [Username], [Password], [Fullname], [Birthday], [Gender], [School], [Class], [PhoneNumber], [IsCounselor], [State]) VALUES (2, N'test@a.a', N'0AA32D65213048FCBE3F8469AC825A33401CAA904EBB6EAC5BB2AFD278745DED', N'Lê Mạnh Hùng', CAST(N'2002-06-14' AS Date), 1, N'Trường THPT Chu Văn An', N'10B', N'0325485634', 0, 0)
INSERT [dbo].[User] ([UserId], [Username], [Password], [Fullname], [Birthday], [Gender], [School], [Class], [PhoneNumber], [IsCounselor], [State]) VALUES (3, N'a@a.a', N'F8044C313ABEC15571C4774F22A5BE29F0909D49DCDA08FF0CA1AC3B886E8EFC', N'Nguyễn Tử Quảng', CAST(N'1998-11-21' AS Date), 1, N'Trường THPT Phan Huy Chú', N'12A4', N'0367456534', 0, 0)
INSERT [dbo].[User] ([UserId], [Username], [Password], [Fullname], [Birthday], [Gender], [School], [Class], [PhoneNumber], [IsCounselor], [State]) VALUES (4, N'b@a.a', N'FBCCFB1397391B9BB9E276AEA206280F79EC2CA6A7610705977FD869363C67C4', N'Nguyễn Thị Thanh', CAST(N'2000-11-03' AS Date), 2, N'THPT Nguyễn Đức Cảnh', N'10A9', N'0365687984', 0, 0)
INSERT [dbo].[User] ([UserId], [Username], [Password], [Fullname], [Birthday], [Gender], [School], [Class], [PhoneNumber], [IsCounselor], [State]) VALUES (5, N'c@a.a', N'FF9226C6D071987EE043B8136FDC287387C7D9D792936D557E709A807F2B4EAF', N'Trần Duy Hưng', CAST(N'2004-01-13' AS Date), 1, N'Trường THPT Thăng Long', N'12D', N'0356346856', 0, 1)
INSERT [dbo].[User] ([UserId], [Username], [Password], [Fullname], [Birthday], [Gender], [School], [Class], [PhoneNumber], [IsCounselor], [State]) VALUES (10, N'a@aa.a', N'D2855EEDBFD45A3237447569C6AA214AF1895337CF45D9C9A82A3226910BA158', N'Nguyễn Văn An', CAST(N'2004-01-01' AS Date), 1, N'Trường THPT Phạm Hồng Thái', N'Chuyên Vật Lý', N'0673562347', 0, 0)
INSERT [dbo].[User] ([UserId], [Username], [Password], [Fullname], [Birthday], [Gender], [School], [Class], [PhoneNumber], [IsCounselor], [State]) VALUES (13, N'aa@a.a', N'426ED65B32EEAC1C8EAA5CB1E2166E11A5E22A9D5640D2CFB3FBDCF1D482CAB9', N'Lê Than Nghị', CAST(N'2004-01-01' AS Date), 2, N'Trường THPT Nguyễn Trãi - Ba Đình', N'10A3', N'0356756636', 0, 0)
INSERT [dbo].[User] ([UserId], [Username], [Password], [Fullname], [Birthday], [Gender], [School], [Class], [PhoneNumber], [IsCounselor], [State]) VALUES (15, N'aa@aa.a', N'81E17F5B24B87C129B18D24DC26B3C8183C3972F1CB5B1ED0697E31BCE4EBE01', N'Lê Công Vinh', CAST(N'2004-01-01' AS Date), 1, N'Trường THPT Lê Quý Đôn', N'11B3', N'0356733454', 0, 0)
INSERT [dbo].[User] ([UserId], [Username], [Password], [Fullname], [Birthday], [Gender], [School], [Class], [PhoneNumber], [IsCounselor], [State]) VALUES (19, N'aaa@a.a', N'AB1C834A4D1E483AC77DB38379136ED8B0B2FD66433DD0D1AB15B36E021BD9A5', N'Nguyễn Xuân Bắc', CAST(N'2004-01-01' AS Date), 1, N'Trường THPT Văn Lang', N'12A1', N'0356747567', 0, 0)
INSERT [dbo].[User] ([UserId], [Username], [Password], [Fullname], [Birthday], [Gender], [School], [Class], [PhoneNumber], [IsCounselor], [State]) VALUES (20, N'aaaa@a.a', N'A1FF9537F25164E39F6A9B09E81697EFA508DA3B626FD753DE995AC08262C7B0', N'Phan Văn Tài Em', CAST(N'2004-01-01' AS Date), 3, N'Trường THPT Trần Phú', N'10C', N'0348176876', 0, 1)
INSERT [dbo].[User] ([UserId], [Username], [Password], [Fullname], [Birthday], [Gender], [School], [Class], [PhoneNumber], [IsCounselor], [State]) VALUES (23, N'aaaaa@a.a', N'BB16F4A13F6F2CAC6E4742D59C34BC6BD860C51F23E817A7461F4F55C97ABEB8', N'Nguyễn Thị Linh', CAST(N'2004-01-01' AS Date), 1, N'Trường THPT Đoàn Kết - Hai Bà Trưng', N'Chuyên Toán 1', N'0384564563', 0, 1)
INSERT [dbo].[User] ([UserId], [Username], [Password], [Fullname], [Birthday], [Gender], [School], [Class], [PhoneNumber], [IsCounselor], [State]) VALUES (26, N'aab@a.a', N'5F31AF3EA453A5BC7F71C193B3A48390728A45A4ABEEF30060421DD924121F73', N'Hoàng Thị Lan', CAST(N'2004-01-01' AS Date), 2, N'Trường THCS & THPT Tạ Quang Bửu', N'Chuyên Tiếng Anh', N'0317346345', 0, 0)
INSERT [dbo].[User] ([UserId], [Username], [Password], [Fullname], [Birthday], [Gender], [School], [Class], [PhoneNumber], [IsCounselor], [State]) VALUES (28, N'aac@a.a', N'612C76F8F316562F0C323A2E86AB398EE7B5A9348B6420DFB70F2D9F2C9265E4', N'Văn Mai Hương', CAST(N'2004-01-01' AS Date), 2, N'Trường THPT Hoàng Diệu', N'10B2', N'0325245457', 1, 1)
INSERT [dbo].[User] ([UserId], [Username], [Password], [Fullname], [Birthday], [Gender], [School], [Class], [PhoneNumber], [IsCounselor], [State]) VALUES (29, N'aad@a.a', N'DCF0AF5D9104BF757518213535B253D44C551AEE40850DF20C77FA406B8511AF', N'Đỗ Thị Nga', CAST(N'2004-01-01' AS Date), 2, N'Trường THPT Kim Liên', N'11A6', N'0361675856', 0, 0)
INSERT [dbo].[User] ([UserId], [Username], [Password], [Fullname], [Birthday], [Gender], [School], [Class], [PhoneNumber], [IsCounselor], [State]) VALUES (30, N'aae@a.a', N'27F71E2D9D2FF1B62FA063BEA3CE4D1761E6A7754B96643C52E8E0D8F1679DF1', N'Phạm Văn Quyền', CAST(N'2004-01-01' AS Date), 1, N'Trường THPT Phùng Khắc Khoan', N'12B3', N'0325678678', 1, 1)
INSERT [dbo].[User] ([UserId], [Username], [Password], [Fullname], [Birthday], [Gender], [School], [Class], [PhoneNumber], [IsCounselor], [State]) VALUES (31, N'aaf@a.a', N'6FEADE8B3F26D5C0BFD5B6A533EAF860B9177C6CF91A0518138A6544DDC874ED', N'Trần Anh Tuấn', CAST(N'2004-01-01' AS Date), 1, N'Trường THPT Hồng Hà', N'12D', N'0323856457', 0, 0)
INSERT [dbo].[User] ([UserId], [Username], [Password], [Fullname], [Birthday], [Gender], [School], [Class], [PhoneNumber], [IsCounselor], [State]) VALUES (32, N'aag@a.a', N'D447ACD0E6D3CCAC55C2168D7122A59B1547A1BF8AD6CD914ACF99E042A2ECC2', N'Nguyễn Văn Việt', CAST(N'2004-01-01' AS Date), 1, N'Trường THPT Việt Đức', N'12A7', N'0378679789', 1, 1)
INSERT [dbo].[User] ([UserId], [Username], [Password], [Fullname], [Birthday], [Gender], [School], [Class], [PhoneNumber], [IsCounselor], [State]) VALUES (36, N'asuca@a.a', N'DF76D70FEF5B355DD78208A14B8D5EDD598C1444739ACA76833E89B39CB74587', N'Trần Thị Nguyệt', CAST(N'2004-01-01' AS Date), 2, N'Trường THPT Đông Kinh', N'Chuyên Hoá Học', N'0328564563', 0, 0)
SET IDENTITY_INSERT [dbo].[User] OFF
/****** Object:  Index [UQ__Timeshee__180A46B736FC3EAE]    Script Date: 5/19/2019 3:48:04 PM ******/
ALTER TABLE [dbo].[Timesheet] ADD  CONSTRAINT [UQ__Timeshee__180A46B736FC3EAE] UNIQUE NONCLUSTERED 
(
	[StartTime] ASC,
	[EndTime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__User__536C85E49EFCAC75]    Script Date: 5/19/2019 3:48:04 PM ******/
ALTER TABLE [dbo].[User] ADD  CONSTRAINT [UQ__User__536C85E49EFCAC75] UNIQUE NONCLUSTERED 
(
	[Username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__User__536C85E4C0BBCE70]    Script Date: 5/19/2019 3:48:04 PM ******/
ALTER TABLE [dbo].[User] ADD  CONSTRAINT [UQ__User__536C85E4C0BBCE70] UNIQUE NONCLUSTERED 
(
	[Username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__User__536C85E4DFF3CD52]    Script Date: 5/19/2019 3:48:04 PM ******/
ALTER TABLE [dbo].[User] ADD  CONSTRAINT [UQ__User__536C85E4DFF3CD52] UNIQUE NONCLUSTERED 
(
	[Username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Building] ADD  CONSTRAINT [DF_Building_Name]  DEFAULT (N'D3') FOR [Name]
GO
ALTER TABLE [dbo].[Building] ADD  CONSTRAINT [DF_Building_Location]  DEFAULT ('POINT(21.004797 105.845266)') FOR [Location]
GO
ALTER TABLE [dbo].[Classroom] ADD  CONSTRAINT [DF_Classroom_Floor]  DEFAULT ((1)) FOR [Floor]
GO
ALTER TABLE [dbo].[Classroom] ADD  CONSTRAINT [DF_Classroom_Name]  DEFAULT ((101)) FOR [Name]
GO
ALTER TABLE [dbo].[Manager] ADD  CONSTRAINT [DF_Manager_Name]  DEFAULT (N'Trần Minh Thành') FOR [Name]
GO
ALTER TABLE [dbo].[Manager] ADD  CONSTRAINT [DF_Manager_Gender]  DEFAULT ((1)) FOR [Gender]
GO
ALTER TABLE [dbo].[Manager] ADD  CONSTRAINT [DF_Manager_Birthday]  DEFAULT ('1990-04-21') FOR [Birthday]
GO
ALTER TABLE [dbo].[Message] ADD  CONSTRAINT [DF_Message_mContent]  DEFAULT (N'Hello') FOR [mContent]
GO
ALTER TABLE [dbo].[Message] ADD  CONSTRAINT [DF_Message_Time]  DEFAULT ('2019-06-01 12:00:00') FOR [Time]
GO
ALTER TABLE [dbo].[Tour] ADD  CONSTRAINT [DF_Tour_Name]  DEFAULT (N'Tham quan trường Đại học Bách Khoa') FOR [Name]
GO
ALTER TABLE [dbo].[Tour] ADD  CONSTRAINT [DF_Tour_State]  DEFAULT ((0)) FOR [State]
GO
ALTER TABLE [dbo].[Tour] ADD  CONSTRAINT [DF_Tour_Date]  DEFAULT ('2019-06-01') FOR [Date]
GO
ALTER TABLE [dbo].[Tour2Member] ADD  CONSTRAINT [DF_Tour2Member_mFunction]  DEFAULT ((0)) FOR [mFunction]
GO
ALTER TABLE [dbo].[User] ADD  CONSTRAINT [DF_User_Fullname]  DEFAULT (N'Lê Mạnh Hùng') FOR [Fullname]
GO
ALTER TABLE [dbo].[User] ADD  CONSTRAINT [DF_User_Birthday]  DEFAULT ('2002-06-14') FOR [Birthday]
GO
ALTER TABLE [dbo].[User] ADD  CONSTRAINT [DF_User_Gender]  DEFAULT ((1)) FOR [Gender]
GO
ALTER TABLE [dbo].[User] ADD  CONSTRAINT [DF_User_IsCounselor]  DEFAULT ((0)) FOR [IsCounselor]
GO
ALTER TABLE [dbo].[User] ADD  CONSTRAINT [DF_User_State]  DEFAULT ((0)) FOR [State]
GO
ALTER TABLE [dbo].[Building2Classroom]  WITH CHECK ADD  CONSTRAINT [FK__Building2__Class__5F7E2DAC] FOREIGN KEY([ClassroomId])
REFERENCES [dbo].[Classroom] ([ClassroomId])
GO
ALTER TABLE [dbo].[Building2Classroom] CHECK CONSTRAINT [FK__Building2__Class__5F7E2DAC]
GO
ALTER TABLE [dbo].[Building2Classroom]  WITH CHECK ADD  CONSTRAINT [FK_Building2Classroom] FOREIGN KEY([BuildingId])
REFERENCES [dbo].[Building] ([BuildingId])
GO
ALTER TABLE [dbo].[Building2Classroom] CHECK CONSTRAINT [FK_Building2Classroom]
GO
ALTER TABLE [dbo].[Message]  WITH CHECK ADD  CONSTRAINT [FK_Message_User_Reciever] FOREIGN KEY([RecieverId])
REFERENCES [dbo].[User] ([UserId])
GO
ALTER TABLE [dbo].[Message] CHECK CONSTRAINT [FK_Message_User_Reciever]
GO
ALTER TABLE [dbo].[Message]  WITH CHECK ADD  CONSTRAINT [FK_Message_User_Sender] FOREIGN KEY([SenderId])
REFERENCES [dbo].[User] ([UserId])
GO
ALTER TABLE [dbo].[Message] CHECK CONSTRAINT [FK_Message_User_Sender]
GO
ALTER TABLE [dbo].[Timesheet2Classroom]  WITH CHECK ADD  CONSTRAINT [FK__Timesheet__Class__634EBE90] FOREIGN KEY([ClassroomId])
REFERENCES [dbo].[Classroom] ([ClassroomId])
GO
ALTER TABLE [dbo].[Timesheet2Classroom] CHECK CONSTRAINT [FK__Timesheet__Class__634EBE90]
GO
ALTER TABLE [dbo].[Timesheet2Classroom]  WITH CHECK ADD FOREIGN KEY([ManagerId])
REFERENCES [dbo].[Manager] ([ManagerId])
GO
ALTER TABLE [dbo].[Timesheet2Classroom]  WITH CHECK ADD  CONSTRAINT [FK_Timesheet2Classroom] FOREIGN KEY([TimesheetId])
REFERENCES [dbo].[Timesheet] ([TimesheetId])
GO
ALTER TABLE [dbo].[Timesheet2Classroom] CHECK CONSTRAINT [FK_Timesheet2Classroom]
GO
ALTER TABLE [dbo].[Tour2Member]  WITH CHECK ADD  CONSTRAINT [FK__Tour2Memb__TourI__5CA1C101] FOREIGN KEY([TourId])
REFERENCES [dbo].[Tour] ([TourId])
GO
ALTER TABLE [dbo].[Tour2Member] CHECK CONSTRAINT [FK__Tour2Memb__TourI__5CA1C101]
GO
ALTER TABLE [dbo].[Tour2Member]  WITH CHECK ADD  CONSTRAINT [FK__Tour2Memb__UserI__5BAD9CC8] FOREIGN KEY([UserId])
REFERENCES [dbo].[User] ([UserId])
GO
ALTER TABLE [dbo].[Tour2Member] CHECK CONSTRAINT [FK__Tour2Memb__UserI__5BAD9CC8]
GO
ALTER TABLE [dbo].[Tour2Timesheet]  WITH CHECK ADD  CONSTRAINT [FK__Tour2Time__Times__662B2B3B] FOREIGN KEY([TimesheetId])
REFERENCES [dbo].[Timesheet] ([TimesheetId])
GO
ALTER TABLE [dbo].[Tour2Timesheet] CHECK CONSTRAINT [FK__Tour2Time__Times__662B2B3B]
GO
ALTER TABLE [dbo].[Tour2Timesheet]  WITH CHECK ADD  CONSTRAINT [FK_Tour2Timesheet] FOREIGN KEY([TourId])
REFERENCES [dbo].[Tour] ([TourId])
GO
ALTER TABLE [dbo].[Tour2Timesheet] CHECK CONSTRAINT [FK_Tour2Timesheet]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ID toà nhà, bắt buộc.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Building', @level2type=N'COLUMN',@level2name=N'BuildingId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Tên toà nhà, bắt buộc.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Building', @level2type=N'COLUMN',@level2name=N'Name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Toạ độ toà nhà trên Google Maps, bắt buộc.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Building', @level2type=N'COLUMN',@level2name=N'Location'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ID toà nhà, bắt buộc.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Building2Classroom', @level2type=N'COLUMN',@level2name=N'BuildingId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ID phòng học, bắt buộc.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Building2Classroom', @level2type=N'COLUMN',@level2name=N'ClassroomId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ID phòng học, bắt buộc.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Classroom', @level2type=N'COLUMN',@level2name=N'ClassroomId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Tầng của phòng học, bắt buộc.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Classroom', @level2type=N'COLUMN',@level2name=N'Floor'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Tên phòng học, bắt buộc.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Classroom', @level2type=N'COLUMN',@level2name=N'Name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ID người quản lý phòng học trong khung giờ, bắt buộc.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Manager', @level2type=N'COLUMN',@level2name=N'ManagerId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Tên người quản lý, bắt buộc.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Manager', @level2type=N'COLUMN',@level2name=N'Name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Giới tính(0 là không tiết lộ, 1 là nam, 2 là nữ, 3 giới tính thứ 3), bắt buộc.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Manager', @level2type=N'COLUMN',@level2name=N'Gender'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Ngày sinh, bắt buộc.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Manager', @level2type=N'COLUMN',@level2name=N'Birthday'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Email của người quản lý, bắt buộc.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Manager', @level2type=N'COLUMN',@level2name=N'Email'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Sđt của người quản lý, bắt buộc.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Manager', @level2type=N'COLUMN',@level2name=N'PhoneNumber'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Id người nhắn, bắt buộc.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Message', @level2type=N'COLUMN',@level2name=N'SenderId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Id người nhận, bắt buộc.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Message', @level2type=N'COLUMN',@level2name=N'RecieverId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ID thành viên đọc được tin nhắn, bắt buộc. ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Message', @level2type=N'COLUMN',@level2name=N'MessageId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Nội dung tin nhắn, bắt buộc.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Message', @level2type=N'COLUMN',@level2name=N'mContent'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Thời điểm nhắn tin, bắt buộc.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Message', @level2type=N'COLUMN',@level2name=N'Time'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ID tin tức, tăng dần và bắt buộc.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'News', @level2type=N'COLUMN',@level2name=N'NewsId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Đường dẫn ảnh minh hoạ tin tức' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'News', @level2type=N'COLUMN',@level2name=N'ImageUrl'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Tiêu đề tin tức, bắt buộc.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'News', @level2type=N'COLUMN',@level2name=N'Title'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Đường dẫn đến trang tin tức, bắt buộc.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'News', @level2type=N'COLUMN',@level2name=N'Url'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Tóm tắt nội dung tin tức.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'News', @level2type=N'COLUMN',@level2name=N'Summary'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Đánh dấu có hiển thị không (0 là không hiển thị, 1 là hiển thị), bắt buộc.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'News', @level2type=N'COLUMN',@level2name=N'IsShowing'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Đường dẫn form đăng ký thông tin người dùng để tạo tài khoản.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Setting', @level2type=N'COLUMN',@level2name=N'FormUrl'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ID của chặng, bắt buộc.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Timesheet', @level2type=N'COLUMN',@level2name=N'TimesheetId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ID Giờ bắt đầu chặng, bắt buộc.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Timesheet', @level2type=N'COLUMN',@level2name=N'StartTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ID Giờ kết thúc chặng, bắt buộc. StartTimeId kết hợp với EndTimeId là duy nhất' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Timesheet', @level2type=N'COLUMN',@level2name=N'EndTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ID của tour, bắt buộc.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Tour', @level2type=N'COLUMN',@level2name=N'TourId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Tên của tour, bắt buộc.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Tour', @level2type=N'COLUMN',@level2name=N'Name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Trạng thái hiển thị của tour (0 là ẩn, 1 hiển thị).' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Tour', @level2type=N'COLUMN',@level2name=N'State'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Đường dẫn ảnh minh hoạ tour.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Tour', @level2type=N'COLUMN',@level2name=N'ImageUrl'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Ngày hoạt động của tour, bắt buộc. Mặc định là 01/06/2019.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Tour', @level2type=N'COLUMN',@level2name=N'Date'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Đường dẫn ảnh bản đồ tour.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Tour', @level2type=N'COLUMN',@level2name=N'MapImageUrl'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ID của tour, khoá ngoại và bắt buộc.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Tour2Member', @level2type=N'COLUMN',@level2name=N'TourId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ID người dùng, khoá ngoại và bắt buộc.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Tour2Member', @level2type=N'COLUMN',@level2name=N'UserId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Vai trò trong tour (1 là trưởng nhóm, 2 là phó nhóm, 3 là phụ huynh, 0 là thành viên bình thường), bắt buộc. Mặc định là 0.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Tour2Member', @level2type=N'COLUMN',@level2name=N'mFunction'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Toạ độ trên Google Maps.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Tour2Member', @level2type=N'COLUMN',@level2name=N'mLocation'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Ghi chú.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Tour2Member', @level2type=N'COLUMN',@level2name=N'Note'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ID của tour, bắt buộc.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Tour2Timesheet', @level2type=N'COLUMN',@level2name=N'TourId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ID của chặng, bắt buộc.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Tour2Timesheet', @level2type=N'COLUMN',@level2name=N'TimesheetId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'bang quan he' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Tour2Timesheet'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ID người dùng, bắt buộc.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'User', @level2type=N'COLUMN',@level2name=N'UserId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Tên đăng nhập, duy nhất và bắt buộc.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'User', @level2type=N'COLUMN',@level2name=N'Username'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Mật khẩu đăng nhập mã hoá SHA256, bắt buộc.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'User', @level2type=N'COLUMN',@level2name=N'Password'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Họ tên đầy đủ, bắt buộc.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'User', @level2type=N'COLUMN',@level2name=N'Fullname'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Ngày sinh, bắt buộc.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'User', @level2type=N'COLUMN',@level2name=N'Birthday'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Giới tính (0 là không tiết lộ, 1 là nam, 2 là nữ, 3 giới tính thứ 3), bắt buộc.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'User', @level2type=N'COLUMN',@level2name=N'Gender'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Tên trường người dùng đang theo học' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'User', @level2type=N'COLUMN',@level2name=N'School'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Tên lớp người dùng đang theo học' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'User', @level2type=N'COLUMN',@level2name=N'Class'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Sđt của người người dùng.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'User', @level2type=N'COLUMN',@level2name=N'PhoneNumber'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Đánh dấu có phải là tư vấn viên không (0 là không phải, 1 là tư vấn viên, mặc định là 0).' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'User', @level2type=N'COLUMN',@level2name=N'IsCounselor'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Trạng thái (0 là offline, 1 là online, 2 là busy, 3 là hidden), bắt buộc. Mặc định là 0.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'User', @level2type=N'COLUMN',@level2name=N'State'
GO
USE [master]
GO
ALTER DATABASE [BKOD] SET  READ_WRITE 
GO
