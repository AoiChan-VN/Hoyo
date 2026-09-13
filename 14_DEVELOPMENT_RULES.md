# Development Rules

## Forbidden

- dumping files into `res://`
- generic `utils` as an architectural dumping ground
- global node searches in hot paths
- making every system an Autoload
- storing gameplay state inside UI nodes
- hardcoding content paths throughout gameplay code
- direct access to another module's internal implementation
- committing local `.godot` editor state as project content
- committing C++ build directories
- embedding GitHub Actions inside the Godot project
- moving code to C++ without profiling evidence
- creating parallel duplicate databases

## Required

- stable content IDs
- explicit ownership
- module API boundaries
- dependency direction
- registries for runtime content lookup
- validation before release
- documented native ABI/version
- deterministic build artifacts
- performance budgets
- tests for domain rules

## Definition of Done for a system

A system is not complete until:
- architecture boundary is defined
- public API is documented
- data ownership is defined
- dependencies are known
- lifecycle is known
- tests exist where practical
- profiler impact is measured when performance-sensitive
- content dependencies are registered
- failure behavior is defined
