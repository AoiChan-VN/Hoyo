# DOD / DDD / DDA / DCL Strategy

These labels are project architecture conventions, not claims that Godot itself implements these methodologies.

## DOD — Data-Oriented Design

Use for:
- large populations
- repeated per-frame simulation
- spatial queries
- projectile/bullet simulation
- crowd agents
- hit detection batches
- status-effect processing
- expensive numeric workloads

Prefer:
- contiguous arrays
- stable handles
- structure-of-arrays where profiling proves useful
- batch processing
- fewer allocations
- fewer Node calls

Do not convert every gameplay object into DOD merely for fashion.

## DDD — Domain-Driven Design

Bounded contexts:

```text
Combat
Character
Equipment
Progression
Quest
World
Economy
Social/Online (if required)
```

Each context defines:
- entities
- value objects
- aggregates
- domain services
- commands
- events
- contracts

Example:

```text
Combat
├── DamageEvent
├── DamageType
├── Combatant
├── Ability
├── StatusEffect
└── DamageResolver
```

## DDA — Data-Driven Architecture

Rules and tunables should be data where designers need iteration.

Examples:
- character stats
- skill coefficients
- enemy parameters
- item definitions
- drop tables
- stamina costs
- animation mappings
- VFX references
- localization keys

Implementation remains code; configuration becomes data.

## DCL — Data/Dependency Composition Layer

Project convention: DCL is the controlled composition boundary that connects:
- domain contracts
- data definitions
- runtime services
- concrete implementations

It prevents random systems from directly constructing dependencies.

Example:

```text
GameCompositionRoot
 ├── ContentCatalog
 ├── SaveService
 ├── CombatService
 ├── NativeSimulation
 └── SceneFlow
```

Only the composition boundary decides which implementation is used.

## Combined model

```text
DDD = meaning / boundaries
DDA = data controls behavior
DOD = efficient runtime representation
DCL = controlled composition
```
