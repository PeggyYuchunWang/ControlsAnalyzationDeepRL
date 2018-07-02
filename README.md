# Deep Reinforcement Learning Humanoid Balance Controls Analyzation
Deep Reinforcement Learning Control Theory Research Project at Advanced Robotics Lab in the University of Edinburgh, Scotland, UK. Thanks to advisor Dr. Zhibin (Alex) Li, mentors Chuanyu Yang and Kai Yuan. This project is an extension of Chuanyu's research on Deep Reinforcement Learning for Humanoid Robotic Control Balance.

## Getting Consolidated Data For All Forces
Run `bash DDPGtrials.sh`. Make sure you have shell/bash version 4. Raw data is stored in folder `allData`. Consolidated data stored in folder `finalData`.

## Analyzation Scripts
Analyzation scripts in folder "analyzeChuanyuData". plottingResults.m analyzes packaged data from single force simulation, analysisForces.m analyzes packaged data from all forces.

## Simulation Scripts Changes
Changed `run_ddpg.py` to take in optional argument `-f [force]`. Default force is 400N. Changed `logger.py` to log forces.
