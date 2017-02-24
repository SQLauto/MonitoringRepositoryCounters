--------------------
-- Baza liczników --
--------------------
USE [master]
GO
-- 
CREATE DATABASE [MONITORSQL1_counters]
GO
----------
-- ODBC --
----------
USE [master]
GO
CREATE LOGIN [DOMAIN\HOST1$] FROM WINDOWS WITH DEFAULT_DATABASE=[MONITORSQL1_counters]
GO
USE [MONITORSQL1_counters]
GO
CREATE USER [DOMAIN\HOST1$] FOR LOGIN [DOMAIN\HOST1$]
GO
USE [MONITORSQL1_counters]
GO
ALTER ROLE [db_datareader] ADD MEMBER [DOMAIN\HOST1$]
GO
USE [MONITORSQL1_counters]
GO
ALTER ROLE [db_datawriter] ADD MEMBER [DOMAIN\HOST1$]
GO
USE [MONITORSQL1_counters]
GO
ALTER ROLE [db_ddladmin] ADD MEMBER [DOMAIN\HOST1$]
GO
--------------------------------
-- Przeglądamy dane liczników --
--------------------------------
  SELECT TOP (10)
	   Details.MachineName
	  ,Details.ObjectName
	  ,Details.CounterName
	  ,Details.InstanceName
      ,Data.CounterDateTime
      ,Data.CounterValue
  FROM MONITORSQL1_counters.dbo.CounterData AS Data
  LEFT JOIN MONITORSQL1_counters.dbo.CounterDetails AS Details 
	ON Data.CounterID = Details.CounterID
  WHERE Details.MachineName = '\\MONITORSQL1'
	AND Details.ObjectName = 'Processor'
	AND Details.CounterName = '% Processor Time'
	AND Details.InstanceName = '_Total'
  ORDER BY CounterDateTime DESC
  --
    SELECT 
	   Details.MachineName
	  ,Details.ObjectName
	  ,Details.CounterName
	  ,Details.InstanceName
      ,CONVERT(CHAR(13), Data.CounterDateTime, 121) AS DateTimeHourly
      ,FORMAT(MIN(Data.CounterValue), '##0.00') AS MinValue
	  ,FORMAT(AVG(Data.CounterValue), '##0.00') AS AvgValue
	  ,FORMAT(MAX(Data.CounterValue), '##0.00') AS MaxValue
	  ,COUNT(Data.CounterValue) AS NmbOfSamples
  FROM MONITORSQL1_counters.dbo.CounterData AS Data
  LEFT JOIN MONITORSQL1_counters.dbo.CounterDetails AS Details 
	ON Data.CounterID = Details.CounterID
  WHERE Details.MachineName = '\\MONITORSQL1'
	AND Details.ObjectName = 'Processor'
	AND Details.CounterName = '% Processor Time'
	AND Details.InstanceName = '_Total'
	AND Data.CounterDateTime > CONVERT(CHAR(19), DATEADD(DAY, -1, SYSDATETIME()), 121)
  GROUP BY  Details.MachineName, Details.ObjectName, Details.CounterName, Details.InstanceName, CONVERT(CHAR(13), Data.CounterDateTime, 121)
  ORDER BY DateTimeHourly ASC
  --
  SELECT 
	   Details.MachineName
	  ,Details.ObjectName
	  ,Details.CounterName
	  ,Details.InstanceName
      ,CONVERT(CHAR(10), Data.CounterDateTime, 121) AS DateTimeDaily
      ,FORMAT(MIN(Data.CounterValue), '##0.00') AS MinValue
	  ,FORMAT(AVG(Data.CounterValue), '##0.00') AS AvgValue
	  ,FORMAT(MAX(Data.CounterValue), '##0.00') AS MaxValue
	  ,MIN(Data.CounterDateTime) AS MinDataSample
	  ,MAX(Data.CounterDateTime) AS MaxDataSample
	  ,COUNT(Data.CounterValue) AS NmbOfSamples
  FROM MONITORSQL1_counters.dbo.CounterData AS Data
  LEFT JOIN MONITORSQL1_counters.dbo.CounterDetails AS Details 
	ON Data.CounterID = Details.CounterID
  WHERE Details.MachineName = '\\MONITORSQL1'
	AND Details.ObjectName = 'Processor'
	AND Details.CounterName = '% Processor Time'
	AND Details.InstanceName = '_Total'
	AND Data.CounterDateTime > CONVERT(CHAR(19), DATEADD(DAY, -7, SYSDATETIME()), 121)
	AND CAST(SUBSTRING(Data.CounterDateTime, 12, 2) AS TINYINT) BETWEEN 8 AND 15
  GROUP BY  Details.MachineName, Details.ObjectName, Details.CounterName, Details.InstanceName, CONVERT(CHAR(10), Data.CounterDateTime, 121)
  ORDER BY DateTimeDaily ASC
  --
  SELECT  DISTINCT
	CONVERT(CHAR(10), Data.CounterDateTime, 121) AS DateTimeDaily
	,PERCENTILE_CONT(0.50) WITHIN GROUP (ORDER BY Data.CounterValue) OVER (PARTITION BY CONVERT(CHAR(10), Data.CounterDateTime, 121)) AS cpu_time_50th
	,PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY Data.CounterValue) OVER (PARTITION BY CONVERT(CHAR(10), Data.CounterDateTime, 121)) AS cpu_time_75th
    ,PERCENTILE_CONT(0.90) WITHIN GROUP (ORDER BY Data.CounterValue) OVER (PARTITION BY CONVERT(CHAR(10), Data.CounterDateTime, 121)) AS cpu_time_90th
    ,PERCENTILE_CONT(0.95) WITHIN GROUP (ORDER BY Data.CounterValue) OVER (PARTITION BY CONVERT(CHAR(10), Data.CounterDateTime, 121)) AS cpu_time_95th
    ,PERCENTILE_CONT(0.99) WITHIN GROUP (ORDER BY Data.CounterValue) OVER (PARTITION BY CONVERT(CHAR(10), Data.CounterDateTime, 121)) AS cpu_time_99th
  FROM MONITORSQL1_counters.dbo.CounterData AS Data
  LEFT JOIN MONITORSQL1_counters.dbo.CounterDetails AS Details 
	ON Data.CounterID = Details.CounterID
	WHERE Details.MachineName = '\\MONITORSQL1'
	AND Details.ObjectName = 'Processor'
	AND Details.CounterName = '% Processor Time'
	AND Details.InstanceName = '_Total'
	AND Data.CounterDateTime > CONVERT(CHAR(19), DATEADD(DAY, -7, SYSDATETIME()), 121)
	AND CAST(SUBSTRING(Data.CounterDateTime, 12, 2) AS TINYINT) BETWEEN 8 AND 15
  ORDER BY DateTimeDaily
  --
    SELECT Details.MachineName
	  ,Details.ObjectName
	  ,Details.CounterName
	  ,Details.InstanceName
      ,Data.CounterDateTime
      ,Data.CounterValue
  FROM MONITORSQL1_counters.dbo.CounterData AS Data
  LEFT JOIN MONITORSQL1_counters.dbo.CounterDetails AS Details 
	ON Data.CounterID = Details.CounterID
	WHERE Details.MachineName = '\\MONITORSQL1'
	AND Details.ObjectName = 'Processor'
	AND Details.CounterName = '% Processor Time'
	AND Details.InstanceName = '_Total'
	AND Data.CounterDateTime BETWEEN '2017-01-30 08:00:00' AND '2017-01-30 15:59:59'
	AND Data.CounterValue >= 12.3041842489041
-------------------------------
-- Konserwacja bazy pomiarów --
-------------------------------
USE [MONITORSQL1_counters]
GO
CREATE NONCLUSTERED INDEX [IX_CounterID_INCL_TimeAndValue]
ON [dbo].[CounterData] ([CounterID])
INCLUDE ([CounterDateTime],[CounterValue])
GO


  
