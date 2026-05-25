CREATE TABLE [dbo].[BattlePasses]
(
    [Id] INT IDENTITY(1, 1) NOT NULL,
    [PublicId] UNIQUEIDENTIFIER NOT NULL DEFAULT NEWID(),

    [TenantId] INT NOT NULL,
    [CreatedByUserId] INT NOT NULL,

    [Name] NVARCHAR(100) NOT NULL,
    [Description] NVARCHAR(1000) NULL,

    [StartAt] DATETIME2 NULL,
    [EndAt] DATETIME2 NULL,

    [CreatedAt] DATETIME2 NOT NULL DEFAULT GETUTCDATE(),
    [UpdatedAt] DATETIME2 NULL,
    [DeletedAt] DATETIME2 NULL,

    [IsActive] BIT NOT NULL DEFAULT 1,

    CONSTRAINT [PK_BattlePasses] PRIMARY KEY CLUSTERED ([Id]),

    CONSTRAINT [FK_BattlePasses_Tenants_TenantId]
        FOREIGN KEY ([TenantId])
        REFERENCES [dbo].[Tenants]([Id]),

    CONSTRAINT [FK_BattlePasses_Users_CreatedByUserId]
        FOREIGN KEY ([CreatedByUserId])
        REFERENCES [dbo].[Users]([Id])
);

GO
CREATE UNIQUE INDEX [IXU_BattlePasses_PublicId]
ON [dbo].[BattlePasses] ([PublicId]);

GO
CREATE INDEX [IX_BattlePasses_TenantId]
ON [dbo].[BattlePasses] ([TenantId])
WHERE [DeletedAt] IS NULL;
