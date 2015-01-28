IF EXISTS(SELECT * FROM sysobjects WHERE xtype = 'U' AND name = 'MultiAppEventSources' AND uid = SCHEMA_ID(SCHEMA_NAME()))
	BEGIN
		PRINT 'The MultiAppEventSources table already exists.'
	END
ELSE
	BEGIN
		CREATE TABLE [MultiAppEventSources]
		(
			[ApplicationName]		[varchar](50)			NOT NULL,
			[Id]					[uniqueidentifier]		NOT NULL,
			[Type]					[nvarchar](255)			NOT NULL,
			[Version]				[int]					NOT NULL
		) ON [PRIMARY]

		CREATE UNIQUE NONCLUSTERED INDEX [IX_Id] ON [MultiAppEventSources] 
		(
			[Id] ASC
		)
		WITH
		(
			PAD_INDEX					= OFF,
			STATISTICS_NORECOMPUTE		= OFF,
			SORT_IN_TEMPDB				= OFF,
			IGNORE_DUP_KEY				= OFF,
			DROP_EXISTING				= OFF,
			ONLINE						= OFF,
			ALLOW_ROW_LOCKS				= ON,
			ALLOW_PAGE_LOCKS			= ON
		) ON [PRIMARY]

		PRINT 'The MultiAppEventSources table was created.'
	END

IF EXISTS(SELECT * FROM sysobjects WHERE xtype = 'U' AND name = 'MultiAppEvents' AND uid = SCHEMA_ID(SCHEMA_NAME()))
	BEGIN
		PRINT 'The MultiAppEvents table already exists.'
	END
ELSE
	BEGIN
		CREATE TABLE [MultiAppEvents]
		(
			[ApplicationName]		[varchar](50)			NOT NULL,
			[SequentialId]			[int] IDENTITY(1,1)		NOT NULL,
			[Id]					[uniqueidentifier]		NOT NULL,
			[TimeStamp]				[datetime]				NOT NULL,
			[Name]					[varchar](max)			NOT NULL,
			[Version]				[varchar](max)			NOT NULL,
			[EventSourceId]			[uniqueidentifier]		NOT NULL,
			[Sequence]				[bigint]				NULL,
			[Data]					[nvarchar](max)			NOT NULL,
			CONSTRAINT [PK_Events] PRIMARY KEY CLUSTERED
			(
				[SequentialId] ASC
			)
			WITH
			(
				PAD_INDEX				= OFF,
				STATISTICS_NORECOMPUTE	= OFF,
				IGNORE_DUP_KEY			= OFF,
				ALLOW_ROW_LOCKS			= ON,
				ALLOW_PAGE_LOCKS		= ON
			)
		) ON [PRIMARY]

		CREATE NONCLUSTERED INDEX [IX_EventSourceId] ON [MultiAppEvents] (EventSourceId)

		PRINT 'The MultiAppEvents table was created.'
	END

IF EXISTS(SELECT * FROM sysobjects WHERE xtype = 'U' AND name = 'MultiAppSnapshots' AND uid = SCHEMA_ID(SCHEMA_NAME()))
	BEGIN
		PRINT 'The MultiAppSnapshots table already exists.'
	END
ELSE
	BEGIN
		CREATE TABLE [MultiAppSnapshots]
		(
			[ApplicationName]		[varchar](50)			NOT NULL,
			[EventSourceId]			[uniqueidentifier]		NOT NULL,
			[Version]				[bigint]				NULL,
			[TimeStamp]				[datetime]				NOT NULL, 
			[Type]					varchar(255)			NOT NULL,
			[Data]					[varbinary](max)		NOT NULL
		) ON [PRIMARY]

		PRINT 'The MultiAppSnapshots table was created.'
	END

IF EXISTS(SELECT * FROM sysobjects WHERE xtype = 'U' AND name = 'MultiAppPipelineState' AND uid = SCHEMA_ID(SCHEMA_NAME()))
	BEGIN
		PRINT 'The MultiAppPipelineState table already exists.'
	END
ELSE
	BEGIN
		CREATE TABLE [MultiAppPipelineState]
		(
			[ApplicationName]		[varchar](50)			NOT NULL,
			[BatchId]				[int] IDENTITY(1,1)		NOT NULL,
			[PipelineName]			[varchar](255)			NOT NULL,
			[LastProcessedEventId]	[uniqueidentifier]		NOT NULL,
			CONSTRAINT [PK_MainPipelineState] PRIMARY KEY CLUSTERED 
			(
				[BatchId] ASC
			)
			WITH
			(
				PAD_INDEX				= OFF,
				STATISTICS_NORECOMPUTE	= OFF,
				IGNORE_DUP_KEY			= OFF,
				ALLOW_ROW_LOCKS			= ON, 
				ALLOW_PAGE_LOCKS		= ON
			)
		) ON [PRIMARY]

		PRINT 'The MultiAppPipelineState table was created.'
	END
