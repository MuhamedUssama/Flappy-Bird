import 'dart:async';

import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flappy_bird/components/background.dart';
import 'package:flappy_bird/components/bird.dart';
import 'package:flappy_bird/components/ground.dart';
import 'package:flappy_bird/components/pipe.dart';
import 'package:flappy_bird/components/pipe_manager.dart';
import 'package:flappy_bird/components/score.dart';
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
  late PipeManager pipeManager;
  late Score scoreComponent;

  int score = 0;

  @override
  FutureOr<void> onLoad() {
    // Load Background
    background = Background(size);
    add(background);

    // Load Bird
    bird = Bird();
    add(bird);

    // Load Ground
    ground = Ground();
    add(ground);

    // Load Pipes
    pipeManager = PipeManager();
    add(pipeManager);

    // Load Score
    scoreComponent = Score();
    add(scoreComponent);
  }

  @override
  void onTapDown(TapDownEvent event) {
    bird.flap();
    super.onTapDown(event);
  }

  @override
  void update(double dt) {
    super.update(dt);
    checkScore();
  }

  void checkScore() {
    if (isGameOver) return;

    for (final pipe in children.whereType<Pipe>()) {
      if (pipe.isTopPipe && !pipe.scored) {
        if (bird.position.x > pipe.position.x + pipe.size.x) {
          score += 1;
          pipe.scored = true;
        }
      }
    }
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
    if (buildContext == null) return;

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
    score = 0;
    isGameOver = false;
    children.whereType<Pipe>().forEach((pipe) => pipe.removeFromParent());
    resumeEngine();
  }
}
