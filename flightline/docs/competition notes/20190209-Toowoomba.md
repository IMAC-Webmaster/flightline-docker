# Toowoomba Comp Notes:

On the weekend of the 9th of February 2019 we had our fist competition using Score and the Flightline web app.
The user base were already very used to electronic scoring using Score with ScorePad running on iPads.

The comp was run successfully but not without some teething problems.   It was always going to be a challenge introducing a new system to a group of users already happy with the current system, but we got through it and the feedback so far has been very useful.  I expect more feedback to come.

We had 15 pilots across all classes and flew over 204 sequences.

Data integrity has been excellent, there were 2 sequences where there was a problem.   In one case the judge simply picked up pen and paper and wrote the scores down manually, called me over and we entered the score properly into the system.

In the other case the judge did not look at the screen properly and was not recording his scores as he thought he was.   In this case it was necessary to use the other judges scores.   This would be akin to losing a score sheet if we were scoring manually.

**The following is a list of things that came up.**
 - As mentioned above, one sheet was lost due to user error.  I'd like to investigate what can be done to alert the judge that they have made a mistake.   If they don't look at the screen then the first they know is when they try and print the sheet.

 - One issue occurred when the data was not fully cleared before the start of the comp.  I gave a short demo to the CD but I did not fully clear the data.   It took me 10 minutes to fix.

 - One judge resorted to pen/paper for one sheet.  This was because the device lost wifi connection and he was not sure how to proceed.  He took a conservative approach and that was ok.   He could have entered the pilot number manually and the Notaumatic would have just cached the results until wifi was available.

 - One pilot needed to restart his round after the first manoeuvre because, again, the judge did not check the screen before giving the pilot the OK to fly.

 - The workload for the judges went up.   Before there was a scribe holding the device, so the judge held the aresti sequence and a scoring wheel (maybe).  With Notaumatic, there is less need for a scribe so they hold the aresti sequence, the Notaumatic, and between the two judges there is a small iPad to queue the next pilot.  This was mostly solved by putting the judges behind a fold-up table.

 They are also able to listen to the sequence via earpiece.  Some judges found this distracting at least until they became comfortable with the routine.   I personally found it very handy to have a judges caller for the Unknowns and also for the higher known classes.

 - Until the judges got a handle on it.  There was some delay between sequence 1 and 2 in a round.   This is a potential issue for pilots who are close to the 2 sequence threshold with their fuel/battery supply.

 - Double sequences are harder for the judges.

 - BUG/Feature request: The highlighted score is not indicated (flashing) until the sequence is read.  This is quite some time for complex unlimited figures.   You can still enter a score, but it's not clear to the judge that you are on the right score when you are not listening to the device.

 - BUG/Feature request: For judges that choose not to listen to the aresti there is little indication that they have successfully entered a score.  They need to look down.  (much in the same way they would when writing a score on paper).

 - BUG/Feature request: The top line while scoring should show Judge/Flight/Pilot numbers.   Sometimes it does and sometimes it does not.   **ToDo:** Add image.

 - Double rounds are a problem.  It works, but there are plenty of opportunities for the judges to select the wrong flight for the pilot.  I need to re-think how to make this user proof.   Something like not allowing the second seq to be flown until the first one is entered (or zeroed).  We switched to single sequences and it went very well after that.

 - rPi wifi is sometimes slow.  I had to reboot twice to get it working.  I was expecting this as I have heard of issues.  There really is no problem running a comp off the pi wifi however it might go more smoothly with a dedicated good quality wifi AP.  James from the Australian Pattern Association reports a similar experience.

 - Unfortunately I could not deliver the results on the day (they were available about 6 hours later).  We found a bug which occurred when the judge chose a non-existent pilot number.  I need to handle this better by not allowing the judge to do that where possible (they can force it).  If it happens I need to be able to detect it in flightline or score and ask the CD to assign a pilot to that sheet.  It's fairly obvious which pilot it will be because the pilot before them will have 2 sheets (for two judges) and the pilot after them will have 2 sheets.   While the problem sheet will reside alongside a legitimate sheet.

Please see the ToDoList.md file for the action list...
