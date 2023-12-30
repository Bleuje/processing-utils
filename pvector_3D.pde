PVector rotX(PVector v,float theta)
{
  float y = v.y*cos(theta) - v.z*sin(theta);
  float z = v.y*sin(theta) + v.z*cos(theta);
  return new PVector(v.x,y,z);
}

PVector rotY(PVector v,float theta)
{
  float x = v.x*cos(theta) - v.z*sin(theta);
  float z = v.x*sin(theta) + v.z*cos(theta);
  return new PVector(x,v.y,z);
}

PVector rotZ(PVector v,float theta)
{
  float x = v.x*cos(theta) - v.y*sin(theta);
  float y = v.x*sin(theta) + v.y*cos(theta);
  return new PVector(x,y,v.z);
}

void vertex(PVector v)
{
    vertex(v.x,v.y,v.z);
}

void translate(PVector v)
{
    translate(v.x,v.y,v.z);
}

class Coordinates
{
    PVector position;
    PVector u1, u2, u3;

    Coordinates(PVector pos, PVector u1_, PVector u2_, PVector u3_)
    {
        position = pos;
        u1 = u1_.copy().normalize();
        u2 = u2_.copy().normalize();
        u3 = u3_.copy().normalize();
    }

    void showVectors()
    {
        push();
        translate(position.x, position.y, position.z);
        float F = 30;
        strokeWeight(5.0);
        stroke(255, 0, 0);
        line(0, 0, 0, u1.x*F, u1.y*F, u1.z*F);
        stroke(0, 255, 0);
        line(0, 0, 0, u2.x*F, u2.y*F, u2.z*F);
        stroke(0, 0, 255);
        line(0, 0, 0, u3.x*F, u3.y*F, u3.z*F);
        pop();
    }
}

