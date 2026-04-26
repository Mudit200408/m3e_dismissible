# M3E Dismissible

![M3E Intro](https://raw.githubusercontent.com/Mudit200408/m3e_dismissible/main/doc/intro.png)

A comprehensive Flutter package providing expressive, Material 3 card lists with dynamically rounded corners inside normal `ListView`s and `CustomScrollView`s (via slivers). It offers **interactive dismissible cards** featuring expressive M3 styling and spring physics.

It automatically calculates and draws the corners to fit exactly the [Material 3 Expressive](https://m3.material.io/blog/building-with-m3-expressive) spec for adjacent items. It gives extensive customization options including customizable splash ripples, custom border colors, custom elevation and highly tunable haptic feedback along with stiffness and damping for animations.

---

## 🎮 Interactive Demo

You can try out the package demo here: [m3e_core demo](https://mudit200408.github.io/m3e_core/)

---

## 🚀 Features

- **Dynamic border radius:** The first and last items get a larger outer radius while adjoining cards receive a smaller inner radius seamlessly.
- **Physics & Animations:** Spring-driven physics for dragging. Neighbour-pull effects on swipe.
- **Highly Customizable:** Complete control over gaps, radii, colors, haptics, and padding.
- **Sliver & Column Support:** Provides Slivers and Column wrappers out of the box to beautifully tie into complex layouts.

---

## ⚠️ Breaking Changes (v0.1.0)

- The `neighbourStiffness` and `neighbourDamping` properties have been removed and replaced with a single `neighbourMotion` property of type `M3EMotion`.
- Haptic properties (`hapticOnTap` and `hapticOnThreshold`) now accept the `M3EHapticFeedback` enum instead of integer constants for better type safety and clarity.

---

## 📦 Installation

```yaml
dependencies:
  m3e_dismissible: ^0.1.0
```

```dart
import 'package:m3e_dismissible/m3e_dismissible.dart';
```

---
## 🧩 Components & Usage

## M3E Dismissible Cards
Swipe-to-dismiss items with a beautiful spring-driven "neighbour pull" effect.

### 🔴 Dismissible M3E (Gmail Style)

<img src="https://raw.githubusercontent.com/Mudit200408/m3e_dismissible/main/doc/dismissible-gmail.gif"  height="450" alt="Dismissible M3E List"/>

### 🔴 Dismissible M3E (neighbourPull: 50.0, neighbourReach: 3, stiffness: 500, damping: 0.25, dismissThreshold: 0.6)

<img src="https://raw.githubusercontent.com/Mudit200408/m3e_dismissible/main/doc/dismissible-highPull.gif"  height="450" alt="Dismissible M3E High Pull"/>

### Usage:

```dart
M3EDismissibleCardList(
  itemCount: items.length,
  itemBuilder: (ctx, i) => Text(items[i].title),
  onDismiss: (i, dir) async { 
    items.removeAt(i); 
    return true; 
  },
  style: const M3EDismissibleCardStyle(
    outerRadius: 24,
    dismissThreshold: 0.3,
    neighbourPull: 12.0,
  ),
)
```

**`M3EDismissibleCardList` Parameters:**
| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `itemCount` | `int` | **Required** | Number of data items. |
| `itemBuilder` | `IndexedWidgetBuilder` | **Required** | Builds content for each item. |
| `onDismiss` | `Future<bool> Function(int, DismissDirection)?` | `null` | Called when swipe exceeds threshold. Return `true` to dismiss. |
| `onTap` | `void Function(int)?` | `null` | Called on tap (blocked during drag). |
| `style` | `M3EDismissibleCardStyle` | `const M3EDismissibleCardStyle()` | Visual and interaction configuration. |
| `physics` | `ScrollPhysics?` | `null` | Scroll physics override. |
| `scrollController` | `ScrollController?` | `null` | Scroll controller. |
| `listPadding` | `EdgeInsetsGeometry?` | `null` | Padding around the entire list. |
| `shrinkWrap` | `bool` | `false` | Whether the list should shrink-wrap its children. |
| `clipBehavior` | `Clip` | `Clip.hardEdge` | Clip behavior for the list. |

**`M3EDismissibleCardStyle` Parameters:**
| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `outerRadius` | `double` | `18.0` | Outer corner radius for first/last/single items. |
| `innerRadius` | `double` | `4.0` | Inner corner radius for middle items. |
| `selectedBorderRadius` | `double?` | `null` | Radius applied to the dragged card once threshold is crossed. |
| `backgroundBorderRadius` | `double?` | `100` | Radius applied to the background when swiping start-to-end. |
| `secondaryBackgroundBorderRadius` | `double?` | `100` | Radius applied to the secondary background when swiping end-to-start. |
| `collapseSpeed` | `double` | `50` | Speed of collapse animation after the card is dismissed. Higher Number = Faster Collapse, Lower Number = Slower Collapse |
| `gap` | `double` | `3.0` | Vertical gap between cards. |
| `color` | `Color?` | `surfaceContainerHighest` | Card background colour. |
| `padding` | `EdgeInsetsGeometry?` | `null` | Inner padding of each card's content area. |
| `margin` | `EdgeInsetsGeometry?` | `null` | Outer margin around each card. |
| `border` | `BorderSide?` | `null` | Optional border drawn on every card. |
| `elevation` | `double` | `0.0` | Resting elevation. |
| `background` | `Widget?` | `null` | Revealed background when swiping start-to-end. |
| `secondaryBackground` | `Widget?` | `null` | Revealed background when swiping end-to-start. |
| `splashColor` | `Color?` | `null` | Ink splash color. |
| `highlightColor` | `Color?` | `null` | Ink highlight color. |
| `splashFactory` | `InteractiveInkFeatureFactory?` | `null` | Splash factory. |
| `enableFeedback` | `bool` | `true` | Whether gestures provide acoustic/haptic feedback. |
| `hapticOnTap` | `M3EHapticFeedback` | `none` | Haptic feedback intensity on tap. |
| `dismissThreshold` | `double` | `0.2` | Fraction of width before dismiss triggers. |
| `hapticOnThreshold` | `M3EHapticFeedback` | `light` | Haptic feedback level when crossing dismiss threshold. |
| `dismissHapticStream` | `bool` | `false` | Fire continuous light haptics during drag. |
| `neighbourPull` | `double` | `8.0` | Maximum pixel offset applied to neighbouring cards. |
| `neighbourReach` | `int` | `3` | How many cards above + below the dragged card are affected. |
| `neighbourMotion` | `M3EMotion` | `800/0.7` | Spring motion for neighbour snapping. |
| `snapBackMotion` | `M3EMotion` | `380/0.6` | Motion for snapping back when drag is released below threshold. |
| `flyMotion` | `M3EMotion` | `400/0.8` | Motion for flying off screen when drag is released above threshold. |

> *Variants Available:* `SliverM3EDismissibleCardList`, `M3EDismissibleCardColumn`

---

## 🏗️ Motion System (`M3EMotion`)

Spring physics presets for animations. All presets use specific stiffness and damping values to achieve their respective feels.

### 🏗️ Spatial Presets (Shape Morphing)
Used for animating the container shape and border radius.

| Preset Name | Stiffness | Damping | Description |
|---|---|---|---|
| `standardSpatialFast` | `1400` | `0.9` | Snappy spring for responsive feel. |
| `standardSpatialDefault`| `700` | `0.9` | Balanced spring for general use. |
| `standardSpatialSlow` | `300` | `0.9` | Relaxed spring for dramatic feel. |
| `aospSpatial` | `380` | `1.0` | Matches AOSP's notification list feel (no bounce). |
| `expressiveSpatialFast` | `800` | `0.6` | Bouncier spring for expressive feel. |
| `expressiveSpatialDefault`| `380` | `0.75` | Bouncy, balanced spring for expressive feel. |
| `expressiveSpatialSlow` | `200` | `0.8` | Very bouncy spring for dramatic expressive feel. |

### ✨ Effects Presets (Opacity/Scale)
Used for internal content animations like cross-fades.

| Preset Name | Stiffness | Damping | Description |
|---|---|---|---|
| `standardEffectsFast` | `3800` | `1.0` | Snappy effect animation. |
| `standardEffectsDefault`| `1600` | `1.0` | Balanced effect animation. |
| `standardEffectsSlow` | `800` | `1.0` | Relaxed effect animation. |
| `expressiveEffectsFast` | `3800` | `1.0` | Snappy expressive effect. |
| `expressiveEffectsDefault`| `1600` | `1.0` | Balanced expressive effect. |
| `expressiveEffectsSlow` | `800` | `1.0` | Relaxed expressive effect. |

### 🛠️ Custom Motion
Create a custom spring with specific physics:
```dart
M3EMotion.custom(stiffness: 380, damping: 0.75, snapToEnd: false)
```

---

### 🎯 Check the [Example](https://github.com/Mudit200408/m3e_dismissible/tree/main/example) App for more details. 

---
## 🐞 Found a bug? or ✨ You have a Feature Request?

Feel free to open a [Issue](https://github.com/Mudit200408/m3e_dismissible/issues) or [Contribute](https://github.com/Mudit200408/m3e_dismissible/pulls) to the project.

Hope You Love It!

----
## Credits
- [Motor](https://pub.dev/packages/motor) Pub Package for Expressive Animations
- Claude and Gemini for helping me with the code and documentation.

### Radhe Radhe 🙏
