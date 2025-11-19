import 'dart:async';

import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flappy_bird/components/background.dart';
import 'package:flappy_bird/components/bird.dart';

class FlappyBirdGame extends FlameGame with TapCallbacks {
  /*
    Basic Game Components
    - Background
    - Bird
    - Ground
    - Pipes
    - Score
  */

  late Bird bird;
  late Background background;

  @override
  FutureOr<void> onLoad() {
    // Load Background
    background = Background(size);
    add(background);

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
