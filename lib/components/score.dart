import 'dart:async';

import 'package:flame/components.dart';
import 'package:flappy_bird/flappy_bird_game.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Score extends PositionComponent with HasGameReference<FlappyBirdGame> {
  late TextComponent scoreText;

  @override
  FutureOr<void> onLoad() {
    scoreText = TextComponent(
      text: '0',
      textRenderer: TextPaint(
        style: GoogleFonts.pressStart2p(
          fontSize: 48,
          color: Colors.white,
          shadows: [
            const Shadow(
              blurRadius: 7,
              color: Colors.black,
              offset: Offset(3, 3),
            ),
          ],
        ),
      ),
    );

    // Center the score horizontally and place it near the top
    scoreText.anchor = Anchor.topCenter;
    scoreText.position = Vector2(game.size.x / 2, 60);

    add(scoreText);
  }

  @override
  void update(double dt) {
    scoreText.text = game.score.toString();
  }
}
