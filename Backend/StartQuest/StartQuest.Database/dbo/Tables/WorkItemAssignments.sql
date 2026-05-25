CREATE TABLE [dbo].[WorkItemAssignments]
(
    [Id] INT IDENTITY(1, 1) NOT NULL,

    [WorkItemId] INT NOT NULL,
    [UserId] INT NOT NULL,
    [AssignedByUserId] INT NOT NULL,

    [IsPrimary] BIT NOT NULL DEFAULT 0,
    [AssignedAt] DATETIME2 NOT NULL DEFAULT GETUTCDATE(),

    [CreatedAt] DATETIME2 NOT NULL DEFAULT GETUTCDATE(),
    [DeletedAt] DATETIME2 NULL,

    [IsActive] BIT NOT NULL DEFAULT 1,

    CONSTRAINT [PK_WorkItemAssignments] PRIMARY KEY CLUSTERED ([Id]),

    CONSTRAINT [FK_WorkItemAssignments_WorkItems_WorkItemId]
        FOREIGN KEY ([WorkItemId])
        REFERENCES [dbo].[WorkItems]([Id]),

    CONSTRAINT [FK_WorkItemAssignments_Users_UserId]
        FOREIGN KEY ([UserId])
        REFERENCES [dbo].[Users]([Id]),

    CONSTRAINT [FK_WorkItemAssignments_Users_AssignedByUserId]
        FOREIGN KEY ([AssignedByUserId])
        REFERENCES [dbo].[Users]([Id])
);

GO
CREATE UNIQUE INDEX [IXU_WorkItemAssignments_WorkItemId_UserId]
ON [dbo].[WorkItemAssignments] ([WorkItemId], [UserId])
WHERE [DeletedAt] IS NULL;

GO
CREATE INDEX [IX_WorkItemAssignments_UserId]
ON [dbo].[WorkItemAssignments] ([UserId])
WHERE [DeletedAt] IS NULL;
