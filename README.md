# TLMA-simulator

Simulation of sound waves using the Transmission Line Matrix (TLM) model for acoustic signals.

This simulator is based on the methods described in:

> Y. Kagawa, T. Tsuchiya, B. Fujii, and K. Fujioka,  
> *"Discrete Huygens’ Model Approach to Sound Wave Propagation,"*  
> *Journal of Sound and Vibration*, vol. 218, no. 3, pp. 419–444, 1998.  
> [https://doi.org/10.1006/jsvi.1998.1861](https://doi.org/10.1006/jsvi.1998.1861)

## Features
The project features a customizable acoustic simualator for rectangular 2D boxes for different boundary reflection coefficients, and different fluids inside the box. The simulator shows the pressure signal as a function of time as well as the frequency spectrum at the receiver end of the rectangular box. The modes of the rectangular box can be found by looking at the peaks of the frequency spectrum plot. The simulation environment also makes it possible to use one of premade sources, but with the possibility to extend to other sources that can be defined by the user in the `source/generate_source.m` file. The simulator provides a progress bar that shows completion status of the current simulation in 10% intervals while running.

## How to use
From root of repository navigate to the initParmas.m file folder:
`cd src/initParams.m`
Then, from there you can set all of the simulation parameters in the following order
1. `params.c` set sound speed of medium, 343 by default (in air).
2. Set `params.Lx` and `params.Ly` for geometry of the pipe.
3. Set `params.f_max`for the maximum frequency you are going to use in the simulation. Set `params.nppw` (number of points per wavelength), should be at least 10.
4. Set `params.R` for reflection coefficient of the boundaries..
5. Set `params.t_max` for simulation time.
6. Select between sweep', 'dirac' or 'harmonic' when setting `params.source.type` for different sources, and choose amplitude by setting `params.source.amp`. Depending on your source selection there are many parameter you can tune under the relevant source sections commented in the code.
7. For all sources a source is placed in the lower left corner, and a microphone at the lower right corner (receiver).
8. If using the harmonic source then you can adjust the number of microphones you want to be spread evenly across the x-axis (more = better resolution but longer simulation time) by setting `params.numMics`. By adjusting `params.micX` and `params.micY` you can adjust the x- and y positions respectively. The microphones are used to create snapshots at different time instants for the whole pipe.
9. There are more parameters you can tune to make it closer to your specifications, see the comments in the file for more.

After setting all of the parameters all you have to do is to run `src/main.m` and simulation will start. After simulation 4 plots will appear: One showing the source pressure as a function of time, and one that does the same for the receiver microphone. There is also the fourier transform plot made from the time signals of the pressure, which is showing the frequency spectrum at the receiver end, as well as the SPL plot. If setting the harmonic source, four snapshots at quarter-period intervals will also be shown.
