# Copyright 2024 Lawrence Livermore National Security, LLC
# and other contributors. See the top-level COPYRIGHT file
# for details.
#
# SPDX-License-Identifier: MIT

print "Simulation of ${element} with ${nx}x${ny}x${nz} unit cells"
include ${element}/${element}.inc

units		metal
atom_style	atomic
atom_modify map hash

lattice		${latttype} $(v_alatt*v_thexp) # Effective lattice constant

region		box block 0 ${nx} 0 ${ny} 0 ${nz}

create_box	1 box
create_atoms	1 box
mass		1 ${M}

if "${pbc}==1" then "jump SELF pbc_section"
if "${pbc}==2" then "jump SELF z_bc_section"
label open_bc_section
  displace_atoms all move 0.25 0.25 0.25
  change_box all boundary s s s
  variable bc string open
  jump SELF bc_section_end

label z_bc_section
  displace_atoms all move 0.25 0.25 0.0
  change_box all boundary s s p
  variable bc string openxy
  jump SELF bc_section_end

label pbc_section
  variable bc string pbc

label bc_section_end


velocity all create $(2*v_T) 87287 loop geom # 2*T to compensate for equipartitioning
velocity all zero linear
velocity all zero angular

if "${alloytype}==1" then "jump SELF alloy_section"
label eam_section
  pair_style	eam
  pair_coeff	* * ${element}/${potfile}
  jump SELF potential_end
label alloy_section
  pair_style	eam/alloy
  pair_coeff	* * ${element}/${potfile} ${element}
label potential_end

print "Input file mass = ${M}, after potential init, atom mass = $(mass[1])"

neighbor	0.5 bin
neigh_modify	every 1 delay 0 check yes

fix		1 all nve

compute msd all msd
fix avgs all ave/time 1 1000 1000 c_thermo_press c_thermo_temp

thermo_style custom step f_avgs[2] pe etotal f_avgs[1] c_msd[1]

timestep 0.002  ## 2 fs timestep.
thermo		1000
run		20000

write_dump all custom &
  ${element}/cfgs/dump.${element}-crystal.${nx}x${ny}x${nz}.${bc} &
  id type x y z vx vy vz fx fy fz  modify sort id
