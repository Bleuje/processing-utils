// ease in and out, [0,1] -> [0,1], with a parameter g:
// https://patakk.tumblr.com/post/88602945835/heres-a-simple-function-you-can-use-for-easing
float ease(float p, float g)
{
  if (p < 0.5) 
    return 0.5 * pow(2*p, g);
  else
    return 1 - 0.5 * pow(2*(1 - p), g);
}

// by jn3008
float bounce(float x)
{
    int n = 3;
    float [] intervals = {0, 0.55, 0.85};
    float [] heights = {1, 0.18, 0.035};

    for (int i = 0; i < n; i++)
        if (x < intervals[i])
            return 1 - heights[i - 1] * (1 - sq(map(x, intervals[i - 1], intervals[i], i == 1 ? 0 : -1, 1)));
    return 1 - (1 - c01(sq(map(x, intervals[n - 1], 1, -1, 1)))) * heights[n - 1];
}

// easing function taken from https://easings.net/#easeOutElastic, slightly modified
float easeOutElastic(float x)
{
  float c4 = (2*PI)/3;
  if(x<=0) return 0;
  if(x>=1) return 1;
  return pow(2, -10 * x) * sin((x * 10 - 0.75) * c4) + 1;
}