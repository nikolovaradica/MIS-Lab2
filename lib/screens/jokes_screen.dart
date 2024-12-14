import 'package:flutter/material.dart';
import 'package:joke_app/models/joke_model.dart';
import 'package:joke_app/services/api_service.dart';

class JokesScreen extends StatelessWidget {
  final String type;
  const JokesScreen({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${type[0].toUpperCase()}${type.substring(1)} Jokes", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)),
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
        child: FutureBuilder<List<Map<String, dynamic>>>(
          future: ApiService.getJokesByType(type),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Padding(
                padding: EdgeInsets.all(16.0),
                child: Center(child: LinearProgressIndicator()),
              );
            } else if (snapshot.hasError) {
              return Center(child: Text("Error: ${snapshot.error}", style: const TextStyle(color: Colors.white),));
            } else if (snapshot.hasData) {
              final jokes = snapshot.data!.map((data) => Joke.fromJson(data)).toList();
              return ListView.builder(
                itemCount: jokes.length,
                itemBuilder: (context, index) {
                  final joke = jokes[index];
                  return Card(
                    color: Colors.white,
                    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      title: Text(
                        joke.setup,
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Color(0xff61045f)),
                      ),
                      subtitle: Text(
                        joke.punchline,
                        style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w400, color: Color(0xffaa076b)),
                      ),
                    ),
                  );
                },
              );
            } else {
              return const Center(child: Text("No jokes found", style: const TextStyle(color: Colors.white)));
            }
          },
        ),
      ),
    );
  }
}