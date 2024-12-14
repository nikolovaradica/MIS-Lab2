import 'package:flutter/material.dart';
import 'package:joke_app/models/joke_model.dart';
import 'package:joke_app/services/api_service.dart';

class RandomJokeScreen extends StatelessWidget {
  const RandomJokeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Random Joke", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)),
        backgroundColor: const Color(0xffaa076b),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xffaa076b), Color(0xff61045f)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter
          )
        ),
        child: FutureBuilder<Map<String, dynamic>>(
          future: ApiService.getRandomJoke(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Padding(
                padding: EdgeInsets.all(16.0),
                child: Center(child: LinearProgressIndicator()),
              );
            } else if (snapshot.hasError) {
              return Center(child: Text("Error: ${snapshot.error}", style: const TextStyle(color: Colors.white)));
            } else if (snapshot.hasData) {
              final joke = Joke.fromJson(snapshot.data!);
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      joke.setup, 
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      joke.punchline, 
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.white),
                      textAlign: TextAlign.center
                    ),
                  ],
                ),
              );
            } else {
              return const Center(child: Text("No joke found", style: TextStyle(color: Colors.white)));
            }
          },
        ),
      ),
    );
  }
}