class Blob {

// Declare variables
float minx;
float miny;
float maxx;
float maxy;

// PVector stores x,y data
ArrayList<PVector> points;

// This is the Blob constructor
Blob(float x, float y) {
        minx = x;
        miny = y;
        maxx = x;
        maxy = y;
        // Create a new PVector object
        points = new ArrayList<PVector>();
        // Don't lead PVector empty
        points.add(new PVector(x,y));
}

// This function draw the rectangles
void show() {
        stroke(0);
        fill(255);
        strokeWeight(2);
        rectMode(CORNERS);
        rect(minx, miny, maxx, maxy);

        //Stroke every point included in PVector
        for (PVector v : points) {
                stroke (255,0,255);
                point(v.x,v.y);
        }
}

// This functions describes blobs's corners
void add(float x, float y) {
        // Add points to PVector
        points.add(new PVector(x,y));
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

        // float cx = max(min(x, maxx), minx);
        // float cy = max(min(y, maxy), miny);

        // float cx = (minx + maxx) / 2;
        // float cy = (miny + maxy) / 2;

        // float d = distSq(cx, cy, x, y);

        // d is the minimum distance to check
        float d =  10000000;
        // Check for every PVector point whether is at distants and store it
        for (PVector v : points) {
                float tempD = distSq(x,y,v.x,v.y);
                if (tempD < d) {
                        d = tempD;
                }
        }

        if (d < distThreshold*distThreshold) {
                return true;
        } else {
                return false;
        }
}
}
