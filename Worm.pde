/**********************************************\
*
*  Andrey A. Ugolnik
*  http://www.ugolnik.info
*  andrey@ugolnik.info
*
\**********************************************/

class Worm
{
  ArrayList<Segment> segments = new ArrayList();
  PVector vel = new PVector();

  float wormLength = 0;

  Worm(float x, float y, int count, color col)
  {
    PVector parent = new PVector(x, y);
    float angle = PI / 4;

    for (int i = 0; i < count; i++)
    {
      Segment segment;
      if (i == 0)
      {
        segment = new Head(parent);
      } else if (i == count - 1)
      {
        segment = new Tail(parent);
      } else
      {
        segment = new Segment(parent, col);
      }

      PVector v = new PVector(segment.r * cos(angle), segment.r * sin(angle));
      segment.b.set(segment.a.x + v.x, segment.a.y + v.y);
      wormLength += PVector.dist(new PVector(0, 0), v);
      
      segments.add(segment);
      parent.set(segment.b);
    }
  }

  void grow(int count)
  {
    for (int i = 0; i < count; i++)
    {
      int middle = segments.size() / 2;
      Segment prev = segments.get(middle);
      Segment tail = new Segment(prev.b, prev.col);
      segments.add(middle, tail);
    }
  }

  PVector getHeadPos()
  {
    Segment head = segments.get(0);
    return head.a;
  }

  void setTarget(PVector target)
  {
    Segment head = segments.get(0);

    PVector v = PVector.sub(target, head.a);
    v.normalize();

    vel.set(v);
    vel.mult(3);
  }

  boolean testCollision(PVector pos)
  {
    for (Segment segment : segments)
    {
      float distance = PVector.dist(segment.a, pos);
      if (distance < segment.r * 2)
      {
        return true;
      }
    }
    return false;
  }

  void update()
  {
    Segment head = segments.get(0);

    head.a.add(vel);

    PVector p = head.a;

    if ((p.x >= width && vel.x > 0) || (p.x <= 0 && vel.x < 0))
    {
      vel.x = -vel.x;
    }
    if ((p.y >= height && vel.y > 0) || (p.y <= 0 && vel.y < 0))
    {
      vel.y = -vel.y;
    }

    final int count = segments.size();
    final float maxSegs = 500;
    final float radius = map(count < maxSegs ? count : maxSegs, 0, maxSegs, 6, 20);
    for (int i = 0; i < count; i++)
    {
      Segment s = segments.get(i);
      s.r = map(i, 0, count, radius, radius * 0.6);
      s.follow(p);
      p = new PVector(s.b.x, s.b.y);
    }
  }

  void draw()
  {
    final int count = segments.size();
    for (int i = 0; i < count; i++)
    {
      Segment s = segments.get(count - i - 1);
      s.draw();
    }
  }
}