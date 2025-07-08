import 'package:flutter/material.dart';
import '../services/potter_api_service.dart';
import '../models/character_model.dart';
import 'dart:developer';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  PotterApiService potterAPIService = PotterApiService();
  late Future<List<Character>> futureCharacters;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override

  void initState(){
    super.initState();
    futureCharacters = potterAPIService.fetchCharacters();
    futureCharacters.then((data){
      for(var i = 0 ; i < data.length ; i++) {
        log(data[i].name);
      }
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('You have pushed the button this many times:'),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
