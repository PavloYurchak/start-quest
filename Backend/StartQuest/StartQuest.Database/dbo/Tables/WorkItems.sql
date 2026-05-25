CREATE TABLE [dbo].[WorkItems]
(
    [Id] INT IDENTITY(1, 1) NOT NULL,
    [PublicId] UNIQUEIDENTIFIER NOT NULL DEFAULT NEWID(),

    [TenantId] INT NOT NULL,
    [ProjectId] INT NOT NULL,
    [TypeId] INT NOT NULL,
    [StatusId] INT NOT NULL,
    [ParentId] INT NULL,
    [CreatedByUserId] INT NOT NULL,

    [Number] INT NOT NULL,
    [Code] NVARCHAR(50) NOT NULL,
    [Title] NVARCHAR(200) NOT NULL,
    [Description] NVARCHAR(MAX) NULL,

    [DueAt] DATETIME2 NULL,
    [CompletedAt] DATETIME2 NULL,

    [CreatedAt] DATETIME2 NOT NULL DEFAULT GETUTCDATE(),
    [UpdatedAt] DATETIME2 NULL,
    [DeletedAt] DATETIME2 NULL,

    [IsActive] BIT NOT NULL DEFAULT 1,

    CONSTRAINT [PK_WorkItems] PRIMARY KEY CLUSTERED ([Id]),

    CONSTRAINT [FK_WorkItems_Tenants_TenantId]
        FOREIGN KEY ([TenantId])
        REFERENCES [dbo].[Tenants]([Id]),

    CONSTRAINT [FK_WorkItems_Projects_ProjectId]
        FOREIGN KEY ([ProjectId])
        REFERENCES [dbo].[Projects]([Id]),

    CONSTRAINT [FK_WorkItems_WorkItemTypes_TypeId]
        FOREIGN KEY ([TypeId])
        REFERENCES [dbo].[WorkItemTypes]([Id]),

    CONSTRAINT [FK_WorkItems_WorkItemStatuses_StatusId]
        FOREIGN KEY ([StatusId])
        REFERENCES [dbo].[WorkItemStatuses]([Id]),

    CONSTRAINT [FK_WorkItems_WorkItems_ParentId]
        FOREIGN KEY ([ParentId])
        REFERENCES [dbo].[WorkItems]([Id]),

    CONSTRAINT [FK_WorkItems_Users_CreatedByUserId]
        FOREIGN KEY ([CreatedByUserId])
        REFERENCES [dbo].[Users]([Id])
);

GO
CREATE UNIQUE INDEX [IXU_WorkItems_PublicId]
ON [dbo].[WorkItems] ([PublicId]);

GO
CREATE UNIQUE INDEX [IXU_WorkItems_ProjectId_Number]
ON [dbo].[WorkItems] ([ProjectId], [Number])
WHERE [DeletedAt] IS NULL;

GO
CREATE UNIQUE INDEX [IXU_WorkItems_TenantId_Code]
ON [dbo].[WorkItems] ([TenantId], [Code])
WHERE [DeletedAt] IS NULL;

GO
CREATE INDEX [IX_WorkItems_ProjectId_StatusId]
ON [dbo].[WorkItems] ([ProjectId], [StatusId])
WHERE [DeletedAt] IS NULL;

GO
CREATE INDEX [IX_WorkItems_ParentId]
ON [dbo].[WorkItems] ([ParentId])
WHERE [DeletedAt] IS NULL;
