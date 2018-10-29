// Tutorial by Daniel Shiffman
// https://youtu.be/ce-2l2wRqO8

// import video library
import processing.video.*;

// Call Capture objects as video
Capture video;

// Set global variables
color trackColor;
float threshold = 25;
float distThreshold = 25;

// Create an ArrayList for Blobs
ArrayList<Blob> blobs = new ArrayList<Blob>();

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

void keyPressed(){
        if (key == 'a') {
                distThreshold++;
        } else if (key == 'z') {
                distThreshold--;
        }
        println(distThreshold);
}

void draw(){
        // Load pixels array
        video.loadPixels();
        // Show video
        image(video,0,0);

        blobs.clear();

        // Set some local variables
        threshold = 80;

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
                        // If it's different enough store in avg
                        if (d < threshold*threshold) {

                                boolean found = false;
                                for (Blob b : blobs) {
                                        if (b.isNear(x, y)) {
                                                b.add(x, y);
                                                found = true;
                                                break;
                                        }
                                }
                                if (!found) {
                                        Blob b = new Blob(x, y);
                                        blobs.add(b);
                                }
                        }
                }
        }
        for (Blob b : blobs) {
                if (b.size() > 500) {
                        b.show();
                }
        }
}


// Distance square function is faster than dist()
float distSq(float x1, float y1, float z1, float x2, float y2, float z2) {
        float d = (x2-x1)*(x2-x1) + (y2-y1)*(y2-y1) +(z2-z1)*(z2-z1);
        return d;
}
float distSq(float x1, float y1, float x2, float y2) {
        float d = (x2-x1)*(x2-x1) + (y2-y1)*(y2-y1);
        return d;
}

void mousePressed() {
        // Choose certain pixel color to track
        int loc = mouseX + mouseY*video.width;
        trackColor = video.pixels[loc];
}
