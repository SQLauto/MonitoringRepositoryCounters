CREATE DATABASE Performance_JIRA_ARCH
GO
USE [Performance_JIRA_ARCH]
GO
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[CounterData_1](
	[MachineName] [varchar](50) NOT NULL,
	[CounterID] [int] NOT NULL,
	[CounterDateTime] [char](24) NOT NULL,
	[CounterValue] [float] NOT NULL,
	[CounterValueMax] [float] NOT NULL,
	[CounterValueMin] [float] NOT NULL
) ON [PRIMARY]
GO

SET ANSI_PADDING ON
GO

CREATE NONCLUSTERED INDEX [index_CounterData] ON [dbo].[CounterData_1]
(
	[CounterID] ASC,
	[CounterDateTime] ASC
)
INCLUDE ( 	[CounterValue]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO

SET ANSI_PADDING ON
GO

CREATE NONCLUSTERED INDEX [index_onlyCounterData] ON [dbo].[CounterData_1]
(
	[CounterDateTime] DESC
)
INCLUDE ( 	[CounterID],
	[CounterValue]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO

CREATE TABLE [dbo].[CounterData_10](
	[MachineName] [varchar](50) NOT NULL,
	[CounterID] [int] NOT NULL,
	[CounterDateTime] [char](24) NOT NULL,
	[CounterValue] [float] NOT NULL,
	[CounterValueMax] [float] NOT NULL,
	[CounterValueMin] [float] NOT NULL
) ON [PRIMARY]
GO

SET ANSI_PADDING ON
GO

CREATE NONCLUSTERED INDEX [index_CounterData] ON [dbo].[CounterData_10]
(
	[CounterID] ASC,
	[CounterDateTime] ASC
)
INCLUDE ( 	[CounterValue]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO

SET ANSI_PADDING ON
GO

CREATE NONCLUSTERED INDEX [index_onlyCounterData] ON [dbo].[CounterData_10]
(
	[CounterDateTime] DESC
)
INCLUDE ( 	[CounterID],
	[CounterValue]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
