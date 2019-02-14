# Things to add to flightline/score:
 1. BUG: Proper deletion of data from Score.   Including sequences.
 1. Authentication.
 1. Ability to re-open a closed round (Only with proper authorisation).
 1. Ability to re-enter scores for a pilot already recorded (Only with proper authorisation).
 1. Ability to zero a flight for the pilot (if they did not fly), and disallow closing the round until all pilots have flown or been zeroed.
 1. Would be great to be able to drill down through Rounds/Flights/Sequences to see raw scores.
 1. Live scoring (nearly done).
 1. BUG: Fix non-existent pilot bug.
 1. BUG: If the flightline DB is emptied, and there is no flightline ID defined then there are problems for Score serialising the data from flightline.   Fixed in setup.sh but need to handle it in Score!
 1. BUG: If adding the same class twice in flightline, the schedule list is not initialised.   You must first choose a differnet class and then re-select the class you want.
