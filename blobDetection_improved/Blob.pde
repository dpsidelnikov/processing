class Blob {

// Declare variables
float minx;
float miny;
float maxx;
float maxy;

int id = 0;

int lifespan = 255;

boolean taken = false;

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
boolean checkLife(){
        lifespan--;
        if (lifespan < 0) {
                return true;
        } else {
                return false;
        }
}
// This function draw the rectangles
void show() {
        stroke(0);
        fill(255, lifespan);
        strokeWeight(2);
        rectMode(CORNERS);
        rect(minx, miny, maxx, maxy);
        textAlign(CENTER);
        textSize(64);
        fill(0);
        text(id, minx + (maxx - minx) * 0.5, maxy - 10);
        // textSize(32);
        // text(lifespan, minx + (maxx - minx) * 0.5, miny - 10);

        //Stroke every point included in PVector
        // for (PVector v : points) {
        //         stroke (255,0,255);
        //         point(v.x,v.y);
        // }
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

void become(Blob other){
        minx = other.minx;
        miny = other.miny;
        maxx = other.maxx;
        maxy = other.maxy;

}

// Gets blobs size
float size() {
        return (maxx-minx)*(maxy-miny);
}

PVector getCenter(){
        float x = (maxx-minx)*0.5 + minx;
        float y = (maxy-miny)*0.5 + miny;
        return new PVector(x,y);
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
