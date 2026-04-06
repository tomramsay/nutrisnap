# Contributing to NutriSnap

## Branch Strategy

- `main` — stable, production-ready
- `develop` — integration branch
- `feature/*` — feature branches off develop
- `fix/*` — bug fix branches

## Commit Convention

We use [Conventional Commits](https://www.conventionalcommits.org/):

```
feat: add photo food recognition
fix: correct calorie calculation for rice
chore: update dependencies
docs: update README setup steps
style: format dart files
refactor: extract nutrition calculator
test: add unit tests for TDEE formula
```

## Pull Requests

1. Create a feature branch from `develop`
2. Write tests for new features
3. Ensure `flutter analyze` passes with no issues
4. Ensure `flutter test` passes
5. Submit PR with a clear description

## Code Style

- Follow [Effective Dart](https://dart.dev/effective-dart)
- Run `dart format .` before committing
- Use Riverpod for all state management
- Use Freezed for all data models
