# Testing and Validation

## Test layers

```text
Unit
 ↓
Domain
 ↓
Integration
 ↓
Runtime
 ↓
Performance
 ↓
Device validation
```

## Unit

Tests pure rules:
- damage
- stats
- progression
- quest transitions
- inventory
- resource calculations

## Integration

Tests:
- content registry
- save/load
- scene composition
- native adapter
- resource loading

## Performance

Measure:
- CPU frame time
- GPU frame time
- memory
- allocations
- draw calls
- scene-tree operations
- loading time
- thermal throttling
- battery impact

## Validation gates

A release candidate should pass:
- project import
- headless validation where applicable
- content registry validation
- missing-resource scan
- native library load
- automated tests
- target-device smoke test
- performance budget checks
