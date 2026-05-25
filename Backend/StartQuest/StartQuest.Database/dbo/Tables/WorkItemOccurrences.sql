CREATE TABLE [dbo].[WorkItemOccurrences]
(
    [Id] BIGINT IDENTITY(1, 1) NOT NULL,
    [PublicId] UNIQUEIDENTIFIER NOT NULL DEFAULT NEWID(),

    [WorkItemId] INT NOT NULL,
    [ScheduleId] INT NOT NULL,
    [StatusId] INT NOT NULL,

    [ScheduledStartAt] DATETIME2 NOT NULL,
    [ScheduledEndAt] DATETIME2 NULL,
    [CompletedAt] DATETIME2 NULL,
    [Notes] NVARCHAR(1000) NULL,

    [CreatedAt] DATETIME2 NOT NULL DEFAULT GETUTCDATE(),
    [UpdatedAt] DATETIME2 NULL,
    [DeletedAt] DATETIME2 NULL,

    [IsActive] BIT NOT NULL DEFAULT 1,

    CONSTRAINT [PK_WorkItemOccurrences] PRIMARY KEY CLUSTERED ([Id]),

    CONSTRAINT [FK_WorkItemOccurrences_WorkItems_WorkItemId]
        FOREIGN KEY ([WorkItemId])
        REFERENCES [dbo].[WorkItems]([Id]),

    CONSTRAINT [FK_WorkItemOccurrences_WorkItemSchedules_ScheduleId]
        FOREIGN KEY ([ScheduleId])
        REFERENCES [dbo].[WorkItemSchedules]([Id]),

    CONSTRAINT [FK_WorkItemOccurrences_OccurrenceStatuses_StatusId]
        FOREIGN KEY ([StatusId])
        REFERENCES [dbo].[OccurrenceStatuses]([Id])
);

GO
CREATE UNIQUE INDEX [IXU_WorkItemOccurrences_PublicId]
ON [dbo].[WorkItemOccurrences] ([PublicId]);

GO
CREATE UNIQUE INDEX [IXU_WorkItemOccurrences_ScheduleId_ScheduledStartAt]
ON [dbo].[WorkItemOccurrences] ([ScheduleId], [ScheduledStartAt])
WHERE [DeletedAt] IS NULL;

GO
CREATE INDEX [IX_WorkItemOccurrences_WorkItemId_ScheduledStartAt]
ON [dbo].[WorkItemOccurrences] ([WorkItemId], [ScheduledStartAt])
WHERE [DeletedAt] IS NULL;
