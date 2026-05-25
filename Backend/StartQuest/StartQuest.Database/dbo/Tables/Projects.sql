CREATE TABLE [dbo].[Projects]
(
    [Id] INT IDENTITY(1, 1) NOT NULL,
    [PublicId] UNIQUEIDENTIFIER NOT NULL DEFAULT NEWID(),

    [TenantId] INT NOT NULL,
    [StatusId] INT NOT NULL,
    [CreatedByUserId] INT NOT NULL,

    [Key] NVARCHAR(20) NOT NULL,
    [Name] NVARCHAR(100) NOT NULL,
    [Description] NVARCHAR(1000) NULL,

    [StartAt] DATETIME2 NULL,
    [EndAt] DATETIME2 NULL,

    [CreatedAt] DATETIME2 NOT NULL DEFAULT GETUTCDATE(),
    [UpdatedAt] DATETIME2 NULL,
    [DeletedAt] DATETIME2 NULL,

    [IsActive] BIT NOT NULL DEFAULT 1,

    CONSTRAINT [PK_Projects] PRIMARY KEY CLUSTERED ([Id]),

    CONSTRAINT [FK_Projects_Tenants_TenantId]
        FOREIGN KEY ([TenantId])
        REFERENCES [dbo].[Tenants]([Id]),

    CONSTRAINT [FK_Projects_ProjectStatuses_StatusId]
        FOREIGN KEY ([StatusId])
        REFERENCES [dbo].[ProjectStatuses]([Id]),

    CONSTRAINT [FK_Projects_Users_CreatedByUserId]
        FOREIGN KEY ([CreatedByUserId])
        REFERENCES [dbo].[Users]([Id])
);

GO
CREATE UNIQUE INDEX [IXU_Projects_PublicId]
ON [dbo].[Projects] ([PublicId]);

GO
CREATE UNIQUE INDEX [IXU_Projects_TenantId_Key]
ON [dbo].[Projects] ([TenantId], [Key])
WHERE [DeletedAt] IS NULL;

GO
CREATE INDEX [IX_Projects_TenantId_StatusId]
ON [dbo].[Projects] ([TenantId], [StatusId])
WHERE [DeletedAt] IS NULL;
