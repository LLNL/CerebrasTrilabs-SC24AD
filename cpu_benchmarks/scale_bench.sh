# Copyright 2024 Lawrence Livermore National Security, LLC
# and other contributors. See the top-level COPYRIGHT file
# for details.
#
# SPDX-License-Identifier: MIT

lmp="./lmp_mpi_quartz"

#for nnodes in 36 32 25 16 8 ; do
#for nnodes in 9 8 6 4 3 2 1 ;  do
#for nnodes in 4 3 2 1 6 8 9 ;  do
for nnodes in 8 ; do
    ntasks=$((nnodes*36))
    # Ta, W
    if ( true ) ; then
    #for shapes in "192 261 8" "256 261 6" ; do
    for shapes in "256 261 6" ; do
	    	
	nx=`echo $shapes | awk '{print $1}'`
	ny=`echo $shapes | awk '{print $2}'`
	nz=`echo $shapes | awk '{print $3}'`
	for elem in Ta W ; do
	    echo "element=$elem, nx=$nx, ny=$ny, nz=$nz, nnodes=$nnodes"
	    for bc in 0 ; do
		srun -N$nnodes -n$ntasks -t199  $lmp -in in.bench \
		     -var element $elem \
		     -var nx $nx -var ny $ny -var nz $nz -var pbc $bc \
		     -log nbench.log.$nx.$ny.$nz.$elem.$bc.p$nnodes \
		     > nbench.run.$nx.$ny.$nz.$elem.$bc.p$nnodes  &
	    done
	done
    done
    fi
    # Cu
    if ( true ) ; then
    for shapes in "174 192 6" ; do
	nx=`echo $shapes | awk '{print $1}'`
	ny=`echo $shapes | awk '{print $2}'`
	nz=`echo $shapes | awk '{print $3}'`
	
	for elem in Cu ; do
	    echo "element=$elem nx=$nx, ny=$ny, nz=$nz, nnodes=$nnodes"
	    for bc in 0 ; do
		srun -N$nnodes -n$ntasks -t199 $lmp -in in.bench \
		     -var element $elem \
		     -var nx $nx -var ny $ny -var nz $nz -var pbc $bc \
		     -log nbench.log.$nx.$ny.$nz.$elem.$bc.p$nnodes \
		     > nbench.run.$nx.$ny.$nz.$elem.$bc.p$nnodes  &
	    done
	done
    done
    fi

    echo "Submitted all jobs for nnodes=$nnodes"
    sleep 5
done
