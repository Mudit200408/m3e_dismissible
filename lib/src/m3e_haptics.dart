import 'package:flutter/services.dart';

/// Haptic feedback intensity levels for Material 3 Expressive components.
enum M3EHapticFeedback {
  /// No haptic feedback.
  none,

  /// Light haptic impact.
  light,

  /// Medium haptic impact.
  medium,

  /// Heavy haptic impact.
  heavy,
}

/// Helper function to apply haptic feedback based on [M3EHapticFeedback].
void applyHaptic(M3EHapticFeedback haptic) {
  switch (haptic) {
    case M3EHapticFeedback.light:
      HapticFeedback.lightImpact();
      break;
    case M3EHapticFeedback.medium:
      HapticFeedback.mediumImpact();
      break;
    case M3EHapticFeedback.heavy:
      HapticFeedback.heavyImpact();
      break;
    case M3EHapticFeedback.none:
      break;
  }
}
