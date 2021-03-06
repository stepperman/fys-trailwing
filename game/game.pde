import samuelal.squelized.*;
import java.util.Properties;
import processing.sound.*;

TileManager manager;
Player player;
float circleX = 2000;
float xSpeed = 5;
int radius = 10;
boolean ballHit = false;
String gameState;
Enemy enemy;
PlayGame play;
StartMenu start;
LoginScreen login;
Hiscore hiscore;
GameOver gameOver;
SoundFile backgroundMusicStartScreen;
SoundFile backgroundMusicGameOverScreen;
HUD hud;
ButtonLayout buttonLayout;
MusicManager musicManager;
Animations animations;
SoundBank soundBank;
CommentsDatabase commentDatabase;
AchievementsDatabase achievementsDb;
PlayerDatabase playerdb;
ScreenShake screenShake;

void setup() {
  commentDatabase = new CommentsDatabase();
  playerdb = new PlayerDatabase();
  achievementsDb = new AchievementsDatabase();
  screenShake = new ScreenShake();
  soundBank = new SoundBank(this);
  gameState = "LOGIN";
  animations = new Animations();
  background(255);
  size(1600, 900, P2D);
  frameRate(60);
  player = new Player(width/2, height - Config.PLAYER_BOTTOM_OFFSET);
  play = new PlayGame();
  start = new StartMenu();
  manager = new TileManager(Config.DEFAULT_CAMERA_MOVEMENT_SPEED);
  enemy = new Enemy(player);
  hiscore = new Hiscore();
  login = new LoginScreen();
  gameOver = new GameOver();
  buttonLayout = new ButtonLayout();
  musicManager = new MusicManager(this);
  PFont font = createFont("Arial", 64);
  textFont(font);
  hud = new HUD();
  /*SessionDatabase session = new SessionDatabase();
   print(session.getSessions());*/
}

void draw()
{
  gameStates();
  musicManager.update();
  Input.update();
}

void keyPressed() {
  //send pressed key to input class

  Input.keyPressed(key, CODED, keyCode);
  if (key == ESC)
    key = 0;
}

void keyReleased() {
  //send released key to input class
  Input.keyReleased(key, CODED, keyCode);
}

void mousePressed() {
  //send pressed mouseside to input class
  Input.mousePressed(mouseButton);
}

void mouseReleased() {
  //send released mouseside to input class
  Input.mouseReleased(mouseButton);
}


void gameStates() {
  if (gameState == "LOGIN") {
    login.screen();
  } else if (gameState == "START") {
    start.screen();
    start.menuSelecter();
    start.audioSlider();
  } else if (gameState == "PLAY") {
    boolean available = screenShake.isAvailable();
    if (available)
    {
      pushMatrix();
      PVector offset = screenShake.getOffset();
      translate(offset.x, offset.y);
    }
    play.update();
    play.draw();
    if (available)
    {
      popMatrix();
    }
  } else if (gameState == "BUTTONLAYOUT") {
    buttonLayout.draw(); 
    buttonLayout.spaceCheck();
  } else if ( gameState == "HISCORE") {
    hiscore.screen();
  } else if (gameState == "GAMEOVER") {
    gameOver.update();
    gameOver.draw();

    if (gameOver.drawCommentOverlay)
    {
      gameOver.drawCommentOverlay();
    }
  }
}
