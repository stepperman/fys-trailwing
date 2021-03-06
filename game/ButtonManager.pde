/* 
 Made by Patrick Eikema
 
 
 This class needs an array list of Buttons.
 It handles the selection of buttons. 
 */

class ButtonManager {
  ArrayList<TextButton> buttons;
  int index, indexMax;

  ButtonManager(ArrayList buttons) {
    this.buttons = buttons;
    this.index = 0;
    this.indexMax = buttons.size()-1;
  }

  // if the left mouse button is clicked on any of the buttons, select them.
  void indexSelecterMouse() {
    for (int i = 0; i < buttons.size(); i++) {
      if (mouseX > buttons.get(i).x-buttons.get(i).w/2 && mouseX < buttons.get(i).x + buttons.get(i).w/2 && mouseY > buttons.get(i).y-buttons.get(i).h/2 && mouseY < buttons.get(i).y + buttons.get(i).h/2 && Input.mouseButtonClicked(LEFT)) {
        buttons.get(i).selected = true;
        for (int j = 0; j <buttons.size(); j++) {
          if (j != i) {
            buttons.get(j).selected = false;
          }
        }
      }
    }
  }


  // handles selection with top and down buttons on keyboard. 
  void indexSelecterKeysVertical() {
    if ((Input.keyClicked('s')||Input.keyCodeClicked(DOWN)) && index < indexMax) {
      index += 1;
      soundBank.playSound(SoundType.BUTTON_NAVIGATE);
    } else if ((Input.keyClicked('w')||Input.keyCodeClicked(UP))&& index > 0) {
      index -= 1;
      soundBank.playSound(SoundType.BUTTON_NAVIGATE);
    }

    for (int i = 0; i < buttons.size(); i++) {
      for (int j = 0; j < buttons.size(); j++) {
        buttons.get(index).selected = true;
        if (j != i) {
          buttons.get(j).selected = false;
        }
      }
    }
  }

  // handles selection with left and right buttons on keyboard.
  void indexSelectedKeysHorizontal() {
    if (Input.keyCodeClicked(LEFT) && index < indexMax) {
      index += 1;
    } else if (Input.keyCodeClicked(RIGHT)&& index > 0) {
      index -= 1;
    }

    for (int i = 0; i < buttons.size(); i++) {
      for (int j = 0; j < buttons.size(); j++) {
        buttons.get(index).selected = true;
        if (j != i) {
          buttons.get(j).selected = false;
        }
      }
    }
  }
}
