#include <Bounce2.h>

// INSTANTIATE A Button OBJECT
Bounce2::Button button = Bounce2::Button();
Bounce2::Button button2 = Bounce2::Button();

// WE WILL attach() THE BUTTON TO THE FOLLOWING PIN IN setup()
#define BUTTON_PIN 10
#define BUTTON_PIN2 11

// DEFINE THE PIN FOR THE LED :
// 1) SOME BOARDS HAVE A DEFAULT LED (LED_BUILTIN)
//#define LED_PIN LED_BUILTIN
// 2) OTHERWISE SET YOUR OWN PIN
#define LED_PIN 2
#define LED_PIN2 3

// SET A VARIABLE TO STORE THE LED STATE
bool ledState = HIGH;
bool ledState2 = HIGH;

void setup() {

  // BUTTON SETUP 
  
  // SELECT ONE OF THE FOLLOWING :
  // 1) IF YOUR BUTTON HAS AN INTERNAL PULL-UP
  // button.attach( BUTTON_PIN ,  INPUT_PULLUP ); // USE INTERNAL PULL-UP
  // 2) IF YOUR BUTTON USES AN EXTERNAL PULL-UP
  button.attach( BUTTON_PIN, INPUT ); // USE EXTERNAL PULL-UP
  button2.attach( BUTTON_PIN2, INPUT);

  // DEBOUNCE INTERVAL IN MILLISECONDS
  button.interval(5); 
  button2.interval(5);

  // INDICATE THAT THE LOW STATE CORRESPONDS TO PHYSICALLY PRESSING THE BUTTON
  button.setPressedState(HIGH); 
  button2.setPressedState(HIGH);
  // LED SETUP
  pinMode(LED_PIN,OUTPUT);
  digitalWrite(LED_PIN,ledState);

  pinMode(LED_PIN2,OUTPUT);
  digitalWrite(LED_PIN2,ledState2);

}

void loop() {
  // UPDATE THE BUTTON
  // YOU MUST CALL THIS EVERY LOOP
  button.update();
  button2.update();

  if ( button.pressed() ) {
    
    // TOGGLE THE LED STATE : 
    ledState = !ledState; // SET ledState TO THE OPPOSITE OF ledState
    digitalWrite(LED_PIN,ledState);
    ledState = !ledState; // SET ledState TO THE OPPOSITE OF ledState
    digitalWrite(LED_PIN,ledState);

  }
  if ( button2.pressed() ) {
    
    // TOGGLE THE LED STATE : 
    ledState2 = !ledState2; // SET ledState TO THE OPPOSITE OF ledState
    digitalWrite(LED_PIN2,ledState2);
    ledState2 = !ledState2; // SET ledState TO THE OPPOSITE OF ledState
    digitalWrite(LED_PIN2,ledState2);

  }
}