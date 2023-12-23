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