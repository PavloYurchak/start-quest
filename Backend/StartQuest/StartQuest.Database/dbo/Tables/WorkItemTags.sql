CREATE TABLE [dbo].[WorkItemTags]
(
    [Id] INT IDENTITY(1, 1) NOT NULL,

    [WorkItemId] INT NOT NULL,
    [TagId] INT NOT NULL,

    [CreatedAt] DATETIME2 NOT NULL DEFAULT GETUTCDATE(),
    [DeletedAt] DATETIME2 NULL,

    CONSTRAINT [PK_WorkItemTags] PRIMARY KEY CLUSTERED ([Id]),

    CONSTRAINT [FK_WorkItemTags_WorkItems_WorkItemId]
        FOREIGN KEY ([WorkItemId])
        REFERENCES [dbo].[WorkItems]([Id]),

    CONSTRAINT [FK_WorkItemTags_Tags_TagId]
        FOREIGN KEY ([TagId])
        REFERENCES [dbo].[Tags]([Id])
);

GO
CREATE UNIQUE INDEX [IXU_WorkItemTags_WorkItemId_TagId]
ON [dbo].[WorkItemTags] ([WorkItemId], [TagId])
WHERE [DeletedAt] IS NULL;
