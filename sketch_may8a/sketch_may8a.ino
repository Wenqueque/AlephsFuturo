const int botonPin = 2; // Pin donde está conectado el botón
int estadoBoton; // Variable para almacenar el estado del botón

void setup() {
  Serial.begin(9600); // Inicializa la comunicación serial
  pinMode(botonPin, INPUT_PULLUP); // Configura el pin del botón como entrada con pull-up interno
}

void loop() {
  estadoBoton = digitalRead(botonPin); // Lee el estado del botón

  // Si el botón está presionado, envía '1', de lo contrario, envía '0'
  if (estadoBoton == LOW) {
    Serial.println('1');
  } else {
    Serial.println('0');
  }

  delay(100); // Espera 100 milisegundos para evitar rebotes del botón
}
