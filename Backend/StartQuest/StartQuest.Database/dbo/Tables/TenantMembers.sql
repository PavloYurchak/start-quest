CREATE TABLE [dbo].[TenantMembers]
(
    [Id] INT IDENTITY(1, 1) NOT NULL,

    [TenantId] INT NOT NULL,
    [UserId] INT NOT NULL,
    [RoleId] INT NOT NULL,

    [JoinedAt] DATETIME2 NOT NULL DEFAULT GETUTCDATE(),

    [CreatedAt] DATETIME2 NOT NULL DEFAULT GETUTCDATE(),
    [UpdatedAt] DATETIME2 NULL,
    [DeletedAt] DATETIME2 NULL,

    [IsActive] BIT NOT NULL DEFAULT 1,

    CONSTRAINT [PK_TenantMembers] PRIMARY KEY CLUSTERED ([Id]),

    CONSTRAINT [FK_TenantMembers_Tenants_TenantId]
        FOREIGN KEY ([TenantId])
        REFERENCES [dbo].[Tenants]([Id]),

    CONSTRAINT [FK_TenantMembers_Users_UserId]
        FOREIGN KEY ([UserId])
        REFERENCES [dbo].[Users]([Id]),

    CONSTRAINT [FK_TenantMembers_TenantRoles_RoleId]
        FOREIGN KEY ([RoleId])
        REFERENCES [dbo].[TenantRoles]([Id])
);

GO
CREATE UNIQUE INDEX [IXU_TenantMembers_TenantId_UserId]
ON [dbo].[TenantMembers] ([TenantId], [UserId])
WHERE [DeletedAt] IS NULL;

GO
CREATE INDEX [IX_TenantMembers_UserId]
ON [dbo].[TenantMembers] ([UserId])
WHERE [DeletedAt] IS NULL;
