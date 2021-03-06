USE [master]
GO
/****** Object:  Database [Computer game]    Script Date: 02.05.2022 16:26:17 ******/
CREATE DATABASE [Computer game]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Сomputer game', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\Сomputer game.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Сomputer game_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\Сomputer game_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [Computer game] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Computer game].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Computer game] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Computer game] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Computer game] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Computer game] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Computer game] SET ARITHABORT OFF 
GO
ALTER DATABASE [Computer game] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Computer game] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Computer game] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Computer game] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Computer game] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Computer game] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Computer game] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Computer game] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Computer game] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Computer game] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Computer game] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Computer game] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Computer game] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Computer game] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Computer game] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Computer game] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Computer game] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Computer game] SET RECOVERY FULL 
GO
ALTER DATABASE [Computer game] SET  MULTI_USER 
GO
ALTER DATABASE [Computer game] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Computer game] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Computer game] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Computer game] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Computer game] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [Computer game] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'Computer game', N'ON'
GO
ALTER DATABASE [Computer game] SET QUERY_STORE = OFF
GO
USE [Computer game]
GO
/****** Object:  User [pc]    Script Date: 02.05.2022 16:26:17 ******/
CREATE USER [pc] FOR LOGIN [pc] WITH DEFAULT_SCHEMA=[pc]
GO
ALTER ROLE [db_owner] ADD MEMBER [pc]
GO
ALTER ROLE [db_ddladmin] ADD MEMBER [pc]
GO
/****** Object:  Table [dbo].[character_weapon]    Script Date: 02.05.2022 16:26:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[character_weapon](
	[character_id] [bigint] NOT NULL,
	[weapon_id] [bigint] NOT NULL,
	[weapon_streangth] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[characters]    Script Date: 02.05.2022 16:26:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[characters](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](50) NOT NULL,
	[race] [nvarchar](50) NOT NULL,
	[story] [nvarchar](max) NOT NULL,
	[birthday] [date] NOT NULL,
	[class_id] [bigint] NULL,
	[player_id] [bigint] NULL,
	[notes] [nvarchar](50) NOT NULL,
	[stamina] [int] NOT NULL,
	[strength] [int] NOT NULL,
	[agility] [int] NOT NULL,
	[intellect] [int] NOT NULL,
	[clan] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_characters] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[classes]    Script Date: 02.05.2022 16:26:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[classes](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[title] [nvarchar](50) NOT NULL,
	[description] [nvarchar](max) NOT NULL,
	[special_ability_id] [bigint] NOT NULL,
	[main_stat_id] [bigint] NOT NULL,
 CONSTRAINT [PK_Class] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[main_stats]    Script Date: 02.05.2022 16:26:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[main_stats](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_main_stats] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[players]    Script Date: 02.05.2022 16:26:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[players](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[nickname] [nvarchar](50) NOT NULL,
	[login] [nvarchar](255) NOT NULL,
	[password] [nvarchar](255) NOT NULL,
	[mail] [nvarchar](255) NULL,
	[phone] [nvarchar](11) NULL,
	[card] [nvarchar](16) NULL,
	[birthday] [date] NOT NULL,
	[rat_group] [int] NOT NULL,
 CONSTRAINT [PK_players] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[special_abilities]    Script Date: 02.05.2022 16:26:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[special_abilities](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_special_abilities] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[weapons]    Script Date: 02.05.2022 16:26:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[weapons](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[title] [nvarchar](50) NOT NULL,
	[description] [nvarchar](max) NOT NULL,
	[type] [nvarchar](50) NOT NULL,
	[special_ability] [nvarchar](50) NULL,
	[attack_range] [int] NOT NULL,
	[attack_speed] [int] NOT NULL,
	[increasing_the_attribute] [int] NOT NULL,
	[damage] [int] NOT NULL,
	[rarity] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_weapons] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
INSERT [dbo].[character_weapon] ([character_id], [weapon_id], [weapon_streangth]) VALUES (1, 1, 22)
INSERT [dbo].[character_weapon] ([character_id], [weapon_id], [weapon_streangth]) VALUES (1, 2, 11)
INSERT [dbo].[character_weapon] ([character_id], [weapon_id], [weapon_streangth]) VALUES (9, 1, 22)
INSERT [dbo].[character_weapon] ([character_id], [weapon_id], [weapon_streangth]) VALUES (3, 3, 2)
INSERT [dbo].[character_weapon] ([character_id], [weapon_id], [weapon_streangth]) VALUES (8, 2, 3)
INSERT [dbo].[character_weapon] ([character_id], [weapon_id], [weapon_streangth]) VALUES (11, 1, 2)
INSERT [dbo].[character_weapon] ([character_id], [weapon_id], [weapon_streangth]) VALUES (3, 4, 2)
INSERT [dbo].[character_weapon] ([character_id], [weapon_id], [weapon_streangth]) VALUES (3, 5, 1)
INSERT [dbo].[character_weapon] ([character_id], [weapon_id], [weapon_streangth]) VALUES (1, 1, 11)
INSERT [dbo].[character_weapon] ([character_id], [weapon_id], [weapon_streangth]) VALUES (2, 1, 33)
GO
SET IDENTITY_INSERT [dbo].[characters] ON 

INSERT [dbo].[characters] ([id], [name], [race], [story], [birthday], [class_id], [player_id], [notes], [stamina], [strength], [agility], [intellect], [clan]) VALUES (1, N'qqq', N'dsa', N'gdf', CAST(N'1111-11-11' AS Date), 1, 1, N'fdfds', 321, 321, 321, 111, N'dsa')
INSERT [dbo].[characters] ([id], [name], [race], [story], [birthday], [class_id], [player_id], [notes], [stamina], [strength], [agility], [intellect], [clan]) VALUES (2, N'fds', N'gfd', N'_gfd', CAST(N'1231-11-22' AS Date), 2, 2, N'fsdf', 325, 543, 111, 5, N'gfd')
INSERT [dbo].[characters] ([id], [name], [race], [story], [birthday], [class_id], [player_id], [notes], [stamina], [strength], [agility], [intellect], [clan]) VALUES (3, N'xxx', N'ghdfh', N'dfgg___', CAST(N'1221-02-01' AS Date), 3, 3, N'fsd', 111, 222, 333, 12, N'gfdjhgf')
INSERT [dbo].[characters] ([id], [name], [race], [story], [birthday], [class_id], [player_id], [notes], [stamina], [strength], [agility], [intellect], [clan]) VALUES (4, N'fbhhh', N'fdg', N'fsdfs_hh321', CAST(N'1321-03-04' AS Date), 4, 4, N'dfgfgd', 645, 241, 31, 421, N'gfd')
INSERT [dbo].[characters] ([id], [name], [race], [story], [birthday], [class_id], [player_id], [notes], [stamina], [strength], [agility], [intellect], [clan]) VALUES (8, N'gfd', N'gfd', N'gdf_', CAST(N'2022-01-11' AS Date), 5, 3, N'gdf', 1, 12, 23, 12, N'dfsa')
INSERT [dbo].[characters] ([id], [name], [race], [story], [birthday], [class_id], [player_id], [notes], [stamina], [strength], [agility], [intellect], [clan]) VALUES (9, N'ewq', N'gfds', N'ewq eqw aa', CAST(N'1111-11-11' AS Date), 2, 1, N'fsfds', 13, 321, 33, 12, N'jhgbnv')
INSERT [dbo].[characters] ([id], [name], [race], [story], [birthday], [class_id], [player_id], [notes], [stamina], [strength], [agility], [intellect], [clan]) VALUES (10, N'eqqqq', N'fdsfsdfs', N'aa ad dsa sadsa adsa', CAST(N'2022-12-31' AS Date), 2, 2, N'fds', 1111, 1123, 321, 31, N'cvxc')
INSERT [dbo].[characters] ([id], [name], [race], [story], [birthday], [class_id], [player_id], [notes], [stamina], [strength], [agility], [intellect], [clan]) VALUES (11, N'eqweqw', N'sd', N'вфы и вфы вфы', CAST(N'2022-11-02' AS Date), 2, 3, N'вфы', 123, 3, 3, 3, N'fgds')
INSERT [dbo].[characters] ([id], [name], [race], [story], [birthday], [class_id], [player_id], [notes], [stamina], [strength], [agility], [intellect], [clan]) VALUES (12, N'f', N'fsd', N'qq q', CAST(N'1113-01-01' AS Date), 1, 4, N'da', 321, 31, 1, 32, N'fds')
INSERT [dbo].[characters] ([id], [name], [race], [story], [birthday], [class_id], [player_id], [notes], [stamina], [strength], [agility], [intellect], [clan]) VALUES (13, N'adaas', N'ghgfhfg', N'qre', CAST(N'2022-01-01' AS Date), 1, 7, N'rsd', 321, 2, 12, 321, N'hgf')
INSERT [dbo].[characters] ([id], [name], [race], [story], [birthday], [class_id], [player_id], [notes], [stamina], [strength], [agility], [intellect], [clan]) VALUES (14, N'hgfhf', N'ssssss', N'dfxgjgh', CAST(N'2022-02-01' AS Date), 1, 7, N'fssa', 321, 32, 321, 1, N'bcvgfd')
INSERT [dbo].[characters] ([id], [name], [race], [story], [birthday], [class_id], [player_id], [notes], [stamina], [strength], [agility], [intellect], [clan]) VALUES (15, N'mmm', N'ewq', N'qqqsas', CAST(N'2022-01-02' AS Date), 2, NULL, N'hfg', 432, 321, 21, 1, N'fsd')
INSERT [dbo].[characters] ([id], [name], [race], [story], [birthday], [class_id], [player_id], [notes], [stamina], [strength], [agility], [intellect], [clan]) VALUES (16, N'dada', N'fggdf', N'3w412', CAST(N'2022-09-09' AS Date), NULL, 6, N'hgf', 1, 1, 1, 11, N'hgf')
INSERT [dbo].[characters] ([id], [name], [race], [story], [birthday], [class_id], [player_id], [notes], [stamina], [strength], [agility], [intellect], [clan]) VALUES (17, N'dsazzz', N'zzzxcxzc', N'421', CAST(N'2022-01-01' AS Date), 6, NULL, N'gdfs', 1, 1, 1, 1, N'gfd')
INSERT [dbo].[characters] ([id], [name], [race], [story], [birthday], [class_id], [player_id], [notes], [stamina], [strength], [agility], [intellect], [clan]) VALUES (19, N'zxc', N'sddddd', N'qeqweq', CAST(N'2022-12-02' AS Date), 6, 6, N'rdfs', 23, 2, 23, 1, N'fffff')
INSERT [dbo].[characters] ([id], [name], [race], [story], [birthday], [class_id], [player_id], [notes], [stamina], [strength], [agility], [intellect], [clan]) VALUES (20, N'vbn', N'fdsjjjj', N'wqesds', CAST(N'2022-11-01' AS Date), 7, 1, N'ewqeq', 1, 12, 3, 323, N'safdsdf')
INSERT [dbo].[characters] ([id], [name], [race], [story], [birthday], [class_id], [player_id], [notes], [stamina], [strength], [agility], [intellect], [clan]) VALUES (21, N'bnbnb', N'ewqeq', N'qwe', CAST(N'2022-03-03' AS Date), 3, 1, N'gdfg', 4, 32, 1, 2, N'fgff')
INSERT [dbo].[characters] ([id], [name], [race], [story], [birthday], [class_id], [player_id], [notes], [stamina], [strength], [agility], [intellect], [clan]) VALUES (22, N'jjjjjjjj', N'jkkkkkk', N'gfd', CAST(N'2022-04-04' AS Date), 4, 1, N'fdsf', 1, 1, 1, 3, N'fdsf')
INSERT [dbo].[characters] ([id], [name], [race], [story], [birthday], [class_id], [player_id], [notes], [stamina], [strength], [agility], [intellect], [clan]) VALUES (23, N'kkkkkk', N'klklklk', N'gfd', CAST(N'2022-05-05' AS Date), 6, 1, N'gdfg', 2, 2, 12, 32, N'fdsf')
INSERT [dbo].[characters] ([id], [name], [race], [story], [birthday], [class_id], [player_id], [notes], [stamina], [strength], [agility], [intellect], [clan]) VALUES (24, N'mmmm', N'gbfvb', N'reerwe', CAST(N'2022-06-06' AS Date), 8, 1, N'fds', 21, 321, 321, 123, N'fgdfgd')
INSERT [dbo].[characters] ([id], [name], [race], [story], [birthday], [class_id], [player_id], [notes], [stamina], [strength], [agility], [intellect], [clan]) VALUES (25, N'llllllll', N'kgfklkl', N'gfdgd', CAST(N'2022-07-07' AS Date), 9, 1, N'fdsf', 325, 78, 98, 77, N'hgfjdh')
INSERT [dbo].[characters] ([id], [name], [race], [story], [birthday], [class_id], [player_id], [notes], [stamina], [strength], [agility], [intellect], [clan]) VALUES (26, N'ooooooooll', N'klkl;k;', N'gfdgdf', CAST(N'2022-08-08' AS Date), 10, 1, N'fdsl', 789, 85749, 789, 89, N'fdsfgds')
INSERT [dbo].[characters] ([id], [name], [race], [story], [birthday], [class_id], [player_id], [notes], [stamina], [strength], [agility], [intellect], [clan]) VALUES (27, N'hhhh', N'hgfhfgh', N'wwww', CAST(N'2022-09-09' AS Date), 5, 1, N'gfdg', 65, 534, 534, 34, N'hgfgh')
SET IDENTITY_INSERT [dbo].[characters] OFF
GO
SET IDENTITY_INSERT [dbo].[classes] ON 

INSERT [dbo].[classes] ([id], [title], [description], [special_ability_id], [main_stat_id]) VALUES (1, N'lgfd', N'tertt', 1, 2)
INSERT [dbo].[classes] ([id], [title], [description], [special_ability_id], [main_stat_id]) VALUES (2, N'zzz', N'hhhhh', 3, 1)
INSERT [dbo].[classes] ([id], [title], [description], [special_ability_id], [main_stat_id]) VALUES (3, N'ffsaa', N'ccc', 4, 3)
INSERT [dbo].[classes] ([id], [title], [description], [special_ability_id], [main_stat_id]) VALUES (4, N'напав фф', N'пва', 1, 1)
INSERT [dbo].[classes] ([id], [title], [description], [special_ability_id], [main_stat_id]) VALUES (5, N'на', N'уцй', 2, 1)
INSERT [dbo].[classes] ([id], [title], [description], [special_ability_id], [main_stat_id]) VALUES (6, N'яя аа', N'авы', 3, 3)
INSERT [dbo].[classes] ([id], [title], [description], [special_ability_id], [main_stat_id]) VALUES (7, N'наавыа', N'уцйуй', 2, 2)
INSERT [dbo].[classes] ([id], [title], [description], [special_ability_id], [main_stat_id]) VALUES (8, N'нф на выф', N'павп', 1, 1)
INSERT [dbo].[classes] ([id], [title], [description], [special_ability_id], [main_stat_id]) VALUES (9, N'gg ff', N'fds', 2, 3)
INSERT [dbo].[classes] ([id], [title], [description], [special_ability_id], [main_stat_id]) VALUES (10, N'bvcbcv', N'dada', 1, 1)
SET IDENTITY_INSERT [dbo].[classes] OFF
GO
SET IDENTITY_INSERT [dbo].[main_stats] ON 

INSERT [dbo].[main_stats] ([id], [name]) VALUES (1, N'intelect')
INSERT [dbo].[main_stats] ([id], [name]) VALUES (2, N'strength')
INSERT [dbo].[main_stats] ([id], [name]) VALUES (3, N'agility')
SET IDENTITY_INSERT [dbo].[main_stats] OFF
GO
SET IDENTITY_INSERT [dbo].[players] ON 

INSERT [dbo].[players] ([id], [nickname], [login], [password], [mail], [phone], [card], [birthday], [rat_group]) VALUES (1, N'lol', N'lol', N'123', N'dsa@gfd.fd', N'765756756', N'543245234', CAST(N'2004-12-04' AS Date), 312)
INSERT [dbo].[players] ([id], [nickname], [login], [password], [mail], [phone], [card], [birthday], [rat_group]) VALUES (2, N'kek', N'gfdgfd', N'22', NULL, N'5435435435', N'43211111', CAST(N'2000-02-28' AS Date), 543)
INSERT [dbo].[players] ([id], [nickname], [login], [password], [mail], [phone], [card], [birthday], [rat_group]) VALUES (3, N'cheburec', N'kek', N'22', N'fgrfds@gfd.gf', NULL, NULL, CAST(N'2009-09-09' AS Date), 541)
INSERT [dbo].[players] ([id], [nickname], [login], [password], [mail], [phone], [card], [birthday], [rat_group]) VALUES (4, N'a-fds', N'qw', N'a', NULL, NULL, NULL, CAST(N'2001-01-12' AS Date), 3213)
INSERT [dbo].[players] ([id], [nickname], [login], [password], [mail], [phone], [card], [birthday], [rat_group]) VALUES (6, N'asdffff', N'asdffff', N'123', N'afffsa', NULL, NULL, CAST(N'2022-01-02' AS Date), 22)
INSERT [dbo].[players] ([id], [nickname], [login], [password], [mail], [phone], [card], [birthday], [rat_group]) VALUES (7, N'zxc', N'hgf', N'123', N'qq', NULL, NULL, CAST(N'2000-09-22' AS Date), 12)
SET IDENTITY_INSERT [dbo].[players] OFF
GO
SET IDENTITY_INSERT [dbo].[special_abilities] ON 

INSERT [dbo].[special_abilities] ([id], [name]) VALUES (1, N'ewq')
INSERT [dbo].[special_abilities] ([id], [name]) VALUES (2, N'gfdgdf')
INSERT [dbo].[special_abilities] ([id], [name]) VALUES (3, N'gfdhgdfq')
INSERT [dbo].[special_abilities] ([id], [name]) VALUES (4, N'ettg')
SET IDENTITY_INSERT [dbo].[special_abilities] OFF
GO
SET IDENTITY_INSERT [dbo].[weapons] ON 

INSERT [dbo].[weapons] ([id], [title], [description], [type], [special_ability], [attack_range], [attack_speed], [increasing_the_attribute], [damage], [rarity]) VALUES (1, N'фыв', N'выф', N'авы', N'авы', 101, 200, 1233, 3123, N'пав')
INSERT [dbo].[weapons] ([id], [title], [description], [type], [special_ability], [attack_range], [attack_speed], [increasing_the_attribute], [damage], [rarity]) VALUES (2, N'ку', N'выф', N'оим', N'орпа', 154, 543, 321, 2222, N'авы')
INSERT [dbo].[weapons] ([id], [title], [description], [type], [special_ability], [attack_range], [attack_speed], [increasing_the_attribute], [damage], [rarity]) VALUES (3, N'пав', N'рпа', N'пав', N'авпр', 99, 11, 432, 4324, N'апвр')
INSERT [dbo].[weapons] ([id], [title], [description], [type], [special_ability], [attack_range], [attack_speed], [increasing_the_attribute], [damage], [rarity]) VALUES (4, N'рпа', N'рпа', N'рпа', N'рап', 432, 344, 1, 43, N'рапр')
INSERT [dbo].[weapons] ([id], [title], [description], [type], [special_ability], [attack_range], [attack_speed], [increasing_the_attribute], [damage], [rarity]) VALUES (5, N'ewq', N'sdda', N'dfsaf', N'wqww', 100, 321, 33, 32, N'drs')
SET IDENTITY_INSERT [dbo].[weapons] OFF
GO
ALTER TABLE [dbo].[character_weapon]  WITH CHECK ADD  CONSTRAINT [FK_Character_Weapon] FOREIGN KEY([character_id])
REFERENCES [dbo].[characters] ([id])
GO
ALTER TABLE [dbo].[character_weapon] CHECK CONSTRAINT [FK_Character_Weapon]
GO
ALTER TABLE [dbo].[character_weapon]  WITH CHECK ADD  CONSTRAINT [FK_Weapon_Character] FOREIGN KEY([weapon_id])
REFERENCES [dbo].[weapons] ([id])
GO
ALTER TABLE [dbo].[character_weapon] CHECK CONSTRAINT [FK_Weapon_Character]
GO
ALTER TABLE [dbo].[characters]  WITH CHECK ADD  CONSTRAINT [FK_Character_Player] FOREIGN KEY([player_id])
REFERENCES [dbo].[players] ([id])
GO
ALTER TABLE [dbo].[characters] CHECK CONSTRAINT [FK_Character_Player]
GO
ALTER TABLE [dbo].[characters]  WITH CHECK ADD  CONSTRAINT [FK_Class_Character] FOREIGN KEY([class_id])
REFERENCES [dbo].[classes] ([id])
GO
ALTER TABLE [dbo].[characters] CHECK CONSTRAINT [FK_Class_Character]
GO
ALTER TABLE [dbo].[classes]  WITH CHECK ADD  CONSTRAINT [FK_Ability_Class] FOREIGN KEY([special_ability_id])
REFERENCES [dbo].[special_abilities] ([id])
GO
ALTER TABLE [dbo].[classes] CHECK CONSTRAINT [FK_Ability_Class]
GO
ALTER TABLE [dbo].[classes]  WITH CHECK ADD  CONSTRAINT [FK_Stat_Class] FOREIGN KEY([main_stat_id])
REFERENCES [dbo].[main_stats] ([id])
GO
ALTER TABLE [dbo].[classes] CHECK CONSTRAINT [FK_Stat_Class]
GO
USE [master]
GO
ALTER DATABASE [Computer game] SET  READ_WRITE 
GO
