from ddpg import *
from gym import wrappers
import gc
import numpy as np
import time
from PD_controller import *
from logger import logger
from Interpolate import *
import argparse
gc.enable()

force = 400 #default

parser = argparse.ArgumentParser(description='Force changes')
parser.add_argument('-f', metavar='Force', type=int, help='an integer for force')
args = parser.parse_args()
#print(args)
if args.f != None:
	force = int(args.f)

ENV_NAME = 'HumanoidBalanceFilter-v0'#'HumanoidBalance-v0'
EPISODES = 1
STEPS = 2500000
TEST = 1

PD_frequency = 500
network_frequency = 25
sampling_skip = int(PD_frequency/network_frequency)

max_steps = int(10*network_frequency)

reward_decay=0.1#1#0.1
reward_scale=1.0#1.0/sampling_skip#scale down the reward

#force = 700
print("force", force)
impulse = 0.01
force_chest = [0, 0]  # max(0,force_chest[1]-300*1.0 / EXPLORE)]
force_pelvis = [0, 0]
force_period = [5*PD_frequency,(5+0.1)*PD_frequency]  # impulse / force * FPS
MONITOR_DIR = './results/gym_ddpg'
dir_path = '2017_06_23_16.55.02/no_force'#'2017_06_23_16.55.02/no_force'
MONITOR_DIR = dir_path
def main():
	#env = filter_env.makeFilteredEnv(gym.make(ENV_NAME))
	env = gym.make(ENV_NAME)
	#env = wrappers.Monitor(env, MONITOR_DIR, force=True)

	agent = DDPG(env)

	PD = PDController()
	step_count = 0
	agent.load_weight(dir_path)

	total_reward = 0
	force_chest = [0, 0]
	force_pelvis = [0, 0]

	logging=logger(dir_path)

	t_max = 0#timer
	t_min = 100
	t_total=[]
	prev_action = []

	hipInterpolate = JointTrajectoryInterpolate()
	kneeInterpolate = JointTrajectoryInterpolate()
	ankleInterpolate = JointTrajectoryInterpolate()
	waistInterpolate = JointTrajectoryInterpolate()



	for i in range(TEST):
		step_count = 0

		state = env.reset()
		torque = [0, 0, 0, 0]
		next_state, reward, done, _ = env.step_ex(torque, sampling_skip=1, force_pelvis=force_pelvis,
												  force_chest=force_chest)
		#action = agent.action(state)  # direct action for test
		action = PD.translatePDInput([0,0,0,0])
		for j in range(max_steps):
			prev_action = action
			state, _, done, info = env.observation(torque)
			t0 = time.time()
			action = agent.action(state)  # direct action for test
			t1 = time.time()

			total = t1 - t0
			t_total.append(total)

			reward_add = 0
			env.render()
			# hipInterpolate.cubicInterpolate(prev_action[0],0,action[0],0,1.0/float(network_frequency))
			# kneeInterpolate.cubicInterpolate(prev_action[1], 0, action[1], 0, 1.0 / float(network_frequency))
			# ankleInterpolate.cubicInterpolate(prev_action[2], 0, action[2], 0, 1.0 / float(network_frequency))
			# waistInterpolate.cubicInterpolate(prev_action[3], 0, action[3], 0, 1.0 / float(network_frequency))
			for i in range(sampling_skip):
				step_count += 1
				if ((step_count >= force_period[0]) and (step_count < force_period[1])):
					force_chest = [0, 0]
					force_pelvis = [force, 0]
				else:
					force_chest = [0, 0]
					force_pelvis = [0, 0]
				if ((step_count >= force_period[0]-250) and (step_count < force_period[1]+250)):
					text = ''#''600N applied on pelvis for 0.1s'
				else:
					text = ''

				# action = [hipInterpolate.Interpolate(1.0/PD_frequency), \
				# 	  kneeInterpolate.Interpolate(1.0 / PD_frequency), \
				# 	  ankleInterpolate.Interpolate(1.0 / PD_frequency), \
				# 	  waistInterpolate.Interpolate(1.0 / PD_frequency)]

				SP = [action[0], action[1], action[2], action[3], 0.0, 0.0, 0.0, 0.0]

				PV = [info[8], info[10], info[12], info[14], info[9], info[11], info[13], info[15]]

				#print(np.asarray(PD.translateNetworkOutput(action)))
				logging.add_run(step_count,\
								np.asarray(PD.translateNetworkOutput(action)),\
								[info[8], info[10], info[12], info[14]],\
								[info[25], info[26]],\
								[info[18], info[19]],\
								[info[16], info[17]],\
								[info[0],info[1],info[2],info[3]],\
								[info[27],info[28]],\
								[info[29],info[30]], \
								[info[31], info[32]],\
								info[33],\
								info[34],info[35],info[36],info[37], \
								force
								)
				torque = PD.controller(SP, PV)
				torque = np.clip(torque, -1, 1)
				next_state, reward, done, _ = env.step_ex(torque, sampling_skip=1,
														  force_pelvis=force_pelvis,
														  force_chest=force_chest,
														  text=text)
				reward_add = reward + reward_decay * reward_add
				_, _, done, info = env.observation(torque)

			reward = reward_add*reward_scale  # / sampling_skip
			total_reward += reward
			if done:
				PD.reset()
				break
	ave_reward = total_reward / TEST
	logging.save_run()
	print(' Evaluation Average Reward:' + str(ave_reward))
	t_min=min(t_total)
	t_max=max(t_total)
	t_avg=sum(t_total)/float(len(t_total))
	print(t_min,t_max,t_avg)
	#env.monitor.close()

if __name__ == '__main__':
	main()
