 //each dot has a single brain that allows them to move in random directions
//the brain will be mutated for each generation in order to find the best 'brain'
  
class Brain
{
  //contains PVectors that control the acceleration of the dot
  PVector directions[];
  int step = 0;
  
  Brain(int size)
  {
    directions = new PVector[size];
    randomize(); // make the directions random for the genetic algorithm to move
  }
  
  // randomize movement for every dot; randomize every value in the array
  void randomize()
  {
    for (int i = 0; i < directions.length; i++)
    {
      float randomDir = random(2 * PI);
      directions[i] = PVector.fromAngle(randomDir);
    }
  }
  
  // clone the parents brain and give it to the childs brain
  Brain clone()
  {
    Brain clone = new Brain(directions.length);
     for (int i = 0; i < directions.length; i++)
     {
       clone.directions[i] = directions[i].copy();
     }
     
     return clone;
  }
  
  void mutate()
  {
    // set mutation rate
    // the chance of a specific direction being overwritten by a new one
    float mutationRate = 0.01;
    for (int i = 0; i < directions.length; i++)
    {
      float rand = random(1);
      if (rand < mutationRate)
      {
        // set this direction as a random direction
        float randomAngle = random(2*PI);
        directions[i] = PVector.fromAngle(randomAngle);
      }
    }
  }
}  
