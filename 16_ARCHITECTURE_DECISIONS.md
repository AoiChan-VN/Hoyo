# Architecture Decision Records

## ADR-001 — Separate Native Repository

Decision:
Native C++ source and GitHub Actions live outside the Godot project.

Reason:
Keeps engine project focused on game/runtime content and prevents build-system pollution.

## ADR-002 — GDExtension Instead of Engine Fork

Decision:
Use GDExtension for native C++ unless a requirement specifically needs an engine modification.

Reason:
Native code can be compiled independently and loaded as a shared library.

## ADR-003 — Stable Content IDs

Decision:
Runtime code references stable IDs rather than arbitrary filesystem paths.

Reason:
Allows asset relocation and controlled content evolution.

## ADR-004 — Domain Before Scene

Decision:
Gameplay rules belong to domain/application layers; scenes are runtime composition.

Reason:
Prevents gameplay logic from becoming coupled to NodeTree layout.

## ADR-005 — Native Only for Proven Hotspots

Decision:
C++ is introduced based on profiling.

Reason:
Native code adds ABI/build/release complexity and should pay for itself through measurable performance or capability gains.
