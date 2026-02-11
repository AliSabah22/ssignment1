import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Random Number Generator',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFF2196F3),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF147CD3),
          foregroundColor: Colors.white,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF147CD3),
            foregroundColor: Colors.white,
          ),
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.white),
          bodyMedium: TextStyle(color: Colors.white),
          titleLarge: TextStyle(color: Colors.white),
        ),
      ),
      home: const MyHomePage(title: 'Random Number Generator'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {

  late AnimationController _controller;

  Map<int, int> stats = {
    for (int i = 1; i <= 9; i++) i: 0,
  };

  int? lastNumber;
  Timer? _timer;
  int tempNumber = 0;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );
  }

  void _animationListener(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      _timer?.cancel();
      setState(() {
        lastNumber = tempNumber;
        stats[lastNumber!] = stats[lastNumber!]! + 1;
      });
    }
  }

  void generateRandomNumber() {
    _controller
      ..removeStatusListener(_animationListener)
      ..addStatusListener(_animationListener)
      ..forward(from: 0);

    _timer?.cancel();
    _timer = Timer.periodic(const Duration(milliseconds: 100), (_) {
      setState(() {
        tempNumber = Random().nextInt(9) + 1;
      });
    });
  }

  void resetStats() {
    setState(() {
      for (int i = 1; i <= 9; i++) {
        stats[i] = 0;
      }
      lastNumber = null;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.home),
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Text(
                _controller.isAnimating
                    ? tempNumber.toString()
                    : lastNumber?.toString() ?? "",
                style: const TextStyle(fontSize: 40),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: generateRandomNumber,
                    child: const Text("Generate"),
                  ),
                ),

                const SizedBox(height: 15),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => StatisticsPage(
                            stats: stats,
                            onReset: resetStats,
                          ),
                        ),
                      );
                    },
                    child: const Text("View Statistics"),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ================= STATISTICS PAGE =================

class StatisticsPage extends StatefulWidget {
  final Map<int, int> stats;
  final VoidCallback onReset;

  const StatisticsPage({super.key, required this.stats, required this.onReset});

  @override
  State<StatisticsPage> createState() => _StatisticsPage();
}

class _StatisticsPage extends State<StatisticsPage> {
  late Map<int, int> localStates;

  @override
  void initState() {
    super.initState();
    localStates = Map.from(widget.stats);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text("Statistics"),
      ),

      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
              children: localStates.entries.map((entry) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Number ${entry.key}",
                          style: const TextStyle(fontSize: 18)),
                      Text(entry.value.toString(),
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      widget.onReset();
                      setState(() {
                        for (int i = 1; i <= 9; i++) {
                          localStates[i] = 0;
                        }
                      });
                    },
                    child: const Text("Reset"),
                  ),
                ),

                const SizedBox(height: 15),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("Back to Home"),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
