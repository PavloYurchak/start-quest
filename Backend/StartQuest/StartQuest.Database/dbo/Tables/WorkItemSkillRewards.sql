CREATE TABLE [dbo].[WorkItemSkillRewards]
(
    [Id] INT IDENTITY(1, 1) NOT NULL,

    [WorkItemId] INT NOT NULL,
    [SkillId] INT NOT NULL,
    [ExperienceReward] INT NOT NULL DEFAULT 0,

    [CreatedAt] DATETIME2 NOT NULL DEFAULT GETUTCDATE(),
    [DeletedAt] DATETIME2 NULL,

    CONSTRAINT [PK_WorkItemSkillRewards] PRIMARY KEY CLUSTERED ([Id]),

    CONSTRAINT [FK_WorkItemSkillRewards_WorkItems_WorkItemId]
        FOREIGN KEY ([WorkItemId])
        REFERENCES [dbo].[WorkItems]([Id]),

    CONSTRAINT [FK_WorkItemSkillRewards_Skills_SkillId]
        FOREIGN KEY ([SkillId])
        REFERENCES [dbo].[Skills]([Id])
);

GO
CREATE UNIQUE INDEX [IXU_WorkItemSkillRewards_WorkItemId_SkillId]
ON [dbo].[WorkItemSkillRewards] ([WorkItemId], [SkillId])
WHERE [DeletedAt] IS NULL;
