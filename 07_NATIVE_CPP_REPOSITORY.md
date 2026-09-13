# Native C++ Repository

Repository name example:

```text
GameNative/
```

This repository is separate from the Godot game project.

```text
GameNative/
├── README.md
├── LICENSE
├── .gitignore
├── .gitattributes
├── SConstruct
├── godot-cpp/
│
├── src/
│   ├── register_types.cpp
│   ├── native/
│   │   ├── combat/
│   │   ├── simulation/
│   │   ├── navigation/
│   │   └── math/
│   └── adapters/
│
├── include/
│   └── game_native/
│
├── tests/
├── platform/
│   ├── linux/
│   ├── android/
│   └── windows/
│
├── config/
│   └── build_profiles/
│
├── .github/
│   └── workflows/
│       ├── build-linux.yml
│       ├── build-android.yml
│       └── release.yml
│
└── dist/
    └── artifacts/
```

## Boundary

The C++ repository does not contain the entire Godot game.

The Godot project consumes only the published native artifact:

```text
GameNative CI
    ↓
libgame_native.so
    ↓
GameProject/addons/native/bin/<platform>/
```

## Native responsibilities

Good candidates:
- CPU-heavy simulation
- batch math
- path/geometry algorithms
- deterministic simulation
- large-scale entity processing
- specialized data structures

Poor candidates:
- simple UI logic
- scene transitions
- ordinary button interactions
- one-off gameplay orchestration
- code moved to C++ without profiling evidence
