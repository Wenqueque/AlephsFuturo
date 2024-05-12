
import processing.video.*;
import processing.sound.*;
import processing.serial.*;
import spout.*;

Spout spout;
String estado = "presente"; // Estado inicial
Serial puertoSerial; // Objeto para la comunicación serial
Movie video; // Variable para almacenar el video
boolean videoCargado = false; // Variable para controlar si el video ha sido cargado
PImage imagenFuturo; // Variable para almacenar la imagen "futuro.jpg"
boolean reproduccionTerminada = false; // Variable para controlar si la reproducción del video ha terminado
SoundFile sonido; // Variable para almacenar el sonido
boolean reproduciendoAudio = false; // Variable para controlar si el sonido está reproduciéndose

void setup() {
  size(800, 600,P3D);
  spout = new Spout(this);
  spout.createSender("TPlenguaje");
  imagenFuturo = loadImage("futuro.png"); // Cargar la imagen "futuro.jpg"
  sonido = new SoundFile(this, "futuro.wav"); // Cargar el archivo de sonido
  
  // Configurar la comunicación serial
  puertoSerial = new Serial(this,"COM8", 9600);
}

void draw() {
  // Leer el estado del puerto serial
  while (puertoSerial.available() > 0) {
    int estadoSerial = puertoSerial.read(); // Leer el estado del puerto serial
    
    // Actualizar el estado según el estado recibido por el puerto serial
    if (estadoSerial == '1') {
      estado = "futuro";
    } else if (estadoSerial == '0') {
      estado = "presente";
    }
  }
  
  // Cambiar el fondo a blanco cuando el estado es "presente"
  if (estado.equals("presente")) {
    background(255);
  }
  
  // Mostrar la imagen si el estado es "presente"
  if (estado.equals("presente")) {
    image(loadImage("presente.png"), 0, 0, width, height);
    // Detener el video si estaba reproduciéndose
    if (video != null && videoCargado) {
      video.stop();
      videoCargado = false;
      reproduccionTerminada = false; // Reiniciar la variable de control de reproducción terminada
    }
    // Detener el sonido si estaba reproduciéndose
    if (reproduciendoAudio) {
      sonido.stop();
      reproduciendoAudio = false;
    }
  } 
  // Mostrar el video si el estado es "futuro" y la reproducción no ha terminado
  else if (estado.equals("futuro") && !reproduccionTerminada) {
    // Cargar el video si no ha sido cargado
    if (!videoCargado) {
      video = new Movie(this, "transicionP-F.mp4"); // Cargar el video
      video.play(); // Reproducir el video
      videoCargado = true; // Marcar el video como cargado
      reproduciendoAudio = true; // Marcar el sonido como reproduciéndose
    }
    // Mostrar el fotograma actual del video
    if (video.available()) {
      video.read();
      image(video, 0, 0, width, height);
    }
    // Verificar si la reproducción del video ha terminado
    if (video.time() == video.duration()) {
      video.stop(); // Detener el video
      reproduccionTerminada = true; // Marcar la reproducción como terminada
      if (!sonido.isPlaying()) {
        sonido.loop(); // Reproducir el sonido en loop si no estaba reproduciéndose
      }
    }
  }
  
  // Mostrar la imagen "futuro.png" si la reproducción del video ha terminado
  if (estado.equals("futuro") && reproduccionTerminada) {
    image(imagenFuturo, 0, 0, width, height);
  }
  spout.sendTexture();
}
