import de.voidplus.leapmotion.*;

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
static final float MAP_SIZE = 800.0;
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
 Green hilly terrain layer
 */
Terrain terrain;
/**
 * Moving water layer
 */
Terrain water;
/**
 * Brown mountain layer
 */
Terrain mountains;
/**
 * Snowy mountain layer
 */
Terrain snow;
/**
 * Leap motion controller API
 */
LeapMotion leap;

/**
 * Setup processing method. Sets up terrain layers and fullscreen window on application start.
 */
void setup() {
    leap = new LeapMotion(this);

    size(displayWidth, displayHeight, P3D);
    smooth();
    ortho();
    noFill();
    
    terrain = new Terrain(30, 30);
    terrain.initWithPerlin(terrainXOffset, terrainYOffset,  0.3);
    terrain.enableBottomCutoff = true;
    terrain.bottomCutoff = 100.0;
    mountains = new Terrain(30, 30);
    mountains.initWithPerlin(terrainXOffset + 0.05, terrainYOffset + 0.05, 0.3);
    mountains.yOffset = -150.0;
    mountains.tint = color(173,57,44);
    mountains.enableBottomCutoff = true;
    mountains.bottomCutoff = 160.0;
    water = new Terrain(30, 30);
    water.tint = color(42,186,178, 180);
    water.yOffset = -25.0;
    snow = new Terrain(30, 30);
    snow.initWithPerlin(terrainXOffset + 0.1, terrainYOffset + 0.1, 0.3);
    snow.yOffset = -200.0;
    snow.tint = color(220);
    snow.enableBottomCutoff = true;
    snow.bottomCutoff = 215.0;
    
}

/**
 * Draws one frame.
 */
void draw() {
    time += 0.01;
  
    water.initWithPerlin(-terrainXOffset + time * 5, -terrainYOffset + time * 5,  0.5);
  
    background(#170124);
    translate(width / 2, height / 2);
    stroke(255);
    
    rotateX(ISOMETRIC_X_ANGLE);
    rotateY(ISOMETRIC_Y_ANGLE);
    
    setupLights();

    mountains.drawSurface(MAP_SIZE, 300);
    snow.drawSurface(MAP_SIZE, 500);
    terrain.drawSurface(MAP_SIZE, 150);
    water.drawSurface(MAP_SIZE, 20);

    if(leap.countHands() > 0  && leap.getHands().get(0).getPalmPosition().y > 200.0)
    {
        PVector vector = leap.getHands().get(0).getStabilizedPalmPosition();
        float magnitude = vector.z / 1000.0;
        if(magnitude < 0)
            magnitude *= 5.0;
        moveUp(magnitude);
        System.out.println(vector.z);
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
    regenerateTerrains();
}

void moveUp(float number)
{
    terrainXOffset -= number;
    terrainYOffset += number;
    regenerateTerrains();
}

void regenerateTerrains()
{
    terrain.initWithPerlin(terrainXOffset, terrainYOffset, 0.3);
    mountains.initWithPerlin(terrainXOffset + 0.05, terrainYOffset + 0.05, 0.3);
    snow.initWithPerlin(terrainXOffset + 0.1, terrainYOffset + 0.1, 0.3);
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
