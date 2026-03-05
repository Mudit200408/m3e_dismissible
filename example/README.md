# M3E Dismissible Example App

This example app demonstrates the various components and layouts provided by the `m3e_dismissible` package.

![M3E Intro](https://raw.githubusercontent.com/Mudit200408/m3e_dismissible/main/doc/intro.png)

## 📌 Overview

The example application is designed to showcase the power and flexibility of the **M3E Dismissible** package. It contains three main tabs demonstrating the different layout wrappers available:

1.  **ListView (`M3EDismissibleCardList`)**: The standard scrollable list.
2.  **Sliver (`SliverM3EDismissibleCardList`)**: For advanced scrolling effects within a `CustomScrollView`.
3.  **Column (`M3EDismissibleCardColumn`)**: For static, non-scrolling vertical layouts.

---

## 🎨 Gmail-Style UI

<img src="https://raw.githubusercontent.com/Mudit200408/m3e_dismissible/main/doc/dismissible-gmail.gif"  height="450" alt="Dismissible M3E List"/>

In the example app, the Gmail-style UI (pull-to-load more or showing a loader at the end smoothly) is achieved by:

1. **Lazy Loading Indicator**: Returning a loading tile widget when `index == items.length`.

```dart
class LoadingTile extends StatelessWidget {
  const LoadingTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            width: 18,
            height: 18,
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
          const SizedBox(width: 12),
          Text(
            'Loading more…',
            style: TextStyle(
              fontSize: 13,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}
```
2. **Custom Dismiss Style**: Applying an expressive dismiss style with rounded backgrounds.

Here is how you can easily configure the beautiful delete and archive backgrounds with spring haptics:

```dart
M3EDismissibleCardStyle getDismissStyle() => M3EDismissibleCardStyle(
  hapticOnTap: 1,
  hapticOnThreshold: 1,
  backgroundBorderRadius: 100, // Fully rounded behind the card when swiped
  secondaryBackgroundBorderRadius: 100,
  collapseSpeed: 60,
  dismissHapticStream: true, // Continuous haptics during interaction
  dismissThreshold: 0.3,
  background: Container(
    color: const Color.fromARGB(255, 80, 218, 87),
    alignment: Alignment.center,
    child: const Icon(Icons.archive, color: Colors.white, size: 28),
  ),
  secondaryBackground: Container(
    color: Colors.red.shade600,
    alignment: Alignment.center,
    child: const Icon(Icons.delete, color: Colors.white, size: 28),
  ),
);
```

---

## 💻 Layout Showcases

### 1. ListView (`M3EDismissibleCardList`)

Perfect for a standalone, scrollable list of dismissible items. The example implements infinite scrolling by detecting the scroll position and simulating a network load.

```dart
M3EDismissibleCardList(
  itemCount: items.length,
  onDismiss: (index, direction) async {
    items.removeAt(index);
    // Return true to successfully dismiss, false to cancel and snap back
    return true; 
  },
  itemBuilder: (context, index) => buildEmailTile(context, items[index]),
)
```

### 2. Sliver (`SliverM3EDismissibleCardList`)

Ideal when you need dismissible lists to integrate with other scrollable content, like a `SliverAppBar` or various `SliverPadding` sections in a unified `CustomScrollView`.

```dart
CustomScrollView(
  slivers: [
    const SliverAppBar(
      title: Text("Sliver Example"),
      floating: true,
      snap: true,
    ),
    SliverPadding(
      padding: const EdgeInsets.all(16.0),
      sliver: SliverM3EDismissibleCardList(
        itemCount: items.length,
        onDismiss: (index, direction) async {
          items.removeAt(index);
          return true; 
        },
        itemBuilder: (context, index) => buildEmailTile(context, items[index]),
      ),
    ),
  ],
)
```

### 3. Column (`M3EDismissibleCardColumn`)

When you don't need independent scrolling but still desire the beautiful neighbour-pull effect and dismiss action. This is great for short lists inside an already scrolling parent (like `SingleChildScrollView`).

<img src="https://raw.githubusercontent.com/Mudit200408/m3e_dismissible/main/doc/dismissible-highPull.gif"  height="450" alt="Dismissible M3E High Pull"/>

```dart
M3EDismissibleCardColumn(
  itemCount: items.length,
  onDismiss: (index, direction) async {
    items.removeAt(index);
    return true;
  },
  style: M3EDismissibleCardStyle(
    dismissThreshold: 0.6,
    neighbourPull: 20.0, // High pull effect to displace neighbours!
    neighbourReach: 3,
    background: Container(color: Colors.blue),
  ),
  itemBuilder: (context, index) => buildEmailTile(context, items[index]),
)
```

---

## 🏃 Running the Example

1. Ensure you have Flutter installed.
2. Clone the repository.
3. Open a terminal in the `example` directory.
4. Run `flutter pub get`.
5. Run `flutter run`.