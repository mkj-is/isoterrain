

public class Terrain
{
  static final int DEFAULT_SIZE = 50;
  
  private int w;
  private int h;
  private float data[][];
  
  public color tint = #ECF67A;
  public float yOffset = -100.0;
  
  public float topCutoff = 0.0;
  public float bottomCutoff = 0.0;
  public boolean enableBottomCutoff = false;
  public boolean enableTopCutoff = false;
  
  public Terrain()
  {
    this(DEFAULT_SIZE, DEFAULT_SIZE);
  }
  
  public Terrain(int xsize, int ysize)
  {
    w = xsize;
    h = ysize;
    if(w <= 0)
    {
      w = DEFAULT_SIZE;
    }
    if(h <= 0)
    {
      h = DEFAULT_SIZE; 
    }
    data = new float[w][h];
  }
  
  public void initWithPerlin(float xoffset, float yoffset, float scale)
  {
    for(int x = 0; x < w; x++)
    {
      for(int y = 0; y < w; y++)
      {
        data[x][y] = noise(xoffset + x * scale, yoffset + y * scale);
      }
    }
  }
  
  public float getValue(int x, int y, float multiplier)
  {
    if(enableBottomCutoff && data[x][y] * multiplier > bottomCutoff)
    {
      return bottomCutoff;
    }
    return data[x][y] * multiplier;
  }
  
  public int getWidth()
  {
    return w;
  }
  
  public int getHeight()
  {
    return h;
  }
  
  public void drawSurface(float size, float multiply)
  {
    fill(tint);
    noStroke();
    for (int i = 1; i <= getWidth() - 1; i++) {
        for (int j = 1; j <= getHeight() - 1; j++) {
            beginShape();
            vertex(-size / 2.0 + i * size / getWidth(), getValue(i, j - 1, multiply) + yOffset, -size / 2.0 + (j - 1) * size / getHeight());
            vertex(-size / 2.0 + i * size / getWidth(), getValue(i, j, multiply) + yOffset, -size / 2.0 + j * size / getHeight());
            vertex(-size / 2.0 + (i - 1) * size / getWidth(), getValue(i - 1, j - 1, multiply) + yOffset, -size / 2.0 + (j - 1) * size / getHeight());
            endShape();
            beginShape();
            vertex(-size / 2.0 + i * size / getWidth(), getValue(i, j, multiply) + yOffset, -size / 2.0 + j * size / getHeight());
            vertex(-size / 2.0 + (i - 1) * size / getWidth(), getValue(i - 1, j - 1, multiply) + yOffset, -size / 2.0 + (j - 1) * size / getHeight());
            vertex(-size / 2.0 + (i - 1) * size / getWidth(), getValue(i - 1, j, multiply) + yOffset, -size / 2.0 + j * size / getHeight());
            endShape();
      }
    }
  }
}
