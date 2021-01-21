
import java.util.*;
import java.awt.*;
import javax.swing.JOptionPane;
import javax.swing.JList;

int black=0;
int white=255;
int gray=128;
int darkGray=64;
int lightGray=190;
String welcome = "Welcome to Pyroprint v0.1";

String message="";

String mmenu[]={"LOAD","ORIGIN","PRINT","JOG","CONF","QUIT"};

PImage img;
PImage imghres;

float pWidth=200;          // Width of printed image in mm
float pHeight=300;         // Height of printed image in mm

int iWidth;                // Width of image in pixels
int iHeight;                // Height of image in pixels

float stepX=0.2;
float  stepY=0.2;

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
  
  float n=sqrt(r*r+g*g+b*b)/sqrt(3);
  return int(n);
}

void printLine(int i)
{
  color c;
  for (int j=0;j<10; j++)
   {
     c=imghres.get(i,j);
     print(greyLevel(c)+" ");
   }
}

void setup()
{
  img=loadImage("nantes.jpg");
  int w=img.width;
  int h=img.height;
  img.resize(400, (400*h)/w);
  imghres=loadImage("nantes.jpg");
  println(imghres.width+" "+imghres.height+" ");
  iWidth=int(pWidth/stepX);
  iHeight=int(pHeight/stepY);
  println(iWidth+" "+iHeight+" ");
  printLine(10);
}

void draw() {
  background(60);
  //ellipse(mouseX, mouseY, 33, 33);
  menu();
  
  image(img,100,100);
}
