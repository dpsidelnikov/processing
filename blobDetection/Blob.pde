class Blob {

// Declare variables
float minx;
float miny;
float maxx;
float maxy;

// This is the Blob constructor
Blob(float x, float y) {
        minx = x;
        miny = y;
        maxx = x;
        maxy = y;
}

// This function draw the rectangles
void show() {
        stroke(0);
        fill(255);
        strokeWeight(2);
        rectMode(CORNERS);
        rect(minx, miny, maxx, maxy);
}

// This functions describes blobs's corners
void add(float x, float y) {
        minx = min(minx, x);
        miny = min(miny, y);
        maxx = max(maxx, x);
        maxy = max(maxy, y);
}

// Gets blobs size
float size() {
        return (maxx-minx)*(maxy-miny);
}

// Check if a pixel is close enought to count as a part of a blob
boolean isNear(float x, float y) {
        float cx = (minx + maxx) / 2;
        float cy = (miny + maxy) / 2;

        float d = distSq(cx, cy, x, y);
        if (d < distThreshold*distThreshold) {
                return true;
        } else {
                return false;
        }
}
}
