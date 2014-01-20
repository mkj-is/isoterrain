import de.voidplus.leapmotion.*;
import java.util.List;
import java.util.ArrayList;
import java.awt.event.KeyEvent;

/**
 *
 * @file isoterrain.pda
 *
 * @author Matěj Kašpar Jirásek <matej.jirasek@gmail.com>
 * @date 2013-12-06
 *
 * @link http://mkj.is
 * @link https://is.muni.cz/predmet/fi/podzim2013/PV097?lang=en
 * @link http://dribbble.com/shots/767412-Island-Map
 *
 * Main processing file for Isoterrain project. This project was made as semestral work in PV097 course at Faculty of Informatics, Masaryk University, Brno. It was inspired by Timothy 
 */

/**
 * Angle of rotation around X axis
 */
static final float ISOMETRIC_X_ANGLE = -atan(sin(radians(45)));
/**
 * Angle of rotation around Y axis
 */
static final float ISOMETRIC_Y_ANGLE = radians(45);
/**
 * Size of the map
 */
static final float MAP_SIZE = 600.0;
/**
 * Sun strength
 */
static final float SUN_STRENGTH = 91;
/**
 * Time seed
 */
float time = random(100);
/**
 * X map offset for moving
 */
float terrainXOffset = random(100);
/**
 * Y map offset for moving
 */ 
float terrainYOffset = random(100);
/**
 * Leap motion controller API
 */
LeapMotion leap;
/**
 * Currently selected layer of terrain
 */
int selectedLayer = 0;
/**
 * Layers of the terrain
 */
List<Terrain> layers = new ArrayList<Terrain>();
/**
 * Show interface text
 */
boolean showInterface = true;
/**
 * X map position
 */
float positionX = terrainXOffset;
/**
 * Y map position
 */
float positionY = terrainYOffset;

/**
 * Setup processing method. Sets up terrain layers and fullscreen window on application start.
 */
void setup() {
    leap = new LeapMotion(this);

    size(displayWidth, displayHeight, P3D);
    smooth();
    ortho();
    noFill();
    
    PFont f = createFont("osifont", 24, true);
    textFont(f, 24);

    addDefaultLayers();
}

/**
 * Add default layers
 */
void addDefaultLayers()
{
    Terrain terrain = new Terrain(30, 30);
    terrain.title = "Hills";
    terrain.setOffset(terrainXOffset, terrainYOffset);
    terrain.enableBottomCutoff = true;
    terrain.bottomCutoff = 100.0;
    terrain.multiply = 150.0;
    
    Terrain mountains = new Terrain(30, 30);
    mountains.title = "Mountains";
    mountains.setOffset(terrainXOffset + 0.05, terrainYOffset + 0.05);
    mountains.hOffset = -150.0;
    mountains.tint = color(173,57,44);
    mountains.enableBottomCutoff = true;
    mountains.bottomCutoff = 160.0;
    mountains.multiply = 300.0;
    
    Terrain water = new Terrain(30, 30);
    water.title = "Water";
    water.tint = color(42,186,178, 180);
    water.hOffset = -25.0;
    water.multiply = 20.0;
    water.scale = 0.5;
    
    Terrain snow = new Terrain(30, 30);
    snow.title = "Snow";
    snow.setOffset(terrainXOffset + 0.1, terrainYOffset + 0.1);
    snow.hOffset = -200.0;
    snow.tint = color(220);
    snow.enableBottomCutoff = true;
    snow.bottomCutoff = 215.0;
    snow.multiply = 500.0;

    layers.add(water);
    layers.add(terrain);
    layers.add(mountains);
    layers.add(snow);
}   

/**
 * Draws one frame.
 */
