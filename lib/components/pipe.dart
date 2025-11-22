import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flappy_bird/flappy_bird_game.dart';
import 'package:flappy_bird/utils/assets_manager.dart';
import 'package:flappy_bird/utils/configuration.dart';

class Pipe extends SpriteComponent
    with HasGameReference<FlappyBirdGame>, CollisionCallbacks {
  // determine if the pipe is top or bottom
  final bool isTopPipe;
  bool scored = false;

  Pipe(Vector2 position, Vector2 size, {required this.isTopPipe})
    : super(position: position, size: size);

  @override
  FutureOr<void> onLoad() async {
    sprite = await Sprite.load(
      isTopPipe ? AssetsManager.pipeTop : AssetsManager.pipeBottom,
    );

    // add a collision box
    add(RectangleHitbox());
  }

  @override
  void update(double dt) {
    // scroll pipe to left
    position.x -= Config.groundScrollingSpeed * dt;

    // remove pipe if it goes off the screen
    if (position.x + size.x <= 0) {
      removeFromParent();
    }
  }
}
