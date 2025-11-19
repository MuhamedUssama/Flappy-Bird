import 'dart:async';

import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flappy_bird/components/background.dart';
import 'package:flappy_bird/components/bird.dart';
import 'package:flappy_bird/components/ground.dart';

class FlappyBirdGame extends FlameGame with TapCallbacks {
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
}
