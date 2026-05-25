CREATE TABLE [dbo].[Crafts]
(
    [Id] INT IDENTITY(1, 1) NOT NULL,
    [PublicId] UNIQUEIDENTIFIER NOT NULL DEFAULT NEWID(),

    [TenantId] INT NOT NULL,
    [CreatedByUserId] INT NOT NULL,

    [Name] NVARCHAR(100) NOT NULL,
    [Description] NVARCHAR(1000) NULL,

    [CreatedAt] DATETIME2 NOT NULL DEFAULT GETUTCDATE(),
    [UpdatedAt] DATETIME2 NULL,
    [DeletedAt] DATETIME2 NULL,

    [IsActive] BIT NOT NULL DEFAULT 1,

    CONSTRAINT [PK_Crafts] PRIMARY KEY CLUSTERED ([Id]),

    CONSTRAINT [FK_Crafts_Tenants_TenantId]
        FOREIGN KEY ([TenantId])
        REFERENCES [dbo].[Tenants]([Id]),

    CONSTRAINT [FK_Crafts_Users_CreatedByUserId]
        FOREIGN KEY ([CreatedByUserId])
        REFERENCES [dbo].[Users]([Id])
);

GO
CREATE UNIQUE INDEX [IXU_Crafts_PublicId]
ON [dbo].[Crafts] ([PublicId]);

GO
CREATE UNIQUE INDEX [IXU_Crafts_TenantId_Name]
ON [dbo].[Crafts] ([TenantId], [Name])
WHERE [DeletedAt] IS NULL;
