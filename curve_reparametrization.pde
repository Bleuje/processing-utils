// would be nice if you let me know if the code in this file is useful to you (I'm @etiennejcb on twitter)

PVector curvePath(float q) {
    PVector v  = new PVector(0, 0, 0);
    // ...
    return v;
}

int mSmooth = 5000;
float [] cumulLengths = new float[mSmooth+1];

void fillCumulLengths()
{
  float curLength = 0;
  cumulLengths[0] = curLength;
  PVector prevPos = curvePath(0);
  for(int i=1;i<=mSmooth;i++)
  {
    float p = 1.0*i/mSmooth;
    PVector v = curvePath(p);
    PVector diff = v.copy().sub(prevPos);
    curLength += diff.mag();
    cumulLengths[i] = curLength;
    prevPos = v;
  }
}

int mSampling = 5000;
float [] paramOfSample = new float[mSampling+1];

void fillParamOfSample()
{
  int currentLengthsIndex = 1;
  float totalLength = cumulLengths[mSmooth];
  for(int ind=0;ind<mSampling;ind++)
  {
    while(cumulLengths[currentLengthsIndex] < 1.0*ind/mSampling*totalLength)
    {
      currentLengthsIndex++;
    }
    float leftLength = cumulLengths[currentLengthsIndex-1];
    float rightLength = cumulLengths[currentLengthsIndex];
    float curLength = 1.0*ind*totalLength/mSampling;
    float segmentLength = rightLength-leftLength;
    float lerper = (curLength - leftLength)/segmentLength;
    float q = lerp(currentLengthsIndex-1,currentLengthsIndex,lerper)/mSmooth;
    
    paramOfSample[ind] = q;
  }
}

PVector constantSpeedCurve(float p)
{
    p = ((p%1)+1)%1;
    float floatIndex = p*(mSampling-1);
    int index1 = floor(floatIndex);
    int index2 = index1+1;
    float lerper = floatIndex-index1;
    float prm = lerp(paramOfSample[index1],paramOfSample[index2],lerper);

    return curvePath(prm);
}

/* in setup():

  fillCumulLengths();
  fillParamOfSample();

*/
