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
float isoThetaX = -atan(sin(radians(45)));
/**
 * Angle of rotation around Y axis
 */
float isoThetaY = radians(45);
/**
 * Size of the map
 */
float size = 600.0;
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
 * Setup processing method. Sets up terrain layers and fullscreen window on application start.
 */
void setup() {
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
    
    rotateX(isoThetaX);
    rotateY(isoThetaY);
    
    setupLights();

    float h = 100;

    mountains.drawSurface(size, 300);
    snow.drawSurface(size, 500);
    terrain.drawSurface(size, 150);
    water.drawSurface(size, 20);
}

/**
 * Setups light based on global time.
 */
void setupLights()
{
    ambientLight(32 - cos(time) * 16, 32 - cos(time) * 16, 32 - cos(time) * 16);
    directionalLight(182, 182, 182, 0, sin(time), cos(time));
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
    if (keyCode == UP) {
      terrainXOffset -= 0.5;
    } else if (keyCode == DOWN) {
      terrainXOffset += 0.5;
    } else if (keyCode == LEFT) {
      terrainYOffset += 0.5;
    } else if (keyCode == RIGHT) {
      terrainYOffset -= 0.5;
    }
    terrain.initWithPerlin(terrainXOffset, terrainYOffset, 0.3);
    mountains.initWithPerlin(terrainXOffset + 0.05, terrainYOffset + 0.05, 0.3);
    snow.initWithPerlin(terrainXOffset + 0.1, terrainYOffset + 0.1, 0.3);
}
