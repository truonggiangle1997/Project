USE [master]
GO
/****** Object:  Database [dbManga]    Script Date: 5/12/2019 6:37:03 PM ******/
CREATE DATABASE [dbManga]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'dbManga', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\dbManga.mdf' , SIZE = 4096KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'dbManga_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\dbManga_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [dbManga] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [dbManga].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [dbManga] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [dbManga] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [dbManga] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [dbManga] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [dbManga] SET ARITHABORT OFF 
GO
ALTER DATABASE [dbManga] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [dbManga] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [dbManga] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [dbManga] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [dbManga] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [dbManga] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [dbManga] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [dbManga] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [dbManga] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [dbManga] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [dbManga] SET  DISABLE_BROKER 
GO
ALTER DATABASE [dbManga] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [dbManga] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [dbManga] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [dbManga] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [dbManga] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [dbManga] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [dbManga] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [dbManga] SET RECOVERY FULL 
GO
ALTER DATABASE [dbManga] SET  MULTI_USER 
GO
ALTER DATABASE [dbManga] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [dbManga] SET DB_CHAINING OFF 
GO
ALTER DATABASE [dbManga] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [dbManga] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
EXEC sys.sp_db_vardecimal_storage_format N'dbManga', N'ON'
GO
USE [dbManga]
GO
/****** Object:  Table [dbo].[Authors]    Script Date: 5/12/2019 6:37:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Authors](
	[authorId] [nvarchar](20) NOT NULL,
	[authorName] [nvarchar](50) NOT NULL,
	[facebook] [nvarchar](300) NULL,
	[twitter] [nvarchar](300) NULL,
 CONSTRAINT [PK_TacGia] PRIMARY KEY CLUSTERED 
(
	[authorId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Chapters]    Script Date: 5/12/2019 6:37:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Chapters](
	[chapterId] [int] IDENTITY(1,1) NOT NULL,
	[mangaId] [nvarchar](20) NULL,
	[chapterNumber] [int] NULL,
	[chapterName] [nvarchar](50) NULL,
 CONSTRAINT [PK_Chapters] PRIMARY KEY CLUSTERED 
(
	[chapterId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Genres]    Script Date: 5/12/2019 6:37:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Genres](
	[genreId] [nvarchar](20) NOT NULL,
	[genreName] [nvarchar](20) NOT NULL,
 CONSTRAINT [PK_TheLoai] PRIMARY KEY CLUSTERED 
(
	[genreId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Mangas]    Script Date: 5/12/2019 6:37:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Mangas](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[mangaId] [nvarchar](20) NOT NULL,
	[mangaName] [nvarchar](100) NOT NULL,
	[authorId] [nvarchar](20) NULL,
	[statusId] [int] NOT NULL,
	[describe] [nvarchar](2000) NULL,
	[cover] [nvarchar](200) NULL,
 CONSTRAINT [PK_Truyen] PRIMARY KEY CLUSTERED 
(
	[mangaId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Mangas_Genres]    Script Date: 5/12/2019 6:37:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Mangas_Genres](
	[mangaId] [nvarchar](20) NOT NULL,
	[genreId] [nvarchar](20) NOT NULL,
 CONSTRAINT [PK_Truyen_TheLoai] PRIMARY KEY CLUSTERED 
(
	[mangaId] ASC,
	[genreId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Mangas_Users]    Script Date: 5/12/2019 6:37:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Mangas_Users](
	[userId] [nvarchar](20) NOT NULL,
	[mangaId] [nvarchar](20) NOT NULL,
 CONSTRAINT [PK_Mangas_Users] PRIMARY KEY CLUSTERED 
(
	[userId] ASC,
	[mangaId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Pages]    Script Date: 5/12/2019 6:37:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Pages](
	[pageId] [int] IDENTITY(1,1) NOT NULL,
	[chapterId] [int] NULL,
	[pageNumber] [int] NULL,
	[link1] [nvarchar](2000) NULL,
	[link2] [nvarchar](2000) NULL,
 CONSTRAINT [PK_Pages] PRIMARY KEY CLUSTERED 
(
	[pageId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Roles]    Script Date: 5/12/2019 6:37:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Roles](
	[roleId] [int] NOT NULL,
	[roleName] [nvarchar](50) NULL,
 CONSTRAINT [PK_Roles] PRIMARY KEY CLUSTERED 
(
	[roleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Status]    Script Date: 5/12/2019 6:37:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Status](
	[statusId] [int] NOT NULL,
	[statusName] [nvarchar](20) NOT NULL,
 CONSTRAINT [PK_TinhTrang] PRIMARY KEY CLUSTERED 
(
	[statusId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Users]    Script Date: 5/12/2019 6:37:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Users](
	[userId] [nvarchar](20) NOT NULL,
	[password] [varbinary](max) NULL,
	[name] [nvarchar](50) NULL,
	[roleId] [int] NULL,
	[condition] [nvarchar](50) NULL,
 CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED 
(
	[userId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
INSERT [dbo].[Authors] ([authorId], [authorName], [facebook], [twitter]) VALUES (N'001', N'WATARI Masahito', NULL, NULL)
INSERT [dbo].[Authors] ([authorId], [authorName], [facebook], [twitter]) VALUES (N'002', N'Adachi Mitsuru', NULL, NULL)
INSERT [dbo].[Authors] ([authorId], [authorName], [facebook], [twitter]) VALUES (N'003', N'Clamp', NULL, NULL)
INSERT [dbo].[Authors] ([authorId], [authorName], [facebook], [twitter]) VALUES (N'004', N'x', N'x', N'x')
INSERT [dbo].[Authors] ([authorId], [authorName], [facebook], [twitter]) VALUES (N'005', N'GOTOUGE Koyoharu', NULL, NULL)
INSERT [dbo].[Authors] ([authorId], [authorName], [facebook], [twitter]) VALUES (N'006', N'Watsuki Nobuhiro', NULL, NULL)
INSERT [dbo].[Authors] ([authorId], [authorName], [facebook], [twitter]) VALUES (N'007', N'Gosho Aoyama', NULL, NULL)
SET IDENTITY_INSERT [dbo].[Chapters] ON 

INSERT [dbo].[Chapters] ([chapterId], [mangaId], [chapterNumber], [chapterName]) VALUES (1, N'001', 1, NULL)
INSERT [dbo].[Chapters] ([chapterId], [mangaId], [chapterNumber], [chapterName]) VALUES (2, N'001', 2, NULL)
INSERT [dbo].[Chapters] ([chapterId], [mangaId], [chapterNumber], [chapterName]) VALUES (3, N'001', 3, NULL)
INSERT [dbo].[Chapters] ([chapterId], [mangaId], [chapterNumber], [chapterName]) VALUES (4, N'002', 1, NULL)
INSERT [dbo].[Chapters] ([chapterId], [mangaId], [chapterNumber], [chapterName]) VALUES (5, N'002', 2, NULL)
INSERT [dbo].[Chapters] ([chapterId], [mangaId], [chapterNumber], [chapterName]) VALUES (6, N'002', 3, NULL)
INSERT [dbo].[Chapters] ([chapterId], [mangaId], [chapterNumber], [chapterName]) VALUES (7, N'003', 1, NULL)
INSERT [dbo].[Chapters] ([chapterId], [mangaId], [chapterNumber], [chapterName]) VALUES (8, N'003', 2, NULL)
INSERT [dbo].[Chapters] ([chapterId], [mangaId], [chapterNumber], [chapterName]) VALUES (9, N'003', 3, NULL)
INSERT [dbo].[Chapters] ([chapterId], [mangaId], [chapterNumber], [chapterName]) VALUES (10, N'004', 1, NULL)
INSERT [dbo].[Chapters] ([chapterId], [mangaId], [chapterNumber], [chapterName]) VALUES (11, N'004', 2, NULL)
INSERT [dbo].[Chapters] ([chapterId], [mangaId], [chapterNumber], [chapterName]) VALUES (12, N'004', 3, NULL)
INSERT [dbo].[Chapters] ([chapterId], [mangaId], [chapterNumber], [chapterName]) VALUES (13, N'005', 1, NULL)
INSERT [dbo].[Chapters] ([chapterId], [mangaId], [chapterNumber], [chapterName]) VALUES (14, N'005', 2, NULL)
INSERT [dbo].[Chapters] ([chapterId], [mangaId], [chapterNumber], [chapterName]) VALUES (15, N'005', 3, NULL)
INSERT [dbo].[Chapters] ([chapterId], [mangaId], [chapterNumber], [chapterName]) VALUES (16, N'006', 1, NULL)
INSERT [dbo].[Chapters] ([chapterId], [mangaId], [chapterNumber], [chapterName]) VALUES (17, N'006', 2, NULL)
INSERT [dbo].[Chapters] ([chapterId], [mangaId], [chapterNumber], [chapterName]) VALUES (18, N'006', 3, NULL)
INSERT [dbo].[Chapters] ([chapterId], [mangaId], [chapterNumber], [chapterName]) VALUES (19, N'007', 1, NULL)
INSERT [dbo].[Chapters] ([chapterId], [mangaId], [chapterNumber], [chapterName]) VALUES (20, N'007', 2, NULL)
INSERT [dbo].[Chapters] ([chapterId], [mangaId], [chapterNumber], [chapterName]) VALUES (21, N'007', 3, NULL)
INSERT [dbo].[Chapters] ([chapterId], [mangaId], [chapterNumber], [chapterName]) VALUES (22, N'008', 1, NULL)
INSERT [dbo].[Chapters] ([chapterId], [mangaId], [chapterNumber], [chapterName]) VALUES (23, N'008', 2, NULL)
INSERT [dbo].[Chapters] ([chapterId], [mangaId], [chapterNumber], [chapterName]) VALUES (24, N'008', 3, NULL)
INSERT [dbo].[Chapters] ([chapterId], [mangaId], [chapterNumber], [chapterName]) VALUES (25, N'008', 1, NULL)
INSERT [dbo].[Chapters] ([chapterId], [mangaId], [chapterNumber], [chapterName]) VALUES (26, N'009', 1, NULL)
INSERT [dbo].[Chapters] ([chapterId], [mangaId], [chapterNumber], [chapterName]) VALUES (27, N'009', 2, NULL)
INSERT [dbo].[Chapters] ([chapterId], [mangaId], [chapterNumber], [chapterName]) VALUES (28, N'009', 3, NULL)
INSERT [dbo].[Chapters] ([chapterId], [mangaId], [chapterNumber], [chapterName]) VALUES (29, N'010', 1, NULL)
INSERT [dbo].[Chapters] ([chapterId], [mangaId], [chapterNumber], [chapterName]) VALUES (30, N'010', 2, NULL)
INSERT [dbo].[Chapters] ([chapterId], [mangaId], [chapterNumber], [chapterName]) VALUES (31, N'010', 3, NULL)
INSERT [dbo].[Chapters] ([chapterId], [mangaId], [chapterNumber], [chapterName]) VALUES (32, N'011', 1, NULL)
INSERT [dbo].[Chapters] ([chapterId], [mangaId], [chapterNumber], [chapterName]) VALUES (33, N'011', 2, NULL)
INSERT [dbo].[Chapters] ([chapterId], [mangaId], [chapterNumber], [chapterName]) VALUES (35, N'011', 3, NULL)
INSERT [dbo].[Chapters] ([chapterId], [mangaId], [chapterNumber], [chapterName]) VALUES (36, N'012', 1, NULL)
INSERT [dbo].[Chapters] ([chapterId], [mangaId], [chapterNumber], [chapterName]) VALUES (37, N'012', 2, NULL)
INSERT [dbo].[Chapters] ([chapterId], [mangaId], [chapterNumber], [chapterName]) VALUES (38, N'012', 3, NULL)
INSERT [dbo].[Chapters] ([chapterId], [mangaId], [chapterNumber], [chapterName]) VALUES (39, N'013', 1, NULL)
INSERT [dbo].[Chapters] ([chapterId], [mangaId], [chapterNumber], [chapterName]) VALUES (40, N'013', 2, NULL)
INSERT [dbo].[Chapters] ([chapterId], [mangaId], [chapterNumber], [chapterName]) VALUES (41, N'013', 3, NULL)
INSERT [dbo].[Chapters] ([chapterId], [mangaId], [chapterNumber], [chapterName]) VALUES (43, N'012', 4, N'next')
INSERT [dbo].[Chapters] ([chapterId], [mangaId], [chapterNumber], [chapterName]) VALUES (44, N'012', 5, N'next')
SET IDENTITY_INSERT [dbo].[Chapters] OFF
INSERT [dbo].[Genres] ([genreId], [genreName]) VALUES (N'001', N'Action')
INSERT [dbo].[Genres] ([genreId], [genreName]) VALUES (N'002', N'Adventure')
INSERT [dbo].[Genres] ([genreId], [genreName]) VALUES (N'003', N'Comedy')
INSERT [dbo].[Genres] ([genreId], [genreName]) VALUES (N'004', N'Detective')
INSERT [dbo].[Genres] ([genreId], [genreName]) VALUES (N'005', N'Drama')
INSERT [dbo].[Genres] ([genreId], [genreName]) VALUES (N'006', N'Fantasy')
INSERT [dbo].[Genres] ([genreId], [genreName]) VALUES (N'007', N'Historical')
INSERT [dbo].[Genres] ([genreId], [genreName]) VALUES (N'008', N'Isekai')
INSERT [dbo].[Genres] ([genreId], [genreName]) VALUES (N'009', N'Romance')
INSERT [dbo].[Genres] ([genreId], [genreName]) VALUES (N'010', N'Shounen')
SET IDENTITY_INSERT [dbo].[Mangas] ON 

INSERT [dbo].[Mangas] ([id], [mangaId], [mangaName], [authorId], [statusId], [describe], [cover]) VALUES (3, N'001', N'Chobits', N'003', 3, N'Trong 1 tương lai gần, những computer với hình dáng con người được sáng tạo ra với rất nhiều chức năng hữu ích. Với 1 persocom, bạn có thể chơi game, kết nối Internet, bảo quản tài khoản cá nhân', N'https://i.imgur.com/7WEMxk5.jpg')
INSERT [dbo].[Mangas] ([id], [mangaId], [mangaName], [authorId], [statusId], [describe], [cover]) VALUES (4, N'002', N'Clover', N'003', 3, N'Câu chuyện nói về số phận của những đứa trẻ có phép thuật. Các "ma đạo sư" thuộc Hội Đồng tối cao (còn gọi đơn giản là ngài "pháp sư" đó) là những người điều khiển thế giới ngầm', N'https://i.imgur.com/6M33gVe.jpg')
INSERT [dbo].[Mangas] ([id], [mangaId], [mangaName], [authorId], [statusId], [describe], [cover]) VALUES (5, N'003', N'Kobato', N'003', 3, N'Câu chuyện về 1 cô gái tên Hanato Kobato, vừa mới dọn tới 1 chung cư ở Tokyo (chung cư này được quản lí bởi Chitose Hibiya, bây giờ là Chitose Mihara, nơi mà Hideki và Chii từng ở trong Chobits)', N'https://i.imgur.com/lLlqToe.jpg')
INSERT [dbo].[Mangas] ([id], [mangaId], [mangaName], [authorId], [statusId], [describe], [cover]) VALUES (6, N'004', N'xxxHolic', N'003', 2, N'xxxHOLiC giống như một tuyển tập các “chuyện thường ngày” của Watanuki Kimihiro, một nam sinh trung học có ngoại hình bình thường, tính cách không có gì nổi bật (các bạn đã thấy nhàm chưa ^^?)', N'https://i.imgur.com/98niPfo.jpg')
INSERT [dbo].[Mangas] ([id], [mangaId], [mangaName], [authorId], [statusId], [describe], [cover]) VALUES (7, N'005', N'Katsu!', N'002', 1, N'Ờ thì trong một thành phố nào đó ở Nhật, có một chàng trai tình cờ gặp được một cô gái xinh đẹp', N'https://i.imgur.com/Gi1MV07.jpg')
INSERT [dbo].[Mangas] ([id], [mangaId], [mangaName], [authorId], [statusId], [describe], [cover]) VALUES (8, N'006', N'Miyuki', N'002', 3, N'Wakamatsu Masato sống chung nhà với người em gái cùng cha khác mẹ của mình là Miyuki, dù cả hai thật ra không hề có quan hệ ruột thịt máu mủ.', N'https://i.imgur.com/3KdcoXB.jpg')
INSERT [dbo].[Mangas] ([id], [mangaId], [mangaName], [authorId], [statusId], [describe], [cover]) VALUES (9, N'007', N'Rough', N'002', 1, N'Một tác phẩm nổi tiếng của Adachi sensei. Một câu chuyện gần giống như Romeo và Juliet thời hiện đại... Một câu chuyện tình cảm nhẹ nhàng của tuổi mới lớn', N'https://i.imgur.com/Un9Rw45.jpg')
INSERT [dbo].[Mangas] ([id], [mangaId], [mangaName], [authorId], [statusId], [describe], [cover]) VALUES (10, N'008', N'Touch', N'002', 3, N'Touch kể về câu chuyện của ba người: Kazuya và Tatsuya Uesugi (hai anh em sinh đôi) và Minami Asakura. Họ sống bên cạnh nhau từ khi còn nhỏ và cha mẹ họ đã xây một căn nhà trong sân giữa hai nhà làm nơi cho tụi nhóc chơi đùa', N'https://i.imgur.com/QMsLEt0.jpg')
INSERT [dbo].[Mangas] ([id], [mangaId], [mangaName], [authorId], [statusId], [describe], [cover]) VALUES (12, N'009', N'Konosuba', N'001', 1, N'cuộc hành trình của kazuma và đồng bọn', N'https://i.imgur.com/osW5aCA.jpg')
INSERT [dbo].[Mangas] ([id], [mangaId], [mangaName], [authorId], [statusId], [describe], [cover]) VALUES (13, N'010', N'Shurabara!', N'001', 2, N'Yagimoto Kazuhiro cũng như bao cậu con trai mới lớn khác, cậu luôn muốn tìm cho mình được một cô người yêu. Vì thế, cậu đối tốt với mọi cô gái và làm bất cứ điều gì họ nhờ vả', N'https://i.imgur.com/P60btzf.jpg')
INSERT [dbo].[Mangas] ([id], [mangaId], [mangaName], [authorId], [statusId], [describe], [cover]) VALUES (44, N'011', N'Kimetsu no Yaiba', N'005', 1, N'Một lần, sau khi bán than, Tanjirou ngủ nhờ nhà của một người trong làng bởi người đó kể cho cậu những câu chuyện về quỷ thường xuất hiện vào buổi đêm ở trên núi', N'https://i.imgur.com/gwAf79d.jpg')
INSERT [dbo].[Mangas] ([id], [mangaId], [mangaName], [authorId], [statusId], [describe], [cover]) VALUES (47, N'012', N'Rurouni Kenshin', N'006', 3, N'Himura Kenshin là một Hitokiri (sát thủ) huyền thoại cuối đời Bakumatsu (thời nhà Mạc), được mệnh danh là Hitokiri Battousai, với môn phái "Hitten Mitsuru Ryu" (hay còn gọi là : Phi Thiên Ngự Kiếm)', N'https://i.imgur.com/pBL1gf3.jpg')
INSERT [dbo].[Mangas] ([id], [mangaId], [mangaName], [authorId], [statusId], [describe], [cover]) VALUES (49, N'013', N'Thám tử lừng danh Conan', N'007', 1, N'Một bộ truyện gối đầu giường và gắn bó với biết bao thế hệ', N'https://i.imgur.com/usl3G1w.jpg')
INSERT [dbo].[Mangas] ([id], [mangaId], [mangaName], [authorId], [statusId], [describe], [cover]) VALUES (51, N'020', N'Gintama', N'002', 3, N'truyen bua', N'abc')
INSERT [dbo].[Mangas] ([id], [mangaId], [mangaName], [authorId], [statusId], [describe], [cover]) VALUES (53, N'030', N'123456', N'001', 1, N'demo', N'null')
SET IDENTITY_INSERT [dbo].[Mangas] OFF
INSERT [dbo].[Mangas_Genres] ([mangaId], [genreId]) VALUES (N'001', N'003')
INSERT [dbo].[Mangas_Genres] ([mangaId], [genreId]) VALUES (N'001', N'005')
INSERT [dbo].[Mangas_Genres] ([mangaId], [genreId]) VALUES (N'001', N'009')
INSERT [dbo].[Mangas_Genres] ([mangaId], [genreId]) VALUES (N'002', N'001')
INSERT [dbo].[Mangas_Genres] ([mangaId], [genreId]) VALUES (N'002', N'006')
INSERT [dbo].[Mangas_Genres] ([mangaId], [genreId]) VALUES (N'002', N'010')
INSERT [dbo].[Mangas_Genres] ([mangaId], [genreId]) VALUES (N'003', N'003')
INSERT [dbo].[Mangas_Genres] ([mangaId], [genreId]) VALUES (N'003', N'009')
INSERT [dbo].[Mangas_Genres] ([mangaId], [genreId]) VALUES (N'004', N'003')
INSERT [dbo].[Mangas_Genres] ([mangaId], [genreId]) VALUES (N'004', N'005')
INSERT [dbo].[Mangas_Genres] ([mangaId], [genreId]) VALUES (N'004', N'006')
INSERT [dbo].[Mangas_Genres] ([mangaId], [genreId]) VALUES (N'005', N'003')
INSERT [dbo].[Mangas_Genres] ([mangaId], [genreId]) VALUES (N'005', N'005')
INSERT [dbo].[Mangas_Genres] ([mangaId], [genreId]) VALUES (N'005', N'010')
INSERT [dbo].[Mangas_Genres] ([mangaId], [genreId]) VALUES (N'006', N'003')
INSERT [dbo].[Mangas_Genres] ([mangaId], [genreId]) VALUES (N'006', N'005')
INSERT [dbo].[Mangas_Genres] ([mangaId], [genreId]) VALUES (N'006', N'009')
INSERT [dbo].[Mangas_Genres] ([mangaId], [genreId]) VALUES (N'006', N'010')
INSERT [dbo].[Mangas_Genres] ([mangaId], [genreId]) VALUES (N'007', N'009')
INSERT [dbo].[Mangas_Genres] ([mangaId], [genreId]) VALUES (N'007', N'010')
INSERT [dbo].[Mangas_Genres] ([mangaId], [genreId]) VALUES (N'008', N'003')
INSERT [dbo].[Mangas_Genres] ([mangaId], [genreId]) VALUES (N'008', N'009')
INSERT [dbo].[Mangas_Genres] ([mangaId], [genreId]) VALUES (N'008', N'010')
INSERT [dbo].[Mangas_Genres] ([mangaId], [genreId]) VALUES (N'009', N'001')
INSERT [dbo].[Mangas_Genres] ([mangaId], [genreId]) VALUES (N'009', N'002')
INSERT [dbo].[Mangas_Genres] ([mangaId], [genreId]) VALUES (N'009', N'003')
INSERT [dbo].[Mangas_Genres] ([mangaId], [genreId]) VALUES (N'009', N'005')
INSERT [dbo].[Mangas_Genres] ([mangaId], [genreId]) VALUES (N'009', N'006')
INSERT [dbo].[Mangas_Genres] ([mangaId], [genreId]) VALUES (N'009', N'008')
INSERT [dbo].[Mangas_Genres] ([mangaId], [genreId]) VALUES (N'009', N'009')
INSERT [dbo].[Mangas_Genres] ([mangaId], [genreId]) VALUES (N'009', N'010')
INSERT [dbo].[Mangas_Genres] ([mangaId], [genreId]) VALUES (N'010', N'003')
INSERT [dbo].[Mangas_Genres] ([mangaId], [genreId]) VALUES (N'010', N'009')
INSERT [dbo].[Mangas_Genres] ([mangaId], [genreId]) VALUES (N'011', N'006')
INSERT [dbo].[Mangas_Genres] ([mangaId], [genreId]) VALUES (N'011', N'007')
INSERT [dbo].[Mangas_Genres] ([mangaId], [genreId]) VALUES (N'011', N'009')
INSERT [dbo].[Mangas_Genres] ([mangaId], [genreId]) VALUES (N'012', N'001')
INSERT [dbo].[Mangas_Genres] ([mangaId], [genreId]) VALUES (N'012', N'007')
INSERT [dbo].[Mangas_Genres] ([mangaId], [genreId]) VALUES (N'012', N'009')
INSERT [dbo].[Mangas_Genres] ([mangaId], [genreId]) VALUES (N'012', N'010')
INSERT [dbo].[Mangas_Genres] ([mangaId], [genreId]) VALUES (N'013', N'002')
INSERT [dbo].[Mangas_Genres] ([mangaId], [genreId]) VALUES (N'013', N'004')
INSERT [dbo].[Mangas_Genres] ([mangaId], [genreId]) VALUES (N'013', N'007')
INSERT [dbo].[Mangas_Genres] ([mangaId], [genreId]) VALUES (N'013', N'009')
INSERT [dbo].[Mangas_Genres] ([mangaId], [genreId]) VALUES (N'020', N'001')
INSERT [dbo].[Mangas_Genres] ([mangaId], [genreId]) VALUES (N'020', N'007')
INSERT [dbo].[Mangas_Genres] ([mangaId], [genreId]) VALUES (N'020', N'010')
INSERT [dbo].[Mangas_Genres] ([mangaId], [genreId]) VALUES (N'030', N'003')
INSERT [dbo].[Mangas_Genres] ([mangaId], [genreId]) VALUES (N'030', N'005')
INSERT [dbo].[Mangas_Genres] ([mangaId], [genreId]) VALUES (N'030', N'008')
INSERT [dbo].[Mangas_Genres] ([mangaId], [genreId]) VALUES (N'030', N'009')
INSERT [dbo].[Mangas_Users] ([userId], [mangaId]) VALUES (N'member_1', N'001')
INSERT [dbo].[Mangas_Users] ([userId], [mangaId]) VALUES (N'member_1', N'002')
SET IDENTITY_INSERT [dbo].[Pages] ON 

INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (63, 36, 1, N'https://storage.fshare.vn/aca/5cbd58b1ea2ba-1555913782.jpg', NULL)
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (64, 36, 2, N'https://storage.fshare.vn/aca/5cbd58c0493da-1555913796.jpg', NULL)
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (65, 36, 3, N'https://storage.fshare.vn/aca/5cbd58c93b18c-1555913805.jpg', NULL)
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (66, 36, 4, N'https://storage.fshare.vn/aca/5cbd58ca2c851-1555913806.jpg', NULL)
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (67, 36, 5, N'https://storage.fshare.vn/aca/5cbd58cb14182-1555913807.jpg', NULL)
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (68, 36, 6, N'https://storage.fshare.vn/aca/5cbd58cb7b609-1555913807.jpg', NULL)
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (69, 36, 7, N'https://storage.fshare.vn/aca/5cbd58ceb7534-1555913810.jpg', NULL)
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (70, 36, 8, N'https://storage.fshare.vn/aca/5cbd58cfba9be-1555913811.jpg', NULL)
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (71, 36, 9, N'https://storage.fshare.vn/aca/5cbd58d042eb7-1555913812.jpg', NULL)
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (72, 36, 10, N'https://storage.fshare.vn/aca/5cbd58d409c46-1555913816.jpg', NULL)
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (73, 36, 11, N'https://storage.fshare.vn/aca/5cbd58d57a2f0-1555913817.jpg', NULL)
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (74, 36, 12, N'https://storage.fshare.vn/aca/5cbd58d616544-1555913818.jpg', NULL)
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (75, 36, 13, N'https://storage.fshare.vn/aca/5cbd58d6ab492-1555913818.jpg', NULL)
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (76, 36, 14, N'https://storage.fshare.vn/aca/5cbd58d72cbc6-1555913819.jpg', NULL)
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (77, 36, 15, N'https://storage.fshare.vn/aca/5cbd58d7a7ccc-1555913819.jpg', NULL)
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (78, 36, 16, N'https://storage.fshare.vn/aca/5cbd58dd70210-1555913825.jpg', NULL)
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (79, 36, 17, N'https://storage.fshare.vn/aca/5cbd58dde1d5c-1555913826.jpg', NULL)
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (80, 36, 18, N'https://storage.fshare.vn/aca/5cbd58e68547a-1555913834.jpg', NULL)
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (81, 36, 19, N'https://storage.fshare.vn/aca/5cbd58ebb650e-1555913839.jpg', NULL)
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (82, 36, 20, N'https://storage.fshare.vn/aca/5cbd58ec2722b-1555913840.jpg', NULL)
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (83, 36, 21, N'https://storage.fshare.vn/aca/5cbd58ec8ea8f-1555913840.jpg', NULL)
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (84, 36, 22, N'https://storage.fshare.vn/aca/5cbd58ed28b54-1555913841.jpg', NULL)
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (85, 36, 23, N'https://storage.fshare.vn/aca/5cbd58ed9f86b-1555913841.jpg', NULL)
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (86, 36, 24, N'https://storage.fshare.vn/aca/5cbd58ee15c85-1555913842.jpg', NULL)
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (87, 36, 25, N'https://storage.fshare.vn/aca/5cbd58f1ed9a7-1555913846.jpg', NULL)
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (88, 36, 26, N'https://storage.fshare.vn/aca/5cbd58f27e667-1555913846.jpg', NULL)
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (89, 36, 27, N'https://storage.fshare.vn/aca/5cbd58f539a04-1555913849.jpg', NULL)
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (90, 36, 28, N'https://storage.fshare.vn/aca/5cbd58f5ba490-1555913849.jpg', NULL)
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (91, 36, 29, N'https://storage.fshare.vn/aca/5cbd58f938c1a-1555913853.jpg', NULL)
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (92, 36, 30, N'https://storage.fshare.vn/aca/5cbd58fc54198-1555913856.jpg', NULL)
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (93, 36, 31, N'https://storage.fshare.vn/aca/5cbd58fce848a-1555913857.jpg', NULL)
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (94, 36, 32, N'https://storage.fshare.vn/aca/5cbd58fd6c616-1555913857.jpg', NULL)
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (95, 36, 33, N'https://storage.fshare.vn/aca/5cbd58fddf1df-1555913858.jpg', NULL)
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (96, 36, 34, N'https://storage.fshare.vn/aca/5cbd5901b37e1-1555913861.jpg', NULL)
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (97, 36, 35, N'https://storage.fshare.vn/aca/5cbd590268fbb-1555913862.jpg', NULL)
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (98, 36, 36, N'https://storage.fshare.vn/aca/5cbd5902da002-1555913863.jpg', NULL)
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (99, 36, 37, N'https://storage.fshare.vn/aca/5cbd5903e964e-1555913864.jpg', NULL)
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (100, 36, 38, N'https://storage.fshare.vn/aca/5cbd59046d6f9-1555913864.jpg', NULL)
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (101, 36, 39, N'https://storage.fshare.vn/aca/5cbd5904e1cee-1555913865.jpg', NULL)
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (102, 36, 40, N'https://storage.fshare.vn/aca/5cbd590583b71-1555913865.jpg', NULL)
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (103, 36, 41, N'https://storage.fshare.vn/aca/5cbd5909b6842-1555913869.jpg', NULL)
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (104, 36, 42, N'https://storage.fshare.vn/aca/5cbd590a4e6dd-1555913870.jpg', NULL)
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (105, 36, 43, N'https://storage.fshare.vn/aca/5cbd590adf3a2-1555913871.jpg', NULL)
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (106, 36, 44, N'https://storage.fshare.vn/aca/5cbd591001e13-1555913876.jpg', NULL)
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (107, 36, 45, N'https://storage.fshare.vn/aca/5cbd591090b34-1555913876.jpg', NULL)
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (108, 36, 46, N'https://storage.fshare.vn/aca/5cbd5911d7a77-1555913877.jpg', NULL)
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (109, 36, 47, N'https://storage.fshare.vn/aca/5cbd59170febb-1555913883.jpg', NULL)
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (110, 36, 48, N'https://storage.fshare.vn/aca/5cbd5919120f5-1555913885.jpg', NULL)
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (111, 36, 49, N'https://storage.fshare.vn/aca/5cbd591b496d1-1555913887.jpg', NULL)
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (112, 36, 50, N'https://storage.fshare.vn/aca/5cbd591bb4c68-1555913887.jpg', NULL)
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (113, 36, 51, N'https://storage.fshare.vn/aca/5cbd591c36a6c-1555913888.jpg', NULL)
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (114, 36, 52, N'https://storage.fshare.vn/aca/5cbd591dcc73e-1555913889.jpg', NULL)
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (115, 36, 53, N'https://storage.fshare.vn/aca/5cbd591f442dc-1555913891.jpg', NULL)
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (116, 36, 54, N'https://storage.fshare.vn/aca/5cbd5920852c5-1555913892.jpg', NULL)
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (117, 36, 55, N'https://storage.fshare.vn/aca/5cbd5921a4ef9-1555913893.jpg', NULL)
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (118, 36, 56, N'https://storage.fshare.vn/aca/5cbd592632cd3-1555913898.jpg', NULL)
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (119, 37, 1, N'https://1.bp.blogspot.com/-xOwBtp0mTlc/UBE235LMCSI/AAAAAAAAIGM/afYjoGEyE1I/s0/001.jpg?imgmax=3000', N'null')
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (120, 37, 2, N'https://1.bp.blogspot.com/-gjuZvmtAnVI/UBE25aEzahI/AAAAAAAAIGU/UyZ1G7yssaA/s0/002.jpg?imgmax=3000', N'null')
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (121, 37, 3, N'https://1.bp.blogspot.com/-2nMGfn8OKj8/UBE26-fi5MI/AAAAAAAAIGc/zgCXcyLcMdc/s0/003.jpg?imgmax=3000', NULL)
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (122, 37, 4, N'https://1.bp.blogspot.com/-w3Pku3LlofM/UBE28TPDzII/AAAAAAAAIGk/XquzLXJPUUg/s0/004.jpg?imgmax=3000', NULL)
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (123, 37, 5, N'https://1.bp.blogspot.com/-H0vpL1aDyMA/UBE29z038AI/AAAAAAAAIGs/fABTsedTUCE/s0/005.jpg?imgmax=3000', NULL)
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (124, 38, 1, N'https://1.bp.blogspot.com/-MXzdcOF1Yds/UBE-R7BA85I/AAAAAAAAIK0/m4i71l0p380/s0/001.jpg?imgmax=3000', N'null')
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (125, 38, 2, N'https://1.bp.blogspot.com/-t9ZLoor6l0k/UBE-TaBYUCI/AAAAAAAAIK8/aC4XQGi3sD8/s0/002.jpg?imgmax=3000', N'null')
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (126, 38, 3, N'https://1.bp.blogspot.com/-RAZj3iVfysQ/UBE-VJH185I/AAAAAAAAILE/g5LQ3gohRtw/s0/003.jpg?imgmax=3000', N'null')
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (127, 38, 4, N'https://1.bp.blogspot.com/-bx2THf2vCk4/UBE-WssEWsI/AAAAAAAAILM/5gHF74J4oAw/s0/004.jpg?imgmax=3000', N'null')
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (128, 38, 5, N'https://1.bp.blogspot.com/-YO_UPZWwrwI/UBE-YWXOyUI/AAAAAAAAILU/9n0bMDPLsDg/s0/005.jpg?imgmax=3000', N'null')
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (129, 43, 1, N'https://1.bp.blogspot.com/-Vc0P_jViF4A/UBFE7hK3alI/AAAAAAAAIOY/U2ykRAoca-E/s0/000.jpg?imgmax=3000', N'null')
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (130, 43, 2, N'https://1.bp.blogspot.com/-d35e7F9Anww/UBFE9JcIEoI/AAAAAAAAIOg/3kEPjMsHk24/s0/001.jpg?imgmax=3000', N'null')
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (131, 43, 3, N'https://1.bp.blogspot.com/-04L4KDVBqgg/UBFE_-cRXTI/AAAAAAAAIOo/sq1mLAvH2pg/s0/002.jpg?imgmax=3000', N'null')
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (132, 43, 4, N'https://1.bp.blogspot.com/-rAr3BynwVlM/UBFFBcJPNeI/AAAAAAAAIOw/FoVCrINTwYg/s0/003.jpg?imgmax=3000', N'null')
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (133, 43, 5, N'https://1.bp.blogspot.com/-P_TvvcCID2s/UBFFEcgogXI/AAAAAAAAIO4/GwnYqFnR3AM/s0/004.jpg?imgmax=3000', N'null')
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (134, 44, 1, N'https://1.bp.blogspot.com/-kf3XmeeoeXk/UBFKbjTx7iI/AAAAAAAAIRs/dBAAQwvX7rE/s0/000.jpg?imgmax=3000', N'null')
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (135, 44, 2, N'https://1.bp.blogspot.com/-ogiTrEbgVcQ/UBFKdX-Fj5I/AAAAAAAAIR0/x9IDvY53XIg/s0/001.jpg?imgmax=3000', N'null')
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (136, 44, 3, N'https://1.bp.blogspot.com/-egxoYVdF-jM/UBFKfCEnZpI/AAAAAAAAIR8/pd5XMnhJyQk/s0/002.jpg?imgmax=3000', N'null')
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (137, 44, 4, N'https://1.bp.blogspot.com/-790ZIJtUPNk/UBFKg0pPh3I/AAAAAAAAISE/r9Q6rpGieA4/s0/003.jpg?imgmax=3000', N'null')
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (138, 44, 5, N'https://1.bp.blogspot.com/-PJnXCJ18-3k/UBFKjQCU_VI/AAAAAAAAISM/1-uiSrx9XHI/s0/004.jpg?imgmax=3000', N'null')
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (139, 1, 1, N'https://4.bp.blogspot.com/_aUnUg5mtxOQ/TcfG7i98WJI/AAAAAAAABfk/DYqjpDqwoJo/chobits-v01-c001-001.jpg?imgmax=0', N'null')
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (140, 1, 2, N'https://4.bp.blogspot.com/_aUnUg5mtxOQ/TcfG-k_SWnI/AAAAAAAABfw/NyafWtwRy8E/chobits-v01-c001-005.jpg?imgmax=0', N'null')
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (141, 1, 3, N'https://4.bp.blogspot.com/_aUnUg5mtxOQ/TcfHAG7B5pI/AAAAAAAABf0/-0foYG2OBE0/chobits-v01-c001-006.jpg?imgmax=0', N'null')
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (142, 1, 4, N'https://4.bp.blogspot.com/_aUnUg5mtxOQ/TcfHCphc-tI/AAAAAAAABf4/uFxSAMdlgDc/chobits-v01-c001-007.jpg?imgmax=0', N'null')
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (143, 1, 5, N'https://3.bp.blogspot.com/_aUnUg5mtxOQ/TcfHEvdJHuI/AAAAAAAABf8/yvhvPNUIDEc/chobits-v01-c001-008.jpg?imgmax=0', N'null')
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (144, 2, 1, N'https://3.bp.blogspot.com/_aUnUg5mtxOQ/TcfGthdRX6I/AAAAAAAABeU/o0f7VnKOIeo/chobits-v01-c002-001.jpg?imgmax=0', N'null')
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (145, 2, 2, N'https://4.bp.blogspot.com/_aUnUg5mtxOQ/TcfGugOcmSI/AAAAAAAABeY/f1tmpzPKRN8/chobits-v01-c002-002.jpg?imgmax=0', N'null')
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (146, 2, 3, N'https://4.bp.blogspot.com/_aUnUg5mtxOQ/TcfGvOEEA2I/AAAAAAAABeg/nvdJONfRzfI/chobits-v01-c002-003.jpg?imgmax=0', N'null')
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (147, 2, 4, N'https://4.bp.blogspot.com/_aUnUg5mtxOQ/TcfGwU5wiyI/AAAAAAAABek/CHcUvcQk4hw/chobits-v01-c002-004.jpg?imgmax=0', N'null')
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (148, 2, 5, N'https://4.bp.blogspot.com/_aUnUg5mtxOQ/TcfGxTSbRuI/AAAAAAAABeo/pRs59Bot610/chobits-v01-c002-005.jpg?imgmax=0', N'null')
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (149, 3, 1, N'https://4.bp.blogspot.com/_aUnUg5mtxOQ/TcfGb1BS4RI/AAAAAAAABdU/x06x7j78QQU/chobits-v01-c003-001.jpg?imgmax=0', N'null')
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (150, 3, 2, N'https://4.bp.blogspot.com/_aUnUg5mtxOQ/TcfGc2YenBI/AAAAAAAABdY/JpgeOhPlc8c/chobits-v01-c003-002.jpg?imgmax=0', N'null')
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (151, 3, 3, N'https://4.bp.blogspot.com/_aUnUg5mtxOQ/TcfGdz_5UUI/AAAAAAAABdc/vSncFF_wFDM/chobits-v01-c003-003.jpg?imgmax=0', N'null')
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (152, 3, 4, N'https://3.bp.blogspot.com/_aUnUg5mtxOQ/TcfGfFmj9II/AAAAAAAABdg/ckjRRA9lxkQ/chobits-v01-c003-004.jpg?imgmax=0', N'null')
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (153, 3, 5, N'https://3.bp.blogspot.com/_aUnUg5mtxOQ/TcfGgJyrCoI/AAAAAAAABdk/WnO4TEI1V8g/chobits-v01-c003-005.jpg?imgmax=0', N'null')
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (154, 4, 1, N'http://3.bp.blogspot.com/-RPFIthyU0VQ/UzsWTQ0VhuI/AAAAAAAAB-k/kjycvt2g_cI/s1600/img000003.jpg', N'null')
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (155, 4, 2, N'http://3.bp.blogspot.com/-rzDhwp3PHG4/UzsWcKF_nWI/AAAAAAAAB_E/vDUPt1QPy0I/s1600/img000007.jpg', N'null')
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (156, 4, 3, N'http://3.bp.blogspot.com/-apbl4tGDpPo/UzsWfAB3ubI/AAAAAAAAB_M/Upo42AmzZd4/s1600/img000008.jpg', N'null')
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (157, 4, 4, N'http://3.bp.blogspot.com/-XlJK-ZDUMdE/UzsWh9KwqbI/AAAAAAAAB_U/2kyEoOCYo-A/s1600/img000009.jpg', N'null')
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (158, 4, 5, N'http://3.bp.blogspot.com/-0a8hwgaMMKs/UzsWmPG36XI/AAAAAAAAB_c/uE0NnWe0xY8/s1600/img000010.jpg', N'null')
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (159, 5, 1, N'http://truyentranhtuan.com/manga/clover-nhom-vnsharing-net/2/clover-001.JPG', N'null')
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (160, 5, 2, N'http://truyentranhtuan.com/manga/clover-nhom-vnsharing-net/2/clover-002.JPG', N'null')
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (161, 5, 3, N'http://truyentranhtuan.com/manga/clover-nhom-vnsharing-net/2/clover-003.JPG', N'null')
GO
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (162, 5, 4, N'http://truyentranhtuan.com/manga/clover-nhom-vnsharing-net/2/clover-004.JPG', N'null')
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (163, 5, 4, N'http://truyentranhtuan.com/manga/clover-nhom-vnsharing-net/2/clover-005.JPG', N'null')
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (164, 6, 1, N'http://truyentranhtuan.com/manga/clover-nhom-vnsharing-net/3/clover-001.JPG', N'null')
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (165, 6, 2, N'http://truyentranhtuan.com/manga/clover-nhom-vnsharing-net/3/clover-002.JPG', N'null')
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (166, 6, 3, N'http://truyentranhtuan.com/manga/clover-nhom-vnsharing-net/3/clover-003.JPG', N'null')
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (167, 6, 4, N'http://truyentranhtuan.com/manga/clover-nhom-vnsharing-net/3/clover-004.JPG', N'null')
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (168, 6, 5, N'http://truyentranhtuan.com/manga/clover-nhom-vnsharing-net/3/clover-005.JPG', N'null')
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (169, 7, 1, N'https://3.bp.blogspot.com/-5ngDJ2UJbbc/UhIBlzGfDjI/AAAAAAABNH8/sMJadbKmsBs/truyentranh8.com-kobato01_page01.jpg?imgmax=16383', N'null')
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (170, 7, 1, N'https://1.bp.blogspot.com/-58VIZCWL-Zg/UhIBnpGOY4I/AAAAAAABNIE/7ln7M9rVybc/truyentranh8.com-kobato01_page0203.jpg?imgmax=16383', N'null')
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (171, 7, 3, N'https://1.bp.blogspot.com/-oyW8Lyrq5sM/UhIBpLvoUlI/AAAAAAABNIM/XfWCawXelj0/truyentranh8.com-kobato01_page04.jpg?imgmax=16383', N'null')
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (172, 7, 4, N'https://1.bp.blogspot.com/-MDtkeH6eHDw/UhIBrZ_XE2I/AAAAAAABNIU/am8K58m7BWw/truyentranh8.com-kobato01_page05.jpg?imgmax=16383', N'null')
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (173, 7, 5, N'https://3.bp.blogspot.com/-6H0VXo_W68o/UhIBuFCiBQI/AAAAAAABNIc/N8Sz9vsha2Q/truyentranh8.com-kobato01_page06.jpg?imgmax=16383', N'null')
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (174, 8, 1, N'https://1.bp.blogspot.com/-eJm1-zVD4dc/UhIA8ofqH7I/AAAAAAABNFY/1JP9vwKRrT4/truyentranh8-com-kobato02_page01.jpg?imgmax=16383', N'null')
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (175, 8, 2, N'https://1.bp.blogspot.com/-dycsWyS3ch8/UhIA_Ea4nAI/AAAAAAABNFk/j34gU0OLhEY/truyentranh8-com-kobato02_page02.jpg?imgmax=16383', N'null')
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (176, 8, 3, N'https://1.bp.blogspot.com/-ay86UNXPO-g/UhIBA9rxbzI/AAAAAAABNFw/D5LiR4slKOI/truyentranh8-com-kobato02_page03.jpg?imgmax=16383', N'null')
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (177, 8, 4, N'https://3.bp.blogspot.com/-CjwRUFGLsIE/UhIBDUaVeiI/AAAAAAABNF4/SH8aVy3yWGg/truyentranh8-com-kobato02_page04.jpg?imgmax=16383', N'null')
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (178, 8, 5, N'https://3.bp.blogspot.com/-sWvQ4qlNLPQ/UhIBFDKSW_I/AAAAAAABNGA/aHSU5cm3PLE/truyentranh8-com-kobato02_page05.jpg?imgmax=16383', N'null')
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (179, 9, 1, N'https://4.bp.blogspot.com/-sCWy4IrbYEA/UhIAa9JEr6I/AAAAAAABNC0/xe_xDyuNDko/truyentranh8.com-kobato03_page01.jpg?imgmax=16383', N'null')
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (180, 9, 2, N'https://3.bp.blogspot.com/-pkSnXY2pSe4/UhIAcSIxZQI/AAAAAAABNC8/RkGOSbh8-H8/truyentranh8.com-kobato03_page02.jpg?imgmax=16383', N'null')
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (181, 9, 3, N'https://2.bp.blogspot.com/-TSam9a2ef2A/UhIAedEg9jI/AAAAAAABNDE/64MhUeIuN8Q/truyentranh8.com-kobato03_page03.jpg?imgmax=16383', N'null')
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (182, 9, 4, N'https://2.bp.blogspot.com/-33jNeuLsHNk/UhIAgO7lEeI/AAAAAAABNDU/6qU8PS8lAeg/truyentranh8.com-kobato03_page04.jpg?imgmax=16383', N'null')
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (183, 9, 5, N'https://2.bp.blogspot.com/-gDRefVnMivE/UhIAhyzqiiI/AAAAAAABNDc/x7VEI2Mc08M/truyentranh8.com-kobato03_page05.jpg?imgmax=16383', N'null')
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (184, 10, 1, N'http://4.bp.blogspot.com/--hiZtQztRyM/UekgIVSr0ZI/AAAAAAAACO4/1RxCC3lP9Bo/s0/CongChuaHuyenBi1_003.jpg', N'null')
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (185, 10, 2, N'http://4.bp.blogspot.com/-FnWaTxLenpU/UekgI-VJjOI/AAAAAAAACPA/DlzkieV1Dvs/s0/CongChuaHuyenBi1_005.jpg', N'null')
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (186, 10, 3, N'http://3.bp.blogspot.com/-G2EcX1kYk8U/UekgL8Jg7ZI/AAAAAAAACPI/6-R0Xebaahk/s0/CongChuaHuyenBi1_006.jpg', N'null')
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (187, 10, 4, N'http://3.bp.blogspot.com/-1SurBj_gFRQ/UekgOPWzjCI/AAAAAAAACPQ/V2XgJbaVZDI/s0/CongChuaHuyenBi1_007.jpg', N'null')
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (188, 10, 5, N'http://3.bp.blogspot.com/-uK8L9SA1FXA/UekgO5gy9WI/AAAAAAAACPY/015-SdoUYHI/s0/CongChuaHuyenBi1_008.jpg', N'null')
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (189, 13, 1, N'http://1.bp.blogspot.com/-orWX54emM6A/UOL2sHXqm2I/AAAAAAAADtY/WhNnfTYXhCE/-SxS-%252520K-%25252001-01004.png?imgmax=2000', N'null')
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (190, 13, 2, N'http://1.bp.blogspot.com/-f_Ih9LGr5kc/UOL2x4FzhdI/AAAAAAAADto/G0wePfEBx6U/-SxS-%252520K-%25252001-01006.png?imgmax=2000', N'null')
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (191, 13, 3, N'http://1.bp.blogspot.com/-8LOZuD-yf0Y/UOL20Qu1OiI/AAAAAAAADtw/voCINC5E8rA/-SxS-%252520K-%25252001-01007.png?imgmax=2000', N'null')
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (192, 13, 4, N'http://1.bp.blogspot.com/-X9KJbGoYgUY/UOL22QChrTI/AAAAAAAADt4/DkdFC7YW310/-SxS-%252520K-%25252001-01008.png?imgmax=2000', N'null')
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (193, 13, 5, N'http://1.bp.blogspot.com/-NpD0S0bDtN8/UOL27rVpS6I/AAAAAAAADuA/34Q6QnihKfw/-SxS-%252520K-%25252001-01009.png?imgmax=2000', N'null')
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (194, 14, 1, N'http://1.bp.blogspot.com/-5UcNUfUEaoo/UQOHpUXSYhI/AAAAAAAAMgc/xvDBo3YJh2w/-SxS-%252520K-%25252002-01041.png?imgmax=2000', N'null')
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (195, 14, 2, N'http://1.bp.blogspot.com/-hHAsC87FMQM/UQOHqdwKt0I/AAAAAAAAMgk/TIyM0vaVS8k/-SxS-%252520K-%25252002-01042.png?imgmax=2000', N'null')
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (196, 14, 3, N'http://1.bp.blogspot.com/-7T7YRMZjQ44/UQOHrwanmtI/AAAAAAAAMgs/lxmEeYs0FAQ/-SxS-%252520K-%25252002-01043.png?imgmax=2000', N'null')
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (197, 14, 4, N'http://1.bp.blogspot.com/-LV8JjYtB8mo/UQOHtM7SN2I/AAAAAAAAMg0/uf8EIMvwKqo/-SxS-%252520K-%25252002-01044.png?imgmax=2000', N'null')
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (198, 14, 5, N'http://1.bp.blogspot.com/-t61jVtZSDE0/UQOHuJ9ukLI/AAAAAAAAMg8/3ngL_whG80E/-SxS-%252520K-%25252002-01045.png?imgmax=2000', N'null')
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (199, 15, 1, N'http://2.bp.blogspot.com/-vfHOTwL2eW0/URIc9Da_IkI/AAAAAAAACuw/Xnk71CELMtI/-SxS-%252520K-%25252003-01069.png?imgmax=2000', N'null')
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (200, 15, 2, N'http://2.bp.blogspot.com/-YO2tY_uf3YM/URIc-Hv6bAI/AAAAAAAACu4/ObkSggdErm8/-SxS-%252520K-%25252003-01070%252520copy.png?imgmax=2000', N'null')
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (201, 15, 3, N'http://2.bp.blogspot.com/-wVqmwb1ImrI/URIc_M7fhLI/AAAAAAAACvA/uyNzrApDOok/-SxS-%252520K-%25252003-01071%252520copy.png?imgmax=2000', N'null')
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (202, 15, 4, N'http://2.bp.blogspot.com/-g9C5Gi-24fQ/URIdAB-ZQBI/AAAAAAAACvI/5nl4R9hZH3w/-SxS-%252520K-%25252003-01072%252520copy.png?imgmax=2000', N'null')
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (203, 15, 5, N'http://2.bp.blogspot.com/-auMqshp-HJU/URIdBTiEYqI/AAAAAAAACvQ/EudD9_o63C8/-SxS-%252520K-%25252003-01073%252520copy.png?imgmax=2000', N'null')
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (204, 16, 1, N'http://1.bp.blogspot.com/-2M6rc_vfYvw/Tj_4-pXPFDI/AAAAAAAADdM/vfW8AXFVwAQ/A4_V_Manga_Miyuki_01_001_005.png?imgmax=2000', N'null')
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (205, 16, 2, N'http://1.bp.blogspot.com/-cU48ABkOYBg/Tj_4_Cg4GVI/AAAAAAAADdQ/q0sf7rWaClQ/A4_V_Manga_Miyuki_01_001_006.png?imgmax=2000', N'null')
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (206, 16, 3, N'http://1.bp.blogspot.com/-3yU9o4Gbc3Y/Tj_4_Wpm-rI/AAAAAAAADdU/svKTYPpTAAM/A4_V_Manga_Miyuki_01_001_007.png?imgmax=2000', N'null')
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (207, 16, 4, N'http://1.bp.blogspot.com/-sb1B2znF25U/Tj_4_3BAGgI/AAAAAAAADdY/chBSn4Rt-xc/A4_V_Manga_Miyuki_01_001_008.png?imgmax=2000', N'null')
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (208, 16, 5, N'http://1.bp.blogspot.com/-wsbysHUMzCg/Tj_5AHrg4UI/AAAAAAAADdc/ZTh3rBCt1RQ/A4_V_Manga_Miyuki_01_001_009.png?imgmax=2000', N'null')
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (209, 17, 1, N'http://2.bp.blogspot.com/-dREYpu3ikGQ/Tj_5mp8uhCI/AAAAAAAADgM/y0A3ge9gMW4/A4_V_Manga_Miyuki_01_002_045.png?imgmax=2000', N'null')
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (210, 17, 2, N'http://2.bp.blogspot.com/-Ttx_yonuWWo/Tj_5nL2Fp9I/AAAAAAAADgQ/5wVsrDke5nQ/A4_V_Manga_Miyuki_01_002_046.png?imgmax=2000', N'null')
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (211, 17, 3, N'http://2.bp.blogspot.com/-iJZI_9AHbuQ/Tj_5nWegrgI/AAAAAAAADgU/S7zvadjWfmE/A4_V_Manga_Miyuki_01_002_047.png?imgmax=2000', N'null')
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (212, 17, 4, N'http://2.bp.blogspot.com/-raOyjxTBlJM/Tj_5n0NX7FI/AAAAAAAADgY/oSrNIy9Y91k/A4_V_Manga_Miyuki_01_002_048.png?imgmax=2000', N'null')
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (213, 17, 5, N'http://2.bp.blogspot.com/-f55CrNTFx4E/Tj_5oEeycxI/AAAAAAAADgc/uKYXkDAlN44/A4_V_Manga_Miyuki_01_002_049.png?imgmax=2000', N'null')
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (214, 18, 1, N'http://1.bp.blogspot.com/-akY9E2iXslY/Tj_6Yv-JYAI/AAAAAAAADiQ/OlNKAUOnCRU/A4_V_Manga_Miyuki_01_003_069.png?imgmax=2000', N'null')
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (215, 18, 2, N'http://1.bp.blogspot.com/-x-H--A987LE/Tj_6YxlTXkI/AAAAAAAADiU/aGWHUh0M4Ck/A4_V_Manga_Miyuki_01_003_070.png?imgmax=2000', N'null')
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (216, 18, 3, N'http://1.bp.blogspot.com/-MI6d2Fp-F6o/Tj_6ZcU-WOI/AAAAAAAADiY/ua-w2rweS-A/A4_V_Manga_Miyuki_01_003_071.png?imgmax=2000', N'null')
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (217, 18, 4, N'http://1.bp.blogspot.com/-MkhKo7ylsKE/Tj_6ZqfMuaI/AAAAAAAADic/0AlDFBdioBM/A4_V_Manga_Miyuki_01_003_072.png?imgmax=2000', N'null')
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (218, 18, 5, N'http://1.bp.blogspot.com/-KJ21ehYtea0/Tj_6Z_4jqtI/AAAAAAAADig/rdnklI0RCeM/A4_V_Manga_Miyuki_01_003_073.png?imgmax=2000', N'null')
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (219, 19, 1, N'http://2.bp.blogspot.com/-pW1YidJ_gjg/Tw6kIvkZG9I/AAAAAAAABv8/Qxm3GP75hdM/002.jpg?imgmax=2000', N'null')
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (220, 19, 2, N'http://2.bp.blogspot.com/-HleW8EBc5os/Tw6kJ1dMv3I/AAAAAAAABwE/gLtdlH143HM/003.jpg?imgmax=2000', N'null')
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (221, 19, 3, N'http://2.bp.blogspot.com/-Gp74a9MkMIM/Tw6kK80kX5I/AAAAAAAABwM/oZIE6YZ8eng/004.jpg?imgmax=2000', N'null')
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (222, 19, 4, N'http://2.bp.blogspot.com/-G31RsyF5POo/Tw6kMK-ZPII/AAAAAAAABwU/4HE6x1oSmx8/005.jpg?imgmax=2000', N'null')
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (223, 19, 5, N'http://2.bp.blogspot.com/-7awAmKRfuvI/Tw6kNu6RmsI/AAAAAAAABwc/K2vRvmPqxp8/006.jpg?imgmax=2000', N'null')
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (224, 20, 1, N'http://2.bp.blogspot.com/-C-_EUQkC2Nk/Tw6lt7XrBlI/AAAAAAAAB5Q/h88-D7ETK5U/001.jpg?imgmax=2000', N'null')
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (225, 20, 2, N'http://2.bp.blogspot.com/-Tupe_27Ve4w/Tw6lvH0G2tI/AAAAAAAAB5Y/B8axhMQSsBk/002.jpg?imgmax=2000', N'null')
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (226, 20, 3, N'http://2.bp.blogspot.com/-tm4COZkMcCc/Tw6lwgYYIcI/AAAAAAAAB5g/p-b4Zy05Oe0/003.jpg?imgmax=2000', N'null')
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (227, 20, 4, N'http://2.bp.blogspot.com/--NzHCeToT5w/Tw6lyGBysbI/AAAAAAAAB5o/uM9D13M9I4w/004.jpg?imgmax=2000', N'null')
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (228, 20, 5, N'http://2.bp.blogspot.com/-ML3tCEhfOOA/Tw6lzqHEf_I/AAAAAAAAB5w/8ddTUoTnvus/005.jpg?imgmax=2000', N'null')
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (229, 21, 1, N'http://2.bp.blogspot.com/-RoueLhIlQD8/Tw76CREEbRI/AAAAAAAAC9U/Hoq2t3JZqfg/001.png?imgmax=2000', N'null')
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (230, 21, 2, N'http://2.bp.blogspot.com/-K2KYqZGHyYY/Tw76DangXDI/AAAAAAAAC9c/x0-K8QlJD_g/002.png?imgmax=2000', N'null')
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (231, 21, 3, N'http://2.bp.blogspot.com/-8BFx_xht018/Tw76EdnTmXI/AAAAAAAAC9k/EKbn_rrkbko/003.png?imgmax=2000', N'null')
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (232, 21, 4, N'http://2.bp.blogspot.com/-nA0Od5qS4s0/Tw76FzN8bjI/AAAAAAAAC9s/EX4eIDqWHTk/004.jpg?imgmax=2000', N'null')
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (233, 21, 5, N'http://2.bp.blogspot.com/-4s2j1CXB2oA/Tw76G8VhH5I/AAAAAAAAC90/kZ4A-8EdTg0/005.jpg?imgmax=2000', N'null')
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (234, 22, 1, N'http://1.bp.blogspot.com/_hipimC-WsnE/Tc9Hyjbnt3I/AAAAAAAABwU/L3klmfvWUeQ/Touch-v01-c001-003.jpg?imgmax=2000', N'null')
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (235, 22, 2, N'http://1.bp.blogspot.com/_hipimC-WsnE/Tc9HzHahi9I/AAAAAAAABwc/rTOzHHu152E/Touch-v01-c001-005.jpg?imgmax=2000', N'null')
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (236, 22, 3, N'http://1.bp.blogspot.com/_hipimC-WsnE/Tc9HzzdsDRI/AAAAAAAABwo/gpFTi0a4KMs/Touch-v01-c001-006.jpg?imgmax=2000', N'null')
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (237, 22, 4, N'http://1.bp.blogspot.com/_hipimC-WsnE/Tc9H0aFwWiI/AAAAAAAABww/09jWeQ2Ysxo/Touch-v01-c001-007.jpg?imgmax=2000', N'null')
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (238, 22, 5, N'http://1.bp.blogspot.com/_hipimC-WsnE/Tc9H1HUI5FI/AAAAAAAABw4/4Kf5xBXOYUo/Touch-v01-c001-008.jpg?imgmax=2000', N'null')
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (239, 23, 1, N'http://1.bp.blogspot.com/_hipimC-WsnE/Tc9HowriJvI/AAAAAAAABt4/N8A9vl6OyM0/Touch-v01-c002-033.jpg?imgmax=2000', N'null')
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (240, 23, 2, N'http://1.bp.blogspot.com/_hipimC-WsnE/Tc9HpoiWrJI/AAAAAAAABuA/0s7lRc7q2Qw/Touch-v01-c002-034.jpg?imgmax=2000', N'null')
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (241, 23, 3, N'http://1.bp.blogspot.com/_hipimC-WsnE/Tc9HqSqjRlI/AAAAAAAABuM/rd2RQxfI6pw/Touch-v01-c002-035.jpg?imgmax=2000', N'null')
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (242, 23, 4, N'http://1.bp.blogspot.com/_hipimC-WsnE/Tc9Hq1zkpVI/AAAAAAAABuY/kKA6QMSpMgo/Touch-v01-c002-036.jpg?imgmax=2000', N'null')
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (243, 23, 5, N'http://1.bp.blogspot.com/_hipimC-WsnE/Tc9Hrj5OeZI/AAAAAAAABuk/4Lssv1tSRJs/Touch-v01-c002-037.jpg?imgmax=2000', N'null')
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (244, 24, 1, N'http://2.bp.blogspot.com/_hipimC-WsnE/Tc9HlMaKSNI/AAAAAAAABs8/TYij2Av9Kuk/Touch-v01-c003-053.jpg?imgmax=2000', N'null')
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (245, 24, 2, N'http://2.bp.blogspot.com/_hipimC-WsnE/Tc9Hl1kTF6I/AAAAAAAABtE/hBU8I1JNGJE/Touch-v01-c003-054.jpg?imgmax=2000', N'null')
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (246, 24, 3, N'http://2.bp.blogspot.com/_hipimC-WsnE/Tc9HncifmkI/AAAAAAAABtY/hgTzbuhuMTU/Touch-v01-c003-056.jpg?imgmax=2000', N'null')
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (247, 24, 4, N'http://2.bp.blogspot.com/_hipimC-WsnE/Tc9HoBEVQOI/AAAAAAAABtk/tsr1Npn1uhs/Touch-v01-c003-057.jpg?imgmax=2000', N'null')
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (248, 24, 5, N'http://2.bp.blogspot.com/_hipimC-WsnE/Tc9HowrR4YI/AAAAAAAABt0/qVRc9wnrYDI/Touch-v01-c003-058.jpg?imgmax=2000', N'null')
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (249, 25, 1, N'http://1.bp.blogspot.com/_hipimC-WsnE/Tc9Hij9SAVI/AAAAAAAABr0/5K-aLyqNcBI/Touch-v01-c004-071.jpg?imgmax=2000', N'null')
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (250, 25, 2, N'http://1.bp.blogspot.com/_hipimC-WsnE/Tc9HjL23I5I/AAAAAAAABsU/nkJUKPBHwA0/Touch-v01-c004-072.jpg?imgmax=2000', N'null')
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (251, 25, 3, N'http://1.bp.blogspot.com/_hipimC-WsnE/Tc9HkLdRt0I/AAAAAAAABss/RlUUPxSDO-Y/Touch-v01-c004-073.jpg?imgmax=2000', N'null')
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (252, 25, 4, N'http://1.bp.blogspot.com/_hipimC-WsnE/Tc9Hk6bDciI/AAAAAAAABs4/YLExE_Nf4jQ/Touch-v01-c004-074.jpg?imgmax=2000', N'null')
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (253, 25, 5, N'http://1.bp.blogspot.com/_hipimC-WsnE/Tc9HlYinbGI/AAAAAAAABtA/6EyJdY9LT1g/Touch-v01-c004-075.jpg?imgmax=2000', N'null')
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (254, 26, 1, N'http://mangaqq.com/1369/1/2.jpg', N'null')
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (255, 26, 2, N'http://mangaqq.com/1369/1/3.jpg', N'null')
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (256, 26, 3, N'http://mangaqq.com/1369/1/4.jpg', N'null')
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (257, 26, 4, N'http://mangaqq.com/1369/1/5.jpg', N'null')
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (258, 26, 5, N'http://mangaqq.com/1369/1/6.jpg', N'null')
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (259, 27, 1, N'https://1.bp.blogspot.com/-xarTopqR-dI/XCdjmurbP1I/AAAAAAABD_I/oeDzn42qAhsdhLUmDKa1EJNq_Maws3uNACHMYCw/1.png?imgmax=16383', N'null')
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (260, 27, 2, N'https://1.bp.blogspot.com/-ALMBEyHfrMo/XCdjoOoj2aI/AAAAAAABD_g/5VVnvo-B_hkfypkM2Lkaq6azTCQfQq_ggCHMYCw/2.png?imgmax=16383', N'null')
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (261, 27, 3, N'https://1.bp.blogspot.com/-JSQqBBg7Mr8/XCdjp2g3jAI/AAAAAAABD_w/Li_zR1J8SwE_dG1anDP0D8SDF0DoQSHpQCHMYCw/3.png?imgmax=16383', N'null')
GO
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (262, 27, 4, N'https://1.bp.blogspot.com/-woqZy700ZEo/XCdjr56gBFI/AAAAAAABEAE/K8bxZlekiWwPcZvVrgBBy1Ay40XDRuQfwCHMYCw/4.png?imgmax=16383', N'null')
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (263, 27, 5, N'https://1.bp.blogspot.com/-IRz6JcRI0fk/XCdjtc5vPVI/AAAAAAABEAc/ZDYdBqTkz4kPtC0aoNzZbkPty-GJ260UQCHMYCw/5.png?imgmax=16383', N'null')
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (264, 28, 1, N'https://3.bp.blogspot.com/-SCOPCbMe-Qw/VLaFAfBPQVI/AAAAAAAAI1A/ygCnxhC9v6w/002.png?imgmax=16383', N'null')
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (265, 28, 2, N'https://3.bp.blogspot.com/-EQIwtC9sO_M/VLaFB_PLMNI/AAAAAAAAI1I/YmLlbDXzLYI/003.png?imgmax=16383', N'null')
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (266, 28, 3, N'https://3.bp.blogspot.com/-cKnulWmR0Bg/VLaFDNajZTI/AAAAAAAAI1Q/y90ISG-az6E/004.png?imgmax=16383', N'null')
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (267, 28, 4, N'https://3.bp.blogspot.com/-_1ybvqPz7to/VLaFEWY5zxI/AAAAAAAAI1Y/Q_RE-IgY2UM/005.png?imgmax=16383', N'null')
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (268, 28, 5, N'https://3.bp.blogspot.com/-eC0w51KLxNs/VLaFFsvRLYI/AAAAAAAAI1g/aLBKr_SeFS0/006.png?imgmax=16383', N'null')
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (269, 29, 1, N'https://2.bp.blogspot.com/-vbUszgCBnJw/UKIVgs2ntpI/AAAAAAAAGl4/4y_aFivzlsU/s0/003.jpg', N'null')
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (270, 29, 2, N'https://2.bp.blogspot.com/-Kd8uzUCeFS0/UKIVfrD71tI/AAAAAAAAGlw/oNdB7p9xhTY/s0/004.jpg', N'null')
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (271, 29, 3, N'https://2.bp.blogspot.com/-DM7fW43a4y8/UKIVioM7atI/AAAAAAAAGmA/bEfzhxpz_zc/s0/005.png', N'null')
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (272, 29, 4, N'https://2.bp.blogspot.com/-Ge5KuRkHHNA/UKIVju7DUvI/AAAAAAAAGmI/MGWPX1j9JOc/s0/006.png', N'null')
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (273, 29, 5, N'https://2.bp.blogspot.com/-IMWQaW3gGxo/UKIVlymy2nI/AAAAAAAAGmQ/Q5wCcvCDWQQ/s0/007.png', N'null')
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (274, 30, 5, N'http://cdn5.truyentranh8.net/u/nhoclan/4743-Shurabara/002-109494/006.png', N'null')
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (275, 30, 1, N'http://cdn5.truyentranh8.net/u/nhoclan/4743-Shurabara/002-109494/002.png', N'null')
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (276, 30, 2, N'http://cdn5.truyentranh8.net/u/nhoclan/4743-Shurabara/002-109494/003.png', N'null')
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (277, 30, 3, N'http://cdn5.truyentranh8.net/u/nhoclan/4743-Shurabara/002-109494/004.png', N'null')
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (278, 30, 4, N'http://cdn5.truyentranh8.net/u/nhoclan/4743-Shurabara/002-109494/005.png', N'null')
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (279, 31, 1, N'http://cdn5.truyentranh8.net/u/chichichi7/4743-Shurabara/003-109663/002.png', N'null')
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (280, 31, 2, N'http://cdn5.truyentranh8.net/u/chichichi7/4743-Shurabara/003-109663/003.png', N'null')
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (281, 31, 3, N'http://cdn5.truyentranh8.net/u/chichichi7/4743-Shurabara/003-109663/004.png', N'null')
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (282, 31, 4, N'http://cdn5.truyentranh8.net/u/chichichi7/4743-Shurabara/003-109663/005.png', N'null')
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (283, 31, 5, N'http://cdn5.truyentranh8.net/u/chichichi7/4743-Shurabara/003-109663/006.png', N'null')
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (284, 32, 1, N'https://3.bp.blogspot.com/-vetxEO2HIYQ/WBcNlHWrh1I/AAAAAAAFxQg/gWLQlN9__mY/004.jpg?imgmax=16383', N'null')
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (285, 32, 2, N'https://3.bp.blogspot.com/-aGG8ENSjig4/WBcNs7xYyYI/AAAAAAAFxQk/X-PGZnQzZLY/005.jpg?imgmax=16383', N'null')
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (286, 32, 3, N'https://3.bp.blogspot.com/-t-QmuNlHaMY/WBcNx2vFRlI/AAAAAAAFxQo/ns37vxI6Hzg/029.png?imgmax=16383', N'null')
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (287, 32, 4, N'https://3.bp.blogspot.com/-o1OhmF6SPLU/WBcN3GSpmJI/AAAAAAAFxQw/5WWC7ga22i8/030.png?imgmax=16383', N'null')
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (288, 32, 5, N'https://3.bp.blogspot.com/-cRKvjfitdjA/WBcN8P78HxI/AAAAAAAFxQ0/AiEcRG3xg5I/031.png?imgmax=16383', N'null')
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (289, 33, 1, N'https://3.bp.blogspot.com/-C2ohCHw8svk/WBcUPGiSMnI/AAAAAAAFxcY/O9rYRKdA0ug/002.jpg?imgmax=16383', N'null')
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (290, 33, 2, N'https://3.bp.blogspot.com/-eDGQGQvOyjw/WBcUURzuBQI/AAAAAAAFxcc/tiUCXRnQeEs/0099.png?imgmax=16383', N'null')
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (291, 33, 3, N'https://3.bp.blogspot.com/-ecFUsMDp7ks/WBcUaplW4sI/AAAAAAAFxco/y5cQS4oVp-E/0100.png?imgmax=16383', N'null')
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (292, 33, 4, N'https://3.bp.blogspot.com/-AN4gs0gVFCk/WBcUhaPBbII/AAAAAAAFxcs/FGrNQ8PR8K8/0101.png?imgmax=16383', N'null')
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (293, 33, 5, N'https://3.bp.blogspot.com/-alU_mmYc0fo/WBcUnVhouEI/AAAAAAAFxc4/CnhNn3nroDg/0102.png?imgmax=16383', N'null')
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (294, 35, 1, N'https://3.bp.blogspot.com/-5eULyqef7G0/WBcZid3aiMI/AAAAAAAFxig/HGBdWQkvjC4/0298.png?imgmax=16383', N'null')
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (295, 35, 2, N'https://3.bp.blogspot.com/-ydvKc1nxZwY/WBcZnPGaUTI/AAAAAAAFxio/i0Eh0EXBPXY/0299.png?imgmax=16383', N'null')
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (296, 35, 3, N'https://3.bp.blogspot.com/-xM1EzgKad1o/WBcZtDLIHuI/AAAAAAAFxis/R4A--wT59_Y/0300.png?imgmax=16383', N'null')
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (297, 35, 4, N'https://3.bp.blogspot.com/-tO4jRN48ALA/WBcZxd9wSQI/AAAAAAAFxiw/sSd4tiQhjPY/0301.png?imgmax=16383', N'null')
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (298, 35, 5, N'https://3.bp.blogspot.com/-N-CTVsopdZM/WBcZ3dlGjYI/AAAAAAAFxi0/5N-P-t2w_QM/0302.png?imgmax=16383', N'null')
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (299, 39, 1, N'http://cdn5.truyentranh8.net/u/thanhlonglong/20725-conan-bo-dac-biet/001-323278/008.jpg', N'null')
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (300, 39, 2, N'http://cdn5.truyentranh8.net/u/thanhlonglong/20725-conan-bo-dac-biet/001-323278/009.jpg', N'null')
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (301, 39, 3, N'http://cdn5.truyentranh8.net/u/thanhlonglong/20725-conan-bo-dac-biet/001-323278/010.jpg', N'null')
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (302, 39, 4, N'http://cdn5.truyentranh8.net/u/thanhlonglong/20725-conan-bo-dac-biet/001-323278/011.jpg', N'null')
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (303, 39, 5, N'http://cdn5.truyentranh8.net/u/thanhlonglong/20725-conan-bo-dac-biet/001-323278/012.jpg', N'null')
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (304, 40, 1, N'http://cdn5.truyentranh8.net/u/thanhlonglong/20725-conan-bo-dac-biet/002-323279/009.jpg', N'null')
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (305, 40, 2, N'http://cdn5.truyentranh8.net/u/thanhlonglong/20725-conan-bo-dac-biet/002-323279/010.jpg', N'null')
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (306, 40, 3, N'http://cdn5.truyentranh8.net/u/thanhlonglong/20725-conan-bo-dac-biet/002-323279/011.jpg', N'null')
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (307, 40, 4, N'http://cdn5.truyentranh8.net/u/thanhlonglong/20725-conan-bo-dac-biet/002-323279/012.jpg', N'null')
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (308, 40, 5, N'http://cdn5.truyentranh8.net/u/thanhlonglong/20725-conan-bo-dac-biet/002-323279/013.jpg', N'null')
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (309, 41, 1, N'http://cdn5.truyentranh8.net/u/thanhlonglong/20725-conan-bo-dac-biet/003-323400/006.jpg', N'null')
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (310, 41, 2, N'http://cdn5.truyentranh8.net/u/thanhlonglong/20725-conan-bo-dac-biet/003-323400/007.jpg', N'null')
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (311, 41, 3, N'http://cdn5.truyentranh8.net/u/thanhlonglong/20725-conan-bo-dac-biet/003-323400/008.jpg', N'null')
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (312, 41, 4, N'http://cdn5.truyentranh8.net/u/thanhlonglong/20725-conan-bo-dac-biet/003-323400/009.jpg', N'null')
INSERT [dbo].[Pages] ([pageId], [chapterId], [pageNumber], [link1], [link2]) VALUES (313, 41, 5, N'http://cdn5.truyentranh8.net/u/thanhlonglong/20725-conan-bo-dac-biet/003-323400/010.jpg', N'null')
SET IDENTITY_INSERT [dbo].[Pages] OFF
INSERT [dbo].[Roles] ([roleId], [roleName]) VALUES (1, N'admin')
INSERT [dbo].[Roles] ([roleId], [roleName]) VALUES (2, N'member')
INSERT [dbo].[Roles] ([roleId], [roleName]) VALUES (3, N'anonymous')
INSERT [dbo].[Status] ([statusId], [statusName]) VALUES (1, N'Processing')
INSERT [dbo].[Status] ([statusId], [statusName]) VALUES (2, N'Stopped')
INSERT [dbo].[Status] ([statusId], [statusName]) VALUES (3, N'Completed')
INSERT [dbo].[Users] ([userId], [password], [name], [roleId], [condition]) VALUES (N'admin_1', 0x40BD001563085FC35165329EA1FF5C5ECBDBBEEF, N'admin_1', 1, NULL)
INSERT [dbo].[Users] ([userId], [password], [name], [roleId], [condition]) VALUES (N'admin_2', 0x40BD001563085FC35165329EA1FF5C5ECBDBBEEF, N'admin_2', 1, NULL)
INSERT [dbo].[Users] ([userId], [password], [name], [roleId], [condition]) VALUES (N'admin_4', 0x7C4A8D09CA3762AF61E59520943DC26494F8941B, NULL, NULL, NULL)
INSERT [dbo].[Users] ([userId], [password], [name], [roleId], [condition]) VALUES (N'admin_5', 0x40BD001563085FC35165329EA1FF5C5ECBDBBEEF, NULL, NULL, NULL)
INSERT [dbo].[Users] ([userId], [password], [name], [roleId], [condition]) VALUES (N'admin_6', 0x7C4A8D09CA3762AF61E59520943DC26494F8941B, NULL, NULL, NULL)
INSERT [dbo].[Users] ([userId], [password], [name], [roleId], [condition]) VALUES (N'anonymous', NULL, N'anonymous', 3, NULL)
INSERT [dbo].[Users] ([userId], [password], [name], [roleId], [condition]) VALUES (N'mem_5', 0x40BD001563085FC35165329EA1FF5C5ECBDBBEEF, N'mem', 2, N'ok')
INSERT [dbo].[Users] ([userId], [password], [name], [roleId], [condition]) VALUES (N'member_1', 0x40BD001563085FC35165329EA1FF5C5ECBDBBEEF, N'member_1', 2, NULL)
INSERT [dbo].[Users] ([userId], [password], [name], [roleId], [condition]) VALUES (N'member_2', 0x40BD001563085FC35165329EA1FF5C5ECBDBBEEF, N'member_2', 2, NULL)
INSERT [dbo].[Users] ([userId], [password], [name], [roleId], [condition]) VALUES (N'member_3', 0x40BD001563085FC35165329EA1FF5C5ECBDBBEEF, N'member_3', 2, NULL)
ALTER TABLE [dbo].[Chapters]  WITH CHECK ADD  CONSTRAINT [FK_Chapters_Mangas] FOREIGN KEY([mangaId])
REFERENCES [dbo].[Mangas] ([mangaId])
GO
ALTER TABLE [dbo].[Chapters] CHECK CONSTRAINT [FK_Chapters_Mangas]
GO
ALTER TABLE [dbo].[Mangas]  WITH CHECK ADD  CONSTRAINT [FK_Mangas_Authors] FOREIGN KEY([authorId])
REFERENCES [dbo].[Authors] ([authorId])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[Mangas] CHECK CONSTRAINT [FK_Mangas_Authors]
GO
ALTER TABLE [dbo].[Mangas]  WITH CHECK ADD  CONSTRAINT [FK_Mangas_Status] FOREIGN KEY([statusId])
REFERENCES [dbo].[Status] ([statusId])
GO
ALTER TABLE [dbo].[Mangas] CHECK CONSTRAINT [FK_Mangas_Status]
GO
ALTER TABLE [dbo].[Mangas_Genres]  WITH CHECK ADD  CONSTRAINT [FK_Mangas_Genres_Genres] FOREIGN KEY([genreId])
REFERENCES [dbo].[Genres] ([genreId])
GO
ALTER TABLE [dbo].[Mangas_Genres] CHECK CONSTRAINT [FK_Mangas_Genres_Genres]
GO
ALTER TABLE [dbo].[Mangas_Genres]  WITH CHECK ADD  CONSTRAINT [FK_Mangas_Genres_Mangas] FOREIGN KEY([mangaId])
REFERENCES [dbo].[Mangas] ([mangaId])
GO
ALTER TABLE [dbo].[Mangas_Genres] CHECK CONSTRAINT [FK_Mangas_Genres_Mangas]
GO
ALTER TABLE [dbo].[Mangas_Users]  WITH CHECK ADD  CONSTRAINT [FK_Mangas_Users_Mangas] FOREIGN KEY([mangaId])
REFERENCES [dbo].[Mangas] ([mangaId])
GO
ALTER TABLE [dbo].[Mangas_Users] CHECK CONSTRAINT [FK_Mangas_Users_Mangas]
GO
ALTER TABLE [dbo].[Mangas_Users]  WITH CHECK ADD  CONSTRAINT [FK_Mangas_Users_Users] FOREIGN KEY([userId])
REFERENCES [dbo].[Users] ([userId])
GO
ALTER TABLE [dbo].[Mangas_Users] CHECK CONSTRAINT [FK_Mangas_Users_Users]
GO
ALTER TABLE [dbo].[Pages]  WITH CHECK ADD  CONSTRAINT [FK_Pages_Chapters] FOREIGN KEY([chapterId])
REFERENCES [dbo].[Chapters] ([chapterId])
GO
ALTER TABLE [dbo].[Pages] CHECK CONSTRAINT [FK_Pages_Chapters]
GO
ALTER TABLE [dbo].[Users]  WITH CHECK ADD  CONSTRAINT [FK_Users_Roles] FOREIGN KEY([roleId])
REFERENCES [dbo].[Roles] ([roleId])
GO
ALTER TABLE [dbo].[Users] CHECK CONSTRAINT [FK_Users_Roles]
GO
USE [master]
GO
ALTER DATABASE [dbManga] SET  READ_WRITE 
GO
