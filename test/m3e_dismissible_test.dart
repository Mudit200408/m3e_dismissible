import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:m3e_dismissible/m3e_dismissible.dart';

void main() {
  group('M3ESwipeAction tests', () {
    testWidgets('renders action button and triggers callback', (tester) async {
      bool actionTriggered = false;

      final action = M3ESwipeAction(
        icon: const Icon(Icons.share_rounded),
        label: const Text('Share'),
        isPrimary: true,
        onTap: () {
          actionTriggered = true;
        },
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: Builder(
                builder: (context) {
                  return action.buildButton(context, onTriggered: null);
                },
              ),
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.share_rounded), findsOneWidget);
      expect(find.text('Share'), findsOneWidget);

      await tester.tap(find.byIcon(Icons.share_rounded));
      await tester.pumpAndSettle();

      expect(actionTriggered, isTrue);
    });
  });

  group('M3EDismissibleCardColumn with swipe actions', () {
    testWidgets('reveals actions on drag and stays anchored', (tester) async {
      bool actionTapped = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SizedBox(
              width: 400,
              height: 600,
              child: M3EDismissibleCardColumn(
                itemCount: 2,
                style: M3EDismissibleCardStyle(
                  actions: [
                    M3ESwipeAction(
                      icon: const Icon(Icons.archive),
                      onTap: () => actionTapped = true,
                    ),
                  ],
                ),
                itemBuilder: (context, index) {
                  return SizedBox(height: 80, child: Text('Card Item $index'));
                },
              ),
            ),
          ),
        ),
      );

      expect(find.text('Card Item 0'), findsOneWidget);

      // Drag right by 80px to reveal action
      await tester.drag(find.text('Card Item 0'), const Offset(80, 0));
      await tester.pumpAndSettle();

      // Action button should be revealed and visible
      expect(find.byIcon(Icons.archive), findsOneWidget);

      // Tap action button
      await tester.tap(find.byIcon(Icons.archive));
      await tester.pumpAndSettle();

      expect(actionTapped, isTrue);
    });

    testWidgets(
      'triggers hapticOnThreshold when action buttons reach fully open threshold',
      (tester) async {
        final List<String> hapticCalls = [];
        TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
            .setMockMethodCallHandler(
              const MethodChannel('m3e_haptics/haptics'),
              (MethodCall methodCall) async {
                if (methodCall.method == 'vibrate') {
                  final arguments = methodCall.arguments as Map;
                  hapticCalls.add(arguments['type'] as String);
                }
                return null;
              },
            );
        TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
            .setMockMethodCallHandler(SystemChannels.platform, (
              MethodCall methodCall,
            ) async {
              if (methodCall.method == 'HapticFeedback.vibrate') {
                hapticCalls.add(methodCall.arguments as String);
              }
              return null;
            });

        addTearDown(() {
          TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
              .setMockMethodCallHandler(
                const MethodChannel('m3e_haptics/haptics'),
                null,
              );
          TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
              .setMockMethodCallHandler(SystemChannels.platform, null);
        });

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: SizedBox(
                width: 400,
                height: 600,
                child: M3EDismissibleCardColumn(
                  itemCount: 2,
                  style: const M3EDismissibleCardStyle(
                    hapticOnThreshold: M3EHapticFeedback.light,
                    actions: [
                      M3ESwipeAction(icon: Icon(Icons.archive), width: 50.0),
                    ],
                    actionSpacing: 10.0,
                  ),
                  itemBuilder: (context, index) {
                    return SizedBox(
                      height: 80,
                      child: Text('Card Item $index'),
                    );
                  },
                ),
              ),
            ),
          ),
        );

        // Actions width = 50.0 + (1 + 1) * 10.0 = 70.0
        final gesture = await tester.startGesture(
          tester.getCenter(find.text('Card Item 0')),
        );

        // Break touch slop so horizontal drag starts
        await gesture.moveBy(const Offset(25, 0));
        await tester.pump();

        // Drag 30px (total drag offset ~30px < 70.0 threshold) -> no haptic
        await gesture.moveBy(const Offset(30, 0));
        await tester.pump();
        expect(hapticCalls, isEmpty);

        // Drag another 50px (total drag offset ~80px >= 70.0 threshold) -> triggers haptic once
        await gesture.moveBy(const Offset(50, 0));
        await tester.pump();
        expect(hapticCalls, hasLength(1));

        // Drag further to 100px (in overdrag) -> should not trigger again
        await gesture.moveBy(const Offset(20, 0));
        await tester.pump();
        expect(hapticCalls, hasLength(1));

        // Drag back below threshold (e.g. -40px to ~60px) -> should NOT trigger haptic
        await gesture.moveBy(const Offset(-40, 0));
        await tester.pump();
        expect(hapticCalls, hasLength(1));

        await gesture.up();
        await tester.pumpAndSettle();
      },
    );

    testWidgets('does not dismiss when action buttons are used', (
      tester,
    ) async {
      bool itemDismissed = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SizedBox(
              width: 400,
              height: 600,
              child: M3EDismissibleCardColumn(
                itemCount: 2,
                onDismiss: (index, direction) async {
                  itemDismissed = true;
                  return true;
                },
                style: M3EDismissibleCardStyle(
                  actions: [
                    M3ESwipeAction(
                      icon: const Icon(Icons.archive),
                      onTap: () {},
                    ),
                  ],
                ),
                itemBuilder: (context, index) {
                  return SizedBox(height: 80, child: Text('Card Item $index'));
                },
              ),
            ),
          ),
        ),
      );

      // Fling past threshold - since actions are configured, it should reveal actions, not dismiss
      await tester.fling(find.text('Card Item 0'), const Offset(300, 0), 1000);
      await tester.pumpAndSettle();

      expect(itemDismissed, isFalse);
      expect(find.text('Card Item 0'), findsOneWidget);
      expect(find.byIcon(Icons.archive), findsOneWidget);
    });

    testWidgets('reveals actions on long press when enabled', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SizedBox(
              width: 400,
              height: 600,
              child: M3EDismissibleCardColumn(
                itemCount: 2,
                style: const M3EDismissibleCardStyle(
                  actionRevealTrigger: M3EActionRevealTrigger.longPress,
                  actions: [M3ESwipeAction(icon: Icon(Icons.bookmark))],
                ),
                itemBuilder: (context, index) {
                  return SizedBox(
                    height: 80,
                    child: Text('LongPress Card $index'),
                  );
                },
              ),
            ),
          ),
        ),
      );

      expect(find.text('LongPress Card 0'), findsOneWidget);

      // Long press on card 0
      await tester.longPress(find.text('LongPress Card 0'));
      await tester.pumpAndSettle();

      // Action icon should be visible
      expect(find.byIcon(Icons.bookmark), findsOneWidget);
    });

    testWidgets(
      'M3EDismissibleCardColumn dismisses smoothly when only one item is left',
      (tester) async {
        final items = ['Sole Card'];

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: SizedBox(
                width: 400,
                height: 600,
                child: StatefulBuilder(
                  builder: (context, setState) {
                    return M3EDismissibleCardColumn(
                      itemCount: items.length,
                      onDismiss: (index, direction) async {
                        setState(() {
                          items.removeAt(index);
                        });
                        return true;
                      },
                      itemBuilder: (context, index) {
                        return SizedBox(height: 80, child: Text(items[index]));
                      },
                    );
                  },
                ),
              ),
            ),
          ),
        );

        expect(find.text('Sole Card'), findsOneWidget);

        // Swipe right past dismiss threshold
        await tester.drag(find.text('Sole Card'), const Offset(300, 0));
        // Verify intermediate animation frames (collapsing card / flying card exists during animation)
        await tester.pump(const Duration(milliseconds: 100));
        expect(items, isEmpty);

        // Allow animations to fully settle
        await tester.pumpAndSettle();
        expect(find.text('Sole Card'), findsNothing);
      },
    );
  });
}
