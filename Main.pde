Population test;
PVector goal = new PVector(400, 10); // location of the goal that the dot is trying to get to

public void settings() // set the size of the window to 800x800
{
  size(800, 800);
}

void setup()
{
  frameRate(100); 
  background(200);
  test = new Population(1000);
}

void draw()
{
  background(255); // gives a white background
  // draw goal of the dot
  fill (255, 0, 0);
  ellipse(goal.x, goal.y, 10, 10);
  
  // draw obstacles
  fill(0, 0, 255);
  rect(100, 300, 600, 10); 
  
  if (test.isAllDead())
  {
    // all dots in this generation are dead, create new generation with genetic algorithm
    // genetic algorithm
    test.calculateFitness();
    test.naturalSelection(); // select best dot in the generation and use its info to mutate the new generation of dots
    test.mutateNewDots(); // mutate dots based on best dot
  }
  else // show any live dots and move them
  {
    // show every movement in the frame; the movement is played frame by frame
    test.update();
    test.show(); 
  }
}
