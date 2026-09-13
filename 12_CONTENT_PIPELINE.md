# Content Pipeline

## Authoring

Artists/designers create source assets.

```text
Source Asset
   ↓
Import
   ↓
Validation
   ↓
Godot Resource
   ↓
Registry
   ↓
Runtime
```

## Content ownership

Every content package has:
- stable ID
- owner domain
- version
- dependencies
- runtime entry
- validation rules

Example:

```text
content/characters/char.kiana_001/
```

Dependencies are explicit:

```text
Character
 ├── model
 ├── animation_set
 ├── material_set
 ├── abilities
 └── audio
```

## No random asset placement

Do not place assets at project root.

Do not create:

```text
res://final/
res://new/
res://test2/
res://misc/
res://assets2/
```

Temporary work belongs outside the production project or in explicitly isolated development-only locations.
