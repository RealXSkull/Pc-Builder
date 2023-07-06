# -*- coding: utf-8 -*-
"""
Created on Wed Jun  3 16:34:30 2020

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
    
def getModelNo(ModelString):
    if ModelString[1] ==  'Atom':
        modelNo = ModelString[2]
        modelNoFull = ModelString[1]+ ' '+ ModelString[2]
    elif ModelString[1] ==  'Celeron':
        if 'GHz' in ModelString[2] or 'MHz' in ModelString[2]:
            modelNo = 0
            modelNoFull = 0
        elif ModelString[2] == 'D':
            modelNo = ModelString[3]
            modelNoFull = ModelString[1]+' '+ModelString[2]+modelNo
        elif ModelString[2] == 'M' and ('GHz' in ModelString[3] or 'MHz' in ModelString[3]):
            modelNo = 0
            modelNoFull = 0
        elif ModelString[2] == 'M' and ('GHz' not in ModelString[3] and 'MHz' not in ModelString[3]):
            modelNo = ModelString[3]
            modelNoFull = ModelString[1]+' '+ModelString[2]+' '+modelNo
        elif ModelString[2] == '@':
            modelNo = 0
            modelNoFull = 0
        else:
            modelNo = ModelString[2]
            modelNoFull = ModelString[1]+' '+ModelString[2]
    elif ModelString[1] ==  'Core':
        if ModelString[2] ==  'Duo':
            modelNo = ModelString[3]
            modelNoFull = ModelString[1]+' '+ModelString[2]+' '+modelNo
        elif 'm3' in ModelString[2] or 'm5' in ModelString[2] or 'm7' in ModelString[2]:
            modelNo = ModelString[2].upper()
            modelNoFull = ModelString[1]+' '+modelNo
        elif 'M-' in ModelString[2]:
            modelNo = ModelString[2].split('-')[1]
            modelNoFull = ModelString[1]+' '+'M-'+modelNo
        elif ModelString[2] ==  'Solo':
            modelNo = ModelString[3]
            modelNoFull = ModelString[1]+' '+ModelString[2]+' '+  modelNo
        elif ModelString[2] ==  'i5':
            modelNo = 0
            modelNoFull = 0
        else:
            modelNo = ModelString[2]
            modelNoFull = ModelString[1]+' '+ModelString[2]
    elif ModelString[1] ==  'Core2':
        if ModelString[2] == 'Extreme' or ModelString[2] == 'Duo' or ModelString[2] == 'Quad' or ModelString[2] == 'Solo':
            modelNo = ModelString[3]
            modelNoFull = ModelString[1]+' '+ModelString[2]+' '+modelNo
    elif ModelString[1] ==  'Pentium':
        if ModelString[2] == '4' or ModelString[2] == 'III' or ModelString[2] == 'M':
            modelNo = 0
            modelNoFull = 0
        elif ModelString[2] == 'D' or ModelString[2] == 'Gold' or ModelString[2] == 'Silver':
            modelNo = ModelString[3]
            modelNoFull = ModelString[1]+' '+ModelString[2]+' '+modelNo
        elif ModelString[2] == 'Extreme' or ModelString[3] == 'Edition':
            modelNo = ModelString[4]
            modelNoFull = ModelString[1]+' '+ModelString[2]
        else:
            modelNo = ModelString[2]
            modelNoFull = ModelString[1]+' '+ModelString[2]
    elif ModelString[1] ==  'Xeon' or ModelString[1] ==  'XEON':
        if 'GHz' in ModelString[2] or ModelString[2] == '@' or ModelString[2] == 'MV':
            modelNo = 0
            modelNoFull = 0
        elif ModelString[2] == 'Bronze':
            modelNo = ModelString[3]
            modelNoFull = ModelString[1]+ ' ' +ModelString[2]+' '+modelNo
        elif 'V' in ModelString[3] or 'v' in ModelString[3]:
            modelNo = ModelString[2]+ModelString[3].upper()
            modelNoFull = ModelString[1]+ ' '+modelNo
        elif ModelString[2] == 'Gold' or ModelString[2] == 'Platinum' or ModelString[2] == 'Silver':
            modelNo = ModelString[3]
            modelNoFull = ModelString[1]+ ' '+ModelString[2]+' '+modelNo
        elif ModelString[2] == 'E7-':
            modelNo = ModelString[2]+ModelString[3]
            modelNoFull = ModelString[1]+ ' '+modelNo
        else:
            modelNo = ModelString[2]
            modelNoFull = ModelString[1]+' '+ModelString[2]
    else:
        modelNo = 0
        modelNoFull = 0
    return modelNo,modelNoFull
            
############################################
datapath = pd.read_csv('dataCPUspecs.csv')
passpath = pd.read_csv('processorData.csv')
fpassMark = open('processorData.csv')
CPUdataPath = open('dataCPUspecs.csv')
line_fpass = fpassMark.readlines()
line_CPUdata = CPUdataPath.readlines()
##########################################
finalpath = 'MergedCPUspecs.csv'
Name_1 = []
Name_2 = []
Name_3 = []
intelOnly = []
intelModelNo = []
intelModelNoFull = []
count = 0
count_1 = 0
detect_one =0
result = pd.DataFrame()
with open('CPUmaster.csv','w') as outfile:
    for i in passpath['CPU_Name']:
        splitName = i.split(' ')
        if splitName[0]=='Intel':
            intelOnly.append(i)
            [x,y,z] = stripModel(splitName)
            modelExtract,modelNoFull = getModelNo(splitName)
            intelModelNo.append(modelExtract)
            intelModelNoFull.append(modelNoFull)
            index = (datapath[datapath['Processor_Number']== modelExtract].index).tolist()
            if len(index) == 1:
                detect_one += 1
                entries = line_CPUdata[index[0]+1][:-1] + ',' +line_fpass[count+1]
                outfile.write(entries)
                if detect_one == 1:
                    result = pd.concat([result,pd.concat([datapath.loc[index[0]], passpath.loc[count]])])
                else:
                    result = pd.concat([result,pd.concat([datapath.loc[index[0]], passpath.loc[count]])], axis=1)
            Name_1.append(x)
            Name_2.append(y)
            Name_3.append(z)
        count+=1
    count_1 += 1
        
uniqueStr_1 = findUnique(Name_1)
uniqueStr_2 = findUnique(Name_2)
uniqueStr_3 = findUnique(Name_3)
#result_2 = result.T
#result_2.to_csv('CPUMasterPD.csv')


    