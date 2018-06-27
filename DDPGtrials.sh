#!/bin/bash

cd ~/Documents/AA93
matlab -nodesktop -nosplash -r 'try; run initializeMat.m; catch; end; quit'

#forces
for value in {-600..700..10}
do
  echo $value
  cd ~/Documents/AA93/DDPG_PD_3
  python3 run_DDPG.py -f $value
  cd ~/Documents/AA93
  matlab -nodesktop -nosplash -r 'try; run phaseScript.m; catch; end; quit'
done

cd ~/Documents/AA93
matlab -nodesktop -nosplash -r 'try; run analysisData.m; catch; end; quit'
echo "z = p00 + p10*x + p01*y"
