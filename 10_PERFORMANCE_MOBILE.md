# Mobile Performance Architecture

## Priority

1. Avoid unnecessary work.
2. Avoid unnecessary allocations.
3. Avoid unnecessary Node traversal/calls.
4. Batch high-frequency processing.
5. Profile before moving code to native.
6. Control memory lifetime.
7. Keep rendering and simulation budgets explicit.

## Frame budget

For 60 FPS:

```text
16.67 ms/frame
```

This is a total budget shared by:
- game logic
- physics
- animation
- rendering submission
- GPU work
- UI
- audio
- OS/runtime overhead

## Hot path policy

A system qualifies for native consideration when profiling shows:
- sustained CPU hotspot
- high call frequency
- large entity count
- expensive math
- measurable frame-time impact

## Avoid

```gdscript
for enemy in get_tree().get_nodes_in_group("enemies"):
    ...
```

on critical per-frame paths when a maintained registry or simulation buffer can avoid repeated scene-tree traversal.

Prefer:
- cached references
- event-driven updates
- registries
- batches
- explicit update lists

## Rendering

Avoid permanent redraw loops unless required.

For custom drawing:
- redraw only when state changes
- batch where appropriate
- avoid unnecessary material/state changes
- keep UI hierarchy controlled

## Memory

Every frequently created object should have an intentional lifetime strategy.

Use pooling only when profiling proves allocation churn is a problem.
