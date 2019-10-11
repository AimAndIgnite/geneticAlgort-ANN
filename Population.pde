// create a population of Dots

class Population
{
  Dot[] dots;
  float sumOfFitness;
  int numOfGeneration = 1;
  int bestDot = 0;  
  
  int minStep = 400;   
      
  Population(int size) // size = number of dots in the population
  {
    dots = new Dot[size];
    for (int i = 0; i < size; i++)
    {
      dots[i] = new Dot();
    }
  }
  
  // show every dot in the population
  void show()
  {
    for (int i = 1; i < dots.length; i++)
    {
      dots[i].show();
    }
    dots[0].show();
  }
  
 // move every dot in the population 
  void update()
  {
    for (int i  = 0; i < dots.length; i++)
    {
      if (dots[i].brain.step > minStep)
      {
        dots[i].isDead = true;
      } else
      {  
        dots[i].update(); // move every dot and kill them if they reach the boundaries of the window
      }
    }
  }
  
  // calculate fitness (at Dot tab)
  void calculateFitness()
  {
    for (int i = 0; i < dots.length; i++)
    {
      dots[i].calculateFitness();
    }
  }
    
  // check if all dots are dead; if so, stop updating and moving
  boolean isAllDead()
  {
     for (int i = 0; i < dots.length; i++)
     {
        if(!dots[i].isDead && !dots[i].reachedGoal) // if all dots in a generation is dead, create a new (the next) generation
        {
          return false;
        }
     }
     return true;
  }
  
  void naturalSelection()
  {
    Dot[] newDots = new Dot[dots.length]; // to store new dots for the next generation
    setBestDot(); // to get the best dot from a generation
    calculateSumOfParentsFitness();
    
    newDots[0] = dots[bestDot].generateChild(); 
    newDots[0].isBestDot = true;
    
    // for each space in newDots, get a pair of 'parents' and get their 'child'
    for (int i = 1; i < newDots.length; i++)
    {
      // select suitable 'parents' based on fitness value
      Dot parent = selectParent();
      
      // generate child from parent
       newDots[i] = parent.generateChild(); 
    }
    // set the dots array as new dots
    dots = newDots.clone();
    numOfGeneration++; // increment number of generation
  }
  
  // calculate fitness values of two dots (parents)
  void calculateSumOfParentsFitness()
  {
    sumOfFitness = 0;
    for (int i = 0; i < dots.length; i++)
     {
      sumOfFitness += dots[i].fitness;
    }
  }
  
  Dot selectParent()
  {
     float rand = random(sumOfFitness);
     float runningSum = 0;
     
     for (int i = 0; i < dots.length; i++)
     {
       runningSum += dots[i].fitness;
       if (runningSum > rand) 
       {
         return dots[i];
       }
     }
      
     return null;
  }
  
  void mutateNewDots()
  {
    for (int i = 1; i < dots.length; i++)
    {
      dots[i].brain.mutate();
    }
  }
  
  // make the best dot immortal so as the mutation does not occur negatively
  void setBestDot()
  {
    float max = 0;
    int maxIndex = 0;
    for (int i = 0; i < dots.length; i++)
    {
      // place the best dot into the next generation without mutating it
      if (dots[i].fitness > max)
      {
        max = dots[i].fitness;
        maxIndex = i;
      }
    }
    
    // identify best dot
    bestDot = maxIndex;
    
    // if dot has reached goal, calculate the number of steps
    if (dots[bestDot].reachedGoal)
    {
      minStep = dots[bestDot].brain.step;
      println("Step:", minStep);
    }
  }
}

// select parent based on fitness value
// if we have a dot of fitness 1, and fitness 2, dot w/ fitness 2 should be twice as likely to be chosen
// add all of the fitnesses and choose a number between 0 and the fitness sum
// if the number lands on a particular dot zone, then that dot is chosen
