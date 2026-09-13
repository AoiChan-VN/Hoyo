# GDExtension Contract

Godot loads the native shared library through a `.gdextension` file.

Example structure:

```text
addons/native/
├── game_native.gdextension
└── bin/
    └── linux.x86_64/
        └── libgame_native.so
```

Example configuration concept:

```ini
[configuration]

entry_symbol = "game_native_init"
compatibility_minimum = "4.7"

[libraries]

linux.x86_64 = "res://addons/native/bin/linux.x86_64/libgame_native.so"
```

The exact compatibility/version values must be generated and validated against the actual Godot/godot-cpp build used for release.

## API rule

Expose a narrow Godot-facing adapter:

```text
GDScript
   ↓
NativeCombatService
   ↓
Native core
```

Do not expose internal C++ containers or implementation details unnecessarily.

## ABI discipline

Every release records:
- Godot version
- godot-cpp revision
- compiler
- architecture
- build type
- optimization flags
- platform
- native API version

The `.so` is a release artifact, not a source file.
