
float isoThetaX = -atan(sin(radians(45)));
float isoThetaY = radians(45);

float size = 600.0;

float time = random(100);

float terrainXOffset = random(100);
float terrainYOffset = random(100);
float waterOffset = 0.0;

Terrain terrain;
Terrain water;
Terrain mountains;
Terrain snow;

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

void draw() {
    time += 0.005;
  
    water.initWithPerlin(-terrainXOffset + waterOffset, -terrainYOffset + waterOffset,  0.5);
  
    background(#170124);
    translate(width / 2, height / 2);
    stroke(255);
    
    rotateX(isoThetaX);
    rotateY(isoThetaY);
    
    // lights
    ambientLight(32 - cos(time) * 16, 32 - cos(time) * 16, 32 - cos(time) * 16);
    directionalLight(182, 182, 182, 0, sin(time), cos(time));
    lightFalloff(1, 0, 0);
    lightSpecular(0, 0, 0);
    
    // axises
    /*stroke(255, 0, 0);
    line(0, 0, 0, 100, 0, 0);
    stroke(0, 255, 0);
    line(0, 0, 0, 0, 100, 0);
    stroke(0, 0, 255);
    line(0, 0, 0, 0, 0, 100);*/

    float h = 100;

    mountains.drawSurface(size, 300);
    snow.drawSurface(size, 500);
    terrain.drawSurface(size, 150);
    water.drawSurface(size, 20);
    
    waterOffset += 0.05;
}

boolean sketchFullScreen() {
  return true;
}

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
