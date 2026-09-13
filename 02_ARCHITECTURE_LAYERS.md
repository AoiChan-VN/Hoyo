# Architecture Layers

## 1. Presentation

Owns:
- HUD
- menus
- screens
- animation presentation
- UI input interpretation

Must not own:
- authoritative combat rules
- persistence schema
- asset discovery
- low-level algorithms

## 2. Application

Owns:
- use cases
- game session lifecycle
- scene transitions
- loading orchestration
- save/load orchestration

Example:
`StartBattleUseCase`
`LoadCharacterUseCase`
`EnterWorldUseCase`

## 3. Domain

Owns game meaning and rules.

Examples:
- Character
- Ability
- DamageRule
- StatusEffect
- Equipment
- QuestState
- ProgressionRule

Domain code should remain testable without a running scene tree whenever possible.

## 4. Infrastructure

Owns external concerns:
- file persistence
- network clients
- platform APIs
- telemetry
- localization backend
- content loading
- native adapter

## 5. Engine

Owns Godot-specific runtime concerns:
- Node lifecycle
- SceneTree
- AnimationTree
- physics integration
- RenderingServer/PhysicsServer usage
- audio playback

## Dependency direction

```text
Presentation
     ↓
Application
     ↓
Domain ← contracts
     ↑
Infrastructure
     ↑
Engine / Platform adapters
```

A domain object should not call `get_tree()`, search nodes globally, load arbitrary paths, or know a concrete UI class.
