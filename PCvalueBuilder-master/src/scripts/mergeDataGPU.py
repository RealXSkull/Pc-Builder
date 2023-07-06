# -*- coding: utf-8 -*-
"""
Created on Thu Jun  4 14:17:25 2020

@author: NTSL6
"""

import numpy as np
import pandas as pd


def findUnique(listArr):
    unique = []
    for i in listArr:
        if i not in unique:
            unique.append(i)
    return unique

def stripModel(ModelString):
    if ModelString[0] == 'intel' or ModelString[0] == 'Intel':
        x =  ModelString[1]
        if len(ModelString) > 2:
            y =  ModelString[2]
        else:
            y = []
        if len(ModelString) > 3:
            z =  ModelString[3]
        else:
            z = []
        return x,y,z
    else:
        return 0,0,0

#def getModelNo(ModelString):
#    if ModelString[0] ==  'GeForce':
        

############################################
datapath = pd.read_csv('datasetsGPUspecs.csv')
passpath = pd.read_csv('cputableGPU.csv')
fpassMark = open('cputableGPU.csv')
CPUdataPath = open('datasetsGPUspecs.csv')
line_fpass = fpassMark.readlines()
line_CPUdata = CPUdataPath.readlines()
###########################################
Name_dat_1 = []
Name_dat_2 = []
Name_dat_3 = []
Name_dat_0 = []
NewNames_3Words = []

for i in datapath['Name']:
    splitName = i.split(' ')
    [x,y,z] = stripModel(splitName)
    if len(splitName)>2 and len(splitName)<4:
        NewNames_3Words.append( splitName[0]+' '+ splitName[1]+' '+splitName[2])
    elif len(splitName)<5 and len(splitName)>3:
        NewNames_3Words.append(splitName[0]+' '+ splitName[1]+' '+splitName[2]+' '+splitName[3])
    elif len(splitName)>4:
        NewNames_3Words.append(splitName[0]+' '+ splitName[1]+' '+splitName[2]+' '+splitName[3])
    Name_dat_0.append(splitName[0])
    Name_dat_1.append(x)
    Name_dat_2.append(y)
    Name_dat_3.append(z)


uniqueStr_dat_0 = findUnique(Name_dat_0)    
uniqueStr_dat_1 = findUnique(Name_dat_1)
uniqueStr_dat_2 = findUnique(Name_dat_2)
uniqueStr_dat_3 = findUnique(Name_dat_3)


Name_1 = []
Name_2 = []
Name_3 = []
Name_0 = []

dictGPU = []
foundNames = []
detect_one = 0
result = pd.DataFrame()
count = 0

for i in passpath['Videocard_Name']:
    found = 0
    splitName = i.split(' ')
    [x,y,z] = stripModel(splitName)
    Name_0.append(splitName[0])
    Name_1.append(x)
    Name_2.append(y)
    Name_3.append(z)
    if len(splitName)>2 and len(splitName)<4:
        check2Name = splitName[0]+' '+ splitName[1]+' '+splitName[2]
    elif len(splitName)<5 and len(splitName)>3:
        check3Name = splitName[0]+' '+ splitName[1]+' '+splitName[2]+' '+splitName[3]
    else:
        check2Name = ' '
        check3Name = ' '
    if len((datapath[datapath['Name'] == i].index).tolist()) != 0:
        foundNames.append(i)
        dictGPU.append((datapath[datapath['Name'] == i].index).tolist()[0])
        detect_one += 1
        found = 1
    elif len((datapath[datapath['Name'] == check2Name].index).tolist()) != 0:
        foundNames.append(i)
        dictGPU.append((datapath[datapath['Name'] == check2Name].index).tolist()[0])
        detect_one += 1
        found = 1
    elif len((datapath[datapath['Name'] == check3Name].index).tolist()) != 0:
        foundNames.append(i)
        dictGPU.append((datapath[datapath['Name'] == check3Name].index).tolist()[0])
        detect_one += 1
        found = 1
    elif i in NewNames_3Words:
        foundNames.append(i)
        dictGPU.append(NewNames_3Words.index(i))
        detect_one += 1
        found = 1
    
    if found == 1:
        if detect_one == 1:
            result = pd.concat([result,pd.concat([datapath.loc[dictGPU[-1]], passpath.loc[count]])])
        else:
            result = pd.concat([result,pd.concat([datapath.loc[dictGPU[-1]], passpath.loc[count]])], axis=1)   
    count +=1

uniqueStr_0 = findUnique(Name_0)    
uniqueStr_1 = findUnique(Name_1)
uniqueStr_2 = findUnique(Name_2)
uniqueStr_3 = findUnique(Name_3)
#result_2 = result.T
#result_2.to_csv('CPUMasterPD.csv')
