USE [MoviesDb]
GO
/****** Object:  StoredProcedure [dbo].[sp_InsertMovie]    Script Date: 8/25/2022 11:30:42 AM ******/
DROP PROCEDURE [dbo].[sp_InsertMovie]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetNamesThatStartWithI]    Script Date: 8/25/2022 11:30:42 AM ******/
DROP PROCEDURE [dbo].[sp_GetNamesThatStartWithI]
GO
/****** Object:  StoredProcedure [dbo].[sp_DeleteUsingTransaction]    Script Date: 8/25/2022 11:30:42 AM ******/
DROP PROCEDURE [dbo].[sp_DeleteUsingTransaction]
GO
ALTER TABLE [dbo].[MovieTheatre] DROP CONSTRAINT [FK_MovieTheatre_Theatre]
GO
ALTER TABLE [dbo].[MovieTheatre] DROP CONSTRAINT [FK_MovieTheatre_Movies]
GO
ALTER TABLE [dbo].[AuditLog] DROP CONSTRAINT [DF_AuditLog_Id]
GO
/****** Object:  Table [dbo].[Theatre]    Script Date: 8/25/2022 11:30:42 AM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Theatre]') AND type in (N'U'))
DROP TABLE [dbo].[Theatre]
GO
/****** Object:  Table [dbo].[TheateMovieScreen]    Script Date: 8/25/2022 11:30:42 AM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TheateMovieScreen]') AND type in (N'U'))
DROP TABLE [dbo].[TheateMovieScreen]
GO
/****** Object:  Table [dbo].[MovieTheatre]    Script Date: 8/25/2022 11:30:42 AM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[MovieTheatre]') AND type in (N'U'))
DROP TABLE [dbo].[MovieTheatre]
GO
/****** Object:  Table [dbo].[AuditLog]    Script Date: 8/25/2022 11:30:42 AM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AuditLog]') AND type in (N'U'))
DROP TABLE [dbo].[AuditLog]
GO
/****** Object:  Table [dbo].[__EFMigrationsHistory]    Script Date: 8/25/2022 11:30:42 AM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[__EFMigrationsHistory]') AND type in (N'U'))
DROP TABLE [dbo].[__EFMigrationsHistory]
GO
/****** Object:  View [dbo].[vw_Movies]    Script Date: 8/25/2022 11:30:42 AM ******/
DROP VIEW [dbo].[vw_Movies]
GO
/****** Object:  Table [dbo].[Movies]    Script Date: 8/25/2022 11:30:42 AM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Movies]') AND type in (N'U'))
DROP TABLE [dbo].[Movies]
GO
/****** Object:  UserDefinedFunction [dbo].[fn_GetTheatreCountForMovie]    Script Date: 8/25/2022 11:30:42 AM ******/
DROP FUNCTION [dbo].[fn_GetTheatreCountForMovie]
GO
/****** Object:  UserDefinedFunction [dbo].[fn_GetOutputs]    Script Date: 8/25/2022 11:30:42 AM ******/
DROP FUNCTION [dbo].[fn_GetOutputs]
GO
/****** Object:  UserDefinedFunction [dbo].[fn_Get]    Script Date: 8/25/2022 11:30:42 AM ******/
DROP FUNCTION [dbo].[fn_Get]
GO
/****** Object:  UserDefinedFunction [dbo].[fn_Get]    Script Date: 8/25/2022 11:30:42 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[fn_Get] ()
RETURNS int
AS
BEGIN 
  RETURN (SELECT Count(*) from Movies)
END
GO
/****** Object:  UserDefinedFunction [dbo].[fn_GetOutputs]    Script Date: 8/25/2022 11:30:43 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[fn_GetOutputs](@movieId INT)
RETURNS @Result Table (Col1 INT, Col2 INT)
AS
BEGIN
DECLARE @Output1 INT
DECLARE @Output2 INT
DECLARE @Variable1 INT
SET @Variable1 = @movieId
SET @Output1 = (SELECT [dbo].[fn_Get]())
SET @Output2 = (SELECT [dbo].[fn_GetTheatreCountForMovie](@Variable1))
Insert into @Result SELECT @Output1 O1, @Output2 O2
RETURN
END
GO
/****** Object:  UserDefinedFunction [dbo].[fn_GetTheatreCountForMovie]    Script Date: 8/25/2022 11:30:43 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[fn_GetTheatreCountForMovie](@movieId INT)
RETURNS int
AS
BEGIN
RETURN (select count(*) from MovieTheatre where MovieId=@movieId)
END
GO
/****** Object:  Table [dbo].[Movies]    Script Date: 8/25/2022 11:30:43 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Movies](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](max) NOT NULL,
	[Director] [nvarchar](max) NOT NULL,
	[Producer] [nvarchar](max) NOT NULL,
	[Budget] [float] NOT NULL,
 CONSTRAINT [PK_Movies] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [dbo].[vw_Movies]    Script Date: 8/25/2022 11:30:43 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vw_Movies] AS
select * from Movies
GO
/****** Object:  Table [dbo].[__EFMigrationsHistory]    Script Date: 8/25/2022 11:30:43 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[__EFMigrationsHistory](
	[MigrationId] [nvarchar](150) NOT NULL,
	[ProductVersion] [nvarchar](32) NOT NULL,
 CONSTRAINT [PK___EFMigrationsHistory] PRIMARY KEY CLUSTERED 
(
	[MigrationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AuditLog]    Script Date: 8/25/2022 11:30:43 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AuditLog](
	[Id] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[Message] [nvarchar](max) NULL,
 CONSTRAINT [PK_AuditLog] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MovieTheatre]    Script Date: 8/25/2022 11:30:43 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MovieTheatre](
	[MovieId] [int] NOT NULL,
	[TheatreId] [int] NOT NULL,
 CONSTRAINT [PK_MovieTheatre] PRIMARY KEY CLUSTERED 
(
	[MovieId] ASC,
	[TheatreId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TheateMovieScreen]    Script Date: 8/25/2022 11:30:43 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TheateMovieScreen](
	[TheatreId] [int] NOT NULL,
	[MovieId] [int] NULL,
	[ScreenId] [int] NOT NULL,
 CONSTRAINT [PK_TheateMovieScreen] PRIMARY KEY CLUSTERED 
(
	[TheatreId] ASC,
	[ScreenId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Theatre]    Script Date: 8/25/2022 11:30:43 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Theatre](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](max) NOT NULL,
	[Location] [nvarchar](max) NOT NULL,
	[TotalScreens] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_Theatre] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20220810102136_v1', N'6.0.8')
GO
INSERT [dbo].[AuditLog] ([Id], [Message]) VALUES (N'5d2dee6f-e241-4e70-9700-303ab932abea', N'Sample msg')
INSERT [dbo].[AuditLog] ([Id], [Message]) VALUES (N'2e916135-5910-4b21-949c-f718621765da', N'Movie entry inserted with MovieName = Jumanji and Id = 2011AT Aug 24 2022  4:53PM')
INSERT [dbo].[AuditLog] ([Id], [Message]) VALUES (N'65cd5a95-d7d6-4e1b-98d4-fbbbff9f3b7d', N'Sample msg')
GO
SET IDENTITY_INSERT [dbo].[Movies] ON 

INSERT [dbo].[Movies] ([Id], [Name], [Director], [Producer], [Budget]) VALUES (1, N'Inception', N'Christopher', N'Christopher', 100000000000)
INSERT [dbo].[Movies] ([Id], [Name], [Director], [Producer], [Budget]) VALUES (2, N'Intersteller', N'David', N'David', 500000000)
INSERT [dbo].[Movies] ([Id], [Name], [Director], [Producer], [Budget]) VALUES (3, N'Good Fellas', N'Martin', N'WB', 2309909)
INSERT [dbo].[Movies] ([Id], [Name], [Director], [Producer], [Budget]) VALUES (1008, N'Suicide Squad', N'James Gunn', N'DC', 23423423)
INSERT [dbo].[Movies] ([Id], [Name], [Director], [Producer], [Budget]) VALUES (1009, N'Dobara', N'Some Phattu', N'Anarag Kashyap', 1000000)
INSERT [dbo].[Movies] ([Id], [Name], [Director], [Producer], [Budget]) VALUES (2009, N'Gangubai', N'SLB', N'SLB', 84309203)
INSERT [dbo].[Movies] ([Id], [Name], [Director], [Producer], [Budget]) VALUES (2010, N'Annabele', N'Ramsay Bros', N'Ramsay Bros', 84309203)
INSERT [dbo].[Movies] ([Id], [Name], [Director], [Producer], [Budget]) VALUES (2011, N'Jumanji', N'David Dhawan', N'David Dhawan', 2990000)
SET IDENTITY_INSERT [dbo].[Movies] OFF
GO
INSERT [dbo].[MovieTheatre] ([MovieId], [TheatreId]) VALUES (1, 1)
INSERT [dbo].[MovieTheatre] ([MovieId], [TheatreId]) VALUES (1, 2)
INSERT [dbo].[MovieTheatre] ([MovieId], [TheatreId]) VALUES (1, 3)
INSERT [dbo].[MovieTheatre] ([MovieId], [TheatreId]) VALUES (2, 2)
INSERT [dbo].[MovieTheatre] ([MovieId], [TheatreId]) VALUES (3, 1)
INSERT [dbo].[MovieTheatre] ([MovieId], [TheatreId]) VALUES (3, 3)
INSERT [dbo].[MovieTheatre] ([MovieId], [TheatreId]) VALUES (1008, 1)
GO
SET IDENTITY_INSERT [dbo].[Theatre] ON 

INSERT [dbo].[Theatre] ([Id], [Name], [Location], [TotalScreens]) VALUES (1, N'PVR-Koramangala', N'Koramangala', N'10')
INSERT [dbo].[Theatre] ([Id], [Name], [Location], [TotalScreens]) VALUES (2, N'Inox', N'WhiteField', N'7')
INSERT [dbo].[Theatre] ([Id], [Name], [Location], [TotalScreens]) VALUES (3, N'PVR-Bellandur', N'Bellandur', N'5')
SET IDENTITY_INSERT [dbo].[Theatre] OFF
GO
ALTER TABLE [dbo].[AuditLog] ADD  CONSTRAINT [DF_AuditLog_Id]  DEFAULT (newid()) FOR [Id]
GO
ALTER TABLE [dbo].[MovieTheatre]  WITH CHECK ADD  CONSTRAINT [FK_MovieTheatre_Movies] FOREIGN KEY([MovieId])
REFERENCES [dbo].[Movies] ([Id])
GO
ALTER TABLE [dbo].[MovieTheatre] CHECK CONSTRAINT [FK_MovieTheatre_Movies]
GO
ALTER TABLE [dbo].[MovieTheatre]  WITH CHECK ADD  CONSTRAINT [FK_MovieTheatre_Theatre] FOREIGN KEY([TheatreId])
REFERENCES [dbo].[Theatre] ([Id])
GO
ALTER TABLE [dbo].[MovieTheatre] CHECK CONSTRAINT [FK_MovieTheatre_Theatre]
GO
/****** Object:  StoredProcedure [dbo].[sp_DeleteUsingTransaction]    Script Date: 8/25/2022 11:30:43 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_DeleteUsingTransaction]
@Id INT
AS
BEGIN
BEGIN TRANSACTION T1 
DELETE FROM [dbo].[MovieTheatre]
      WHERE MovieId = @Id

IF @@Error <> 0
	ROLLBACK Transaction T1

DELETE FROM [dbo].[Movies]
      WHERE Id = @Id

IF @@Error <> 0
	ROLLBACK Transaction T1

PRINT 'Value of @@Error= ' + CAST(@@Error as varchar)

COMMIT TRANSACTION T1
END
GO
/****** Object:  StoredProcedure [dbo].[sp_GetNamesThatStartWithI]    Script Date: 8/25/2022 11:30:43 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_GetNamesThatStartWithI] AS
select * from Movies Where Name LIKE 'I%' ORDER BY Id,Name DESC
GO
/****** Object:  StoredProcedure [dbo].[sp_InsertMovie]    Script Date: 8/25/2022 11:30:43 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_InsertMovie]
@Name nvarchar(max),
@Director nvarchar(max),
@Producer nvarchar(max),
@Budget float
AS
BEGIN
INSERT INTO [dbo].[Movies]
           ([Name]
           ,[Director]
           ,[Producer]
           ,[Budget])
     VALUES
           (@Name
           ,@Director
           ,@Producer
           ,@Budget)

PRINT 'The value for movie id is: '+ CAST(@@Identity as Varchar)
END
GO
