/**********************************************\
*
*  Andrey A. Ugolnik
*  http://www.ugolnik.info
*  andrey@ugolnik.info
*
\**********************************************/

class Segment
{
  PVector a;
  PVector b;

  color col = color(55, 255, 55, 255);

  float r = 5;

  Segment(PVector v, color segColor)
  {
    a = new PVector(v.x, v.y);
    b = new PVector(v.x, v.y);
    col = segColor;
  }

  void follow(PVector target)
  {
    a.set(target);
    float len = PVector.dist(a, b);
    final float dist = r / sqrt(2);
    if (len >= dist)
    {
      PVector v = PVector.sub(a, b);
      v.setMag(dist);
      v.mult(-1);
      b = PVector.add(a, v);
    }
  }

  void draw()
  {
    noStroke();
    ellipseMode(RADIUS);

    fill(0, 0, 0, 100);
    ellipse(a.x, a.y, r * 1.3, r * 1.3);

    fill(col);
    ellipse(a.x, a.y, r, r);
  }
}