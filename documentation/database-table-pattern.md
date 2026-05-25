# Database Table Pattern

Standard rules for creating SQL tables in the Start-Quest database project.

## Navigation

- [Documentation Home](./index.md)
- [Product Concept](./product-concept.md)
- [Development Plan](./development-plan.md)
- [Page Template](./page-template.md)

## Overview

This document defines the default table creation pattern for Start-Quest.

The goal is to keep all database tables consistent, predictable, and easy to maintain across the backend, database project, EF-generated infrastructure entities, domain models, and repositories.

New tables should follow this pattern unless there is a clear technical reason to do otherwise.

## Table Location

New SQL table files should be created in the SQL Database Project:

```text
Backend/StartQuest/StartQuest.Database/dbo/Tables
```

Each table should have its own `.sql` file.

The file name should match the table name:

```text
Users.sql
QuestLines.sql
Quests.sql
Tasks.sql
```

After creating a new SQL file, it must be added to `StartQuest.Database.sqlproj` as a `Build Include` item.

## Default Table Structure

Most business tables should follow this base structure:

```sql
CREATE TABLE [dbo].[TableName]
(
    [Id] INT IDENTITY(1, 1) NOT NULL,

    -- Business fields

    [CreatedAt] DATETIME2 NOT NULL DEFAULT GETUTCDATE(),
    [UpdatedAt] DATETIME2 NULL,
    [DeletedAt] DATETIME2 NULL,

    [IsActive] BIT NOT NULL DEFAULT 1,

    CONSTRAINT [PK_TableName] PRIMARY KEY CLUSTERED ([Id])
);

GO
```

## Primary Key Rules

Use `INT IDENTITY(1, 1)` for regular business entities and reference tables:

```sql
[Id] INT IDENTITY(1, 1) NOT NULL
```

Use `BIGINT IDENTITY(1, 1)` for tables that can grow quickly or store large historical datasets:

```sql
[Id] BIGINT IDENTITY(1, 1) NOT NULL
```

Examples:

- `Users`, `QuestLines`, `Quests`, `Skills`, `Crafts` should usually use `INT`.
- `TimeSheetEntries`, logs, history records, transactions, and activity streams should usually use `BIGINT`.

## Standard System Fields

Most business tables should include these system fields:

```sql
[CreatedAt] DATETIME2 NOT NULL DEFAULT GETUTCDATE(),
[UpdatedAt] DATETIME2 NULL,
[DeletedAt] DATETIME2 NULL,
[IsActive] BIT NOT NULL DEFAULT 1
```

Field meanings:

- `CreatedAt` is set by the database when the row is created.
- `UpdatedAt` is set by the application when the row is updated.
- `DeletedAt` marks a row as soft-deleted.
- `IsActive` allows a row to be disabled without deleting it.

Technical tables may use a smaller or more specific set of fields when the default system fields do not fit the table lifecycle.

For example, refresh token tables may use `ExpiresAt`, `RevokedAt`, and `ReasonRevoked` instead of the full soft-delete pattern.

## Soft Delete

Business records should not be physically deleted by default.

A record is considered deleted when `DeletedAt` has a value:

```sql
[DeletedAt] DATETIME2 NULL
```

Unique indexes on soft-deletable tables should ignore deleted records:

```sql
CREATE UNIQUE INDEX [IXU_TableName_FieldName]
ON [dbo].[TableName] ([FieldName])
WHERE [DeletedAt] IS NULL;
```

This allows a deleted row to keep its historical data while the same business value can be reused later.

## Naming Conventions

Tables should use plural PascalCase names:

```sql
[Users]
[QuestLines]
[Quests]
[Tasks]
[BattlePasses]
```

Primary key constraints should use:

```text
PK_TableName
```

Foreign key constraints should use:

```text
FK_ChildTable_ParentTable_FieldName
```

Example:

```text
FK_Quests_QuestLines_QuestLineId
```

Unique indexes should use:

```text
IXU_TableName_FieldName
```

Regular indexes should use:

```text
IX_TableName_FieldName
```

Column names should use PascalCase:

```text
UserId
QuestLineId
Name
CreatedAt
IsActive
```

## Unique Indexes

Use filtered unique indexes when a business value must be unique only among non-deleted rows:

```sql
GO
CREATE UNIQUE INDEX [IXU_QuestLines_UserId_Name]
ON [dbo].[QuestLines] ([UserId], [Name])
WHERE [DeletedAt] IS NULL;
```

For user-owned data, prefer composite unique indexes that include `UserId` when uniqueness is user-scoped:

```sql
GO
CREATE UNIQUE INDEX [IXU_Tasks_UserId_Title]
ON [dbo].[Tasks] ([UserId], [Title])
WHERE [DeletedAt] IS NULL;
```

## Foreign Keys

Relationships between tables should be represented with explicit foreign key constraints.

Preferred style:

```sql
CONSTRAINT [FK_Quests_QuestLines_QuestLineId]
    FOREIGN KEY ([QuestLineId])
    REFERENCES [dbo].[QuestLines]([Id])
```

If a table has many relationships, foreign keys may be declared after `CREATE TABLE` by using `ALTER TABLE`.

Keep the style consistent inside a single table file.

## Delete Behavior

For business tables, avoid `ON DELETE CASCADE` by default because Start-Quest uses soft delete for business data.

Use application logic to decide how related business records should be archived, disabled, or soft-deleted.

