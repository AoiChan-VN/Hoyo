# Domain and Submodule Design

## Bounded contexts

### Combat
- damage
- hit validation
- reactions
- status effects
- abilities
- combat state

### Character
- character identity
- stats
- attributes
- animation state contracts
- character progression

### Equipment
- weapons
- artifacts/equipment
- modifiers
- rarity

### Progression
- levels
- experience
- unlocks
- ascension

### Quest
- objectives
- quest state
- triggers
- rewards

### World
- world state
- regions
- interactables
- traversal
- world events

### Economy
- currencies
- costs
- rewards
- inventories

## Submodule rule

A submodule should be created when at least one is true:
- independent lifecycle
- independent ownership
- independent testing
- multiple consumers
- platform/native boundary
- high change frequency
- clear domain boundary

Do not create a submodule for every five files.

## Public API

Each major module should expose a small contract surface.

```text
combat/
├── api/
│   ├── combat_service.gd
│   └── combat_events.gd
├── domain/
├── runtime/
└── tests/
```

Other modules depend on `api`, not internal implementation paths.
