static class Config {

  final static PVector PLAYER_SIZE = new PVector(75, 75);
  final static int MIN_STARTING_CHUNKS = 4;
  final static float CHUNK_BOTTOM_OFFSET = 50;
  final static float DEFAULT_GROUP_WIDTH = 1000; //Changing this will result in chunks clipping in eachother. When you change this also change the chunks in the chunks.json file.
  final static int DEFAULT_CAMERA_MOVEMENT_SPEED = 5;
  final static float CAMERA_SPEED_UP_SPEED = 0.02;

  final static int MAX_CHUNCK_LEVEL = 2;
  final static int MAX_COIN_AMOUNT = 10;
  final static int BONUS_SCORE_COIN = 10;
  final static float PLAYER_BOTTOM_OFFSET = 125;
  final static float PLAYER_JUMP_POWER = -15f;
  final static float PLAYER_JUMP_GRAVITY = 0.25f;
  final static float PLAYER_SPEED = 5;
  final static float PLAYER_MAX_SHIELD_AMOUNT = 5;
  final static float PLAYER_JUMP_OFFSET = 120;  
  final static int FIREBALL_STARTING_TIME = 3200;

  //Directions used for collisions
  final static float LEFT = -1;
  final static float RIGHT = 1;
  final static float UP = 1;
  final static float DOWN = -1;
  final static float POWERUP_WIDTH = 100;
  final static float POWERUP_HEIGHT = 100;
  final static float POWERUP_SPAWN_CHANCE = 100/4;
  final static float POWERUP_ACTIVE_TIMER = 5.5f; // in seconds
  final static float POWERUP_JUMP_BOOST = 2f; // multiplies jump by this
  final static String[] POWERUP_SPRITENAMES = new String[] {
    "invincibility.png", 
    "super_jump.png"
  };

  final static int MAX_COMMENT_LOAD_DISTANCE = 500;
}
