// Button toggle with extreme reliability!

const int ledpins[2] = {
  2, 3};
const int led1Pin =  13;    // LED pin number
const int buttons[2] =  {
  10, 11}
char bstates[2] = {
  0, 0};
char ledStates[2] = {
  0, 0};
unsigned long bcount[2] = {
  0, 0}; // button debounce timers.  Replicate as necessary.

// Have we completed the specified interval since last confirmed event?
// "marker" chooses which counter to check
// Routines by Paul__B of Arduino Forum
boolean timeout(unsigned long *marker, unsigned long interval) {
  if (millis() - *marker >= interval) { 
    *marker += interval;    // move on ready for next interval
    return true;       
  } 
  else return false;
}

// Deal with a button read; true if button pressed and debounced is a new event
// Uses reading of button input, debounce store, state store and debounce interval.
// Routines by Paul__B of Arduino Forum
boolean butndown(char button, unsigned long *marker, char *butnstate, unsigned long interval) {
  switch (*butnstate) {               // Odd states if was pressed, >= 2 if debounce in progress
  case 0: // Button up so far, 
    if (button == HIGH) return false; // Nothing happening!
    else { 
      *butnstate = 2;                 // record that is now pressed
      *marker = millis();             // note when was pressed
      return false;                   // and move on
    }

  case 1: // Button down so far, 
    if (button == LOW) return false; // Nothing happening!
    else { 
      *butnstate = 3;                 // record that is now released
      *marker = millis();             // note when was released
      return false;                   // and move on
    }

  case 2: // Button was up, now down.
    if (button == HIGH) {
      *butnstate = 0;                 // no, not debounced; revert the state
      return false;                   // False alarm!
    }
    else { 
      if (millis() - *marker >= interval) {
        *butnstate = 1;               // jackpot!  update the state
        return true;                  // because we have the desired event!
      }
      else 
        return false;                 // not done yet; just move on
    }

  case 3: // Button was down, now up.
    if (button == LOW) {
      *butnstate = 1;                 // no, not debounced; revert the state
      return false;                   // False alarm!
    }
    else { 
      if (millis() - *marker >= interval) {
        *butnstate = 0;               // Debounced; update the state
        return false;                 // but it is not the event we want
      }
      else 
        return false;                 // not done yet; just move on
    }
  default:                            // Error; recover anyway
    {  
      *butnstate = 0;
      return false;                   // Definitely false!
    }
  }
}

void setup() {
  for (int i=0; i < 4; i++) pinMode(ledpins[i], OUTPUT);      
  for (int i=0; i < 2; i++) { 
    pinMode(buttons[i], INPUT);      
    digitalWrite(buttons[i],HIGH); // internal pullup all versions
  }        
}

void loop() {
  // Toggle LED if button debounced
  for (int i=0; i < 2; i++) {  
    if (butndown(digitalRead(buttons[i]), &bcount[i], &bstates[i], 10UL )) {
      if (ledStates[i] == LOW) {
        ledStates[i] = HIGH;
      }
      else {
        ledStates[i] = LOW; 
      } 
      digitalWrite(ledpins[i], ledStates[i]); 
    }
  } 
}