
// Need G4P library
import g4p_controls.*;
import ddf.minim.*;
import javax.swing.*;
import java.awt.*;
AudioPlayer player;
Minim minim;
boolean playFlag=false;
int offlength;
public void setup(){
  size(400, 300, P2D);
  createGUI();
  customGUI();
  // Place your setup code here
  minim=new Minim(this);
}

public void draw(){
  background(230);
  //draw slider at X:10 Y:180
  //height:10 width: 380 
  pushStyle();
  noStroke();
  fill(#7A757C);
  rect(10,180,380,10);
  ellipse(10,185,15,10);
  ellipse(390,185,15,10);
  fill(#BFA2CB);
  if(!playFlag){
    ellipse(10,185,15,10);
  }
  else{
    ellipse(10+player.position()*380/player.length(),185,15,10);
    fill(0);
    text(int(player.position()/1000/60)+":"+nf(int(player.position()/1000)%60,2)+"/"+int(player.length()/1000/60)+":"+nf(int(player.length()/1000)%60,2),10,200);
  }
  popStyle();
  //over
  if(playFlag){
     if((player.length()-player.position())<=500){
        playFlag=false;
        player.close();
        return; 
     }
     stroke(0);
     for(int i=0;i<player.bufferSize()-1;i++){
        line(i,44+player.left.get(i)*50,i+1,44+player.left.get(i+1)*50);
        line(i,88+player.right.get(i)*50,i+1,88+player.right.get(i+1)*50);
     } 
  }else{
     stroke(0);
     line(0,44,width,44);
     line(0,88,width,88); 
  }
}

// Use this method to add additional statements
// to customise the GUI controls
public void customGUI(){

}
void mouseReleased(){
  if(get(mouseX,mouseY)==color(#7A757C)&&playFlag&&mouseY>=180&&mouseY<=190){
    int offset=constrain(mouseX,10,390);
    noStroke();
    fill(#BFA2CB);
    ellipse(offset,185,15,10);
    player.play((offset-10)*offlength); 
  } 
}
