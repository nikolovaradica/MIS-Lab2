import 'package:flutter/material.dart';
import 'package:joke_app/screens/jokes_screen.dart';

class JokeTypeCard extends StatelessWidget {
  final String jokeType;

  const JokeTypeCard({super.key, required this.jokeType});

  @override
  Widget build(BuildContext context) {
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
            "$jokeType Jokes".toUpperCase(),
            style: const TextStyle(
              fontSize: 16.5,
              fontWeight: FontWeight.w500,
              letterSpacing: 1.5,
            ),
          ),
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => JokesScreen(type: jokeType),
            ),
          );
        },
      ),
    );
  }
}
