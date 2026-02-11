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
      
      
      title: 'Flutter Demo',
      theme: ThemeData(
        appBarTheme: AppBarThemeData(
          backgroundColor: const Color(0xFF147CD3)
        ),
        primaryColor:Color(0xFF2196F3),
        elevatedButtonTheme: ElevatedButtonThemeData(
         style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF147CD3)
         )
        ),  

        textTheme: const TextTheme(
          
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
        title: Text(widget.title),
        backgroundColor: Color(0xFF147CD3),
      ),
      body: Center(
        child: Text(
          'Counter: $_counter',
          style: TextStyle(fontSize: 24),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        child: Icon(Icons.add),
      ),
    );
  }
}


// class StatisticsPage extends StatefulWidget {
//   const StatisticsPage({super.key, required this.title});

//   final String title;

//   @override
//   State<StatisticsPage> createState() => _StatisticsPage();
// }

// class _StatisticsPage extends State<StatisticsPage> {
  // int _counter = 0;

  // void _incrementCounter() {
  //   setState(() {
  //     _counter++;
  //   });
  // }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title),
//       ),
//       body: Center(
//         child: Text(
//           // 'Stats Counter: $_counter',
//           // style: TextStyle(fontSize: 24),
//         ,)
//       ),
//     );
//   }
// }
 


  // @override
  // Widget build(BuildContext context) {

  //   return Scaffold(
  //     appBar: AppBar(
  //       backgroundColor: Theme.of(context).colorScheme.inversePrimary,
  //       title: Text(widget.title),
  //     ),
  //     body: Center(
  //       child: Column(
  //         mainAxisAlignment: .center,
  //         children: [
  //           const Text('You have pushed the button this many times:'),
  //           Text(
  //             '$_counter',
  //             style: Theme.of(context).textTheme.headlineMedium,
  //           ),
  //         ],
  //       ),
  //     ),
  //     floatingActionButton: FloatingActionButton(
  //       onPressed: _incrementCounter,
  //       tooltip: 'Increment',
  //       child: const Icon(Icons.add),
  //     ),
  //   );
  // }
