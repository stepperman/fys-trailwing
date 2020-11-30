/*
Made by Patrick Eikema
 */

class Enemy {
  float speed;
  float x, y;
  float distance;
  float attackW, attackH;
  PImage fireBall;
  boolean angry;
  int angryTimer, angryCooldown;
  int AngryDurationTimer, attackDurationCooldown;
  int fireBallTimer, fireBallDurationCooldown;
  Player player;
  boolean attack;
  float fireBallX, fireBallY, fireBallW, fireBallH;
  float fireBallSpeed;

  SpriteAnimation dragon; 



  Enemy(Player player) {

    //initialisation
    this.player = player;
    dragon = new SpriteAnimation("dragonSprites.png", 3, 8);
    this.fireBall = loadImage("fireBall.png");

    //Size & pos Enemy+
    this.x = 150;
    this.y = player.playerPos.y -50;
    this.speed = 6;
    this.attackW = (width/10)*3;
    this.attackH = 50;

    for (int i = 0; i < dragon.frameImage.length; i++) {
      dragon.frameImage[i].resize(dragon.frameImage[i].width/5*4, dragon.frameImage[i].height/5*4);
    }


    //attackvariables
    this.angry = false;
    this.angryTimer = 0;
    this.angryCooldown = 8000; //  Time in ms he takes to get angry
    this.AngryDurationTimer = 0;
    this.attackDurationCooldown = 4000;  //  Time in ms he stays angry
    this.fireBallTimer = 0;
    this.fireBallDurationCooldown = 3200;  //Time  it takes to shoot the fireBall WHEN angry. (fireBall duration = attackDurationCooldown - fireBallDurationCooldown)
    this.attack = false;
    this.fireBallY = y+130;
    this.fireBallSpeed = 15;
    this.fireBallW = fireBall.width/6;
    this.fireBallH = fireBall.height/6;
  }

  void draw() {
    imageMode(CENTER);

    dragon.draw(x, y);
  }


  void movement() {
    if (y < player.playerPos.y -60) {
      y += speed;
    } else if (y > player.playerPos.y +60) {
      y -= speed;
    }
  }


  void attack() {



    // timer that changes angry to true and draws the fireBall when angry. 
    if (millis()-angryTimer > angryCooldown  ) {
      angry = true;
      fireBallTimer = millis();



      angryTimer = millis();
      AngryDurationTimer = millis();
    } else if (angry && millis()-AngryDurationTimer > attackDurationCooldown) {
      AngryDurationTimer = millis();
      angry = false;
    }

    if (angry && millis()-fireBallTimer > fireBallDurationCooldown) {
      attack = true;
      fireBallX = x + 130;
    }

    if (attack) {
      fireBallX += fireBallSpeed;
    }
  }


  void collision() {

    //checks collision between fireball and player
    if (fireBallX + fireBallW/2 > player.playerPos.x - player.size.x/2 && fireBallX - fireBallW/2 < player.playerPos.x + player.size.x/2 && fireBallY + fireBallH/2 > player.playerPos.y - player.size.y/2 && fireBallY - fireBallH/2 < player.playerPos.y + player.size.y/2) {
      fireBallX = 10000;
      player.damage();
    }
  }

  void drawAttack() {
    if (attack) {
      imageMode(CENTER);
      image(fireBall, fireBallX, fireBallY, fireBallW, fireBallH );
    }
  }

  /* 
   TO DO: 
   -Make the dragon move more smoothly
   -Flying dragon sprites??
   -When the dragon flies through an obstacle, destroy it.
   -Better angry animation
   
   */
}
