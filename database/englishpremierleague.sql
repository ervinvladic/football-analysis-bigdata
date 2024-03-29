USE [EnglishPremierLeague]
GO
/****** Object:  Table [dbo].[EnglishPremierLeague]    Script Date: 14/02/2024 09:40:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EnglishPremierLeague](
	[Date] [date] NULL,
	[HomeTeam] [nvarchar](100) NULL,
	[AwayTeam] [nvarchar](100) NULL,
	[FTHG] [int] NULL,
	[FTAG] [int] NULL,
	[FTR] [char](1) NULL,
	[HTHG] [int] NULL,
	[HTAG] [int] NULL,
	[HTR] [char](1) NULL,
	[Referee] [nvarchar](100) NULL,
	[HomeShots] [int] NULL,
	[AwayShots] [int] NULL,
	[HomeShotsOnTarget] [int] NULL,
	[AwayShotsOnTarget] [int] NULL,
	[HomeFouls] [int] NULL,
	[AwayFouls] [int] NULL,
	[HomeCorners] [int] NULL,
	[AwayCorners] [int] NULL,
	[HomeYellowCards] [int] NULL,
	[AwayYellowCards] [int] NULL,
	[HomeRedCards] [int] NULL,
	[AwayRedCards] [int] NULL
) ON [PRIMARY]
GO
