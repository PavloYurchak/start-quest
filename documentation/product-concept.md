# Start-Quest Product Concept

Core product idea and first-stage domain model for the Start-Quest project.

## Navigation

- [Documentation Home](./index.md)
- [Page Template](./page-template.md)

## Product Idea

Start-Quest is an application designed to optimize time, improve focus, and help manage personal productivity.

The concept is inspired by games: quests, quest lines, tasks, skills, crafts, challenges, and rewards.

The goal is to make everyday life and work feel structured, trackable, and engaging, similar to progressing in a game.

## QuestLine Goal Feature

The application will also support a `QuestLine Goal` feature.

When a user creates a QuestLine, they define a high-level objective.

The system then helps build a structured plan to achieve that objective.

Using AI, the application will automatically generate a hierarchy of Quests and Tasks, providing a clear step-by-step path toward the goal.

## Core Entities

### QuestLine

- Similar to an Epic in Jira
- Represents a high-level goal
- Groups related Quests, Tasks, Skills, and Crafts

### Quest

- A larger unit of work
- Can contain multiple Tasks
- May be associated with Skills as progress markers or rewards

### Task

- A single, concrete action
- Solves a specific problem or represents a clear step

### Skill

- A capability or knowledge gained while completing Tasks or Quests
- Can be used as a reward, but it is not mandatory

### Craft

- A practical result or outcome
- Can be derived from a Skill or granted as a reward for completing Tasks or Quests

### Daily

- A recurring task or habit
- Covers activities such as gym, routines, responsibilities, or scheduled actions

### Battle Pass

- A challenge system
- Allows users to create one or multiple battle passes for personal challenges

### TimeSheet

- A system for tracking time spent on tasks
- Helps measure productivity and log personal activity for self-analysis

## First Stage (MVP)

The first stage should focus on implementing the core domain and basic productivity features:

- QuestLines
- Quests
- Tasks
- Skills
- Crafts
- Dailies
- Battle Passes
- TimeSheet
- Basic logging for self-monitoring

The goal of this stage is to create a functional system that allows users to organize and track their work and personal progress.

## Second Stage

The second stage should focus on AI integration.

AI can be used for:

- Task and quest generation
- Productivity analysis
- Recommendations
- Personal progress insights
- Smart planning and optimization

## General Requirements

- Use clean and simple Markdown structure
- Use headings and bullet points
- Keep the design simple and extendable
- Do not overcomplicate architecture at this stage
- Focus on clarity and scalability for future development
