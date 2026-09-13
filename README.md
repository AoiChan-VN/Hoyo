# AAA Godot 4.7.2 Architecture Documentation

This package defines the production architecture for a mobile-first action RPG using Godot 4.7.2, GDScript and a separate Native C++ GDExtension repository.

## Documents

- `00_MASTER_ARCHITECTURE.md`
- `01_PROJECT_FOLDER_TREE.md`
- `02_ARCHITECTURE_LAYERS.md`
- `03_DOD_DDD_DDA_DCL.md`
- `04_DOMAIN_AND_SUBMODULES.md`
- `05_DATA_ASSET_DATABASE.md`
- `06_SCENE_NODE_HIERARCHY.md`
- `07_NATIVE_CPP_REPOSITORY.md`
- `08_GDEXTENSION_CONTRACT.md`
- `09_GITHUB_ACTIONS_PIPELINE.md`
- `10_PERFORMANCE_MOBILE.md`
- `11_TESTING_VALIDATION.md`
- `12_CONTENT_PIPELINE.md`
- `13_GIT_REPOSITORY_BOUNDARIES.md`
- `14_DEVELOPMENT_RULES.md`
- `15_IMPLEMENTATION_ROADMAP.md`
- `16_ARCHITECTURE_DECISIONS.md`
- `17_RELEASE_CHECKLIST.md`

## Repository model

```text
[GameProject repository]
    Godot Editor project
    GDScript / scenes / Resources / content / registries
                 │
                 │ consumes approved artifact
                 ▼
[Native C++ repository]
    C++ / godot-cpp / tests / GitHub Actions
                 │
                 ▼
        libgame_native.so
```

The C++ repository is not embedded into the Godot project repository.
