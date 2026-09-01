## 1.0.1

### Added

- `M3ESwipeAction` — expressive vertical pill action buttons revealed on swipe with staggered reveal animation.
- `actions` and `secondaryActions` parameters on `M3EDismissibleCardStyle` for swipe-to-reveal action buttons.
- `direction` parameter on `M3EDismissibleCardStyle` to control allowed swipe directions (`DismissDirection`).
- `emptyBuilder` parameter on all list variants for empty-state widgets.
- `autoExecutePrimaryOnFullSwipe` — auto-trigger primary action when swiping past threshold.
- `actionRevealTrigger` — single-point interaction triggers (tap, double-tap, long-press) for accessibility.
- `actionSpacing` — configurable spacing between revealed action buttons.
- `toggleRevealActions` and `revealActionsAtIndex` methods on the controller for programmatic action reveal.
- `applyTypedHaptic` for more nuanced haptic feedback during drag.

### Changed

- Improved card settle curve from overshooting spring to `easeOutCubic`.
- Updated card background color default from `surfaceContainerHighest` to `surfaceContainer`.
- Improved dismiss callback behavior — now cancels dismissal properly when consumer returns `false`.

## 1.0.0

- pubspec: migrate to standalone material_ui package for flutter 3.47
- pubspec: Update the minimum flutter SDK to 3.47.0

## 0.1.2
* Allow overriding or disabling drop shadows via `boxShadow` in `M3EDismissibleCardStyle` (#1)
* Fix drop shadow rendering so setting `elevation` to `0` eliminates shadows automatically (#1)

## 0.1.1
* fix: respect onDismiss return value to allow canceling dismissals (#2) [Contributed by RZI3D]
* Add example showing the onDismiss fixup in M3EDismissible 

## 0.1.0
* **Performance Overhaul**: Significantly reduced widget rebuilds and object allocations during drag animations.
* **New Motion API**: Exposed `snapBackMotion` and `flyMotion` in `M3EDismissibleCardStyle`.
* **Advanced Haptics**: Added granular control over tap, threshold, and stream haptics via `M3EHapticFeedback`.
* **Flexible Styling**: Added support for `innerRadius`, `outerRadius`, `selectedBorderRadius`, and `gap` customization.
* **Stability**: Fixed animation jank during card collapse and addressed several controller lifecycle edge cases.
* **Breaking Changes**:
    - The `neighbourStiffness` and `neighbourDamping` properties have been removed and replaced with a single `neighbourMotion` property of type `M3EMotion`.
    - Haptic properties (like `hapticOnTap` and `hapticOnThreshold`) now accept the `M3EHapticFeedback` enum instead of integer constants for better type safety and clarity.

## 0.0.1
* Initial Release
* Implemented M3E Dismissible Cards with Sliver, ListView & Column support
* Added Support for Customizable Haptics, Spring Physics, and Follows Material 3 Expressive Styling
