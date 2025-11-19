import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flappy_bird/flappy_bird_game.dart';
import 'package:flappy_bird/utils/assets_manager.dart';
import 'package:flappy_bird/utils/configuration.dart';

class Ground extends SpriteComponent
    with HasGameReference<FlappyBirdGame>, CollisionCallbacks {
  // Init
  Ground() : super();

  @override
  FutureOr<void> onLoad() async {
    // Set Size & Position
    size = Vector2(2 * game.size.x, Config.groundHieght);
    position = Vector2(0, game.size.y - Config.groundHieght);

    // load image
    sprite = await Sprite.load(AssetsManager.ground);

    // add a collision box
    add(RectangleHitbox());
  }

  @override
  void update(double dt) {
    // Move ground to left
    position.x -= Config.groundScrollingSpeed * dt;

    // reset ground if it goes off screen for inifinite scroll
    // if half of ground has been passed, reset.
    if (position.x + size.x / 2 <= 0) {
      position.x = 0;
    }
  }
}
