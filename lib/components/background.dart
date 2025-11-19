import 'dart:async';

import 'package:flame/components.dart';
import 'package:flappy_bird/utils/assets_manager.dart';

class Background extends SpriteComponent {
  // Initialize Background Position & Size
  Background(Vector2 size) : super(position: Vector2(0, 0), size: size);

  @override
  FutureOr<void> onLoad() async {
    sprite = await Sprite.load(AssetsManager.background);
  }
}
