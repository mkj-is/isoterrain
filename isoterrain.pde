import de.voidplus.leapmotion.*;
import java.util.List;
import java.util.ArrayList;

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
 * X map position
 */
float terrainXOffset = random(100);
/**
 * Y map position
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
 * Setup processing method. Sets up terrain layers and fullscreen window on application start.
 */
void setup() {
    leap = new LeapMotion(this);

    size(displayWidth, displayHeight, P3D);
    smooth();
    ortho();
    noFill();

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

    layers.add(terrain);
    layers.add(mountains);
    layers.add(water);
    layers.add(snow);
}   

/**
 * Draws one frame.
 */
void draw() {
    
    time += 0.01;
    water.setOffset(-terrainXOffset + time * 5, -terrainYOffset + time * 5);
  
    background(#170124);
    translate(width / 2, height / 2);
    stroke(255);
    
    rotateX(ISOMETRIC_X_ANGLE);
    rotateY(ISOMETRIC_Y_ANGLE);
    
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
    directionalLight(strength, strength, strength, 0, sin(time), cos(time));
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
    if (keyCode == 83 /* S key */) {
      saveImage();
      return;
    } else if (keyCode == UP) {
      terrainXOffset -= 0.5;
    } else if (keyCode == DOWN) {
      terrainXOffset += 0.5;
    } else if (keyCode == LEFT) {
      terrainYOffset += 0.5;
    } else if (keyCode == RIGHT) {
      terrainYOffset -= 0.5;
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
