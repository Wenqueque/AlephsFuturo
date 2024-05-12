import processing.serial.*;
PImage imgPresente;
PImage imgFuturo;
Serial puerto; // Objeto Serial para la comunicación con Arduino
String estado = ""; // Variable para almacenar el estado recibido de Arduino

void setup() {
  size(1152, 648);
  imgPresente = loadImage("presente.png"); // Carga la imagen para el estado "presente"
  imgFuturo = loadImage("futuro.png"); // Carga la imagen para el estado "futuro"
  puerto = new Serial(this, "COM8", 9600); // Inicializa la comunicación serial con Arduino
}

void draw() {
  if (puerto.available() > 0) { // Si hay datos disponibles en el puerto serial
    estado = puerto.readStringUntil('\n'); // Lee el estado enviado por Arduino hasta encontrar un salto de línea
    if (estado != null) { // Si se ha recibido un estado válido
      println("Estado recibido: " + estado); // Muestra el estado recibido en la consola de Processing
      mostrarImagen();
    }
  }
}

void mostrarImagen() {
  background(255); // Limpia la pantalla
  if (estado.trim().equals("futuro")) { // Si el estado es "futuro"
    image(imgFuturo, 0, 0, width, height); // Muestra la imagen "futuro.png" en pantalla
  } else if (estado.trim().equals("presente")) { // Si el estado es "presente"
    image(imgPresente, 0, 0, width, height); // Muestra la imagen "presente.png" en pantalla
  }
}
