**Author:** Chendar  

**Version:** 1.1.0

**Description:**  
Simple addon for making skillchains using immanence on a scholar and bursting off of those if enabled. 
Note: Does not keep track of stratagem usage and timing may very well be off if you don't have capped (80%) fast cast on your scholar.

**Abbreviations:** scd

**Commands:**

 1. //scd sc [liquefusion|sixstep]	 
 
 -- Starts making a skillchain of the selected element, or three-step fire or six-step if those arguments are provided. If using the six-step without tabula rasa active use immenance once and wait about 10 seconds before firing it off.
											
 2. //scd element [Element]			 
 
 -- 'Element' can be any of 'Stone', 'Water', 'Aero', 'Blizzard', 'Thunder', 'Light' or 'Dark' and is optional. If no Element is provided it will cycle through them instead.
											
 3. //scd burst [on|off|helix]  	 
 
 -- Sets Burst mode to on, off or helix or cycles through them if no arguement is given. If 'on' or 'helix' it will automatically burst the correct tier 5 spell or helix 2. For light/dark it'll only ever do helix.
 
 4. //scd ebullience 					 
 
 -- Toggles ebullience usage for the bursting on/off. Note that if tabula rasa is active it will always use ebullience in any case.

**Changes:**  
v1.0.3 - v1.1.0
 * sixstep option added for skillchains
 
v1.0.2 - v1.0.3
 * minor HUD tweaks	

v1.0.1 - v1.0.2
 * added auto-translates to chat messages
 
v1.0.0 - v1.0.1
 * added 'liquefusion' for making a 3 step fire skillchain
        