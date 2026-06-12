#include <Servo.h>

Servo myServo;
int trigPin = 13;
int echoPin = 11;

long getDistance()
{
  long total = 0;
  int validReadings = 0;
  
  for(int i = 0; i < 3; i++)
  {
    digitalWrite(trigPin, LOW);
    delayMicroseconds(2);
    digitalWrite(trigPin, HIGH);
    delayMicroseconds(10);
    digitalWrite(trigPin, LOW);
    long Duration = pulseIn(echoPin, HIGH);
    long d = Duration * 0.034 / 2;
    
    if(d > 2)
    {
      total = total + d;
      validReadings = validReadings + 1;
    }
    delay(10);
  }
  
  if(validReadings == 0) return 999;
  return total / validReadings;
}

void setup()
{
  pinMode (trigPin, OUTPUT);
  pinMode (echoPin, INPUT);
  myServo.attach(6);
  Serial.begin(9600);
}

void loop()
{
  for (int angle = 0; angle <= 180; angle ++)
  {
    myServo.write(angle);
    delay(15);
    long distance = getDistance();
    Serial.print(angle);
    Serial.print(",");
    Serial.println(distance);
  }

  for(int angle = 180; angle >= 0; angle--)
  {
    myServo.write(angle);
    delay(15);
    long distance = getDistance();
    Serial.print(angle);
    Serial.print(",");
    Serial.println(distance);
  }
}