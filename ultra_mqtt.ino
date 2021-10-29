/*
 * ESP8266 (Adafruit HUZZAH) Mosquitto MQTT Subscribe Example
 * Thomas Varnish (https://github.com/tvarnish), (https://www.instructables.com/member/Tango172)
 * Made as part of my MQTT Instructable - "How to use MQTT with the Raspberry Pi and ESP8266"
 */
#include <ESP8266WiFi.h> // Enables the ESP8266 to connect to the local network (via WiFi)
#include <PubSubClient.h> // Allows us to connect to, and publish to the MQTT broker
// defines pins numbers

const int trigPin = 4;  //D2
const int echoPin = 5;  //D1
const int ledPin = 0; // This code uses the built-in led for visual feedback that a message has been received

// defines variables
long duration;
int distance;

// WiFi
// Make sure to update this for your own WiFi network!
const char* ssid = "realme xt";
const char* wifi_password = "12345678";

// MQTT
// Make sure to update this for your own MQTT Broker!
const char* mqtt_server = "192.168.43.122";
const char* topic = "dustbin/";
int id=5;
char* mqtt_topic;

const char* mqtt_username = "";
const char* mqtt_password = "";
// The client id identifies the ESP8266 device. Think of it a bit like a hostname (Or just a name, like Greg).
const char* clientID = "ESP8266_1";

// Initialise the WiFi and MQTT Client objects
WiFiClient wifiClient;
PubSubClient client(mqtt_server, 1883, wifiClient); // 1883 is the listener port for the Broker

void ReceivedMessage(char* topic, byte* payload, unsigned int length) {
  // Output the first character of the message to serial (debug)
  Serial.println((char*)payload);

  // Handle the message we received
  // Here, we are only looking at the first character of the received message (payload[0])
  // If it is 0, turn the led off.
  // If it is 1, turn the led on.
  if ((char)payload[0] == '0') {
    digitalWrite(ledPin, HIGH); // Notice for the HUZZAH Pin 0, HIGH is OFF and LOW is ON. Normally it is the other way around.
  }
  if ((char)payload[0] == '1') {
    digitalWrite(ledPin, LOW);
  }
}

bool Connect() {
  // Connect to MQTT Server and subscribe to the topic
  
  Serial.println(" connection data ");
  if (client.connect(clientID, mqtt_username, mqtt_password)) {
      client.publish(mqtt_topic,"ESP-Bin Connected ");
      return true;
    }
    else {
      return false;
  }
}

void setup() {
  pinMode(ledPin, OUTPUT);
  pinMode(trigPin, OUTPUT); // Sets the trigPin as an Output
  pinMode(echoPin, INPUT); // Sets the echoPin as an Input
  // Switch the on-board LED off to start with
  digitalWrite(ledPin, HIGH);
  String c=topic+String(id);
  mqtt_topic=&c[0];
  // Begin Serial on 115200
  // Remember to choose the correct Baudrate on the Serial monitor!
  // This is just for debugging purposes
  Serial.begin(115200);

  Serial.print("Connecting to ");
  Serial.println(ssid);

  // Connect to the WiFi
  WiFi.begin(ssid, wifi_password);

  // Wait until the connection has been confirmed before continuing
  while (WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.print(".");
  }

  // Debugging - Output the IP Address of the ESP8266
  Serial.println("WiFi connected");
  Serial.print("IP address: ");
  Serial.println(WiFi.localIP());

  // Connect to MQTT Broker
  // setCallback sets the function to be called when a message is received.
  client.setCallback(ReceivedMessage);
  if (Connect()) {
    Serial.println("Connected Successfully to MQTT Broker!");  
  }
  else {
    Serial.println("Connection Failed!");
  }
}

void loop() {
  // Clears the trigPin
digitalWrite(trigPin, LOW);
delayMicroseconds(2);
//id++;
//d=id%20;
String c=topic+String(id);
  mqtt_topic=&c[0];
// Sets the trigPin on HIGH state for 10 micro seconds
digitalWrite(trigPin, HIGH);
delayMicroseconds(10);
digitalWrite(trigPin, LOW);

// Reads the echoPin, returns the sound wave travel time in microseconds
duration = pulseIn(echoPin, HIGH);

// Calculating the distance
distance= duration*0.034/2;
// Prints the distance on the Serial Monitor
if(distance<15 && distance>5){
Serial.println("90% full");}
if(distance<5){
  Serial.println("100% full");
}
Serial.println(distance);

  if(distance<0|| distance>100){
    return;
  }
  
  // If the connection is lost, try to connect again
  if (!client.connected()) {
    Connect();
  }
  //distance=(distance*id)%100;
  String message="{\"site\":\"room1\",\"fill_percentage\": "+String(100-distance+5)+" }";
  char* ch=&message[0];
  client.publish(mqtt_topic,ch);
  //"dustbin1,site=room1 fill%="+String(100-distance)
  //"{\"id\":21,\"site\":\"room1\",\"fill_percentage\": "+String(100-distance+5)+" }"
  // client.loop() just tells the MQTT client code to do what it needs to do itself (i.e. check for messages, etc.)
  client.loop();
  // Once it has done all it needs to do for this cycle, go back to checking if we are still connected.
  delay(5000);
}
