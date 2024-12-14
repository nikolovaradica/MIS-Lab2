import 'package:flutter/material.dart';
import 'package:joke_app/screens/jokes_screen.dart';
import 'package:joke_app/screens/random_joke_screen.dart';
import 'package:joke_app/services/api_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<String>> jokeTypes;

  @override
  void initState() {
    super.initState();
    jokeTypes = ApiService.getJokeTypes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Joke Types", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)),
        backgroundColor: const Color(0xffaa076b),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context, 
                  MaterialPageRoute(
                    builder: (context) => const RandomJokeScreen(),
                  ),
                );
              },
              icon: const Icon(Icons.shuffle, color: Colors.white),
              label: const Text("Random Joke", style: TextStyle(color: Colors.white)),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),

                backgroundColor: const Color(0xff61045f),
                elevation: 5,
                textStyle: const TextStyle(fontSize: 16),
              ),
            ),
          )
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xffaa076b), Color(0xff61045f)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter
          )
        ),
        child: FutureBuilder<List<String>>(
          future: jokeTypes,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Padding(
                padding: EdgeInsets.all(16.0),
                child: Center(child: LinearProgressIndicator()),
              );
            } else if (snapshot.hasError) {
              return Center(child: Text("Error: ${snapshot.error}"));
            } else if (snapshot.hasData) {
              final types = snapshot.data!;
              return ListView.builder(
                itemCount: types.length,
                itemBuilder: (context, index) {
                  return Card(
                    color: Colors.white,
                    elevation: 10,
                    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    
                    child: ListTile(
                      title: Center(
                        child: Text(
                          "${types[index]} jokes".toUpperCase(), 
                          style: const TextStyle(
                            fontSize: 16.5, 
                            fontWeight: FontWeight.w500, 
                            letterSpacing: 1.5
                          )
                        )
                      ),
                      onTap: () {
                        Navigator.push(
                          context, 
                          MaterialPageRoute(
                            builder: (context) => JokesScreen(type: types[index]),
                          ),
                        );
                      },
                    ),
                  );
                },
              );
            } else {
              return const Center(child: Text("No joke types found"));
            }
          },
        ),
      ),
    );
  }
}