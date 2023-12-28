# Strength of a Cu single crystal containing a spherical nanovoid

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

## LAMMPS

Since we will consider 60 LAMMPS simulations will be conducted in this project. Each time we run a new simulation, create a new directory.

The interatomic potential is the same one used in our previous project.

## Related to a previous project

In [a previous project of ours](https://github.com/shuozhixu/Materials_2024), the CLS processes in nanolaminated Ag and two types of Ag/Cu nanolaminates were studied. The layer thickness for each metal was 5 nm. No cavities were involved. According to four experimental Ag/Cu nanolminates papers above, (i) there is a cavity-free zone within 20 nm from the interface in the Cu layer and (ii) the cavity can be a void or a He bubble. For cavities near the interface, they adhere to the interface in the Ag layer rather than straddling the interface in both metals. Therefore, if one were to insert a cavity in our previous 5-nm-thick model, the cavity either adheres to the interface in the Ag layer or sits in the middle of the Ag layer. In addition, the cavity's diameter varies from 1 nm to 12 nm according to [Wang et al.](https://doi.org/10.1016/j.actamat.2018.09.003)

Unfortunately, there is no interatomic potentials for Ag/He, and so we only consider void.

## Nanolaminated Ag

Our previous project considered CLS in all three different slip planes. Here, let's consider all of them.

Therefore, we need to insert a void either at the interface or in the middle of a Ag layer where CLS takes place. For each slip plane, let the dislocation glide through the center of the void. The insertion of the void can be done in [LAMMPS](https://docs.lammps.org/delete_atoms.html) or [atomsk](https://atomsk.univ-lille.fr/tutorial_removeatoms.php). Three void diameters can be considered: 1 nm, 2 nm, and 3 nm.

Since there are three void sizes, two void locations, and three slip planes, 18 LAMMPS simulations need to be conducted.

## Ag/Cu Nanolaminate - type 1

Our previous project considered CLS in 10 different slip planes, which possess different critical stresses for CLS. Here, let's consider three planes: one with the maximum critical stress, one with the minimum critical stress, and another with the average critical stress.

As a result, 18 LAMMPS simulations need to be conducted.

## Ag/Cu Nanolaminate - type 2

Along the same line of thought, let's consider three planes here too. Similarly, another 18 LAMMPS simulations should be conducted.

## Single crystalline pure metals

There are two pure metals, Cu and Ag. To provide references, we can simulate the dislocation/void interactions in Ag, and compare results with those in nanolaminates. The dislocation line should be 5 nm, the same as those used in nanolaminates. There are two types of boundary conditions along the dislocation line direction: periodic boundary conditions and traction-free boundary conditions. Thus, there are 6 cases in total.

The dislocation/void interactions in a Cu single crystal where the periodic boundary conditions were applied along the dislocation line were modeled in [a previous paper](http://dx.doi.org/10.1088/1361-651X/ab8358), which should be studied closely.

## References

If you use any files from this GitHub repository, please cite

- Wu-Rong Jian, Yanqing Su, Shuozhi Xu, Weisen Ji, Irene J. Beyerlein, [Effect of interface structure on dislocation glide behavior in nanolaminates](http://dx.doi.org/10.1557/s43578-021-00261-y), J. Mater. Res. 36 (2021) 2802--2815
- Wu-Rong Jian, Min Zhang, Shuozhi Xu, Irene J. Beyerlein, [Atomistic simulations of dynamics of an edge dislocation and its interaction with a void in copper: A comparative study](http://dx.doi.org/10.1088/1361-651X/ab8358), Modelling Simul. Mater. Sci. Eng. 28 (2020) 045004