# Changelog

## [1.1.0] - 2025-11-19

### Added
- **Dynamic Coloring**: Particles and lines can now change color based on their position using `particleColorBuilder` and `lineColorBuilder`.
- **Split Screen Effect**: New `SplitScreenParticleSystem` widget for easy diagonal split-screen effects.
- **Customizable Presets**: Static presets like `Bubbles`, `Rain`, and `Snow` are now customizable methods (e.g., `ParticleConfig.bubbles(colors: [...])`).

### Changed
- **Deprecation Fixes**: Replaced `withOpacity` with `withValues` for compatibility with newer Flutter versions.
- **Rain Effect**: Improved density and continuity for a more realistic look.