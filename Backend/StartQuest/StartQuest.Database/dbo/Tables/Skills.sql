CREATE TABLE [dbo].[Skills]
(
    [Id] INT IDENTITY(1, 1) NOT NULL,
    [PublicId] UNIQUEIDENTIFIER NOT NULL DEFAULT NEWID(),

    [TenantId] INT NOT NULL,
    [CreatedByUserId] INT NOT NULL,

    [Name] NVARCHAR(100) NOT NULL,
    [Description] NVARCHAR(1000) NULL,
    [Level] INT NOT NULL DEFAULT 1,
    [Experience] INT NOT NULL DEFAULT 0,

    [CreatedAt] DATETIME2 NOT NULL DEFAULT GETUTCDATE(),
    [UpdatedAt] DATETIME2 NULL,
    [DeletedAt] DATETIME2 NULL,

    [IsActive] BIT NOT NULL DEFAULT 1,

    CONSTRAINT [PK_Skills] PRIMARY KEY CLUSTERED ([Id]),

    CONSTRAINT [FK_Skills_Tenants_TenantId]
        FOREIGN KEY ([TenantId])
        REFERENCES [dbo].[Tenants]([Id]),

    CONSTRAINT [FK_Skills_Users_CreatedByUserId]
        FOREIGN KEY ([CreatedByUserId])
        REFERENCES [dbo].[Users]([Id])
);

GO
CREATE UNIQUE INDEX [IXU_Skills_PublicId]
ON [dbo].[Skills] ([PublicId]);

GO
CREATE UNIQUE INDEX [IXU_Skills_TenantId_Name]
ON [dbo].[Skills] ([TenantId], [Name])
WHERE [DeletedAt] IS NULL;
