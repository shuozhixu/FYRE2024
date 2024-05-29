# A Cu single crystal containing a spherical nanovoid

## Foreword

Ductile metal fractures have traditionally been attributed to the growth of voids. With increasing strain, the metal's deformation becomes irreversible, and the voids expand more rapidly. As the strain increases further, neighboring voids interact and coalesce into larger ones, eventually leading to crack propagation within the metal.

In this project, we will employ atomistic simulations to calculate the yield strength of a Cu single crystal containing a spherical nanovoid. We aim to answer these three questions:

- How does the void size affect the yield strength?
- How do the stacking fault energies and surface energies affect the void size-dependent yield strength?
- Related to the second question, can we train a machine learning (ML) model to predict the yield strength?

Please read the following journal articles to understand how the deformation of a void-containing material is modeled in atomistic simulations:

- Shuozhi Xu, Yanqing Su, Saeed Zare Chavoshi, [Deformation of periodic nanovoid structures in Mg single crystals](http://dx.doi.org/10.1088/2053-1591/aaa678), Mater. Res. Express 5 (2018) 016523
- Shuozhi Xu, Yanqing Su, Dengke Chen, Longlei Li, [Plastic deformation of Cu single crystals containing an elliptic cylindrical void](http://dx.doi.org/10.1016/j.matlet.2017.02.005), Mater. Lett. 193 (2017) 283--287
- Shuozhi Xu, Yanqing Su, [Nanovoid growth in BCC $\alpha$-Fe: Influences of initial void geometry](http://dx.doi.org/10.1088/0965-0393/24/8/085015), Modelling Simul. Mater. Sci. Eng. 24 (2016) 085015
- Yanqing Su, Shuozhi Xu, [On the role of initial void geometry in plastic deformation of metallic thin films: A molecular dynamics study](http://dx.doi.org/10.1016/j.msea.2016.09.091), Mater. Sci. Eng. A 678 (2016) 153--164

Note: all papers above were on 2D voids. More papers, including those on 3D voids, can be found [here](https://drive.google.com/drive/folders/10zcbMxHpxCnG1PrJtRhMz4cvf44nXNWz?usp=sharing). We will only consider a 3D, spherical void, in this project.

## Generalized stacking fault energy

To understand the generalized stacking fault energy (GSFE) in face-centered cubic metals, please read [this paper](http://dx.doi.org/10.1063/1.5115282).

Along the GSFE curve, two energies are important: instrinsic stacking fault energy (ISFE) and unstable stacking fault energy (USFE). Note that ISFE is sometimes called stable stacking fault energy.

## Surface energy

To understand the surface energies in elements, please read [this paper](http://dx.doi.org/10.1038/sdata.2016.80).

## Porosity and void size

In additively manufactured [Inconel 625](https://doi.org/10.1016/j.matdes.2022.111545) and [Inconel 718](https://doi.org/10.1016/j.promfg.2020.05.117), the porosity is found to be less than 1%. In Inconel 718, [Prithivirajan and Sangid](https://doi.org/10.1016/j.matdes.2018.04.022) found that a porosity of 1% would likely initiate a fatigue crack. In Cu, [Kumar et al.](https://doi.org/10.1016/j.promfg.2017.07.084) found that the as-printed material has a porosity of 0.26%–1.29%, while a heat treatment can lower the porosity to 0.09%–0.1%. Thus, we use a uniform porosity which is between 0.5% and 1% as a representation.

Note: in this project, as the void size is changed, the simulation cell size is changed as well, such that the porosity remains unchanged.

The largest void diameter consiered in this project is about 100 nm because a void with a diameter exceeding 100 nm cannot be called a nanovoid. We will consider nanovoids only here.

For each interatomic potential, 32 void sizes will be considered.

## Interatomic potentials

The are eleven interatomic potentials in total. The first seven potentials, developed by [Borovikov et al. in 2015](http://dx.doi.org/10.1088/0965-0393/23/5/055003), have largely the same ISFE but with varying USFE. The remaing four potentials, developed by [Borovikov et al. in 2016](http://dx.doi.org/10.1088/0965-0393/24/8/085017), have largely the same USFE but with varying ISFE. Other material properties such as the lattice parameter, elastic constants, as well as vacancy formation and migration energies are largely the same for all eleven potentials. Note that the surface energies predicted by the eleven potentials also differ. Values of ISFE, USFE, and surface energies of the eleven potentials can be found in Table 1 of [this paper](http://dx.doi.org/10.1088/0965-0393/24/8/085017). Files for the eleven potentials can be found in the `potentials/` directory in this GitHub repository.

Note: the eleven potentials have been applied to many problems in Cu, see references 31–45 of [this paper](http://dx.doi.org/10.1007/s10853-023-08779-8).

[//]: # (The second set contains [one interatomic potential]https://doi.org/10.1103/physrevb.63.224106. The file for this potential, `Cu_Mishin.eam.alloy`, can be found in the `potentials/` directory in this GitHub repository. Values of ISFE, USFE, and surface energies predicted by this `Mishin` potential are very close to those by the `Cu31` potential. However, the two potentials predict different lattice parameter and vacancy migration energy.)

## A note on simulations

Since we will consider eleven interatomic potentials and 32 void sizes, we will run in total 352 LAMMPS simulations. Each time we run a new simulation, create a new directory.

## LAMMPS simulations

### The Cu31 potential

#### One void size

Place the following three files in the same directory on OSCER: `Cu31.eam.fs`, `lmp.in`, `lmp.batch`. Then we submit the job by

	sbatch lmp.batch

Once the simulation is finished, we will find a file `dilatation_pressure` in the directory on OSCER. Its first column is the dilatation (which is unitless) and its second column is the hydrostatic pressure (in units of GPa). Plot the dilatation-pressure curve to see what it looks like. When the dilatation is small, the pressure increases with it smoothly (but not linearly). However, when the dilatation is sufficiently large, the pressure would experience a large drop. And that is when the material yields and the plastic deformation begins. That critical hydrostatic pressure is then taken as the yield strength.

#### Other void sizes

To switch to another void size, we need to make one change in the `lmp.in` file:

- line 12. Change the number `64` to `62`

Then submit the job by

	sbatch lmp.batch

Then switch to other void sizes by changing that number in line 12 to `60`, `58`, ..., `2`, respectively. As mentioned, in total 32 void sizes will be considered for each interatomic potential.

Note: the smaller the void size, the smaller the simulation cell, and hence the less time it would take to finish the LAMMPS simulation.

Once all simulations are finished, plot one curve, with the _x_ axis being the void size and the _y_ axis being the yield strength.

### Other potentials

We then run LAMMPS simulations using the remaining ten interatomic potentials, i.e., `Cu1`, `Cu2`, ..., `Cu7`, `Cu32`, `Cu33`, and `Cu34`.

Take `Cu1` as an example. To run the simulation, we first make one change in the `lmp.in` file

- line 33. Change it to `pair_coeff * * Cu2.eam.fs Cu`

Then place the following three files in the same directory on OSCER: `Cu2.eam.fs`, `lmp.in`, `lmp.batch`. Then we submit the job by

	sbatch lmp.batch

Iteratively adjust the value of `len` in line 12 of the `lmp.in` file, so that we will obtain 32 strength values for the `Cu2` potential.

Once all simulations for the `Cu2` potential are done, proceed to the other nine potentials.

## Machine learning models

Once all LAMMPS are finished, make three 3D plots.

The first plot uses all data based on the first seven potentials (i.e., from Cu1 to Cu7). In this plot, let the _x_ axis be the void size, the _y_ axis be the ISFE, and the _z_ axis be the yield strength. There should be 224 data points in total.

The second plot uses all data based on the remaining four potentials (i.e., from Cu31 to Cu34). In this plot, let the _x_ axis be the void size, the _y_ axis be the USFE, and the _z_ axis be the yield strength. There should be 128 data points in total.

The third plot uses all data based on the eleven potentials (i.e., from Cu1 to Cu34). In this plot, let the _x_ axis be the void size, the _y_ axis be the mean surface energy among {100}, {110}, and {111} planes, and the _z_ axis be the yield strength. There should be 352 data points in total.

Alternatively, we may create _N_ combinatorial parameters that involve ISFE, USFE, and/or mean surface energy, e.g., the ratio of ISFE to USFE (see Figure 9 of [this paper](http://dx.doi.org/10.1007/s10853-023-08779-8)) or the difference between USFE and mean surface energy, and then use each of them as the _y_ axis in third plot.

Based on all those data, let's try to answer the following three scientific questions using ML:

- Which one, among ISFE, USFE, and mean surface energy, is the most important in controlling the yield strength?
- Additionally, is there a combinatorial parameter that can best correlate with the yield strength?
- How does the yield strength scale with the ISFE, USFE, mean surface energy, and/or the combinatorial parameter? For example, quadratically or cubically?

## Reference

If you use any files from this GitHub repository, please cite

- Shuozhi Xu, Yanqing Su, Dengke Chen, Longlei Li, [Plastic deformation of Cu single crystals containing an elliptic cylindrical void](http://dx.doi.org/10.1016/j.matlet.2017.02.005), Mater. Lett. 193 (2017) 283--287
