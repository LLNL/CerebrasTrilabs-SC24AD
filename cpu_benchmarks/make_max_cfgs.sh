# Copyright 2024 Lawrence Livermore National Security, LLC
# and other contributors. See the top-level COPYRIGHT file
# for details.
#
# SPDX-License-Identifier: MIT

lmp="./lmp_mpi_quartz"

## This script generates max size configurtaions that fits on the
## CS-2 machine we run on for this project.


# Max Ta,W shapes fitting 'std size CS-2': "186 248 8" "249 248 6"
for shapes in "256 261 6" ; do
    nx=`echo $shapes | awk '{print $1}'`
    ny=`echo $shapes | awk '{print $2}'`
    nz=`echo $shapes | awk '{print $3}'`
    for elem in Ta W ; do
	for bc in 0 ; do
	    echo "Submitting $nx x $ny x $nz, $elem bc=$bc"
	    srun -N8 -n288 -t10 $lmp -in in.eq \
	     -var element $elem \
	     -var nx $nx -var ny $ny -var nz $nz -var pbc $bc \
	     -log xlog.$nx.$ny.$nz.$elem.$bc > xrun.$nx.$ny.$nz.$elem.$bc  &
	done
    done
done

for shapes in "174 192 6" ; do
    nx=`echo $shapes | awk '{print $1}'`
    ny=`echo $shapes | awk '{print $2}'`
    nz=`echo $shapes | awk '{print $3}'`
    for elem in Cu ; do
	for bc in 0 ; do
	    echo "Submitting $nx x $ny x $nz, $elem bc=$bc"
	    srun -N8 -n288 -t10 $lmp -in in.eq \
	     -var element $elem \
	     -var nx $nx -var ny $ny -var nz $nz -var pbc $bc \
	     -log xlog.$nx.$ny.$nz.$elem.$bc > xrun.$nx.$ny.$nz.$elem.$bc  &
	done
    done
done
