# Things to add to flightline/score:
 1. Mostly done! ~~BUG: Proper deletion of data from Score.~~ Done except for sequences.   These just get overwritten for now.
 1. Done! ~~Authentication.~~
 1. Edit the flightline details (Id, name etc...)
 1. Edit users (add/delete/change password);
 1. Maybe extend auth to include local IP address hash so it cannot be copied.
 1. Re-open a closed round.
 1. Re-enter scores for a pilot already recorded.
 1. Would be great to be able to drill down through Rounds/Flights/Sequences to see raw scores.
 1. Adjust the score sheet details.  (Change pilot for example if the judge entered the wrong pilot number)
 1. Zero a flight for the pilot (if they did not fly)
 1. Disallow closing the round until all pilots have flown or been zeroed.
 1. Done! ~~Confirm that user really does want to delete data....   (results, pilots etc)~~
 1. Done! ~~Live scoring~~
 1. Done! ~~BUG: Fix non-existent pilot bug.~~
 1. Done! ~~BUG: Round exists but flights for round do not....~~
 1. Done! ~~BUG: If the flightline DB is emptied, and there is no flightline ID defined then there are problems for Score serialising the data from flightline.~~
 Fixed in setup.sh but need to handle it in Flightline/Score! for neatness...
 1. Done! ~~BUG: If adding the same class twice in flightline, the schedule list is not initialised.   You must first choose a differnet class and then re-select the class you want.~~
 1. BUG: If judge selects a pilot not in the class and starts scoring, need to handle this.  Two thoughts...  Firstly we could always fail the update.   But if the judge does not notice then we are screwed.    Secondly we could allow the single score updates (OPT=N) and return OK to notaumatic, but fail the confirmation (OPT=U).   This way the judge figures it out at the end, but still has his scores...
 1. BUG: freestyle uploaded as Basic class.   Should be 'Freestyle'.
 1. Done! ~~Feature: Extend freestyle to more than 9 flights.~~  Done!
 1. Sometimes Judges dont validate scores!    We are left with unconfirmed sheets!  (Phase = 'S').   These are imported OK but it's messy...
