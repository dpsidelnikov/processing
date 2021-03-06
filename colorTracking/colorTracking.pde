// Tutorial by Daniel Shiffman
// https://youtu.be/nCVZHROb_dE

// import video library
import processing.video.*;

// Call Capture objects as video
Capture video;

// Set global variables
color trackColor;
float threshold = 25;

void setup(){
        // Create a canvas
        size(640, 360);
        // Identiy cameras
        String[] cameras = Capture.list();
        printArray(cameras);
        // Initialise and start video capture
        video = new Capture(this, width,height);
        video.start();
        // Asign trackColor value
        trackColor = color(255, 0, 0);
}

// Capture images when they exist
void captureEvent(Capture video) {
        video.read();
}

void draw(){
        // Load pixels array
        video.loadPixels();
        // Show video
        image(video,0,0);

        // Set some local variables
        threshold = 25;
        float avgX = 0;
        float avgY = 0;
        int count = 0;


        // Loop thought every pixel
        for (int x = 0; x < video.width; x++) {
                for (int y = 0; y < video.height; y++) {
                        // Identify by it's coordinates
                        int loc = x + y * video.width;
                        // Get current color
                        color currentColor = video.pixels[loc];
                        float r1 = red(currentColor);
                        float g1 = green(currentColor);
                        float b1 = blue(currentColor);
                        float r2 = red(trackColor);
                        float g2 = green(trackColor);
                        float b2 = blue(trackColor);

                        // Compare pixel color
                        float d = distSq(r1, g1, b1, r2, g2, b2);
                        // If it's different
                        if (d < threshold*threshold) {
                                stroke(255);
                                strokeWeight(1);
                                point(x, y);
                                avgX += x;
                                avgY += y;
                                count++;
                        }
                }
        }
        // Get the average pixel position
        if (count > 0) {
                avgX = avgX / count;
                avgY = avgY / count;
                // Draw an ellipse
                fill(trackColor);
                strokeWeight(4.0);
                stroke(0);
                ellipse(avgX, avgY, 24, 24);
        }
}

// Distance square function is faster than dist()
float distSq(float x1, float y1, float z1, float x2, float y2, float z2) {
        float d = (x2-x1)*(x2-x1) + (y2-y1)*(y2-y1) +(z2-z1)*(z2-z1);
        return d;
}

void mousePressed() {
        // Choose certain pixel color to track
        int loc = mouseX + mouseY*video.width;
        trackColor = video.pixels[loc];
}
