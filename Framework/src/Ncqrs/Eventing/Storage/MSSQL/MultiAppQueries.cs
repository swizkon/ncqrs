using System;

namespace Ncqrs.Eventing.Storage.MSSQL
{
    internal static class MultiAppQueries
    {
        public const String DeleteUnusedProviders =
        @"DELETE FROM [MultiAppEventSources] 
        WHERE (SELECT Count(EventSourceId) FROM [MultiAppEvents] WHERE [EventSourceId]=[EventSources].[Id]) = 0";

        public const String InsertNewEventQuery =
        @"INSERT INTO [MultiAppEvents]([ApplicationName], [Id], [EventSourceId], [Name], [Version], [Data], [Sequence], [TimeStamp])
            VALUES (@ApplicationName, @EventId, @EventSourceId, @Name, @Version, @Data, @Sequence, @TimeStamp)";

        public const String InsertNewProviderQuery =
        @"INSERT INTO [MultiAppEventSources]([ApplicationName], [Id], [Type], [Version])
            VALUES (@ApplicationName, @Id, @Type, @Version)";

        public const String InsertSnapshot =
        @"DELETE FROM [MultiAppSnapshots] WHERE [EventSourceId] = @EventSourceId AND [ApplicationName] = @ApplicationName;
        INSERT INTO [MultiAppSnapshots]([ApplicationName], [EventSourceId], [Timestamp], [Version], [Type], [Data])
            VALUES (@ApplicationName, @EventSourceId, GETDATE(), @Version, @Type, @Data)";


        public const String SelectAllEventsQuery =
        @"SELECT [Id], [EventSourceId], [Name], [Version], [TimeStamp], [Data], [Sequence]
        FROM [MultiAppEvents] 
        WHERE [EventSourceId] = @EventSourceId 
            AND [Sequence] >= @EventSourceMinVersion 
            AND [Sequence] <= @EventSourceMaxVersion
            AND [ApplicationName] = @ApplicationName
        ORDER BY [Sequence]";


        public const String SelectEventsAfterQuery =
        @"SELECT TOP {0} [Id], [EventSourceId], [Name], [Version], [TimeStamp], [Data], [Sequence]
        FROM [MultiAppEvents]
        WHERE [ApplicationName] = @ApplicationName
            AND [SequentialId] > (SELECT [SequentialId] FROM [MultiAppEvents] WHERE [Id] = @EventId AND [ApplicationName] = @ApplicationName) ORDER BY [SequentialId]";

        public const String SelectEventsFromBeginningOfTime =
        @"SELECT TOP {0} [Id], [EventSourceId], [Name], [Version], [TimeStamp], [Data], [Sequence]
        FROM [MultiAppEvents]
        WHERE [ApplicationName] = @ApplicationName
        ORDER BY [SequentialId]";

        public const String SelectAllIdsForTypeQuery =
        @"SELECT [Id]
        FROM [MultiAppEventSources]
        WHERE [ApplicationName] = @ApplicationName
            AND [Type] = @Type";

        public const String SelectVersionQuery =
        @"SELECT [Version]
        FROM [MultiAppEventSources]
        WHERE [Id] = @id 
            AND [ApplicationName] = @ApplicationName";

        public const String SelectLatestSnapshot =
        @"SELECT TOP 1 *
        FROM [MultiAppSnapshots]
        WHERE [EventSourceId] = @EventSourceId
            AND [ApplicationName] = @ApplicationName 
        ORDER BY Version DESC";

        public const String UpdateEventSourceVersionQuery =
        @"UPDATE [MultiAppEventSources] SET [Version] = @NewVersion
        WHERE [Id] = @id 
            AND [Version] = @initialVersion
            AND [ApplicationName] = @ApplicationName";
    }
}
