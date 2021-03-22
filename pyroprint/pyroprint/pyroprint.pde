
import java.util.*;
import java.awt.*;
import processing.serial.*;
import javax.swing.JOptionPane;
import javax.swing.JList;

int black=0;
int white=255;
int gray=128;
int darkGray=64;
int lightGray=190;
String welcome = "Welcome to Pyroprint v0.1";

String message="";
int tempMessage=0;

String mmenu[]={"LOAD","PRINT","STOP","CAL","QUIT"};

PImage img;
PImage imghres;

float pWidth=200;          // Width of printed image in mm
float pHeight=300;         // Height of printed image in mm

int iWidth;                // Width of image in pixels
int iHeight;                // Height of image in pixels

float stepX=0.2;
float  stepY=0.2;
float printTime;
String endHour;

// Values used to calculate printing time
// must be the same in Arduino program
float Vmax=0.160;   // m/s
float Vmin=0.006; // m/s
float gamma=1.7;   

Serial   serial;
boolean ok;
int nLine;
int fprint;

float avLineTime;
int t0;
int t1;
boolean fsend=true;

void settings() 
{
   size(1000, 800);

}

int menuwidth=90;
void menu()
{
  textSize(20);
   stroke(white);
  
  int sep=menuwidth/2-5;
  int ofx=(width-mmenu.length*menuwidth)/2;
  for (int i=0; i<mmenu.length; i++)
  {
    fill(204, 102, 0);
  
    
    rect(i*menuwidth+ofx,20,menuwidth-10,40,5);
    fill(white); 
    text(mmenu[i],i*menuwidth+sep-mmenu[i].length()*5.5+ofx,50);
  }
}

int testMenu(int x, int y)
{
  int n=0;
  int ofx=(width-mmenu.length*menuwidth)/2;
  if ((y>=20)&&(y<=60))
  {
    n=(x-ofx)/menuwidth+1;
    if (n<1) n=0;
    if (n>mmenu.length) n=0;
  }
  return n; 
}

int greyLevel(color c)
{
  float r=red(c);
  float g=green(c);
  float b=blue(c);
  
  float n=sqrt(r*r+g*g+b*b)/sqrt(3);;
 // print(c);
  return int(n);
}

char tc[]=new char[]{'0','1','2','3','4','5','6','7','8','9','A','B','C','D','E','F'};
char convhex(int v)
{
  
  return tc[v];
}
void dispImage(int i)
{
  color c;
  for (int j=0;j<iWidth/2; j++)
   {
     c=imghres.get(i,2*j);

     int c1=greyLevel(c)/16;
      print(" "+greyLevel(c)+" "+c1);
      c=imghres.get(i,2*j+1);
      int c2=greyLevel(c)/16;
      println(" "+greyLevel(c)+" "+c2);
   }
  
}

String fmn(float t)
{
  int mn=int(t/60);
  int h=int(mn/60);
  mn=mn-60*h;
  return ""+h+"h "+mn+" mn";
}

String endTime(float t)
{
  int h0=hour();
  int m0=minute();
  
  t=t+m0*60+3600*h0;
  
  int mn=int(t/60);
  int h=int(mn/60);
  mn=mn-60*h;
  if (h>23) h-=24;
  return ""+h+"h "+mn+" mn";
  
}

float printingTime()
{
  float t=0;
  float V[]= new float[16];
  for (int i=0; i<16; i++)
  {
       V[i]=pow((i/15.0),gamma)*(Vmax-Vmin)+Vmin;
  }
  for (int i=0; i<iHeight; i++)
  for (int j=0;j<iWidth; j++)
  {
    color  c=imghres.get(j,i);
    int c1=greyLevel(c)/16;
    t=t+stepX*1e-3/V[c1];
  }
 t=t+iHeight*(stepX*1e-3/V[15])*iWidth;
  return t;
}

