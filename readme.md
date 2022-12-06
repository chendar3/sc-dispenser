**Author:** Chendar  
**Version:** 1.0.1
**Description:**  
Simple addon for making skillchains using immancence on a scholar and bursting off of those if enabled.
Note: Does not keep track of stratagem usage so keep that in mind.

**Abbreviations:** scd

**Commands:**
 1. //scd sc ['liquefusion'|'sixstep']	 -- Starts making a skillchain of the selected element, or 3-step fire or 6step if those arguements are provided 
											(6step not implemented yet)
											
 2. //scd element [Element]				 -- Element can be any of 'Stone', 'Water', 'Aero', 'Blizzard', 'Thunder', 'Light' or 'Dark' and is optional
											if no Element is provided it will cycle through them.
											
 3. //scd burst ['on'|'off'|'helix']  	 -- Sets Burst mode to on, off or helix or cycles through them if no arguement is given.
 
 4. //scd ebullience 					 -- Toggles ebullience usage for the bursting on/off. Note that if tabula rasa is active it will use ebullience anyway.

**Changes:**  
v1.0.0 - v1.0.1
 * added 'liquefusion' for making a 3 step fire skillchain
        