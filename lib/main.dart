import 'package:flame/game.dart';
import 'package:flappy_bird/flappy_bird_game.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const FlappyBird());
}

class FlappyBird extends StatelessWidget {
  const FlappyBird({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home: GameWidget(game: FlappyBirdGame()),
    );
  }
}
