
char line [1000];

void setup() {
  // put your setup code here, to run once:
  for (int i=0; i<1000; i++) line[i]=i;
  for (int i=0; i<1000; i++) analogWrite(0,line[i]);

}

void loop() {
  // put your main code here, to run repeatedly:

}
