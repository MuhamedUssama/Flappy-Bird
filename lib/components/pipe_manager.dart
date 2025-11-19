import 'dart:math';

import 'package:flame/components.dart';
import 'package:flappy_bird/components/pipe.dart';
import 'package:flappy_bird/flappy_bird_game.dart';
import 'package:flappy_bird/utils/configuration.dart';

class PipeManager extends Component with HasGameReference<FlappyBirdGame> {
  // We will continously spawn new pipes.

  double pipeSpawnTimer = 0;

  @override
  void update(double dt) {
    // generate new pipe at give interval
    pipeSpawnTimer += dt;

    if (pipeSpawnTimer > Config.pipeInterval) {
      pipeSpawnTimer = 0;
      spawnPipe();
    }
  }

  void spawnPipe() {
    final double screenHeight = game.size.y;

    // max possible height
    final double maxPipeHeight =
        screenHeight -
        Config.groundHieght -
        Config.pipeGap -
        Config.minPipeHeight;

    // height of bottom pipe -> randomly select btween min & max
    final double bottomPipeHeight =
        Config.minPipeHeight +
        Random().nextDouble() * (maxPipeHeight - Config.minPipeHeight);

    // height of top pipe
    final double topPipeHeight =
        screenHeight - Config.groundHieght - bottomPipeHeight - Config.pipeGap;

    // Create A Bottom Pipe
    final Pipe bottomPipe = Pipe(
      Vector2(
        game.size.x,
        screenHeight - Config.groundHieght - bottomPipeHeight,
      ),
      Vector2(Config.pipeWidth, bottomPipeHeight),
      isTopPipe: false,
    );

    // Create A Top Pipe
    final Pipe topPipe = Pipe(
      Vector2(game.size.x, 0),
      Vector2(Config.pipeWidth, topPipeHeight),
      isTopPipe: true,
    );

    // add both pipes to the game
    game.add(bottomPipe);
    game.add(topPipe);
  }
}
