# Start-Quest Development Plan

Full development plan and completion boundaries for the Start-Quest project.

## Navigation

- [Documentation Home](./index.md)
- [Product Concept](./product-concept.md)
- [Page Template](./page-template.md)

## Overview

The purpose of this document is to define:

- Development stages
- Scope of each stage
- Clear completion criteria (Definition of Done)

Start-Quest is a full product with three main parts:

- Backend API (.NET)
- Web Application (Angular)
- Mobile Application

## Development Stages

## Stage 1 – Full System Implementation

This stage focuses on building the complete application with all core entities and functionality.

### Backend API (.NET)

- QuestLine
- Quest
- Task
- Skill
- Craft
- Daily (recurring tasks)
- Battle Pass
- TimeSheet
- Logging system
- Authentication (basic)

### Web Application (Angular)

- Full UI for all entities
- QuestLine management
- Quest and Task management
- Skills and Crafts pages
- Dailies page
- Battle Pass page
- TimeSheet page
- Integration with Backend API

### Mobile Application

- Daily tasks overview
- Quick task completion
- Time tracking
- Progress overview
- Synchronization with Backend API

Description:

The goal of this stage is to deliver a complete, usable application with all core features implemented and working together.

## Stage 2 – AI Optimization

This stage focuses on enhancing the system with AI features.

Scope:

- QuestLine Goal feature
- AI-generated plans based on goals
- AI-generated Quests and Tasks
- Productivity recommendations
- Personal progress insights
- Smart planning and optimization

Description:

AI should help users structure their work, improve focus, and optimize productivity.

## Definition of Done (DoD)

A feature is considered complete when:

- It is implemented
- It works as expected
- It is manually tested
- It does not break existing functionality
- It is committed and pushed
- Documentation is updated if needed

## Stage Completion Criteria

### Stage 1 is complete when:

- All core entities are implemented
- Users can create, update, and track QuestLines, Quests, and Tasks
- TimeSheet works correctly
- Logging system is available
- Web application fully supports all features
- Mobile application supports daily usage
- Backend API is stable and consistent

### Stage 2 is complete when:

- AI can generate structured plans from goals
- AI can create Quests and Tasks
- AI provides useful recommendations
- AI improves user productivity and planning

## Notes

- Keep implementation clean and scalable
- Avoid overengineering in early implementation
- Focus on real usability
- Build a strong backend as the foundation for all clients
