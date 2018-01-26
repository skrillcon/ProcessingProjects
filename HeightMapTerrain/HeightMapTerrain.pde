String filename = "Heightmap.png";
PImage heightmapImg;

color[] terrain;
int imgWidth;
int imgHeight;

float groundScale = 10;

void setup(){
  size(1280, 720, P3D);
  heightmapImg = loadImage(filename);
  imgWidth = heightmapImg.width;
  imgHeight = heightmapImg.height;
  //heightmapImg.filter(GRAY);
  //image(heightmapImg, 0, 0);
  //terrain = new color[heightmapImg.width * heightmapImg.height];
  terrain = heightmapImg.pixels;
}

void draw(){
  float[] terrainGray = rgbToGrayscale(terrain);
  //for(int i = 0; i < terrainGray.length; i++){
  //  println(terrain[i]);
  //}
  
  //println(imgWidth * imgHeight);
  
  background(0);
  stroke(255);
  noFill();

  translate(width/2, height/2+50);
  rotateX(PI/3);
  translate(-width/2, -height/2);
  for (int y = 1; y < imgWidth-1; y++) {
    beginShape(TRIANGLE_STRIP);
    for (int x = 0; x < imgHeight; x++) {
      vertex(x * groundScale, y * groundScale, terrainGray[x + y * imgWidth]);
      vertex(x * groundScale, (y+1) * groundScale, terrainGray[x + (y+1) * imgWidth]);
    }
    endShape();
  }
}

float[] rgbToGrayscale(color[] terrain){
  float[] grayscaleValues = new float[terrain.length];
  for(int i = 0; i < terrain.length; i++){
    // Assuming weighted method for GrayScale
    grayscaleValues[i] = (red(terrain[i]) * .3 + green(terrain[i]) * .59 + blue(terrain[i]) * .11);
  }
  
  return grayscaleValues;
}



// Heightmaps will be gray values only so only 256 diff heights