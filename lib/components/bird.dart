import 'dart:async';

import 'package:flame/components.dart';
import 'package:flappy_bird/utils/assets_manager.dart';
import 'package:flappy_bird/utils/configuration.dart';

class Bird extends SpriteComponent {
  // Initialize Bird Position & Size
  Bird()
    : super(
        position: Vector2(Config.birdStartX, Config.birdStartY),
        size: Vector2(Config.birdWidth, Config.birdHeight),
      );

  // Physical world properties
  double velocity = 0;

  @override
  FutureOr<void> onLoad() async {
    sprite = await Sprite.load(AssetsManager.bird);
  }

  // Jump / Flap
  void flap() {
    velocity = Config.jumpStrength;
  }

  @override
  void update(double dt) {
    // apply gravity (Acceleration)
    velocity += Config.gravity * dt;

    // update bird's position based on current position
    position.y += velocity * dt;
  }
}
