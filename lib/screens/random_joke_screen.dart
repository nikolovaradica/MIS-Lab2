import 'package:flutter/material.dart';
import 'package:joke_app/models/joke_model.dart';
import 'package:joke_app/services/api_service.dart';
import 'package:joke_app/widgets/custom_app_bar.dart';
import 'package:joke_app/widgets/random_joke_card.dart';

class RandomJokeScreen extends StatelessWidget {
  const RandomJokeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Random Joke"),
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
              return RandomJokeCard(joke: joke);
            } else {
              return const Center(child: Text("No joke found", style: TextStyle(color: Colors.white)));
            }
          },
        ),
      ),
    );
  }
}