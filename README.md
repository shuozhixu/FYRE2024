# A Cu single crystal containing a spherical nanovoid

## Foreword

Ductile metal fractures have traditionally been attributed to the growth of voids. With increasing strain, the metal's deformation becomes irreversible, and the voids expand more rapidly. As the strain increases further, neighboring voids interact and coalesce into larger ones, eventually leading to crack propagation within the metal.

In this project, we will employ atomistic simulations to calculate the strength of a Cu single crystal containing a spherical nanovoid. We aim to answer these three questions:

- How does the void size affect the material strength?
- How do the stacking fault energies affect the void size-dependent material strength?
- Related to the second question, can we train an ML model to predict the strength?

Please read the following journal articles to understand how the strength of a void-containing material can be calculated using atomistic simulations:

- Shuozhi Xu, Yanqing Su, Saeed Zare Chavoshi, [Deformation of periodic nanovoid structures in Mg single crystals](http://dx.doi.org/10.1088/2053-1591/aaa678), Mater. Res. Express 5 (2018) 016523
- Shuozhi Xu, Yanqing Su, Dengke Chen, Longlei Li, [Plastic deformation of Cu single crystals containing an elliptic cylindrical void](http://dx.doi.org/10.1016/j.matlet.2017.02.005), Mater. Lett. 193 (2017) 283--287
- Shuozhi Xu, Yanqing Su, [Nanovoid growth in BCC $\alpha$-Fe: Influences of initial void geometry](http://dx.doi.org/10.1088/0965-0393/24/8/085015), Modelling Simul. Mater. Sci. Eng. 24 (2016) 085015
- Yanqing Su, Shuozhi Xu, [On the role of initial void geometry in plastic deformation of metallic thin films: A molecular dynamics study](http://dx.doi.org/10.1016/j.msea.2016.09.091), Mater. Sci. Eng. A 678 (2016) 153--164

Note: all papers above were on 2D voids. More papers, including those on 3D voids, can be found [here](https://drive.google.com/drive/folders/10zcbMxHpxCnG1PrJtRhMz4cvf44nXNWz?usp=sharing).

## Generalized stacking fault energy

To understand the generalized stacking fault energy (GSFE) in face-centered cubic metals, please read [this paper](http://dx.doi.org/10.1063/1.5115282).

Along the GSFE curve, two energies are important: instrinsic stacking fault energy (ISFE) and unstable stacking fault energy (USFE). Note that ISFE is sometimes called stable stacking fault energy.

## Interatomic potentials

Eleven interatomic potentials will be used. The first seven potentials, developed by [Borovikov et al. in 2015](http://dx.doi.org/10.1088/0965-0393/23/5/055003), have largely the same ISFE but with varying USFE. The remaing four potentials, developed by [Borovikov et al. in 2016](10.1088/0965-0393/24/8/085017), have largely the same USFE but with varying ISFE. Files for the eleven potentials can be found in the `potentials/` directory in this GitHub repository. Values of ISFE and USFE of each potential can be found in [this paper](http://dx.doi.org/10.1007/s10853-023-08779-8), whose references 31--45 are prior work where some or all of the eleven potentials were used.

## Void size

30 void sizes will be considered. If we were to change the void size, we would change the simulation cell size as well, such that the porosity remains at 0.5%.

## LAMMPS simulations

Since we will consider eleven interatomic potentials and 30 void sizes, we will run in total 330 LAMMPS simulations in this project. Each time we run a new simulation, create a new directory.

On the one hand, one can run multiple simulations at the same time. On the other hand, it is suggested that no more than ten simulations are run at the same time such that other students can also run simulations.

### The Cu1 potential

#### One void size

Put the following three files in the same directory on OSCER: `Cu1.eam.fs`, `lmp.in`, `lmp.batch`. Then we submit the job by

	sbatch lmp.batch

Once the simulation is finished, we will find a file `dilatation_pressure` in the directory on OSCER. Its first column is the dilatation (which is unitless) and its second column is the hydrostatic pressure (in units of GPa). Plot the dilatation-pressurer curve to see what it looks like. The maximum hydrostatic pressure can be found by running

	sh max_curve.sh
	
which would yield two numbers on the screen. The second number is the maximum hydrostatic pressure.

#### Other void sizes

To switch to another void size, we need to make one change in the `lmp.in` file:

- line 12. Change the number `60` to `58`

Then submit the job by

	sbatch lmp.batch

Then switch to another void size by changing that number in line 12 to `56`, `54`, ..., `2`, respectively. As mentioned, in total 30 void sizes will be considered for each interatomic potential.

Note: the smaller the void size, the smaller the simulation cell, and hence the less time it would take to finish the LAMMPS simulation.

Once all simulations are finished, plot one curve, with the _x_ axis being the void size and the _y_ axis being the maximum hydrostatic pressure.

### Other potentials

To switch to another interatomic potential, e.g., the Cu2 potential, we need to make one change in the `lmp.in` file:

- line 33. Change `Cu1.eam.fs` to `Cu2.eam.fs`

To run the simulation, we need to put the following three files in the same directory on OSCER: `Cu2.eam.fs`, `lmp.in`, `lmp.batch`. Then we submit the job by

	sbatch lmp.batch

For each potential, plot one curve with the _x_ axis being the void size and the _y_ axis being the maximum hydrostatic pressure.

## References

If you use any files from this GitHub repository, please cite

- Shuozhi Xu, Yanqing Su, Dengke Chen, Longlei Li, [Plastic deformation of Cu single crystals containing an elliptic cylindrical void](http://dx.doi.org/10.1016/j.matlet.2017.02.005), Mater. Lett. 193 (2017) 283--287