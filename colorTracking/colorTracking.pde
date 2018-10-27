import processing.video.*;

//Calling Capture objects as video
Capture video;

void setup(){
        //Creating a canvas
        size(640, 360);
        //Identifiying cameras
        String[] cameras = Capture.list();
        printArray(cameras);
        //Initialising and starting video capture
        video = new Capture(this, cameras[3]);
        video.start();
}

//Let's capture images when they exist
void captureEvent(Capture video) {
        video.read();
}
void draw(){
        image(video,0,0);
}
