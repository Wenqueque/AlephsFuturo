package processing.test.sketch_171026a;

/* autogenerated by Processing revision 1293 on 2024-05-02 */
import processing.core.*;
import processing.data.*;
import processing.event.*;
import processing.opengl.*;

import ketai.sensors.*;
import ketai.ui.*;

import java.util.HashMap;
import java.util.ArrayList;
import java.io.File;
import java.io.BufferedReader;
import java.io.PrintWriter;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.IOException;

public class sketch_171026a extends PApplet {




KetaiSensor sensor;
KetaiVibrate vibe;
float accelerometerX, accelerometerY, accelerometerZ;

public void setup() {
  sensor = new KetaiSensor(this);
  vibe = new KetaiVibrate(this);
  sensor.start();
  orientation(LANDSCAPE);
  textAlign(CENTER, CENTER);
  textSize(36);
}

public void draw() {
  background(78, 93, 75);
  text("Accelerometer: \n" + 
    "x: " + nfp(accelerometerX, 1, 3) + "\n" +
    "y: " + nfp(accelerometerY, 1, 3) + "\n" +
    "z: " + nfp(accelerometerZ, 1, 3), 0, 0, width, height);
    if(accelerometerY > 2){
      vibe.vibrate(1000);
  }
    
  }

public void onAccelerometerEvent(float x, float y, float z) {
  accelerometerX = x;
  accelerometerY = y;
  accelerometerZ = z;
}


  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "sketch_171026a" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
