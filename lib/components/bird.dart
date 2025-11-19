import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flappy_bird/components/ground.dart';
import 'package:flappy_bird/flappy_bird_game.dart';
import 'package:flappy_bird/utils/assets_manager.dart';
import 'package:flappy_bird/utils/configuration.dart';

class Bird extends SpriteComponent
    with CollisionCallbacks, HasGameReference<FlappyBirdGame> {
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

    // add a collision box
    add(RectangleHitbox());
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

  /// Collision -> with another object

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);

    // check if bird collides with ground
    if (other is Ground) {
      game.gameOver();
    }
  }
}
