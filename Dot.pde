class Dot
{
  //2 or 3 dimensional array with a Euclidean vector that has magnitude and direction
  PVector pos;
  PVector vel;
  PVector acc;
  Brain brain;
  boolean isDead = false;  
  float fitness = 0; // fitness value of the dot: determines which dot performs greatly or poorly
  boolean reachedGoal = false;  
  boolean isBestDot = false;
      
  //constructor to initialize values
  Dot() 
  {
    brain = new Brain(1000);
    // initialize dot at the bottom of the window
    pos = new PVector(width/2, height-10);
    //inititalize dot(s) to have 0 velocity and acceleration
    vel = new PVector(0, 0);
    acc = new PVector(0, 0);
    
    // initialize brain with 400 vectors
    
  }
  
  //draw dots
  void show()
  {
    if (isBestDot)
    {
      fill(0, 255, 0); // draw the best dot and color it green
      ellipse(pos.x, pos.y, 8, 8);
    }
    
    else
    {
       //normal dots: black color and elliptical
      fill(0);
      //ellipse(xcoor, ycoor, width, height)
      ellipse(pos.x, pos.y, 4, 4);
    }
  }
  
  void move()
  {
    if (brain.directions.length > brain.step)
    {
      // set the acceleration of the dot to the next element of the directions array
      acc = brain.directions[brain.step];
      brain.step++;  
    } 
    else
    {
      isDead = true; // terminate the dot if it runs out of directions to follow
    }
    // else // if 
    
      
    // give initial velocity vased on acceleration
    // and position based on traveled velocity
    vel.add(acc);
    vel.limit(5); // limit the veloctiy of the dot to a maximum magnitude of 5
    pos.add(vel); 
  }
  
  void update()
  {
    if (!isDead && !reachedGoal) // if a dot hasnt died AND hasnt reahed the goal, keep moving it
    {
      move();
       
      // kill the dot if it reaches/hits the boundaries of the window
      if (pos.x < 2 || pos.y < 2 || pos.x > width-2 || pos.y > height-2) 
        isDead = true;     
        
      else if (dist(pos.x, pos.y, goal.x, goal.y) < 5)// if the dot has reached the goal, kill it
      {
        reachedGoal = true;
      }
      
      else if (pos.x< 700 && pos.y < 310 && pos.x > 100 && pos.y > 300) 
      {//if hit obstacle
        isDead = true;
      }
    } 
  }
  
  void calculateFitness() // calcuate fitness value of the dot to determine which has performed greatly or poorly
  {
    // the lower the step, the higher the fitness
    if (reachedGoal)
    {
      // dots that reached the goal have better fitness than that which did not
      fitness = 1.0 / 16.0 + 10000.0 / (float)(brain.step * brain.step);
    }
    float distanceToGoal = dist(pos.x, pos.y, goal.x, goal.y); // the closer the dot to the goal, the better the performance 
    fitness = 1.0 / (distanceToGoal * distanceToGoal); //inverse of the distance between the dot's position and the goal -> the smaller the distance, the higher the fitness value
    // square the distance -> even small steps to the goal gives a large score 
    
  }
  
  Dot generateChild()
  {
     Dot child = new Dot(); 
     // crossover process = get genes from both parents and splice them, then add to child
     child.brain = brain.clone();
     return child;
  }
}
