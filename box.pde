void drawFace(float l)
{
  rectMode(CENTER);
  fill(0);
  stroke(255);
  strokeWeight(1.0);
  rect(0,0,l,l);
  
  /*
  oher stuff
  */
}


void drawCustomBox(float l)
{
  push();
  push();
  translate(0,0,l/2);
  drawFace(l);
  pop();
  rotateX(PI);
  translate(0,0,l/2);
  drawFace(l);
  pop();
  
  push();
  rotateX(HALF_PI);
  push();
  translate(0,0,l/2);
  drawFace(l);
  pop();
  rotateX(PI);
  translate(0,0,l/2);
  drawFace(l);
  pop();
  
  push();
  rotateZ(HALF_PI);
  rotateX(HALF_PI);
  push();
  translate(0,0,l/2);
  drawFace(l);
  pop();
  rotateX(PI);
  translate(0,0,l/2);
  drawFace(l);
  pop();
}