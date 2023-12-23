// motion blur template by beesandbombs, explanation/article: https://bleuje.com/tutorial6/

//////////////////////////////////////////////////////////////////////////////
// Start of template

int[][] result; // pixel colors buffer for motion blur
float t; // time global variable in [0,1[
float c; // other global variable for testing things, controlled by mouse

//-----------------------------------
// some generally useful functions...

float c01(float x)
{
  return constrain(x,0,1);
}

// ease in and out, [0,1] -> [0,1], with a parameter g:
// https://patakk.tumblr.com/post/88602945835/heres-a-simple-function-you-can-use-for-easing
float ease(float p, float g) {
  if (p < 0.5) 
    return 0.5 * pow(2*p, g);
  else
    return 1 - 0.5 * pow(2*(1 - p), g);
}

// defines a map function variant to constrain or not in target interval (exists in openFrameworks)
float map(float x, float a, float b, float c, float d, boolean constr)
{
  return constr ? constrain(map(x,a,b,c,d),min(c,d),max(c,d)) : map(x,a,b,c,d);
}

// short one to map an x from [a,b] to [0,1] and constrain
float mp01(float x, float a, float b)
{
  return map(x,a,b,0,1,true);
}

// reversed pow that does some kind of ease out, [0,1] -> [0,1], with a parameter g
float pow_(float p,float g)
{
  return 1-pow(1-p,g);
}

// hyperbolic tangent, maps ]-infinity,+infinity[ to ]-1,1[ 
float tanh(float x)
{
  return (float)Math.tanh(x);
}

//-----------------------------------

void draw()
{
  if (!recording) // test mode...
  { 
    t = (mouseX*1.3/width)%1;
    c = mouseY*1.0/height;
    if (mousePressed)
      println(c);
    draw_();
  }
  else // render mode...
  { 
    for (int i=0; i<width*height; i++)
      for (int a=0; a<3; a++)
        result[i][a] = 0;

    c = 0;
    for (int sa=0; sa<samplesPerFrame; sa++) {
      t = map(frameCount-1 + sa*shutterAngle/samplesPerFrame, 0, numFrames, 0, 1);
      t %= 1;
      draw_();
      loadPixels();
      for (int i=0; i<pixels.length; i++) {
        result[i][0] += red(pixels[i]);
        result[i][1] += green(pixels[i]);
        result[i][2] += blue(pixels[i]);
      }
    }

    loadPixels();
    for (int i=0; i<pixels.length; i++)
      pixels[i] = 0xff << 24 | 
        int(result[i][0]*1.0/samplesPerFrame) << 16 | 
        int(result[i][1]*1.0/samplesPerFrame) << 8 | 
        int(result[i][2]*1.0/samplesPerFrame);
    updatePixels();
    
    if (frameCount<=numFrames) {
      saveFrame("data/fr###.gif");
      println(frameCount,"/",numFrames);
    }
    
    if (frameCount==numFrames)
      stop();
  }
}

// End of template
//////////////////////////////////////////////////////////////////////////////

int samplesPerFrame = 5;
int numFrames = 80;        
float shutterAngle = .6;

boolean recording = false;




void setup()
{
  size(600,600,P3D);
  result = new int[width*height][3];
  smooth(8);

}


void draw_()
{
  background(0);
  push();
  translate(width/2,height/2);
  
  
  pop();
}
