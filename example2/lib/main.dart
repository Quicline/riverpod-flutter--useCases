import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MainApp(),
    ),
  );
}

// Creating the counter state
class Counter extends StateNotifier<int?> {
  Counter() : super(null);
  void increment() => state = state == null ? 1 : state! + 1;
}

// Making the counter available globally in the app
final counterProvider = StateNotifierProvider<Counter, int?>((ref) {
  return Counter();
});

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.dark,
      home: const HomePage(),
    );
  }
}

class HomePage extends ConsumerWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black45,
        title: Column(
          children: [
            const Text('Example 2'),
            // getting the current value of the counter
            Consumer(
              builder: (BuildContext context, WidgetRef ref, Widget? child) {
                final counterValue = ref.watch(counterProvider);
                return Text(
                  counterValue == null
                      ? 'Press the button'
                      : 'Counter: ${counterValue.toString()}',
                  style: const TextStyle(fontSize: 15),
                );
              },
            )
          ],
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: TextButton(
              onPressed: () {
                // updating the value of the counter
                ref.read(counterProvider.notifier).increment();
              },
              child: const Text('Press Me'),
            ),
          ),
        ],
      ),
    );
  }
}
