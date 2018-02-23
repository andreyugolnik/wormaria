/**********************************************\
*
*  Andrey A. Ugolnik
*  http://www.ugolnik.info
*  andrey@ugolnik.info
*
\**********************************************/

class Apple
{
  PVector pos;
  float radius = 6;
  color col = color(255, 0, 0, 255);

  Apple(float x, float y)
  {
    pos = new PVector(x, y);
  }

  void setColor(color c)
  {
    col = c;
  }
  
  void draw()
  {
    fill(col);
    noStroke();
    ellipseMode(RADIUS);
    ellipse(pos.x, pos.y, radius, radius);
  }
  
  boolean test(float x, float y, float r)
  {
    float dx = pos.x - x;
    float dy = pos.y - y;
    return r * r + radius * radius >= dx * dx + dy * dy;
  }
}