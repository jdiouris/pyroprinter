// first define the pins
const int DirPinX = 5;  // PORTD 5   // this pin defines direction CW or CCW
const int StepPinX = 2;  // PORTD 2 // pulse this pin to move one step
const int DirPinY = 6;  //PORTD 6  // this pin defines direction CW or CCW
const int StepPinY = 3;  // PORTD 3 // pulse this pin to move one step

const int SPR = 200*32;    // Steps per revolution
const int StepEn= 8; // PORTB 0
const int SPP=32; // Steps per pixel

int speeds[16];

const int TVmax=40;

float Vmax=0.160;   // m/s
float Vmin=0.006; // m/s
float gamma=1.7;

unsigned char pixels[1000];
int Npixels;
char val;

int roundTrip=0;    // 1 if round-trip
int evenLine;

void digitalWrite(volatile uint8_t *port, uint8_t rang, uint8_t valeur)
{
  if (valeur)  { *port |=  (1<<rang) ; }
  else          {*port &= ~(1<<rang) ; }
}

void initSpeeds()
{
  
  for (int i=0; i<16; i++)
  {
      float V=pow(((i)/15.0),gamma)*(Vmax-Vmin)+Vmin;
      speeds[i]=int(40e-3/(2*V*200*32)*1e6);
      Serial.println(speeds[i]);
  }
  
}

void motorsOn()
{
  digitalWrite(StepEn, LOW);
}

void motorsOff()
{
  digitalWrite(StepEn, HIGH);
}
void setup()
{
  Serial.begin(115200);
  Serial.println("PyroArd Ok");
  // Make pins as Outputs
  pinMode(StepPinX, OUTPUT);
  pinMode(DirPinX, OUTPUT);
  pinMode(StepEn, OUTPUT);
  
  Serial.begin(115200);
  initSpeeds();
  
//  motorsOn();
//  for (int i=0; i<50; i++) 
//  {
//    forwardLine();
//    delay(1000);
//  }


  
  
  motorsOff();
  evenLine=0;
}

void printLine()
{
  Serial.print("printLine "); 
  Serial.print(Npixels); 
  Serial.println(" pixels");
  motorsOn();
  
  if ((roundTrip==1)&&(evenLine==1))
  {
    backX();
    for (int i=Npixels/2-1; i>=0; i--) 
    {
     drawPixel(speeds[pixels[i]>>4]);
     drawPixel(speeds[pixels[i]&0x0F]);
    }
    for (int i=1; i<100; i++) drawPixel(speeds[15]);
    forwardX();
    for (int i=1; i<50; i++) drawPixel(speeds[4]);
    backX();
    for (int i=1; i<50; i++) drawPixel(speeds[4]);
    forwardX();
    for (int i=1; i<50; i++) drawPixel(speeds[4]);
    backX();
    for (int i=1; i<50; i++) drawPixel(speeds[4]);
    
  }
  else 
  {
    forwardX();
    for (int i=1; i<100; i++) drawPixel(speeds[15]);
    for (int i=0; i<Npixels/2; i++) 
    {
      drawPixel(speeds[pixels[i]&0x0F]);
      drawPixel(speeds[pixels[i]>>4]);
    }
  }

  if (roundTrip==0) 
  {
    backX();
    for (int i=0; i<Npixels; i++) drawPixel(TVmax);  
    for (int i=1; i<100; i++) drawPixel(speeds[15]);
    forwardX();
    for (int i=1; i<50; i++) drawPixel(speeds[4]);
    backX();
    for (int i=1; i<50; i++) drawPixel(speeds[4]);
    forwardX();
    for (int i=1; i<50; i++) drawPixel(speeds[4]);
    backX();
    for (int i=1; i<50; i++) drawPixel(speeds[4]);
    
  }
  delay(1);
  forwardLine();
  delay(1);
  if (evenLine==0) evenLine=1; else evenLine=0;
}

void drawPixel(int ds)
{
  for(int x = 0; x < SPP; x++)
  {
   // digitalWrite(StepPinX, HIGH);
     digitalWrite(&PORTD,2,1);
    delayMicroseconds(ds);
    //digitalWrite(StepPinX, LOW);
    digitalWrite(&PORTD,2,0);
    delayMicroseconds(ds);
  }
  
}

void forwardX()
{
    digitalWrite(DirPinX, LOW);
}

void backX()
{
  digitalWrite(DirPinX, HIGH);
}

void forwardY()
{
    digitalWrite(DirPinY, LOW);
}

void backY()
{
  digitalWrite(DirPinY, HIGH);
}

void forwardLine()
{
  int ds=100;

  forwardY();
    for(int x = 0; x < SPP; x++)
  {
    //digitalWrite(StepPinY, HIGH);
    digitalWrite(&PORTD,3,1);
    delayMicroseconds(ds);
    //digitalWrite(StepPinY, LOW);
    digitalWrite(&PORTD,3,0);
    delayMicroseconds(ds);
  }
  
}



int conv(char c)
{
  if (c<='9') return (c-'0');
  else return (c-'A'+10);
}
// Commande Ligne
// Lxxxxxx;
#define ATT 0
#define LN0 1
#define LN1 2
int etat=ATT;

void loop()
{
  if (Serial.available()) 
   { 
     val = Serial.read();
     Serial.print(val);
     if (val=='L') { Npixels=0; etat=LN0; }
     else if (val==';') { printLine(); Serial.println('@'); etat=ATT; }
     else if (etat==LN0) { pixels[Npixels/2]=conv(val); etat=LN1; Npixels++;}
      else if (etat==LN1) { pixels[Npixels/2]+=conv(val)<<4; etat=LN0; Npixels++;}  
      else if (val=='S') { 
        if (roundTrip==1) if (evenLine==1) {
          backX();
          for (int i=0; i<Npixels; i++) drawPixel(TVmax); 
          for (int i=1; i<100; i++) drawPixel(speeds[15]);
          
        }
        motorsOff(); 
      }             
    }
}
