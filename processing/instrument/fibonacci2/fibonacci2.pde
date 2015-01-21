import oscP5.*;
import netP5.*;


OscP5 oscP5;
NetAddress myRemoteLocation;
  
  
float phi = (sqrt(5)+1)/2;
int num=7;
float[][] pos=new float[num][4];


void setup()
{
  
  size(1200,800);
  frameRate(80);
  
  translate(height/phi,0);
  scale(height);
  noStroke();  
  smooth();
  for (int i=0; i<num; i++) {
    fill((float)i/10*255);
    rect(0,0,1,1);
    fill(255,255,0,150);
  //  arc(0,0,2,2,0,PI/2);
  //  println(screenX(0,0),screenX(1,1),screenY(0,0),screenY(1,1));
   if(i<num)
   {
    pos[i][0]=screenX(0,0);
    pos[i][1]=screenX(1,1);
    pos[i][2]=screenY(0,0);
    pos[i][3]=screenY(1,1);
   }
    scale(1/phi);
    rotate(PI/2);
    translate(1/phi,0);   
  }

  
  oscP5=new OscP5(this,6450);
  myRemoteLocation=new NetAddress("127.0.0.1",6449);
}

int numfib=0;

void draw()
{
 // drawfib(numfib);
  
  numfib+=1;
}

void drawfib(int index)
{

    fill((float)(num-1-index)/10*255);
    float x1=min(pos[num-1-index][0],pos[num-1-index][1]);
    float x2=max(pos[num-1-index][0],pos[num-1-index][1]);
    float y1=min(pos[num-1-index][2],pos[num-1-index][3]);
    float y2=max(pos[num-1-index][2],pos[num-1-index][3]);
    rect(x1,y1,x2,y2);
    fill(255,255,0,150);
    //arc(0,0,2,2,0,PI/2);

}


void mousePressed()
{
  
  OscMessage myMessage=new OscMessage("/play");
  int temp=update();
  myMessage.add("test");
  myMessage.add(temp);
  oscP5.send(myMessage,myRemoteLocation);

}

void mouseReleased()
{
  OscMessage myMessage=new OscMessage("/play");
  myMessage.add("test");
  myMessage.add(-2);
  oscP5.send(myMessage,myRemoteLocation);
}



int update()
{
  for (int i=0;i<num;i++)
  {
    if (overRect(pos[i][0],pos[i][1],pos[i][2],pos[i][3]))
      return num-i;
  }
  return -1;
}

boolean overRect(float x, float x2, float y, float y2)  {
  if (mouseX >= min(x,x2) && mouseX <= max(x2,x) && 
      mouseY >= min(y,y2) && mouseY <= max(y2,y)) {
    return true;
  } else {
    return false;
  }
}

