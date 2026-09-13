# SceneTree and Node Hierarchy

Scenes are runtime composition units, not the database.

## Main

```text
Main
├── Runtime
│   ├── World
│   ├── Actors
│   ├── Simulation
│   └── Cameras
├── Presentation
│   ├── HUD
│   ├── Menus
│   └── Notifications
└── Services
    ├── Audio
    ├── Input
    └── Loading
```

## Character

```text
Character
├── Visual
│   ├── Model
│   ├── Animation
│   └── VFX
├── Collision
├── Interaction
└── Presentation
```

## Rule

Parent-child means lifecycle/ownership or transform relationship.

Do not use:

```text
Root
└── Everything
    ├── UI
    ├── database
    ├── audio
    ├── enemies
    └── unrelated systems
```

Do not use global node lookups as a dependency injection mechanism.

Prefer:
- explicit references
- interfaces/contracts
- composition root
- signals/events for decoupled notifications

## Autoload policy

Autoload only when the system:
- owns global state
- has an independent lifetime
- is truly application-wide

Examples:
- GameSession
- SaveService
- ContentCatalog

Avoid making every manager an autoload.
