import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _counter = 0;

  Future<void> _increase() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('counter', _counter += 1);
    _getCounter();
  }

  Future<void> _getCounter() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _counter = prefs.getInt("counter") ?? 0;
    });
  }

  Future<void> _decrease() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('counter', _counter -= 1);
    _getCounter();
  }

  @override
  void initState() {
    _getCounter();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Share preference"),
      ),
      body: Center(
        child: Text(
          "$_counter",
          style: const TextStyle(fontSize: 30),
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            onPressed: () {
              _decrease();
            },
            icon: const Icon(Icons.remove),
          ),
          IconButton(
            onPressed: () {
              _increase();
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
