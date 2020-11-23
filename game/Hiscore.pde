class Hiscore {
  PImage background;
  PImage backIcon;
  PImage scroll;
  float backgroundX, backgroundY;
  int backgroundW, backgroundH;
  float backIconX, backIconY, backIconW, backIconH;
  
  
  //things in scroll
  float scrollX, scrollY, scrollW, scrollH;
  int fontSizeTitles;
  float hiscoresX;
  float hiscoresY;
  float achievementsX;
  float achievementsY;
  boolean hiscoresSelected;
  boolean achievementsSelected;
  color hiscoresColor; 
  color achievementsColor;
  ArrayList <TextButton> titleButtons;
  ButtonManager manager;
  PFont scrollFont;


  //database stuff
  Properties props; 
  Table highscoreTable;


  Hiscore() {
    this.backgroundX = width/2;
    this.backgroundY = height/2;
    this.backgroundW = displayWidth;
    this.backgroundH = displayHeight;
    this.background = loadImage("startMenuBackground.jpg");
    this.background.resize(backgroundW, backgroundH);
    this.backIcon = loadImage("backIcon.png");
    this.scroll = loadImage("hiscores.png");
    this.backIconW = backIcon.width/10*3;
    this.backIconH = backIcon.width/10*3;
    this.backIconX = backIconW/2;
    this.backIconY = 80;
    this.scrollX = width/2;
    this.scrollY = height/2;
    this.scrollW = scroll.width*1.7;
    this.scrollH = scroll.height*1.7;
    this.fontSizeTitles = 60; // was 40
    this.hiscoresX = scrollX-150;
    this.hiscoresY = scrollY-scrollH/2 + scrollH/4;
    this.achievementsX = scrollX + 150;
    this.achievementsY = hiscoresY;
    this.hiscoresSelected = false;
    this.achievementsSelected = false;
    this.hiscoresColor = color(255);
    this.achievementsColor = color(0);
    this.titleButtons = new ArrayList<TextButton>();
    this.titleButtons.add(new TextButton(achievementsX, achievementsY, "Achievements", fontSizeTitles, color(0), color(255), 0));
    this.titleButtons.add(new TextButton(hiscoresX, hiscoresY, "Hi-Scores", fontSizeTitles, color(0), color(255), 1));
    this.manager = new ButtonManager(titleButtons);
    
    scrollFont = createFont("highscoreFont.ttf",60);
    

    props = new Properties();
    props.setProperty ("user", "eikemap");
    props.setProperty("password", "AqUSO0RutI/93vGU");
    SQLConnection myConnection = new MySQLConnection("jdbc:mysql://oege.ie.hva.nl/zeikemap?serverTimezone=UTC", props);

    highscoreTable = myConnection.getTable("highscore");
    highscoreTable = myConnection.runQuery("SELECT player_id, highscore, date_achieved FROM highscore ORDER BY highscore DESC");
  }


  void screen() {
    imageMode(CENTER);
    image(background, backgroundX, backgroundY);
    image(backIcon, backIconX, backIconY, backIconW, backIconH);

    scroll();

    //Handles keyinputs, first checks if backspace is pressed (goes back)
    if (Input.keyClicked(BACKSPACE)) {
      gameState = "START"; 
      //Checks if back icon is clicked
    } else if (backIconClicked()) {
      gameState = "START";
    }
  }

  void scroll() {
    textFont(scrollFont);
    image(scroll, scrollX, scrollY, scrollW, scrollH);
    fill(hiscoresColor);
    fill(achievementsColor);

    //manager.indexSelecterMouse();
    manager.indexSelectedKeysHorizontal();

    for (int i = 0; i < titleButtons.size(); i++) {
      titleButtons.get(i).drawTextButton();
    }

    fill(0, 50);
    rectMode(CENTER);
    //rect(scrollX, scrollY-scrollH/2+scrollH/10*5.3, scrollW/10*6, scrollH/2, 10, 10, 10, 10);
    
    if(titleButtons.get(1).selected == true){
    printTable(highscoreTable);
    }
  }




  //returns true if back icon is clicked
  boolean backIconClicked() {
    if (Input.mouseButtonClicked(LEFT) && mouseX > backIconX-backIconW/2 && mouseX < backIconX + backIconW/2 && mouseY > backIconY - backIconH/2 && mouseY < backIconY + backIconH/2) {
      return true;
    }
    return false;
  }


  void printTable(Table table) {
    textSize(40);
    fill(0);
    textAlign(CENTER);
    text("NAME", width/2-300, 500);
    text("HIGHSCORE", width/2, 500);
    text("DATE", width/2+300, 500);

    textSize(40);
    for (int i = 0; i < table.getRowCount(); i++) {
      TableRow row = table.getRow(i);
      for (int j = 0; j < table.getColumnCount(); j++) {
        text(row.getString(j), width/2-300 + 300 *j, 600 + 50 * i);
      }
    }
  }
}
