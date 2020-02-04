USE [Performance_Global]
GO
DECLARE @RepositoriumName VARCHAR(100)
DECLARE @MachineName VARCHAR(100)
DECLARE @InstanceName VARCHAR(100)
DECLARE @Enable INT 
DECLARE @ONLY_WINDOWS BIT = 0
DECLARE @Recipients NVARCHAR(200)
--------------------------------------------------
SET @RepositoriumName = 'CRM'
SET @MachineName = '\\HostName'
SET @InstanceName = 'SQLServer:' -- standardowo 'SQLServer:' lub instancja MSSQL$InstanceName:
SET @Enable = 1
SET @ONLY_WINDOWS = 0;
SET @Recipients = N'MSSQL_Admins@domain.com'
--------------------------------------------------
--PROCESOR--
DECLARE @Processor VARCHAR(100)
SET @Processor = '50'
DECLARE @ProcessorQueue VARCHAR(100)
SET @ProcessorQueue = '8'
--DYSKI--
DECLARE @FreeSpacePct VARCHAR(100)
SET @FreeSpacePct = '2'
DECLARE @FreeMegabytes VARCHAR(100)
SET @FreeMegabytes = '1000'
DECLARE @IdleTime VARCHAR(100)
SET @IdleTime = '35'
--PAMIĘĆ--
DECLARE @AvailableMB VARCHAR(100)
SET @AvailableMB = '256'
--SIEĆ--
DECLARE @NetworkQueue VARCHAR(100)
SET @NetworkQueue = '2'
--PAMIĘĆ--
DECLARE @BufferCacheHR VARCHAR(100)
SET @BufferCacheHR = '80'
DECLARE @PlanCacheHR VARCHAR(100)
SET @PlanCacheHR = '80'
DECLARE @PLE VARCHAR(100)
SET @PLE = '300'
--BAZY--
DECLARE @LogUsed VARCHAR(100)
SET @LogUsed = '80'
DECLARE @AvgTimeWait_ms VARCHAR(100)
SET @AvgTimeWait_ms = '15000'
DECLARE @UserConnections VARCHAR(100)
SET @UserConnections = '250'
DECLARE @Latches VARCHAR(100)
SET @Latches = '10'
DECLARE @NetworkIO VARCHAR(100)
SET @NetworkIO = '0'
--TIME--
DECLARE @HowLongWait INT
SET @HowLongWait = 5
DECLARE @MaxLongTime INT
SET @MaxLongTime = 10
---------------------------------------------------------
IF (@ONLY_WINDOWS = 0)
BEGIN
    -- SQL --
    INSERT [dbo].[AlertsDefinitions] ([RepositoriumName], [MachineName], [ObjectName], [CounterName], [InstanceName], [Symbol], [Whichbad], [Value], [Enable], [CurrentLevel], [EmailList], [HoursStart], [HoursEnd], [HowLongWait], [MaxLongTime]) VALUES (@RepositoriumName, @MachineName, @InstanceName + N'Buffer Manager', N'Buffer cache hit ratio', N'*', N'<', N'min', @BufferCacheHR, @Enable, 0, @Recipients, N'07:00:00', N'17:00:00', 75, 80)
    INSERT [dbo].[AlertsDefinitions] ([RepositoriumName], [MachineName], [ObjectName], [CounterName], [InstanceName], [Symbol], [Whichbad], [Value], [Enable], [CurrentLevel], [EmailList], [HoursStart], [HoursEnd], [HowLongWait], [MaxLongTime]) VALUES (@RepositoriumName, @MachineName, @InstanceName + N'Buffer Manager', N'Page life expectancy', N'*', N'<', N'min', @PLE, @Enable, 0, @Recipients, N'07:00:00', N'17:00:00', 55, 60)
    INSERT [dbo].[AlertsDefinitions] ([RepositoriumName], [MachineName], [ObjectName], [CounterName], [InstanceName], [Symbol], [Whichbad], [Value], [Enable], [CurrentLevel], [EmailList], [HoursStart], [HoursEnd], [HowLongWait], [MaxLongTime]) VALUES (@RepositoriumName, @MachineName, @InstanceName + N'Databases', N'Percent Log Used', N'*', N'>', N'max', @LogUsed, @Enable, 0, @Recipients, NULL, NULL, 15, 20)
    INSERT [dbo].[AlertsDefinitions] ([RepositoriumName], [MachineName], [ObjectName], [CounterName], [InstanceName], [Symbol], [Whichbad], [Value], [Enable], [CurrentLevel], [EmailList], [HoursStart], [HoursEnd], [HowLongWait], [MaxLongTime]) VALUES (@RepositoriumName, @MachineName, @InstanceName + N'Plan Cache', N'Cache Hit Ratio', N'_Total', N'<', N'min', @PlanCacheHR, @Enable, 0, @Recipients, N'07:00:00', N'17:00:00', 75, 80)
    INSERT [dbo].[AlertsDefinitions] ([RepositoriumName], [MachineName], [ObjectName], [CounterName], [InstanceName], [Symbol], [Whichbad], [Value], [Enable], [CurrentLevel], [EmailList], [HoursStart], [HoursEnd], [HowLongWait], [MaxLongTime]) VALUES (@RepositoriumName, @MachineName, @InstanceName + N'Wait Statistics', N'Lock waits', N'Average wait time (ms)', N'>', N'max', @AvgTimeWait_ms, @Enable, 0, @Recipients, N'07:00:00', N'17:00:00', @HowLongWait, @MaxLongTime)
    INSERT [dbo].[AlertsDefinitions] ([RepositoriumName], [MachineName], [ObjectName], [CounterName], [InstanceName], [Symbol], [Whichbad], [Value], [Enable], [CurrentLevel], [EmailList], [HoursStart], [HoursEnd], [HowLongWait], [MaxLongTime]) VALUES (@RepositoriumName, @MachineName, @InstanceName + N'General Statistics', N'User Connections', N'*', N'>', N'min', @UserConnections, @Enable, 0, @Recipients, NULL, NULL, @HowLongWait, @MaxLongTime)
    INSERT [dbo].[AlertsDefinitions] ([RepositoriumName], [MachineName], [ObjectName], [CounterName], [InstanceName], [Symbol], [Whichbad], [Value], [Enable], [CurrentLevel], [EmailList], [HoursStart], [HoursEnd], [HowLongWait], [MaxLongTime]) VALUES (@RepositoriumName, @MachineName, @InstanceName + N'Latches', N'Average Latch Wait Time (ms)', N'*', N'>', N'min', @Latches, @Enable, 0, @Recipients,NULL, NULL, @HowLongWait, @MaxLongTime)
    INSERT [dbo].[AlertsDefinitions] ([RepositoriumName], [MachineName], [ObjectName], [CounterName], [InstanceName], [Symbol], [Whichbad], [Value], [Enable], [CurrentLevel], [EmailList], [HoursStart], [HoursEnd], [HowLongWait], [MaxLongTime]) VALUES (@RepositoriumName, @MachineName, @InstanceName + N'Wait Statistics', N'Network IO waits', N'Average wait time (ms)', N'>', N'min', @NetworkIO, @Enable, 0, @Recipients,NULL, NULL, 45, 50)
    INSERT [dbo].[AlertsDefinitions] ([RepositoriumName], [MachineName], [ObjectName], [CounterName], [InstanceName], [Symbol], [Whichbad], [Value], [Enable], [CurrentLevel], [EmailList], [HoursStart], [HoursEnd], [HowLongWait], [MaxLongTime]) VALUES (@RepositoriumName, @MachineName, N'Processor', N'% Processor Time', N'_Total', N'>', N'max', @Processor, @Enable, 0, @Recipients, N'07:00:00', N'17:00:00', 55, 60)
