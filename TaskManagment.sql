USE [TaskManagement]
GO
/****** Object:  UserDefinedFunction [dbo].[fn_GetTaskNameForEmployee]    Script Date: 10/27/2023 3:24:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[fn_GetTaskNameForEmployee] (@EmpName NVARCHAR(50))
RETURNS NVARCHAR(50)
AS
BEGIN
		RETURN (SELECT Top 1 T.[Name] FROM Employee as E LEFT OUTER JOIN EmpTask as ET ON E.EmpId = ET.EmpId
								LEFT OUTER JOIN Task as T ON T.TaskId = ET.TaskId
		WHERE E.EmpName = @EmpName AND T.[Name] IS NOT NULL)

END
GO
/****** Object:  UserDefinedFunction [dbo].[fn_GetTotalTaskForEmployee]    Script Date: 10/27/2023 3:24:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[fn_GetTotalTaskForEmployee] (@EmpName NVARCHAR(50))
RETURNS NVARCHAR(50)
AS
BEGIN
		RETURN (SELECT COUNT(T.[Name]) FROM Employee as E LEFT OUTER JOIN EmpTask as ET ON E.EmpId = ET.EmpId
								LEFT OUTER JOIN Task as T ON T.TaskId = ET.TaskId
		WHERE E.EmpName = @EmpName AND T.[Name] IS NOT NULL)

END
GO
/****** Object:  Table [dbo].[Employee]    Script Date: 10/27/2023 3:24:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Employee](
	[EmpId] [int] IDENTITY(1000,1) NOT NULL,
	[EmpName] [nvarchar](50) NULL,
	[ManagerId] [int] NULL,
	[EmailId] [nvarchar](70) NULL,
	[Doj] [datetime] NULL,
	[IsActive] [bit] NULL,
 CONSTRAINT [PK_Employee] PRIMARY KEY CLUSTERED 
(
	[EmpId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Task]    Script Date: 10/27/2023 3:24:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Task](
	[TaskId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](200) NULL,
	[StartDate] [datetime] NULL,
	[EndDate] [datetime] NULL,
 CONSTRAINT [PK_Task] PRIMARY KEY CLUSTERED 
(
	[TaskId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EmpTask]    Script Date: 10/27/2023 3:24:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EmpTask](
	[EmpId] [int] NOT NULL,
	[TaskId] [int] NOT NULL,
	[IsSubmitted] [bit] NOT NULL,
	[IsCompleted] [bit] NOT NULL,
	[ModifiedOn] [datetime] NOT NULL,
 CONSTRAINT [PK_EmpTask] PRIMARY KEY CLUSTERED 
(
	[EmpId] ASC,
	[TaskId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[vw_EmpTaskNames]    Script Date: 10/27/2023 3:24:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vw_EmpTaskNames] AS
SELECT E.EmpName, T.[Name] FROM Employee as E LEFT OUTER JOIN EmpTask as ET ON E.EmpId = ET.EmpId
						LEFT OUTER JOIN Task as T ON T.TaskId = ET.TaskId
GO
/****** Object:  Table [dbo].[EmployeeBackup]    Script Date: 10/27/2023 3:24:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EmployeeBackup](
	[EmpId] [int] IDENTITY(1000,1) NOT NULL,
	[EmpName] [nvarchar](50) NULL,
	[ManagerId] [int] NULL,
	[EmailId] [nvarchar](70) NULL,
	[Doj] [datetime] NULL,
	[IsActive] [bit] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EmployeeClone]    Script Date: 10/27/2023 3:24:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EmployeeClone](
	[EmpId] [int] IDENTITY(1000,1) NOT NULL,
	[EmpName] [nvarchar](50) NULL,
	[ManagerId] [int] NULL,
	[EmailId] [nvarchar](70) NULL,
	[Doj] [datetime] NULL,
	[IsActive] [bit] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EmpTaskBackUp]    Script Date: 10/27/2023 3:24:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EmpTaskBackUp](
	[EmpId] [int] NOT NULL,
	[TaskId] [int] NOT NULL,
	[IsSubmitted] [bit] NOT NULL,
	[IsCompleted] [bit] NOT NULL,
	[ModifiedOn] [datetime] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TaskBackup]    Script Date: 10/27/2023 3:24:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TaskBackup](
	[TaskId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](200) NULL,
	[StartDate] [datetime] NULL,
	[EndDate] [datetime] NULL
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Employee] ON 

INSERT [dbo].[Employee] ([EmpId], [EmpName], [ManagerId], [EmailId], [Doj], [IsActive]) VALUES (1000, N'Manoj', 1001, N'manoj@kpmg.com', CAST(N'2023-09-10T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[Employee] ([EmpId], [EmpName], [ManagerId], [EmailId], [Doj], [IsActive]) VALUES (1001, N'Garima', 1002, N'garima@kpmg.com', CAST(N'2000-02-04T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[Employee] ([EmpId], [EmpName], [ManagerId], [EmailId], [Doj], [IsActive]) VALUES (1002, N'Sameer Chadda', NULL, N'sameer@kpmg.com', CAST(N'1995-01-10T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[Employee] ([EmpId], [EmpName], [ManagerId], [EmailId], [Doj], [IsActive]) VALUES (1003, N'Benami Guy', 1001, N'benaami@kpmg.com', CAST(N'2021-12-04T00:00:00.000' AS DateTime), 0)
INSERT [dbo].[Employee] ([EmpId], [EmpName], [ManagerId], [EmailId], [Doj], [IsActive]) VALUES (2001, N'Meena', 1002, N'Meena@gmail.com', CAST(N'2012-12-01T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[Employee] ([EmpId], [EmpName], [ManagerId], [EmailId], [Doj], [IsActive]) VALUES (2002, N'Beena', 1002, N'Beena@gmail.com', CAST(N'2012-12-01T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[Employee] ([EmpId], [EmpName], [ManagerId], [EmailId], [Doj], [IsActive]) VALUES (2003, N'Teena', 1002, N'Teena@gmail.com', CAST(N'2012-12-01T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[Employee] ([EmpId], [EmpName], [ManagerId], [EmailId], [Doj], [IsActive]) VALUES (2004, N'Reena', 1002, N'Reena@gmail.com', CAST(N'2012-12-01T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[Employee] ([EmpId], [EmpName], [ManagerId], [EmailId], [Doj], [IsActive]) VALUES (2005, N'Manoj', 1001, N'manoj@kpmg.com', CAST(N'2023-09-10T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[Employee] ([EmpId], [EmpName], [ManagerId], [EmailId], [Doj], [IsActive]) VALUES (2006, N'Garima', 1002, N'garima@kpmg.com', CAST(N'2000-02-04T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[Employee] ([EmpId], [EmpName], [ManagerId], [EmailId], [Doj], [IsActive]) VALUES (2007, N'Sameer Chadda', NULL, N'sameer@kpmg.com', CAST(N'1995-01-10T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[Employee] ([EmpId], [EmpName], [ManagerId], [EmailId], [Doj], [IsActive]) VALUES (2008, N'Benami Guy', 1001, N'benaami@kpmg.com', CAST(N'2021-12-04T00:00:00.000' AS DateTime), 0)
INSERT [dbo].[Employee] ([EmpId], [EmpName], [ManagerId], [EmailId], [Doj], [IsActive]) VALUES (2009, N'Meena', 1002, N'Meena@gmail.com', CAST(N'2012-12-01T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[Employee] ([EmpId], [EmpName], [ManagerId], [EmailId], [Doj], [IsActive]) VALUES (2010, N'Beena', 1002, N'Beena@gmail.com', CAST(N'2012-12-01T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[Employee] ([EmpId], [EmpName], [ManagerId], [EmailId], [Doj], [IsActive]) VALUES (2011, N'Teena', 1002, N'Teena@gmail.com', CAST(N'2012-12-01T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[Employee] ([EmpId], [EmpName], [ManagerId], [EmailId], [Doj], [IsActive]) VALUES (2012, N'Reena', 1002, N'Reena@gmail.com', CAST(N'2012-12-01T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[Employee] ([EmpId], [EmpName], [ManagerId], [EmailId], [Doj], [IsActive]) VALUES (3001, N'Beena', 1002, N'Beena@gmail.com', CAST(N'2012-12-01T00:00:00.000' AS DateTime), 1)
SET IDENTITY_INSERT [dbo].[Employee] OFF
GO
SET IDENTITY_INSERT [dbo].[EmployeeBackup] ON 

INSERT [dbo].[EmployeeBackup] ([EmpId], [EmpName], [ManagerId], [EmailId], [Doj], [IsActive]) VALUES (1000, N'Manoj', 1001, N'manoj@kpmg.com', CAST(N'2023-09-10T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[EmployeeBackup] ([EmpId], [EmpName], [ManagerId], [EmailId], [Doj], [IsActive]) VALUES (1001, N'Garima', 1002, N'garima@kpmg.com', CAST(N'2000-02-04T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[EmployeeBackup] ([EmpId], [EmpName], [ManagerId], [EmailId], [Doj], [IsActive]) VALUES (1003, N'Benami Guy', 1001, N'benaami@kpmg.com', CAST(N'2021-12-04T00:00:00.000' AS DateTime), 0)
INSERT [dbo].[EmployeeBackup] ([EmpId], [EmpName], [ManagerId], [EmailId], [Doj], [IsActive]) VALUES (2001, N'Meena', 1002, N'Meena@gmail.com', CAST(N'2012-12-01T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[EmployeeBackup] ([EmpId], [EmpName], [ManagerId], [EmailId], [Doj], [IsActive]) VALUES (2002, N'Beena', 1002, N'Beena@gmail.com', CAST(N'2012-12-01T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[EmployeeBackup] ([EmpId], [EmpName], [ManagerId], [EmailId], [Doj], [IsActive]) VALUES (2003, N'Teena', 1002, N'Teena@gmail.com', CAST(N'2012-12-01T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[EmployeeBackup] ([EmpId], [EmpName], [ManagerId], [EmailId], [Doj], [IsActive]) VALUES (2004, N'Reena', 1002, N'Reena@gmail.com', CAST(N'2012-12-01T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[EmployeeBackup] ([EmpId], [EmpName], [ManagerId], [EmailId], [Doj], [IsActive]) VALUES (2005, N'Manoj', 1001, N'manoj@kpmg.com', CAST(N'2023-09-10T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[EmployeeBackup] ([EmpId], [EmpName], [ManagerId], [EmailId], [Doj], [IsActive]) VALUES (2006, N'Garima', 1002, N'garima@kpmg.com', CAST(N'2000-02-04T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[EmployeeBackup] ([EmpId], [EmpName], [ManagerId], [EmailId], [Doj], [IsActive]) VALUES (2008, N'Benami Guy', 1001, N'benaami@kpmg.com', CAST(N'2021-12-04T00:00:00.000' AS DateTime), 0)
INSERT [dbo].[EmployeeBackup] ([EmpId], [EmpName], [ManagerId], [EmailId], [Doj], [IsActive]) VALUES (2009, N'Meena', 1002, N'Meena@gmail.com', CAST(N'2012-12-01T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[EmployeeBackup] ([EmpId], [EmpName], [ManagerId], [EmailId], [Doj], [IsActive]) VALUES (2010, N'Beena', 1002, N'Beena@gmail.com', CAST(N'2012-12-01T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[EmployeeBackup] ([EmpId], [EmpName], [ManagerId], [EmailId], [Doj], [IsActive]) VALUES (2011, N'Teena', 1002, N'Teena@gmail.com', CAST(N'2012-12-01T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[EmployeeBackup] ([EmpId], [EmpName], [ManagerId], [EmailId], [Doj], [IsActive]) VALUES (2012, N'Reena', 1002, N'Reena@gmail.com', CAST(N'2012-12-01T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[EmployeeBackup] ([EmpId], [EmpName], [ManagerId], [EmailId], [Doj], [IsActive]) VALUES (3001, N'Beena', 1002, N'Beena@gmail.com', CAST(N'2012-12-01T00:00:00.000' AS DateTime), 1)
SET IDENTITY_INSERT [dbo].[EmployeeBackup] OFF
GO
INSERT [dbo].[EmpTask] ([EmpId], [TaskId], [IsSubmitted], [IsCompleted], [ModifiedOn]) VALUES (1000, 1, 0, 0, CAST(N'2023-10-25T00:00:00.000' AS DateTime))
INSERT [dbo].[EmpTask] ([EmpId], [TaskId], [IsSubmitted], [IsCompleted], [ModifiedOn]) VALUES (1000, 2, 0, 0, CAST(N'2023-10-25T00:00:00.000' AS DateTime))
GO
INSERT [dbo].[EmpTaskBackUp] ([EmpId], [TaskId], [IsSubmitted], [IsCompleted], [ModifiedOn]) VALUES (1000, 1, 0, 0, CAST(N'2023-10-25T00:00:00.000' AS DateTime))
INSERT [dbo].[EmpTaskBackUp] ([EmpId], [TaskId], [IsSubmitted], [IsCompleted], [ModifiedOn]) VALUES (1000, 2, 0, 0, CAST(N'2023-10-25T00:00:00.000' AS DateTime))
INSERT [dbo].[EmpTaskBackUp] ([EmpId], [TaskId], [IsSubmitted], [IsCompleted], [ModifiedOn]) VALUES (999, 999, 0, 0, CAST(N'2023-10-27T00:00:00.000' AS DateTime))
GO
SET IDENTITY_INSERT [dbo].[Task] ON 

INSERT [dbo].[Task] ([TaskId], [Name], [StartDate], [EndDate]) VALUES (1, N'Creating Tables for DAY 1', CAST(N'2023-10-25T00:00:00.000' AS DateTime), CAST(N'2023-10-25T00:00:00.000' AS DateTime))
INSERT [dbo].[Task] ([TaskId], [Name], [StartDate], [EndDate]) VALUES (2, N'Sql Queries', CAST(N'2023-10-26T00:00:00.000' AS DateTime), CAST(N'2023-10-27T00:00:00.000' AS DateTime))
INSERT [dbo].[Task] ([TaskId], [Name], [StartDate], [EndDate]) VALUES (1002, N'Coding', CAST(N'2023-10-25T00:00:00.000' AS DateTime), CAST(N'2023-12-18T00:00:00.000' AS DateTime))
INSERT [dbo].[Task] ([TaskId], [Name], [StartDate], [EndDate]) VALUES (1003, N'Coding', CAST(N'2023-10-25T00:00:00.000' AS DateTime), CAST(N'2023-12-18T00:00:00.000' AS DateTime))
INSERT [dbo].[Task] ([TaskId], [Name], [StartDate], [EndDate]) VALUES (1004, N'Designing', CAST(N'2023-10-25T00:00:00.000' AS DateTime), CAST(N'2023-12-18T00:00:00.000' AS DateTime))
INSERT [dbo].[Task] ([TaskId], [Name], [StartDate], [EndDate]) VALUES (1005, N'Testing', CAST(N'2023-10-25T00:00:00.000' AS DateTime), CAST(N'2023-12-18T00:00:00.000' AS DateTime))
INSERT [dbo].[Task] ([TaskId], [Name], [StartDate], [EndDate]) VALUES (1006, N'DAY1 Lab work', CAST(N'2023-10-25T00:00:00.000' AS DateTime), CAST(N'2023-12-18T00:00:00.000' AS DateTime))
INSERT [dbo].[Task] ([TaskId], [Name], [StartDate], [EndDate]) VALUES (1007, N'DAY2 Lab work', CAST(N'2023-10-25T00:00:00.000' AS DateTime), CAST(N'2023-12-18T00:00:00.000' AS DateTime))
INSERT [dbo].[Task] ([TaskId], [Name], [StartDate], [EndDate]) VALUES (1008, N'DAY3 Lab work', CAST(N'2023-10-25T00:00:00.000' AS DateTime), CAST(N'2023-12-18T00:00:00.000' AS DateTime))
INSERT [dbo].[Task] ([TaskId], [Name], [StartDate], [EndDate]) VALUES (1009, N'DAY4 Lab work', CAST(N'2023-10-25T00:00:00.000' AS DateTime), CAST(N'2023-12-18T00:00:00.000' AS DateTime))
SET IDENTITY_INSERT [dbo].[Task] OFF
GO
SET IDENTITY_INSERT [dbo].[TaskBackup] ON 

INSERT [dbo].[TaskBackup] ([TaskId], [Name], [StartDate], [EndDate]) VALUES (1002, N'DAY1 Lab work', CAST(N'2023-10-25T00:00:00.000' AS DateTime), CAST(N'2023-12-18T00:00:00.000' AS DateTime))
INSERT [dbo].[TaskBackup] ([TaskId], [Name], [StartDate], [EndDate]) VALUES (1003, N'DAY2 Lab work', CAST(N'2023-10-25T00:00:00.000' AS DateTime), CAST(N'2023-12-18T00:00:00.000' AS DateTime))
INSERT [dbo].[TaskBackup] ([TaskId], [Name], [StartDate], [EndDate]) VALUES (1004, N'DAY3 Lab work', CAST(N'2023-10-25T00:00:00.000' AS DateTime), CAST(N'2023-12-18T00:00:00.000' AS DateTime))
INSERT [dbo].[TaskBackup] ([TaskId], [Name], [StartDate], [EndDate]) VALUES (1005, N'DAY4 Lab work', CAST(N'2023-10-25T00:00:00.000' AS DateTime), CAST(N'2023-12-18T00:00:00.000' AS DateTime))
SET IDENTITY_INSERT [dbo].[TaskBackup] OFF
GO
ALTER TABLE [dbo].[EmpTask]  WITH NOCHECK ADD  CONSTRAINT [FK_EmpTask_Employee] FOREIGN KEY([EmpId])
REFERENCES [dbo].[Employee] ([EmpId])
GO
ALTER TABLE [dbo].[EmpTask] NOCHECK CONSTRAINT [FK_EmpTask_Employee]
GO
ALTER TABLE [dbo].[EmpTask]  WITH CHECK ADD  CONSTRAINT [FK_EmpTask_Task] FOREIGN KEY([TaskId])
REFERENCES [dbo].[Task] ([TaskId])
GO
ALTER TABLE [dbo].[EmpTask] CHECK CONSTRAINT [FK_EmpTask_Task]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetEmpTaskNames]    Script Date: 10/27/2023 3:24:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_GetEmpTaskNames] AS
SELECT E.EmpName, T.[Name] FROM Employee as E LEFT OUTER JOIN EmpTask as ET ON E.EmpId = ET.EmpId
						LEFT OUTER JOIN Task as T ON T.TaskId = ET.TaskId
GO
/****** Object:  StoredProcedure [dbo].[sp_GetTaskNameForEmployee]    Script Date: 10/27/2023 3:24:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_GetTaskNameForEmployee] @EmpName NVARCHAR(50)
AS
SELECT E.EmpName, T.[Name] FROM Employee as E LEFT OUTER JOIN EmpTask as ET ON E.EmpId = ET.EmpId
						LEFT OUTER JOIN Task as T ON T.TaskId = ET.TaskId
WHERE E.EmpName = @EmpName AND T.[Name] IS NOT NULL
GO
