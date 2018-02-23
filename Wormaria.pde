/**********************************************\
*
*  Andrey A. Ugolnik
*  http://www.ugolnik.info
*  andrey@ugolnik.info
*
\**********************************************/

ArrayList<Worm> worms = new ArrayList();
ArrayList<Apple> apples = new ArrayList();

void setup()
{
  size(800, 600);

  while (apples.size() < 10)
  {
    apples.add(new Apple(random(width), random(height)));
  }

  worms.add(new Worm(random(width), random(height), 5, randomColor()));
  setNearestTarget(worms.get(0));
}

void draw()
{
  background(50);

  //if (mousePressed)
  //{
  //  setTarget();
  //}

  while (apples.size() < 10 * worms.size())
  {
    apples.add(new Apple(random(width), random(height)));
  }

  for (Apple apple : apples)
  {
    apple.draw();
  }

  for (int i = worms.size() - 1; i >= 0; i--)
  {
    Worm worm = worms.get(i);

    worm.update();
    worm.draw();

    PVector head = worm.getHeadPos();

    for (int a = apples.size() - 1; a >= 0; a--)
    {
      Apple apple = apples.get(a);
      if (apple.test(head.x, head.y, 10))
      {
        worm.grow(1);

        apples.remove(a);

        setNearestTarget(worm);
      }
    }

    if (checkCollision(i))
    {
      ArrayList<Segment> segments = worm.segments;
      for (Segment segment : segments)
      {
        final int r = (int)segment.r;
        for (int a = 0; a < r / 5; a++)
        {
          float x = segment.a.x + r - random(r * 2);
          float y = segment.a.y + r - random(r * 2);
          Apple apple = new Apple(x, y);
          apple.setColor(randomColor());
          apples.add(apple);
        }
      }
      worms.remove(i);
    }
  }

  while (worms.size() < 3)
  {
    worms.add(new Worm(random(width), random(height), 5, randomColor()));
    setNearestTarget(worms.get(worms.size() - 1));
  }
}

color randomColor()
{
  return color(100 + random(155), 100 + random(155), 100 + random(155), 255);
}

boolean checkCollision(int idx)
{
  Worm worm = worms.get(idx);
  PVector pos = worm.getHeadPos();

  for (int i = 0; i < worms.size(); i++)
  {
    if (i != idx)
    {
      Worm w = worms.get(i);
      if (w.testCollision(pos))
      {
        return true;
      }
    }
  }

  return false;
}

void setNearestTarget(Worm worm)
{
  PVector head = worm.getHeadPos();

  float distance = 0;
  int index = -1;
  for (int i = 0; i < apples.size(); i++)
  {
    Apple apple = apples.get(i);

    float dist = PVector.dist(apple.pos, head);
    if (index == -1 || dist < distance)
    {
      index = i;
      distance = dist;
    }
  }

  if (index != -1)
  {
    Apple apple = apples.get(index);
    worm.setTarget(apple.pos);
  }
}