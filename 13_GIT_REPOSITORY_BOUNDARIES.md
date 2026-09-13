# Repository Boundaries

## Repository A — Game

```text
GameProject/
```

Contains:
- Godot scenes
- GDScript
- Resources
- content
- registries
- configuration
- native binary dependency

## Repository B — Native

```text
GameNative/
```

Contains:
- C++
- godot-cpp
- native tests
- build scripts
- GitHub Actions
- native release artifacts

## Optional Repository C — Source Art

Only if production scale requires it:

```text
GameArt/
```

Contains:
- Blender/Maya source
- textures
- concept art
- raw audio
- source exports

The runtime Godot project receives approved/exported assets.

## Why

This prevents:
- Godot repo bloat
- CI/build pollution
- accidental compiler/toolchain commits
- asset source/runtime mixing
- unclear ownership
- senior-dev maintenance overhead
