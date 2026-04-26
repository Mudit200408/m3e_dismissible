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
