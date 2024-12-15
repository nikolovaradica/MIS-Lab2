import 'package:flutter/material.dart';
import 'package:joke_app/models/joke_model.dart';
import 'package:joke_app/services/api_service.dart';
import 'package:joke_app/widgets/custom_app_bar.dart';
import 'package:joke_app/widgets/joke_card.dart';

class JokesScreen extends StatelessWidget {
  final String type;
  const JokesScreen({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "${type[0].toUpperCase()}${type.substring(1)} Jokes"),
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
                  return JokeCard(joke: joke);
                },
              );
            } else {
              return const Center(child: Text("No jokes found", style: TextStyle(color: Colors.white)));
            }
          },
        ),
      ),
    );
  }
}