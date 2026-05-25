CREATE TABLE [dbo].[WorkItemSchedules]
(
    [Id] INT IDENTITY(1, 1) NOT NULL,

    [WorkItemId] INT NOT NULL,
    [ScheduleTypeId] INT NOT NULL,
    [RecurrenceTypeId] INT NULL,

    [StartAt] DATETIME2 NOT NULL,
    [EndAt] DATETIME2 NULL,
    [TimeZone] NVARCHAR(100) NOT NULL DEFAULT 'UTC',
    [Interval] INT NOT NULL DEFAULT 1,
    [DaysOfWeek] NVARCHAR(50) NULL,

    [CreatedAt] DATETIME2 NOT NULL DEFAULT GETUTCDATE(),
    [UpdatedAt] DATETIME2 NULL,
    [DeletedAt] DATETIME2 NULL,

    [IsActive] BIT NOT NULL DEFAULT 1,

    CONSTRAINT [PK_WorkItemSchedules] PRIMARY KEY CLUSTERED ([Id]),

    CONSTRAINT [FK_WorkItemSchedules_WorkItems_WorkItemId]
        FOREIGN KEY ([WorkItemId])
        REFERENCES [dbo].[WorkItems]([Id]),

    CONSTRAINT [FK_WorkItemSchedules_ScheduleTypes_ScheduleTypeId]
        FOREIGN KEY ([ScheduleTypeId])
        REFERENCES [dbo].[ScheduleTypes]([Id]),

    CONSTRAINT [FK_WorkItemSchedules_RecurrenceTypes_RecurrenceTypeId]
        FOREIGN KEY ([RecurrenceTypeId])
        REFERENCES [dbo].[RecurrenceTypes]([Id])
);

GO
CREATE INDEX [IX_WorkItemSchedules_WorkItemId]
ON [dbo].[WorkItemSchedules] ([WorkItemId])
WHERE [DeletedAt] IS NULL;