void draw() {

    time += 0.01;
    layers.get(0).setOffset(-terrainXOffset + time * 5, -terrainYOffset + time * 5);
  
    background(#170124);
    translate(width / 2, height / 2);
    stroke(255);
    
    rotateX(ISOMETRIC_X_ANGLE);
    rotateY(ISOMETRIC_Y_ANGLE);
    
    drawInterface();
    
    setupLights();

    for (Terrain terrain : layers) {
        terrain.drawSurface(MAP_SIZE);
    }

    if(leap.countHands() > 0  && leap.getHands().get(0).getPalmPosition().y > 200.0)
    {
        PVector vector = leap.getHands().get(0).getStabilizedPalmPosition();
        float magnitude = vector.z / 1000.0;
        if(magnitude < 0)
            magnitude *= 5.0;
        move(magnitude);
    }
}

/**
 * Setups light based on global time.
 */
void setupLights()
{
    ambientLight(32 - cos(time) * 16, 32 - cos(time) * 16, 32 - cos(time) * 16);
    float strength = SUN_STRENGTH + SUN_STRENGTH * sin(time);
    float nightBlue = (cos(time) < 0.5 && sin(time) < 0) ? 100.0 - (0.5 - cos(time) < 0.2 ? (0.5 - cos(time)) * 500.0 : 0.0) : 0.0;
    directionalLight(strength, strength, strength + nightBlue, 0, sin(time), cos(time));
    lightFalloff(1, 0, 0);
    lightSpecular(0, 0, 0);
}

/**
 * Makes the sketch fullscreen by default.
 */
boolean sketchFullScreen() {
  return true;
}

/**
 * Maps key presses to various events. Moves the map, exports file and so on.
 */
void keyPressed() {
    if(keyCode >= 48 && keyCode <= 57)
    {
      selectedLayer = keyCode - 48;
      if(selectedLayer < 0 || selectedLayer >= layers.size())
      {
        selectedLayer = 0;
      }
    }
    
    color c;
    switch(keyCode)
    {
      // saving images
      case KeyEvent.VK_S:
        saveImage();
        return;
      // movement on the world
      case UP:
        terrainXOffset -= 0.5;
        break;
      case DOWN:
        terrainXOffset += 0.5;
        break;
      case LEFT:
        terrainYOffset += 0.5;
        break;
      case RIGHT:
        terrainYOffset -= 0.5;
        break;
      // toggle text interface
      case KeyEvent.VK_I:
        showInterface = !showInterface;
        return;
      // selected layer base height
      case KeyEvent.VK_U:
        layers.get(selectedLayer).hOffset -= 5;
        return;
      case KeyEvent.VK_D:
        layers.get(selectedLayer).hOffset += 5;
        return;
      // selected layer magnitude
      case KeyEvent.VK_M:
        layers.get(selectedLayer).multiply += 5;
        return;
      case KeyEvent.VK_L:
        layers.get(selectedLayer).multiply -= 5;
        return;
      // change color of selected layer
      case KeyEvent.VK_R:
        c = layers.get(selectedLayer).tint;
        layers.get(selectedLayer).tint =  color((red(c) + 5) < 255 ? red(c) + 5 : 0, green(c), blue(c), alpha(c));
        return;
      case KeyEvent.VK_G:
        c = layers.get(selectedLayer).tint;
        layers.get(selectedLayer).tint =  color(red(c), (green(c) + 5) < 255 ? green(c) + 5 : 0, blue(c), alpha(c));
        return;
      case KeyEvent.VK_B:
        c = layers.get(selectedLayer).tint;
        layers.get(selectedLayer).tint =  color(red(c), green(c), (blue(c) + 5) < 255 ? blue(c) + 5 : 0, alpha(c));
        return;
      case KeyEvent.VK_A:
        c = layers.get(selectedLayer).tint;
        layers.get(selectedLayer).tint =  color(red(c), green(c), blue(c), (alpha(c) + 5) < 255 ? alpha(c) + 5 : 0);
        return;
      default:
        return;
    }
    moveLayers();
}

void move(float number)
{
    terrainXOffset -= number;
    terrainYOffset += number;
    moveLayers();
}

void moveLayers()
{
    for (Terrain terrain : layers) {
        terrain.moveOffset(terrainXOffset, terrainYOffset);
    }
    positionX += terrainXOffset;
    positionY += terrainYOffset;
    terrainYOffset = 0.0;
    terrainXOffset = 0.0;
}

/**
 * Exports and saves an image
 */
public void saveImage()
{
    int i = 0;
    File filename;
    do
    {
      filename = new File("isoterrain_" + nf(i, 3) + ".png");
      i++;
    }
    while(filename.exists());
    save(filename.toString());
}

public void drawInterface()
{
    if(!showInterface)
    {
      return;
    }
  
    lights();
  
    fill(255);
    
    // terrain layers
    int i = 0;
    for (Terrain terrain : layers) {
        if(selectedLayer == i)
        {
          fill(255, 0, 0);
        }
        else
        {
          fill(255);
        }
        text(i + " - " + terrain.title, MAP_SIZE / 2.0, - 30.0 -i * 30.0, MAP_SIZE / 2.0);
        i++;
    }
    fill(255);

    // selected layer info
    Terrain layer = layers.get(selectedLayer);
    fill(255, 0, 0);
    text("Selected layer = " + layer.title, MAP_SIZE / 2.0, -150.0, 0.0);
    fill(255);
    text("Magnitude = " + int(layer.multiply), MAP_SIZE / 2.0, -120.0, 0.0);
    text("Base height = " + int(layer.hOffset), MAP_SIZE / 2.0, -90.0, 0.0);
    text("Cutoffs = [" + (layer.enableBottomCutoff ? int(layer.bottomCutoff) : "disabled") + ", " + (layer.enableTopCutoff ? int(layer.topCutoff) : "disabled") + "]", MAP_SIZE / 2.0, -60.0, 0.0);
    text("Color = [" + int(red(layer.tint)) + ", " + int(green(layer.tint)) + ", " + int(blue(layer.tint)) + ", " + int(alpha(layer.tint)) + "]", MAP_SIZE / 2.0, -30.0, 0.0);
    
    // time and position
    int hours = (6 + int(time / (PI * 2) * 24)) % 24;
    int minutes = int(((time / (PI * 2.0) * 24.0) - floor(time / (PI * 2) * 24)) / 0.0166667);
    text("Time = " + hours + ":" + minutes, MAP_SIZE / 2.0, -60.0, - MAP_SIZE / 2.0);
    text("Position = [" + int(positionX * 2.0) + ", " + int(positionY * 2.0) + "]", MAP_SIZE / 2.0, -30.0, - MAP_SIZE / 2.0);
    
    noLights();
}
