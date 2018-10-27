import processing.video.*;

// Calling Capture objects as video
Capture video;



// Color to look for
color trackColor;
float threshold = 25;

void setup(){
        // Creating a canvas
        size(640, 360);
        // Identifiying cameras
        String[] cameras = Capture.list();
        printArray(cameras);
        // Initialising and starting video capture
        video = new Capture(this, cameras[3]);
        video.start();
        trackColor = color(255, 0, 0);
}

// Let's capture images when they exist
void captureEvent(Capture video) {
        video.read();
}

void draw(){
        // Loading the pixels array
        video.loadPixels();
        image(video,0,0);
        threshold = 25;

        float avgX = 0;
        float avgY = 0;

        int count = 0;
        // Looping thought every pixel
        for (int x = 0; x < video.width; x++) {
                for (int y = 0; y < video.height; y++) {
                        // Identifiying pixel in a 2D plane
                        int loc = x + y * video.width;
                        // What is current color
                        color currentColor = video.pixels[loc];
                        float r1 = red(currentColor);
                        float g1 = green(currentColor);
                        float b1 = blue(currentColor);
                        float r2 = red(trackColor);
                        float g2 = green(trackColor);
                        float b2 = blue(trackColor);
                        // Comparing colors
                        float d = distSq(r1, g1, b1, r2, g2, b2);
                        // Saving the most similar color
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
        // Only draw if it's similar enough
        if (count > 0) {
                avgX = avgX / count;
                avgY = avgY / count;
                // Draw a circle at the tracked pixel
                fill(trackColor);
                strokeWeight(4.0);
                stroke(0);
                ellipse(avgX, avgY, 24, 24);
        }
}

float distSq(float x1, float y1, float z1, float x2, float y2, float z2) {
        float d = (x2-x1)*(x2-x1) + (y2-y1)*(y2-y1) +(z2-z1)*(z2-z1);
        return d;
}

void mousePressed() {
        // Drawing a circle in certain pixel
        int loc = mouseX + mouseY*video.width;
        trackColor = video.pixels[loc];
}
