byte in[6];
byte currentValue = 0;

void setup() {

  Serial.begin(115200);
  while (Serial.available() <= 0) {
    Serial.println();   // send an initial string
    delay(300);
  }
}

void loop() {
  if (Serial.available() > 0) {
    digitalWrite(13, HIGH);
    in[currentValue] = Serial.read();
    currentValue++;
    if (currentValue > 2) {
      currentValue = 0;
      analogWrite(9, in[0]);
      analogWrite(10, in[1]);
      analogWrite(11, in[2]);
      Serial.write('A');
    }
  }
}
