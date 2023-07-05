# -*- coding: utf-8 -*-
"""
Created on Thu Jun  4 16:44:30 2020

@author: NTSL6
"""

import numpy as np
import pandas as pd
import math


def findUnique(listArr):
    unique = []
    for i in listArr:
        if i not in unique:
            unique.append(i)
    return unique

def resolution(value_1,value_2,uni_resol):
    if value_1 != -1:
        resolValue = uni_resol.index(value_1)
    elif value_1 == -1 and value_2 != -1:
        resolValue = uni_resol.index(value_2)
    elif value_1 == -1 and value_2 == -1:
        resolValue = 2
    return resolValue


def Mem_Bandwidth(value):
    new = value.split('/')[0]
    return float(new[:-2])

def Mem_Speed(value):
    new = value.split(' ')[0]
    return float(new)

def processEx(value,year):
    if value == -1:
        if year <= 2006:
            procOut = 90
        elif year <= 2008 and year > 2006:
            procOut = 65
        elif year <= 2011 and year > 2008:
            procOut = 40
        elif year <= 2013 and year > 2011:
            procOut = 28
        else:
            procOut = 28
    else:
        procOut = int(value[:-2])
    return procOut

def cacheEx(value):
    if value[-4:] ==  '(x2)':
        out = int(value[:-6])*2
    else:
        out = int(value[:-2])
    return out

def priceStrip(value):
    if value[0] == '$' and value[-1] == '*':
        temp = value[1:-2]
        if len(temp.split(','))>1:
            out = float(temp.split(',')[0]+temp.split(',')[1])
        else:
            out = float(temp)
    elif value[0] == '$' and value[-1] != '*':
        temp = value[1:]  
        if len(temp.split(','))>1:
            out = float(temp.split(',')[0]+temp.split(',')[1])
        else:
            out = float(temp)
    return out

def priceEx(value_1,value_2):
    if (value_1) != -1:
        resolValue = priceStrip(value_1)
    elif (value_1) == -1 and (value_2) != -1:
        resolValue = priceStrip(value_2)
    return resolValue
#############################################################################################
#############################################################################################
datapath = pd.read_csv('GPUMasterPD.csv')
FeatureData = datapath[datapath['Price1'].notna() | datapath['Release_Price'].notna()]
#FeatureData = datapath[datapath['Price1'].notna()]


### Resolution
FeatureData_2 = FeatureData[FeatureData['Best_Resolution'].notna() | FeatureData['Resolution_WxH'].notna()]
FeatureData_3 = FeatureData_2[FeatureData_2['Max_Power'].notna() | FeatureData_2['TDP'].notna()]
FeatureData_3 = FeatureData_3.fillna(-1)
#######
uni_resol = findUnique(FeatureData_3['Best_Resolution'].tolist()) + findUnique(FeatureData_3['Resolution_WxH'].tolist())
uni_resol_2 = findUnique(uni_resol)
### Memory
Memory_arr = findUnique(FeatureData_3['Memory'].tolist())
MemorySpeed_arr = findUnique(FeatureData_3['Memory_Speed'].tolist())
Memory_type = findUnique(FeatureData_3['Memory_Type'].tolist())
Memory_bus = findUnique(FeatureData_3['Memory_Bus'].tolist())
openGL_type = findUnique(FeatureData_3['Open_GL'].tolist())
directX_type = findUnique(FeatureData_3['Direct_X'].tolist())

col_names =  ['Brand','Name','year','Memory', 'Memory_speed', 'Memory_bus', 'Memory_Type','Memory_bandwidth', 'power', 'openGl', 'process', 'L2Cache', 'DirectX','Resolution','price','G2DMark', 'G3DMark']
my_df  = pd.DataFrame(columns = col_names)



for i in FeatureData_3['Name']:
    x = FeatureData_3[FeatureData_3['Name']==i]
    year = int((x.Release_Date).tolist()[0].split('-')[2])
    ########################
    if x.Memory.tolist()[0] == -1:
        Memory = Memory_arr.index('512 MB ')
    else:
        Memory = Memory_arr.index(x.Memory.tolist()[0])
    #######################
    if x.Memory_Bus.tolist()[0] == -1:
        Memory_Bus = Memory_bus.index('64 Bit ')
    else:
        Memory_Bus = Memory_bus.index(x.Memory_Bus.tolist()[0])
    #######################
    if x.Memory_Speed.tolist()[0] == -1:
        Memory_Speed = 1100
    else:
        Memory_Speed = (x.Memory_Speed.tolist()[0])
        Memory_Speed = int(Memory_Speed.split(' ')[0])
    #######################
    #######################
    if x.Memory_Type.tolist()[0] == -1:
        Memory_Type = Memory_type.index('DDR3')
    else:
        Memory_Type = Memory_type.index(x.Memory_Type.tolist()[0])
    #######################
    if x.Memory_Bandwidth.tolist()[0] == -1:
        Memory_Bandwidth = 20.8
    else:
        Memory_Bandwidth = Mem_Bandwidth(x.Memory_Bandwidth.tolist()[0])
    #######################
    Power = int((x.Max_Power).tolist()[0].split(' ')[0])
    ###############
    if x.Open_GL.tolist()[0] == -1:
        OpenGL = 0
    else:
        OpenGL = openGL_type.index(x.Open_GL.tolist()[0])
    ###############
    directX = directX_type.index(x.Direct_X.tolist()[0])
    ##############
    L2Cache = cacheEx(x.L2_Cache.tolist()[0])
    ##############
    process = processEx(x.Process.tolist()[0],year)
    ##############
    Resolution = resolution(x.Best_Resolution.tolist()[0],x.Resolution_WxH.tolist()[0],uni_resol_2)
    ##############
    Price = priceEx(x.Price1.tolist()[0],x.Release_Price.tolist()[0])
    ##############
    G2DMark = x.G2D_Mark.tolist()[0]
    G3DMark = x.G3D_Mark.tolist()[0]
    if len(G3DMark.split(','))>1:
        G3DMark = int(G3DMark.split(',')[0]+G3DMark.split(',')[1])
    else:
        G3DMark = int(G3DMark)
    ###############
    
    rowDf = [(x.Manufacturer).tolist()[0],(x.Name).tolist()[0], year,\
              Memory, Memory_Speed, Memory_Bus, Memory_Type, Memory_Bandwidth ,\
              Power, OpenGL, process, L2Cache, directX, Resolution,\
              Price, G2DMark, G3DMark]
    
    my_df.loc[len(my_df)] = rowDf
    
    
#result_2 = result.T
my_df.to_csv('GPUCleaned.csv')