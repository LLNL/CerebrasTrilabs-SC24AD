Cerebras TriLabs SC'24 paper Artifact Description
---------------------------------------------------

Artefact descrition supporting materials for the Supercomputing
Conference (SC'24) paper

  "Fast Molecular Dynamics on a Wafer-Scale
   System"

by

  K. Santos, S. Moore, T. Oppelstrup, A. Sharifian, I. Sharapov,
  A. Thompson, D. Z. Kalchev, D. Perez, S. Pakin, E. A. Leon,
  J. H. Laros, M. James, and S. Rajamanickam.


DESCRIPTION
-------------
The AD appendix, with instructions for how to reproduce the CPU and
GPU timings performed for the paper, and including all necessary input
files and scripts, can be found in the file AD-appendix.pdf. This
repository in addition contains these input files and scripts
organized into relevant directories.

Files for the CPU benchmarks are in the cpu_benchmarks
directory. Files for the GPU benchmarks are in the gpu_benchmarks
directory.

In addition to the material in AD_appendix.pdf you can also, for
convenience, find copies of potential files for LAMMPS that can be
used to reproduce the calculations. They are in the 'potentials'
subdirectory, in the files Cu_u6.eam, Ta_Li_2003.eam.alloy, and
W_shou_short.eam.alloy. See the README file in that directory for
license information of these files, and for how to obtain them from
different sources.

LICENSE
---------
Except for the potential files (described above) all files are
distributed under the MIT license. See the COPYRIGHT file and
LICENSE-MIT for details. For license information about the potential
files, see the README and LICENSE-* files in the 'potentials'
subdirectory.

RELEASE
---------
This appendix has been made open source by the Lawrence Livermore
National Laboratory. The release number is LLNL-CODE-866158. For
auspices and disclaimer statements, see the NOTICE file.
