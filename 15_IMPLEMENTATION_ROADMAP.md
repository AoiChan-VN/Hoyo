# Implementation Roadmap

## Phase 0 — Foundation

- create Godot project
- create folder boundaries
- establish naming conventions
- create architecture docs
- establish Git repository

## Phase 1 — Runtime Core

- bootstrap
- composition root
- scene flow
- input
- save service
- content catalog
- logging

## Phase 2 — Domain

- character
- combat
- ability
- equipment
- progression
- quest
- world

## Phase 3 — Content Pipeline

- stable IDs
- registries
- validation
- content loading
- localization
- asset dependency checks

## Phase 4 — Native

- create separate GameNative repository
- integrate godot-cpp
- define narrow GDExtension API
- implement one profiled hotspot
- build `.so`
- validate artifact inside Godot project

## Phase 5 — Mobile

- target-device profiling
- memory budget
- thermal tests
- loading/streaming
- rendering scalability
- input/UI optimization

## Phase 6 — Production

- CI validation
- release artifacts
- versioning
- regression tests
- content locking
- release branch policy
