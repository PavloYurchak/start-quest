CREATE TABLE [dbo].[Tags]
(
    [Id] INT IDENTITY(1, 1) NOT NULL,

    [TenantId] INT NOT NULL,

    [Name] NVARCHAR(100) NOT NULL,
    [Color] NVARCHAR(20) NULL,

    [CreatedAt] DATETIME2 NOT NULL DEFAULT GETUTCDATE(),
    [UpdatedAt] DATETIME2 NULL,
    [DeletedAt] DATETIME2 NULL,

    [IsActive] BIT NOT NULL DEFAULT 1,

    CONSTRAINT [PK_Tags] PRIMARY KEY CLUSTERED ([Id]),

    CONSTRAINT [FK_Tags_Tenants_TenantId]
        FOREIGN KEY ([TenantId])
        REFERENCES [dbo].[Tenants]([Id])
);

GO
CREATE UNIQUE INDEX [IXU_Tags_TenantId_Name]
ON [dbo].[Tags] ([TenantId], [Name])
WHERE [DeletedAt] IS NULL;
