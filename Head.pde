/**********************************************\
*
*  Andrey A. Ugolnik
*  http://www.ugolnik.info
*  andrey@ugolnik.info
*
\**********************************************/

class Head extends Segment
{
  Head(PVector v)
  {
    super(v, color(255, 55, 55, 255));
  }

  void draw()
  {
    super.draw();

    fill(255, 255, 55, 255);
    noStroke();
    ellipseMode(RADIUS);
    ellipse(a.x, a.y, r / 2, r / 2);
  }
}