`ON DELETE CASCADE` is allowed for technical child tables that have no business value without the parent row.

Example:

```sql
CONSTRAINT [FK_UserRefreshTokens_Users_UserId]
    FOREIGN KEY ([UserId])
    REFERENCES [dbo].[Users]([Id])
    ON DELETE CASCADE
```

## Common Data Types

Use `NVARCHAR` with an explicit length for regular text fields:

```sql
NVARCHAR(50)
NVARCHAR(100)
NVARCHAR(255)
NVARCHAR(512)
```

Use `NVARCHAR(MAX)` only for large text, backup codes, JSON-like data, or long descriptions.

Use `DECIMAL(38, 18)` for precise decimal values:

```sql
[Quantity] DECIMAL(38, 18) NOT NULL DEFAULT 0
```

Use `DATETIME2` for date and time values:

```sql
[ExecutedAt] DATETIME2 NOT NULL
```

Use `BIT` for boolean values:

```sql
[IsActive] BIT NOT NULL DEFAULT 1
[EmailConfirmed] BIT NOT NULL DEFAULT 0
```

## Reference Table Pattern

Use this pattern for dictionaries, types, statuses, and categories:

```sql
CREATE TABLE [dbo].[EntityTypes]
(
    [Id] INT IDENTITY(1, 1) NOT NULL,

    [Code] NVARCHAR(50) NOT NULL,
    [Name] NVARCHAR(100) NOT NULL,
    [Description] NVARCHAR(255) NULL,

    [CreatedAt] DATETIME2 NOT NULL DEFAULT GETUTCDATE(),
    [UpdatedAt] DATETIME2 NULL,
    [DeletedAt] DATETIME2 NULL,

    [IsActive] BIT NOT NULL DEFAULT 1,

    CONSTRAINT [PK_EntityTypes] PRIMARY KEY CLUSTERED ([Id])
);

GO
CREATE UNIQUE INDEX [IXU_EntityTypes_Code]
ON [dbo].[EntityTypes] ([Code])
WHERE [DeletedAt] IS NULL;
```

## User-Owned Business Table Pattern

Most productivity data in Start-Quest belongs to a specific user.

If a table stores user-owned data, it should include `UserId` directly or have a clear ownership path through a parent table.

Example:

```sql
CREATE TABLE [dbo].[QuestLines]
(
    [Id] INT IDENTITY(1, 1) NOT NULL,

    [UserId] INT NOT NULL,

    [Name] NVARCHAR(100) NOT NULL,
    [Description] NVARCHAR(255) NULL,

    [CreatedAt] DATETIME2 NOT NULL DEFAULT GETUTCDATE(),
    [UpdatedAt] DATETIME2 NULL,
    [DeletedAt] DATETIME2 NULL,

    [IsActive] BIT NOT NULL DEFAULT 1,

    CONSTRAINT [PK_QuestLines] PRIMARY KEY CLUSTERED ([Id]),

    CONSTRAINT [FK_QuestLines_Users_UserId]
        FOREIGN KEY ([UserId])
        REFERENCES [dbo].[Users]([Id])
);

GO
CREATE INDEX [IX_QuestLines_UserId]
ON [dbo].[QuestLines] ([UserId])
WHERE [DeletedAt] IS NULL;
```

## EF Scaffold

After creating or changing database tables, regenerate the EF infrastructure model.

The project uses EF-generated infrastructure files:

```text
Backend/StartQuest/StartQuest.Infrastructure/Context/StartQuestContext.cs
Backend/StartQuest/StartQuest.Infrastructure/Entities
```

The scaffold configuration is stored in:

```text
Backend/StartQuest/StartQuest.Infrastructure/efpt.config.json
```

Before running the scaffold, make sure every new table is included in the `Tables` list inside `efpt.config.json`.

Example:

```json
{
  "Name": "[dbo].[QuestLines]",
  "ObjectType": 0
}
```

Then run the EF reverse engineering/scaffold flow used by the project, usually through EF Core Power Tools or the configured EF scaffold command.

The scaffold should update:

- `StartQuestContext.cs` with new `DbSet<T>` properties and model configuration.
- `Infrastructure/Entities/*.cs` with generated entity classes.
- Foreign key relationships and indexes in the generated EF model.

Do not manually edit generated EF files unless there is no other option.

Generated files are marked with:

```csharp
// <auto-generated> This file has been auto generated by EF Core Power Tools. </auto-generated>
```

Any business-specific logic should be added in domain models, mappings, repositories, handlers, or services instead of generated infrastructure entities.

## Creation Checklist

After creating a new table:

1. Add the `.sql` file to `Backend/StartQuest/StartQuest.Database/dbo/Tables`.
2. Add the file to `StartQuest.Database.sqlproj`.
3. Check table, primary key, foreign key, and index naming.
4. Check soft-delete behavior and filtered indexes.
5. Add the table to `efpt.config.json`.
6. Run EF scaffold/reverse engineering to regenerate `StartQuestContext` and infrastructure entities.
7. Add or update the domain model.
8. Add or update mapping between infrastructure entities and domain models.
9. Add repository or service logic if the table is used by the application layer.
10. Build the database project and backend solution.

## Notes

This pattern should be treated as the default for new Start-Quest tables.

Exceptions are allowed only when a table has a different lifecycle, such as authentication tokens, logs, or temporary technical data.
