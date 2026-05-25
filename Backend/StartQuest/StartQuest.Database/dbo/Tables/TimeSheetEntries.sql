CREATE TABLE [dbo].[TimeSheetEntries]
(
    [Id] BIGINT IDENTITY(1, 1) NOT NULL,
    [PublicId] UNIQUEIDENTIFIER NOT NULL DEFAULT NEWID(),

    [TenantId] INT NOT NULL,
    [WorkItemId] INT NOT NULL,
    [OccurrenceId] BIGINT NULL,
    [UserId] INT NOT NULL,

    [StartedAt] DATETIME2 NOT NULL,
    [EndedAt] DATETIME2 NULL,
    [DurationMinutes] INT NOT NULL,
    [Notes] NVARCHAR(1000) NULL,

    [CreatedAt] DATETIME2 NOT NULL DEFAULT GETUTCDATE(),
    [UpdatedAt] DATETIME2 NULL,
    [DeletedAt] DATETIME2 NULL,

    [IsActive] BIT NOT NULL DEFAULT 1,

    CONSTRAINT [PK_TimeSheetEntries] PRIMARY KEY CLUSTERED ([Id]),

    CONSTRAINT [FK_TimeSheetEntries_Tenants_TenantId]
        FOREIGN KEY ([TenantId])
        REFERENCES [dbo].[Tenants]([Id]),

    CONSTRAINT [FK_TimeSheetEntries_WorkItems_WorkItemId]
        FOREIGN KEY ([WorkItemId])
        REFERENCES [dbo].[WorkItems]([Id]),

    CONSTRAINT [FK_TimeSheetEntries_WorkItemOccurrences_OccurrenceId]
        FOREIGN KEY ([OccurrenceId])
        REFERENCES [dbo].[WorkItemOccurrences]([Id]),

    CONSTRAINT [FK_TimeSheetEntries_Users_UserId]
        FOREIGN KEY ([UserId])
        REFERENCES [dbo].[Users]([Id])
);

GO
CREATE UNIQUE INDEX [IXU_TimeSheetEntries_PublicId]
ON [dbo].[TimeSheetEntries] ([PublicId]);

GO
CREATE INDEX [IX_TimeSheetEntries_UserId_StartedAt]
ON [dbo].[TimeSheetEntries] ([UserId], [StartedAt] DESC)
WHERE [DeletedAt] IS NULL;

GO
CREATE INDEX [IX_TimeSheetEntries_WorkItemId_StartedAt]
ON [dbo].[TimeSheetEntries] ([WorkItemId], [StartedAt] DESC)
WHERE [DeletedAt] IS NULL;
