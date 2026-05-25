CREATE TABLE [dbo].[WorkItemCraftRewards]
(
    [Id] INT IDENTITY(1, 1) NOT NULL,

    [WorkItemId] INT NOT NULL,
    [CraftId] INT NOT NULL,

    [CreatedAt] DATETIME2 NOT NULL DEFAULT GETUTCDATE(),
    [DeletedAt] DATETIME2 NULL,

    CONSTRAINT [PK_WorkItemCraftRewards] PRIMARY KEY CLUSTERED ([Id]),

    CONSTRAINT [FK_WorkItemCraftRewards_WorkItems_WorkItemId]
        FOREIGN KEY ([WorkItemId])
        REFERENCES [dbo].[WorkItems]([Id]),

    CONSTRAINT [FK_WorkItemCraftRewards_Crafts_CraftId]
        FOREIGN KEY ([CraftId])
        REFERENCES [dbo].[Crafts]([Id])
);

GO
CREATE UNIQUE INDEX [IXU_WorkItemCraftRewards_WorkItemId_CraftId]
ON [dbo].[WorkItemCraftRewards] ([WorkItemId], [CraftId])
WHERE [DeletedAt] IS NULL;
