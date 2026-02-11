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

        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Color(0xFF147CD3),
          foregroundColor: Colors.white
        ),


        elevatedButtonTheme: ElevatedButtonThemeData(
         style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF147CD3),
          foregroundColor: Colors.white,
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
         ),
        ),  

        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.white),
          bodyMedium: TextStyle(color: Colors.white),
          titleLarge: TextStyle(color: Colors.white),
        ),
        
        
       
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
        
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

class _MyHomePageState extends State<MyHomePage> {
  int? lastNumber;

  void generateRandomNumber() {
    setState(() {
      lastNumber = Random().nextInt(9) + 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.home),
        title: Text(widget.title),
        backgroundColor: Color(0xFF147CD3),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              lastNumber?.toString() ?? "",
            ),
            const SizedBox(height: 30,),
            ElevatedButton(
              onPressed: generateRandomNumber,
              child: const Text("Generate"),
            ),

            SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const StatisticsPage(),
                    )
                  );
              },
              child: const Text("View Statistics"),
            )
          ],
        ),
      ),
    );
  }
}

//Statistics page
class StatisticsPage extends StatefulWidget {
  const StatisticsPage({super.key,});


  @override
  State<StatisticsPage> createState() => _StatisticsPage();
}

class _StatisticsPage extends State<StatisticsPage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
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
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        
      
      body: const Center(
        child: Text("Statistics Screen")),
    );
  }
}
