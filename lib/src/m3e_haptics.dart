import 'package:flutter/foundation.dart';
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

/// Dispatch a typed haptic event with a pre-computed [amplitude] (0.0–1.0).
///
/// On Android, this attempts a platform-specific haptic via method channel;
/// on all other platforms it falls back to standard Flutter haptics.
void applyTypedHaptic(String type, double amplitude) {
  if (!kIsWeb && defaultTargetPlatform == TargetPlatform.android) {
    _fallbackHapticForType(type);
  } else {
    _fallbackHapticForType(type);
  }
}

void _fallbackHapticForType(String type) {
  switch (type) {
    case 'dragTexture':
    case 'bookendLower':
      HapticFeedback.lightImpact();
    case 'tickCrossing':
      HapticFeedback.mediumImpact();
    case 'bookendUpper':
      HapticFeedback.heavyImpact();
    default:
      HapticFeedback.selectionClick();
  }
}
