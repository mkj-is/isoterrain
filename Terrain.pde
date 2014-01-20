/**
 *
 * @file Terrain.pda
 *
 * @author Matěj Kašpar Jirásek <matej.jirasek@gmail.com>
 * @date 2013-12-06
 *
 */

/**
 * @class Terrain
 *
 * Low res triangle mesh terrain layer.
 */
public class Terrain
{
  /**
   * Resolution of the terrain layer
   */
  static final int DEFAULT_SIZE = 50;
  /**
   * Width of the layer
   */
  private int w;
  /**
   * Height of the layer
   */
  private int h;
  /**
   * Vaues of the points on the map
   */
  private float data[][];
  /**
   * Color of the layer
   */
  public color tint = #ECF67A;
  /**
   * Height offset of layer
   */
  public float hOffset = -100.0;
  /**
   * Top cut-off of the layer. Higher values will be cropped.
   */
  public float topCutoff = 0.0;
  /**
   * Bottom cut-off of the layer. Lower values will be cropped.
   */
  public float bottomCutoff = 0.0;
  /**
   * Enable top cut-off
   */
  public boolean enableBottomCutoff = false;
  /**
   * Enable bottom cut-off
   */
  public boolean enableTopCutoff = false;
  /**
   * Description of the layer
   */
  public String title = "Layer";
  /**
   * The height multiplier
   */
  public float multiply = 50.0;
  /**
   * X offset
   */
  public float xOffset = 0.0;
  /**
   * Y offset
   */
  public float yOffset = 0.0;
  /**
   * Scale between two Perlin values
   */
  public float scale = 0.3;
  
  /**
   * Creates the terrain with default values
   */
  public Terrain()
  {
    this(DEFAULT_SIZE, DEFAULT_SIZE);
  }
  
  /**
   * Creates the array for point heights
   * @param xsize count of the point on x axis
   * @param ysize count of the point on y axis
   */
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
  
  /**
   * Sets up random values for the mesh (initialized using perlin noise)
   *
   * @param xoffset X offset of the perlin noise
   * @param yoffset Y offset of the perlin noise
   */
  public void setOffset(float xoffset, float yoffset)
  {
    xOffset = xoffset;
    yOffset = yoffset;
    for(int x = 0; x < w; x++)
    {
      for(int y = 0; y < w; y++)
      {
        data[x][y] = noise(xoffset + x * scale, yoffset + y * scale);
      }
    }
  }

  public void moveOffset(float x, float y)
  {
    setOffset(xOffset + x, yOffset + y);
  }
  
  /**
   * Gets height of a point on the layer.
   *
   * @param x position of the location
   * @param y position of the location
   * @param multiplier of the value
   * @return the height of the point
   */
  public float getValue(int x, int y, float multiplier)
  {
    if(enableBottomCutoff && data[x][y] * multiplier > bottomCutoff)
    {
      return bottomCutoff;
    }
    if(enableTopCutoff && data[x][y] * multiplier > topCutoff)
    {
      return topCutoff;
    }
    return data[x][y] * multiplier;
  }
  
  /**
   * Draws the layer
   *
   * @param size size of the terrain in pixels
   */
  public void drawSurface(float size)
  {
    fill(tint);
    noStroke();
    for (int i = 1; i <= w - 1; i++) {
      for (int j = 1; j <= h - 1; j++) {
        beginShape();
        vertex(-size / 2.0 + i * size / w, getValue(i, j - 1, multiply) + hOffset, -size / 2.0 + (j - 1) * size / h);
        vertex(-size / 2.0 + i * size / w, getValue(i, j, multiply) + hOffset, -size / 2.0 + j * size / h);
        vertex(-size / 2.0 + (i - 1) * size / w, getValue(i - 1, j - 1, multiply) + hOffset, -size / 2.0 + (j - 1) * size / h);
        endShape();
        beginShape();
        vertex(-size / 2.0 + i * size / w, getValue(i, j, multiply) + hOffset, -size / 2.0 + j * size / h);
        vertex(-size / 2.0 + (i - 1) * size / w, getValue(i - 1, j - 1, multiply) + hOffset, -size / 2.0 + (j - 1) * size / h);
        vertex(-size / 2.0 + (i - 1) * size / w, getValue(i - 1, j, multiply) + hOffset, -size / 2.0 + j * size / h);
        endShape();
      }
    }
  }
  
  /**
   * Overrrides standard method, used for exporting configuration.
   */
  @Override public String toString()
  {
    return "---\n" + title + "\nOffset=" + xOffset + "," + yOffset + "\nMagnitude=" + multiply + "\nHeight=" + hOffset + "\nColor=" + int(red(tint)) + "," + int(green(tint)) + "," + int(blue(tint)) + "," + int(alpha(tint)) + ",";
  }

}