END
    -- WINDOWS --
    INSERT [dbo].[AlertsDefinitions] ([RepositoriumName], [MachineName], [ObjectName], [CounterName], [InstanceName], [Symbol], [Whichbad], [Value], [Enable], [CurrentLevel], [EmailList], [HoursStart], [HoursEnd], [HowLongWait], [MaxLongTime]) VALUES (@RepositoriumName, @MachineName, N'LogicalDisk', N'% Free Space', N'*', N'<', N'min', @FreeSpacePct, @Enable, 0, @Recipients, NULL, NULL, @HowLongWait, @MaxLongTime)
    INSERT [dbo].[AlertsDefinitions] ([RepositoriumName], [MachineName], [ObjectName], [CounterName], [InstanceName], [Symbol], [Whichbad], [Value], [Enable], [CurrentLevel], [EmailList], [HoursStart], [HoursEnd], [HowLongWait], [MaxLongTime]) VALUES (@RepositoriumName, @MachineName, N'LogicalDisk', N'Free Megabytes', N'*', N'<', N'min', @FreeMegabytes, @Enable, 0, @Recipients, NULL, NULL, @HowLongWait, @MaxLongTime)
    INSERT [dbo].[AlertsDefinitions] ([RepositoriumName], [MachineName], [ObjectName], [CounterName], [InstanceName], [Symbol], [Whichbad], [Value], [Enable], [CurrentLevel], [EmailList], [HoursStart], [HoursEnd], [HowLongWait], [MaxLongTime]) VALUES (@RepositoriumName, @MachineName, N'LogicalDisk', N'% Idle Time', N'*', N'<', N'min', @IdleTime, @Enable, 0, @Recipients, N'07:00:00', N'17:00:00', 75, 80)
    INSERT [dbo].[AlertsDefinitions] ([RepositoriumName], [MachineName], [ObjectName], [CounterName], [InstanceName], [Symbol], [Whichbad], [Value], [Enable], [CurrentLevel], [EmailList], [HoursStart], [HoursEnd], [HowLongWait], [MaxLongTime]) VALUES (@RepositoriumName, @MachineName, N'Memory', N'Available MBytes', N'*', N'<', N'min', @AvailableMB, @Enable, 0, @Recipients, N'07:00:00', N'17:00:00', @HowLongWait, @MaxLongTime)
    INSERT [dbo].[AlertsDefinitions] ([RepositoriumName], [MachineName], [ObjectName], [CounterName], [InstanceName], [Symbol], [Whichbad], [Value], [Enable], [CurrentLevel], [EmailList], [HoursStart], [HoursEnd], [HowLongWait], [MaxLongTime]) VALUES (@RepositoriumName, @MachineName, N'Network Interface', N'Output Queue Length', N'*', N'>', N'max', @NetworkQueue, @Enable, 0, @Recipients, N'07:00:00', N'17:00:00', 45, 50)
    INSERT [dbo].[AlertsDefinitions] ([RepositoriumName], [MachineName], [ObjectName], [CounterName], [InstanceName], [Symbol], [Whichbad], [Value], [Enable], [CurrentLevel], [EmailList], [HoursStart], [HoursEnd], [HowLongWait], [MaxLongTime]) VALUES (@RepositoriumName, @MachineName, N'System', N'Processor Queue Length', N'*', N'>', N'max', @ProcessorQueue, @Enable, 0, @Recipients, N'07:00:00', N'17:00:00', 20, 25)

