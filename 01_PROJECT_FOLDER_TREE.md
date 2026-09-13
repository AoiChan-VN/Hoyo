# Production Project Folder Tree

The following is the Godot Editor project. It intentionally does NOT contain the C++ source repository or CI/CD repository.

```text
GameProject/
├── project.godot
├── icon.svg
├── README.md
├── LICENSE
├── CHANGELOG.md
│
├── .gitignore
├── .gitattributes
│
├── addons/
│   └── native/
│       ├── game_native.gdextension
│       └── bin/
│           ├── linux.x86_64/
│           │   └── libgame_native.so
│           ├── android.arm64/
│           │   └── libgame_native.so
│           └── .../
│
├── app/
│   ├── bootstrap/
│   │   ├── main.tscn
│   │   └── main.gd
│   ├── application/
│   │   ├── game_session/
│   │   ├── scene_flow/
│   │   ├── loading/
│   │   └── save/
│   └── presentation/
│       ├── hud/
│       ├── menus/
│       ├── screens/
│       └── transitions/
│
├── domain/
│   ├── combat/
│   │   ├── entities/
│   │   ├── components/
│   │   ├── systems/
│   │   ├── rules/
│   │   └── contracts/
│   ├── character/
│   ├── equipment/
│   ├── progression/
│   ├── quest/
│   ├── world/
│   └── economy/
│
├── features/
│   ├── player/
│   ├── enemies/
│   ├── bosses/
│   ├── abilities/
│   ├── interaction/
│   ├── camera/
│   └── traversal/
│
├── engine/
│   ├── scene/
│   ├── input/
│   ├── animation/
│   ├── audio/
│   ├── physics/
│   ├── rendering/
│   ├── streaming/
│   └── threading/
│
├── infrastructure/
│   ├── persistence/
│   ├── content/
│   ├── localization/
│   ├── telemetry/
│   ├── networking/
│   └── platform/
│
├── data/
│   ├── schemas/
│   ├── catalogs/
│   ├── registries/
│   ├── tables/
│   ├── configs/
│   └── localization/
│
├── content/
│   ├── characters/
│   ├── enemies/
│   ├── bosses/
│   ├── weapons/
│   ├── skills/
│   ├── worlds/
│   ├── levels/
│   ├── quests/
│   ├── ui/
│   ├── audio/
│   ├── vfx/
│   ├── materials/
│   └── cinematics/
│
├── assets/
│   ├── source/
│   │   ├── art/
│   │   ├── audio/
│   │   └── video/
│   ├── imported/
│   └── generated/
│
├── shared/
│   ├── resources/
│   ├── interfaces/
│   ├── utilities/
│   └── constants/
│
├── tests/
│   ├── unit/
│   ├── integration/
│   ├── performance/
│   └── fixtures/
│
├── tools/
│   ├── editor/
│   ├── validation/
│   └── content/
│
└── docs/
    ├── architecture/
    ├── systems/
    ├── data/
    ├── content/
    ├── performance/
    └── production/
```

## Important boundary

The following do NOT live here:

```text
GameNative/
├── src/
├── include/
├── godot-cpp/
├── SConstruct
├── platform/
├── tests/
├── .github/
└── build/
```

That is a separate repository.

Likewise, generated `.so`, `.dll`, `.dylib` files are build artifacts. They are not C++ source and must never become the architecture's source-of-truth.
