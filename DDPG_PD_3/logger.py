from collections import deque
import numpy as np
import random
import scipy.io

class logger(object):
    def __init__(self, dir_path):
        self.filename1 = (dir_path + '/train_log' + '.mat')
        self.filename2 = (dir_path + '/run_log' + '.mat')

        self.episode = []
        self.step =[]
        self.reward = []

        self.joint_tar = []
        self.joint_msr = []

        self.COM=[]
        self.COM_REF=[]
        self.COM_vel=[]
        self.torque =[]
        self.Feet_pos=[]
        self.Feet_vel=[]
        self.COM_REF_Filter=[]

        self.pelvis_linear_velocity=[]
        self.chest_linear_velocity=[]
        self.pelvis_height=[]
        self.chest_position=[]
        self.thigh_position=[]
        self.shank_position=[]
        self.foot_position=[]
        self.pelvis_angle=[]
        self.pelvis_angular_velocity=[]
        self.chest_angle=[]
        self.chest_angular_velocity=[]
        self.joint_angle=[]
        self.joint_speed_normalize=[]
        self.ground_contact=[]

        self.chest_angular_rate=[]
        self.pelvis_angular_rate=[]
        self.foot_angular_rate=[]
        self.foot_angle=[]

        self.force = []


    def add_train(self, episode, step, reward):
        self.episode.append(episode)
        self.step.append(step)
        self.reward.append(reward)

    def add_run(self, step, joint_tar, joint_msr, COM, COM_vel, COM_REF, torque, Feet_pos, Feet_vel, COM_REF_Filter, network_input,\
                chest_ang_rate,pelvis_ang_rate,foot_ang_rate,foot_angle, force):
        self.step.append(step)
        self.joint_tar.append(joint_tar)
        self.joint_msr.append(joint_msr)
        self.COM.append(COM)
        self.COM_vel.append(COM_vel)
        self.COM_REF.append(COM_REF)
        self.torque.append(torque)
        self.Feet_pos.append(Feet_pos)
        self.Feet_vel.append(Feet_vel)
        self.COM_REF_Filter.append(COM_REF_Filter)

        self.pelvis_linear_velocity.append([network_input[0],network_input[1]])
        self.chest_linear_velocity.append([network_input[2],network_input[3]])
        self.pelvis_height.append(network_input[4])
        self.chest_position.append([network_input[5],network_input[6]])
        self.thigh_position.append([network_input[7],network_input[8]])
        self.shank_position.append([network_input[9],network_input[10]])
        self.foot_position.append([network_input[11],network_input[12]])
        self.pelvis_angle.append(network_input[13])
        self.pelvis_angular_velocity.append(network_input[14])
        self.chest_angle.append(network_input[15])
        self.chest_angular_velocity.append(network_input[16])
        self.joint_angle.append([network_input[17],network_input[19],network_input[21],network_input[24]])
        self.joint_speed_normalize.append([network_input[18],network_input[20],network_input[22],network_input[25]])
        self.ground_contact.append(network_input[23])

        self.chest_angular_rate.append(chest_ang_rate)
        self.pelvis_angular_rate.append(pelvis_ang_rate)
        self.foot_angular_rate.append(foot_ang_rate)
        self.foot_angle.append(foot_angle)

        self.force.append(force)

    def save_train(self):
        scipy.io.savemat(self.filename1,
                         mdict={'episode': np.asarray(self.episode),\
                                'step': np.asarray(self.step),\
                                'reward': np.asarray(self.reward)})

    def save_run(self):
        scipy.io.savemat(self.filename2,
                         mdict={'joint_tar': np.asarray(self.joint_tar),\
                                'step': np.asarray(self.step),\
                                'joint_msr': np.asarray(self.joint_msr),\
                                'COM': np.asarray(self.COM),\
                                'COM_vel': np.asarray(self.COM_vel),\
                                'COM_REF': np.asarray(self.COM_REF),\
                                'torque': np.asarray(self.torque), \
                                'Feet_pos': np.asarray(self.Feet_pos), \
                                'Feet_vel': np.asarray(self.Feet_vel),\
                                'COM_REF_Filter': np.asarray(self.COM_REF_Filter),\

                                'pelvis_linear_velocity': np.asarray(self.pelvis_linear_velocity),\
                                'chest_linear_velocity': np.asarray(self.chest_linear_velocity),\
                                'pelvis_height': np.asarray(self.pelvis_height),\
                                'chest_position': np.asarray(self.chest_position),\
                                'thigh_position': np.asarray(self.thigh_position),\
                                'shank_position': np.asarray(self.shank_position),\
                                'foot_position': np.asarray(self.foot_position),\
                                'pelvis_angle': np.asarray(self.pelvis_angle),\
                                'pelvis_angular_velocity': np.asarray(self.pelvis_angular_velocity),\
                                'chest_angle': np.asarray(self.chest_angle),\
                                'chest_angular_velocity': np.asarray(self.chest_angular_velocity),\
                                'joint_angle': np.asarray(self.joint_angle),\
                                'joint_speed_normalize': np.asarray(self.joint_speed_normalize),\
                                'ground_contact': np.asarray(self.ground_contact),\

                                'chest_angular_rate': np.asarray(self.chest_angular_rate), \
                                'pelvis_angular_rate': np.asarray(self.pelvis_angular_rate), \
                                'foot_angular_rate': np.asarray(self.foot_angular_rate), \
                                'foot_angle': np.asarray(self.foot_angle), \
                                'force': np.asarray(self.force)
                                })
