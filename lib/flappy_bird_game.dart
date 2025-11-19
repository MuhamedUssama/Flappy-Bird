import 'dart:async';

import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flappy_bird/components/background.dart';
import 'package:flappy_bird/components/bird.dart';
import 'package:flappy_bird/components/ground.dart';
import 'package:flappy_bird/utils/configuration.dart';
import 'package:flutter/material.dart';

class FlappyBirdGame extends FlameGame
    with TapCallbacks, HasCollisionDetection {
  /*
    Basic Game Components
    - Background
    - Ground
    - Bird
    - Pipes
    - Score
  */

  late Bird bird;
  late Background background;
  late Ground ground;

  @override
  FutureOr<void> onLoad() {
    // Load Background
    background = Background(size);
    add(background);

    // Load Ground
    ground = Ground();
    add(ground);

    // Load Bird
    bird = Bird();
    add(bird);
  }

  @override
  void onTapDown(TapDownEvent event) {
    bird.flap();
    super.onTapDown(event);
  }

  // Game Over
  bool isGameOver = false;

  void gameOver() {
    if (isGameOver) return;

    isGameOver = true;
    pauseEngine();

    showRestartDialog();
  }

  void showRestartDialog() {
    showDialog(
      context: buildContext!,
      builder: (context) => AlertDialog(
        title: const Text('Game Over'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);

              resetGame();
            },
            child: const Text('Restart'),
          ),
        ],
      ),
    );
  }

  void resetGame() {
    bird.position = Vector2(Config.birdStartX, Config.birdStartY);
    bird.velocity = 0;
    isGameOver = false;
    resumeEngine();
  }
}
