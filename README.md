# SOH.Centaur
Evan Marschall 2019
Assistance and guidance from Zach Eilon and Jon Petruska. (UC Santa Barbara)

Codes to analyze State of Health for Centaur Data Logger using Matlab


Field_SOH is the main script and calls the various function when it is ran. 
The file path must be properly set before running code
The Code outputs a figure with the state of health data plotted for the period of deployment.
There is an option to change how days with no data are displyed
        Usually plots as NaN, but this can be changed to someother "Bad Value"
            To do so change badval in both Concat and Plot_ALL functions
            
            
       
