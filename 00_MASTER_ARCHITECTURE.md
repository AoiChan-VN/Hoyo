# AAA Godot Project — Master Architecture

## Baseline

- Engine: Godot Engine 4.7.2 Stable
- Target: Mobile-first action RPG
- Design reference: Genshin + Honkai Impact, without copying proprietary implementation or assets
- Runtime languages: GDScript + Native C++ through GDExtension
- Godot project and Native C++ build repository are separate deliverables.
- The Godot project contains only the native runtime artifact required to load the extension (`.gdextension` + platform library).
- Native C++ source, toolchains, CI/CD and build output remain outside the Godot project repository.

## Architectural principles

1. Domain boundaries before convenience.
2. Data ownership is explicit.
3. Runtime code does not discover arbitrary files.
4. Assets are addressed through stable IDs and registries.
5. Scenes represent runtime composition; Resources represent data/configuration.
6. Nodes are used where scene-tree lifecycle/transform/signals are useful, not as universal objects.
7. High-frequency, allocation-sensitive systems may move to C++.
8. GDScript remains the orchestration/gameplay layer where iteration speed matters.
9. Dependencies point inward toward contracts/domain abstractions.
10. Every subsystem has an owner, public API, lifecycle and test boundary.
11. No "misc", "stuff", "temp", "helpers" dumping grounds in production.
12. Build artifacts never become source-of-truth assets.
13. Content is versioned independently from implementation where practical.
14. Profiling precedes native optimization.

## Layer model

Presentation
→ Application
→ Domain
→ Infrastructure
→ Engine/Platform

Data follows:
Authoring Data → Import/Build → Catalog/Registry → Runtime Resources → Runtime State

Native C++ follows:
Godot-facing Adapter → Native Services → Algorithms/Data → Platform-independent Core

## Dependency rule

Presentation may depend on Application contracts.
Application may depend on Domain contracts.
Domain must not depend on Godot scene nodes.
Infrastructure implements Application/Domain contracts.
Godot/Native adapters may depend on infrastructure and engine APIs.

Never reverse these dependencies merely to avoid writing an interface.
