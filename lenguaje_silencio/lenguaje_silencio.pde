import cassette.audiofiles.SoundFile;
import ketai.sensors.*;
import ketai.ui.*;


KetaiSensor sensor;
KetaiVibrate vibe;
SoundFile audio, vibracion, notificacion;
String estado;

float accelerometerX, accelerometerY, accelerometerZ;

void setup() {
  sensor = new KetaiSensor(this);
  vibe = new KetaiVibrate(this);
  sensor.start();
  orientation(LANDSCAPE);
  textAlign(CENTER, CENTER);
  textSize(36);
  audio = new SoundFile(this, "audio1.mp3");
  vibracion = new SoundFile(this, "vibracion.mp3");
  notificacion = new SoundFile(this, "iphone.mp3");
}

void draw() {

  background(78, 93, 75);
  text("Accelerometer: \n" +
    "estado = " + estado + "\n" +
    "x: " + nfp(accelerometerX, 1, 3) + "\n" +
    "y: " + nfp(accelerometerY, 1, 3) + "\n" +
    "z: " + nfp(accelerometerZ, 1, 3), 0, 0, width, height);

  if (estado == "mesa") {
    vibe.vibrate(1000);
    vibracion.play();
  }
  if (estado == "mano") {
    //vibe.vibrate(1000);
    notificacion.play();
  }
  if (estado == "atril") {
    //audio.play();
  }

  if (accelerometerY >= 0 && accelerometerY <= 1 ) {
    estado = "mesa";
  }
  if (accelerometerY > 8 && accelerometerY < 10 ) {
    estado = "atril";
  }
  if (accelerometerY > 1 && accelerometerY <= 8 || accelerometerY >= 10) {
    estado = "mano";
  }
}

void onAccelerometerEvent(float x, float y, float z) {
  accelerometerX = round(x);
  accelerometerY = round(y);
  accelerometerZ = round(z);
}
