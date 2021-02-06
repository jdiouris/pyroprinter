PImage img;
int w=500; 
int h=50;

void setup()
{
  size(800,100);
  img=createImage(w,h,RGB);
  int wc=w/16;
  for (int i=0; i<16; i++)
  {
    color c=color(i*16);
    for (int n=0; n<wc; n++) 
      for (int m=0; m<h; m++)
        img.set(n+wc*i,m,c);
  }
  img.save("cal.png");
  
  
}

void draw()
{
  image(img,10,10);
}
