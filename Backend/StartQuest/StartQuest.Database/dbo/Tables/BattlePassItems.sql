CREATE TABLE [dbo].[BattlePassItems]
(
    [Id] INT IDENTITY(1, 1) NOT NULL,

    [BattlePassId] INT NOT NULL,
    [WorkItemId] INT NOT NULL,

    [Points] INT NOT NULL DEFAULT 0,
    [SortOrder] INT NOT NULL DEFAULT 0,

    [CreatedAt] DATETIME2 NOT NULL DEFAULT GETUTCDATE(),
    [UpdatedAt] DATETIME2 NULL,
    [DeletedAt] DATETIME2 NULL,

    [IsActive] BIT NOT NULL DEFAULT 1,

    CONSTRAINT [PK_BattlePassItems] PRIMARY KEY CLUSTERED ([Id]),

    CONSTRAINT [FK_BattlePassItems_BattlePasses_BattlePassId]
        FOREIGN KEY ([BattlePassId])
        REFERENCES [dbo].[BattlePasses]([Id]),

    CONSTRAINT [FK_BattlePassItems_WorkItems_WorkItemId]
        FOREIGN KEY ([WorkItemId])
        REFERENCES [dbo].[WorkItems]([Id])
);

GO
CREATE UNIQUE INDEX [IXU_BattlePassItems_BattlePassId_WorkItemId]
ON [dbo].[BattlePassItems] ([BattlePassId], [WorkItemId])
WHERE [DeletedAt] IS NULL;

GO
CREATE INDEX [IX_BattlePassItems_WorkItemId]
ON [dbo].[BattlePassItems] ([WorkItemId])
WHERE [DeletedAt] IS NULL;
