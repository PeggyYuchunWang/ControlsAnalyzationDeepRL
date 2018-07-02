#!/bin/bash

#uncommment to consolidate data
cd ~/Documents/AA93/analyzeChuanyuData
matlab -nodesktop -nosplash -r 'try; run initializeMat.m; catch; end; quit'

#forces
for value in {-600..700..10}
do
  echo $value
  cd ~/Documents/AA93/DDPG_PD_3
  python3 run_DDPG.py -f $value
  cd ~/Documents/AA93/analyzeChuanyuData
  matlab -nodesktop -nosplash -r 'try; run phaseScript.m; catch; end; quit'
done

cd ~/Documents/AA93/analyzeChuanyuData
matlab -nodesktop -nosplash -r 'try; run analysisData.m; catch; end; quit'
#echo "z = p00 + p10*x + p01*y"

#uncomment to just get data
# for value in {-600..700..10}
# do
#   echo $value
#   cd ~/Documents/AA93/DDPG_PD_3
#   python3 run_DDPG.py -f $value
#   cp ~/Documents/AA93/DDPG_PD_3/2017_06_23_16.55.02/no_force/run_log.mat ~/Documents/AA93/allData
#   mv ~/Documents/AA93/allData/run_log.mat ~/Documents/AA93/allData/$value.mat
# done
#
# echo "data done!"
