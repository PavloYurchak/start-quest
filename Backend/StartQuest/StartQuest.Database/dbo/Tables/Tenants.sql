CREATE TABLE [dbo].[Tenants]
(
    [Id] INT IDENTITY(1, 1) NOT NULL,
    [PublicId] UNIQUEIDENTIFIER NOT NULL DEFAULT NEWID(),

    [TypeId] INT NOT NULL,
    [OwnerUserId] INT NOT NULL,

    [Name] NVARCHAR(100) NOT NULL,
    [Description] NVARCHAR(255) NULL,

    [CreatedAt] DATETIME2 NOT NULL DEFAULT GETUTCDATE(),
    [UpdatedAt] DATETIME2 NULL,
    [DeletedAt] DATETIME2 NULL,

    [IsActive] BIT NOT NULL DEFAULT 1,

    CONSTRAINT [PK_Tenants] PRIMARY KEY CLUSTERED ([Id]),

    CONSTRAINT [FK_Tenants_TenantTypes_TypeId]
        FOREIGN KEY ([TypeId])
        REFERENCES [dbo].[TenantTypes]([Id]),

    CONSTRAINT [FK_Tenants_Users_OwnerUserId]
        FOREIGN KEY ([OwnerUserId])
        REFERENCES [dbo].[Users]([Id])
);

GO
CREATE UNIQUE INDEX [IXU_Tenants_PublicId]
ON [dbo].[Tenants] ([PublicId]);

GO
CREATE INDEX [IX_Tenants_OwnerUserId]
ON [dbo].[Tenants] ([OwnerUserId])
WHERE [DeletedAt] IS NULL;

GO
CREATE INDEX [IX_Tenants_TypeId]
ON [dbo].[Tenants] ([TypeId])
WHERE [DeletedAt] IS NULL;
