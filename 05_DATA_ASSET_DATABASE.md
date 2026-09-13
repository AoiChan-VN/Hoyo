# Data, Asset and Runtime Database

Godot does not provide a conventional centralized asset database like some large proprietary engines. This project therefore creates an explicit content-management layer on top of Godot's filesystem/resource system.

## Three databases

### 1. Definition Database

Authoritative definitions.

```text
data/catalogs/
├── characters.json
├── weapons.json
├── enemies.json
├── abilities.json
├── quests.json
└── worlds.json
```

Use stable IDs:

```text
char.kiana_001
weapon.sword_001
enemy.hilichurl_001
ability.fire_dash_001
```

### 2. Asset Registry

Maps stable content IDs to Godot resources.

```text
data/registries/
├── asset_registry.tres
├── scene_registry.tres
├── animation_registry.tres
├── vfx_registry.tres
└── audio_registry.tres
```

The runtime asks for an ID, not an arbitrary path.

### 3. Runtime State Database

Not source content.

Examples:
- player save
- quest progress
- inventory
- world state
- settings

Stored through the persistence layer and never mixed with authoring data.

## Asset ownership

```text
content/characters/<character_id>/
├── character.tscn
├── character_data.tres
├── animations/
├── materials/
├── vfx/
├── audio/
└── ui/
```

Large shared assets belong in shared libraries only when genuinely shared.

## Naming

Use:
`<domain>_<purpose>_<variant>`

Avoid:
`new`, `final`, `final2`, `test`, `copy`, `misc`.

## IDs

IDs are stable across refactors. Paths may change; IDs should not.
