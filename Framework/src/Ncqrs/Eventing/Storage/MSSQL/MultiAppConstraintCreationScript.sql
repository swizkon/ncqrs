IF EXISTS(SELECT * FROM sysobjects WHERE xtype = 'UQ' AND name = 'UQ_MultiAppEvents_Id' AND uid = SCHEMA_ID(SCHEMA_NAME()))
	BEGIN
		PRINT 'The UQ_MultiAppEvents_Id unique-key constraint already exists.'
	END
ELSE
	BEGIN
		ALTER TABLE [MultiAppEvents] ADD CONSTRAINT [UQ_MultiAppEvents_Id] UNIQUE ([Id])

		PRINT 'The UQ_MultiAppEvents_Id unique-key constraint was created.'
	END

IF EXISTS(SELECT * FROM sysobjects WHERE xtype = 'F' AND name = 'FK_MultiAppEvents_MultiAppEventSources' AND uid = SCHEMA_ID(SCHEMA_NAME()))
	BEGIN
		PRINT 'The FK_MultiAppEvents_MultiAppEventSources foreign-key constraint already exists.'
	END
ELSE
	BEGIN
		ALTER TABLE [MultiAppEvents] WITH CHECK ADD CONSTRAINT [FK_MultiAppEvents_MultiAppEventSources] FOREIGN KEY([EventSourceId])
			REFERENCES [MultiAppEventSources] ([Id])

		ALTER TABLE [MultiAppEvents] CHECK CONSTRAINT [FK_MultiAppEvents_MultiAppEventSources]

		PRINT 'The FK_MultiAppEvents_MultiAppEventSources foreign-key constraint was created.'
	END

IF EXISTS(SELECT * FROM sysobjects WHERE xtype = 'F' AND name = 'FK_MultiAppSnapshots_MultiAppEventSources' AND uid = SCHEMA_ID(SCHEMA_NAME()))
	BEGIN
		PRINT 'The FK_MultiAppSnapshots_MultiAppEventSources foreign-key constraint already exists.'
	END
ELSE
	BEGIN
		ALTER TABLE [MultiAppSnapshots] WITH CHECK ADD CONSTRAINT [FK_MultiAppSnapshots_MultiAppEventSources] FOREIGN KEY([EventSourceId])
			REFERENCES [MultiAppEventSources] ([Id])

		ALTER TABLE [MultiAppSnapshots] CHECK CONSTRAINT [FK_MultiAppSnapshots_MultiAppEventSources]

		PRINT 'The FK_MultiAppSnapshots_MultiAppEventSources foreign-key constraint was created.'
	END

IF EXISTS(SELECT * FROM sysobjects WHERE xtype = 'F' AND name = 'FK_MultiAppPipelineState_MultiAppEvents' AND uid = SCHEMA_ID(SCHEMA_NAME()))
	BEGIN
		PRINT 'The FK_MultiAppPipelineState_MultiAppEvents foreign-key constraint already exists.'
	END
ELSE
	BEGIN
		ALTER TABLE [MultiAppPipelineState] WITH CHECK ADD CONSTRAINT [FK_MultiAppPipelineState_MultiAppEvents] FOREIGN KEY([LastProcessedEventId])
			REFERENCES [MultiAppEvents] ([Id])

		ALTER TABLE [MultiAppPipelineState] CHECK CONSTRAINT [FK_MultiAppPipelineState_MultiAppEvents]

		PRINT 'The FK_MultiAppPipelineState_MultiAppEvents foreign-key constraint was created.'
	END