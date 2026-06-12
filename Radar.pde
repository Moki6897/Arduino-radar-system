import processing.serial.*;

Serial myPort;
String data;
float distance;
int angle;

void setup()
{
  size(800, 800);
  myPort = new Serial(this, "COM3", 9600);
  myPort.bufferUntil('\n');
}

void draw()
{
  background(0, 0, 0);
  fill(125, 125, 0);
  textSize(20);
  text("Radar - Mohan", 20, 30);
  
  // Draw radar circles
  noFill();
  stroke(255, 0, 0);
  ellipse(400, 400, 200, 200);
  ellipse(400, 400, 400, 400);
  ellipse(400, 400, 600, 600);
  ellipse(400, 400, 800, 800);
  
  // Draw sweep line
  stroke(255, 255, 0);
  float x = 400 + cos(radians(angle)) * 400;
  float y = 400 - sin(radians(angle)) * 400;
  line(400, 400, x, y);
  
  // Draw obstacle dot
  if(distance < 40)
  {
    fill(255, 0, 0);
    float ox = 400 + cos(radians(angle)) * (distance * 3);
    float oy = 400 - sin(radians(angle)) * (distance * 3);
    ellipse(ox, oy, 10, 10);
  }
}

void serialEvent(Serial myPort)
{
  data = myPort.readStringUntil('\n');
  if(data != null)
  {
    data = trim(data);
    int idx = data.indexOf(',');
    if(idx > 0)
    {
      angle = int(data.substring(0, idx));
      distance = float(data.substring(idx + 1));
    }
  }
}
