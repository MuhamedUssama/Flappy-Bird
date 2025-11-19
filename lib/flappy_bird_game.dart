import 'dart:async';

import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flappy_bird/components/bird.dart';

class FlappyBirdGame extends FlameGame with TapCallbacks {
  /*
    Basic Game Components
    - Bird
    - Background
    - Ground
    - Pipes
    - Score
  */

  late Bird bird;

  @override
  FutureOr<void> onLoad() {
    bird = Bird();
    add(bird);
  }

  @override
  void onTapDown(TapDownEvent event) {
    bird.flap();
    super.onTapDown(event);
  }
}