void printLine(int i)
{
  color c;
  t1=millis();
  ok=false;
  if (fsend) serial.write('L');
  for (int j=0;j<iWidth/2; j++)
   {
     c=imghres.get(2*j,i);
          print(red(c)+" "+green(c)+" "+blue(c)+ " ");
     int c1=greyLevel(c)/16;
      print(" "+greyLevel(c)+" "+c1);
      c=imghres.get(2*j+1,i);
      int c2=greyLevel(c)/16;
      println(" "+greyLevel(c)+" "+c2);
      if (fsend) serial.write(convhex(c1));
      if (fsend) serial.write(convhex(c2));
   }
   if (fsend) serial.write(';');
  // delay(500);
   nLine++;
   avLineTime=((nLine-1)*avLineTime+(millis()-t1))/nLine;
   if (nLine>iHeight) 
   {
     fprint=0;
     serial.write('S');
   }
   if (!fsend) ok=true;
}

void newImage(String name)
{
  img=loadImage(name);
  int w=img.width;
  int h=img.height;
  img.resize(400, (400*h)/w);
  imghres=loadImage(name);
  imghres.loadPixels();
  iWidth=imghres.width;
  iHeight=imghres.height;
  pWidth=iWidth*stepX;
  pHeight=iHeight*stepY;
  println(iWidth+" "+iHeight+" ");
  printTime=printingTime();
}

void fileSelectedLoad(File selection) {

  if (selection == null) {
    println("Window was closed or the user hit cancel.");
  } else {
    println("User selected " + selection.getAbsolutePath());
    String nFile=selection.getAbsolutePath();
    println("File : "+nFile);
    setMessage("Loading "+nFile);
    newImage(nFile);
  }
}

void fileLoad()
{
  selectInput("Select a file", "fileSelectedLoad");
}


void setup()
{
  setMessage(welcome);
  newImage("cal.jpg");
  //printLine(10);
  print( Serial.list());
   
  
   if (fsend)
   {
   String portName = Serial.list()[0]; //change the 0 to a 1 or 2 etc. to match your port
   
   serial = new Serial(this, portName, 115200);
   }
  
}

void setMessage(String s)
{
  message=s;
  tempMessage=100;
}

void marqueur(int nline)
{
  int i=int(((nline*1.0)*img.height)/imghres.height);
  i=i+100;
  fill(255,0,0);
  triangle(90,i-5,99,i,90,i+5);
}



void draw() {
  background(60);
  //ellipse(mouseX, mouseY, 33, 33);
  menu();
  
  image(img,100,100);
  // Message
  textSize(20);
  fill(255);
  text("Width : "+pWidth+" mm",600,120);
  text("Height : "+pHeight+" mm",600,140);
  text("Printing time : "+fmn(printTime),600,160);
  if (tempMessage>0) 
  {
    tempMessage--;
    text(message,10,height-10);
  }
  
  if (fprint==1)
  {
     marqueur(nLine);
     fill(255,0,0);
     text("Printing",600,200);
     fill(255);
     text("  Line "+nLine+"/"+iHeight,600,220);
     text("  Av line time : "+int(avLineTime)+" ms",600,240);
     text("  Remaining time : "+fmn(avLineTime*(iHeight-nLine)/1000),600,260);
     text("  Remaining time : "+fmn((printTime-1e-3*(millis()-t0))),600,280);
     text("  End time : "+endHour,600,300);
     
     if (ok) 
     {
   avLineTime=((nLine-1)*avLineTime+(millis()-t1))/nLine;
   if (nLine>iHeight) { fprint=0; serial.write('S'); }
   printLine(nLine);
     }
  }
  
}

void mousePressed() {
 
   int nm=testMenu(mouseX,mouseY);
   print(nm);
   // Menu
   if (nm!=0)
   {
     String menu=mmenu[nm-1];
      if (menu.equals("LOAD")) fileLoad(); 
      else if (menu.equals("ROT")) setMessage("ROTATION");
      else if (menu.equals("PRINT")) 
      {
        setMessage("PRINT");
        nLine=0;
        fprint=1;
        avLineTime=0;
        endHour=endTime(printTime);
        t0=millis();
        printLine(nLine);
      }
      else if (menu.equals("STOP")) { fprint=0; serial.write('S'); }
      else if (menu.equals("CAL")) newImage("cal.jpg");
      else if (menu.equals("QUIT")) exit();
   }
}

void serialEvent( Serial myPort) 
{
  String val;
  val = myPort.readStringUntil('\n');

  if (val != null) 
  {
    print(val);
    val = trim(val);
    //println(val);
    if (val.equals("@")) 
    {
     myPort.clear();
     ok = true;
     //print ("ok");
    }
  }
}
