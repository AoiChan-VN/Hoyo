# Separate GitHub Actions Pipeline

GitHub Actions exists in the Native C++ repository only.

## Pipeline

```text
commit / tag
    ↓
checkout
    ↓
setup compiler
    ↓
checkout/update godot-cpp
    ↓
configure build
    ↓
compile
    ↓
unit tests
    ↓
ABI/API validation
    ↓
package
    ↓
publish artifact
```

## Artifact

Example:

```text
game-native/
└── linux-x86_64/
    ├── libgame_native.so
    ├── game_native.gdextension
    └── manifest.json
```

The Godot project receives the approved artifact through the project's controlled dependency/update process.

## Required metadata

```json
{
  "native_version": "1.0.0",
  "godot_version": "4.7.2",
  "platform": "linux",
  "architecture": "x86_64",
  "build_type": "release",
  "git_revision": "<commit>",
  "api_version": 1
}
```

## Rule

Never commit:
- compiler cache
- temporary build directories
- local IDE files
- unversioned generated binaries as source
- entire Godot project into the Native repository
