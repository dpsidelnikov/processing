// Tutorial by Daniel Shiffman
// https://youtu.be/QLHMtE5XsMs

// import video library
import processing.video.*;

// Call Capture objects as video
Capture video;
PImage prev;

// Set global variables
float threshold = 25;

float motionX = 0;
float motionY = 0;

float lerpX = 0;
float lerpY = 0;

void setup(){
        // Create a canvas
        size(640, 480);
        // pixelDensity(2);
        // Identiy cameras
        String[] cameras = Capture.list();
        printArray(cameras);
        // Initialise and start video capture
        video = new Capture(this, width,height);
        video.start();
        prev = createImage(width,height,RGB);
}

// Capture images when they exist
void captureEvent(Capture video) {
        prev.copy(video,0,0,video.width,video.height,0,0,prev.width,prev.height);
        prev.updatePixels();
        video.read();
}

void draw(){
        // Load pixels array
        video.loadPixels();
        prev.loadPixels();
        // Show video
        image(video,0,0);

        // Set some local variables
        threshold = 25;
        float avgX = 0;
        float avgY = 0;
        int count = 0;

        // Loop thought every pixel
        loadPixels();
        for (int x = 0; x < video.width; x++) {
                for (int y = 0; y < video.height; y++) {
                        // Identify by it's coordinates
                        int loc = x + y * video.width;
                        // Get current color
                        color currentColor = video.pixels[loc];
                        float r1 = red(currentColor);
                        float g1 = green(currentColor);
                        float b1 = blue(currentColor);
                        //Get previous color
                        color prevColor = prev.pixels[loc];
                        float r2 = red(prevColor);
                        float g2 = green(prevColor);
                        float b2 = blue(prevColor);

                        // Compare pixel color
                        float d = distSq(r1, g1, b1, r2, g2, b2);
                        // If it's different enough store in avg
                        if (d > threshold*threshold) {
                                avgX += x;
                                avgY += y;
                                count++;
                                // pixels[loc] = color(255);
                        } else {
                                // pixels[loc] = color(0);
                        }

                }
        }
        // updatePixels();
        // Get the average pixel position
        if (count > 200) {
                motionX = avgX / count;
                motionY = avgY / count;
        }
        // Do a linear interpolation to smooth the movement
        lerpX = lerp(lerpX,motionX,0.1);
        lerpY = lerp(lerpY,motionY,0.1);
        // Draw an ellipse
        fill(255,0,255);
        strokeWeight(4.0);
        stroke(0);
        ellipse(lerpX, lerpY, 24, 24);

        // image(video,0,0,100,100);
        // image(prev,100,100,100,0);
}

// Distance square function is faster than dist()
float distSq(float x1, float y1, float z1, float x2, float y2, float z2) {
        float d = (x2-x1)*(x2-x1) + (y2-y1)*(y2-y1) +(z2-z1)*(z2-z1);
        return d;
}

void mousePressed() {

}
