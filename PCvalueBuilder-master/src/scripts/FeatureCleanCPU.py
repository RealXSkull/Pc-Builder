# -*- coding: utf-8 -*-
"""
Created on Thu Jun  4 20:04:35 2020

@author: NTSL6
"""
import numpy as np
import pandas as pd
import math



def priceEx(value_1):
    if len(value_1.split('-')) >1:
        resolValue = value_1.split('-')[0]
        resolValue = float(resolValue[1:])
    else:
        if ',' in value_1[1:]:
            resolValue = value_1[1:].split(',')[0]+value_1[1:].split(',')[1]
            resolValue = float(resolValue)
        else:
            resolValue = float(value_1[1:])
    return resolValue

def MemTypeEx(value):
    if 'DDR4' in value:
        out = 'DDR4'
    elif 'DDR3' in value and 'DDR4' not in value:
        out = 'DDR3'
    elif 'DDR2' in value and 'DDR3' not in value and 'DDR4' not in value:
        out = 'DDR2'
    return out

def yearEx(value):
    out = value[-2:]
    out = '20'+out
    out = int(out)
    return out


def processEx(value,year):
    if value == -1:
        if year <= 2006:
            procOut = 90
        elif year >= 2015:
            procOut = 14
        elif year <= 2013 and year > 2011:
            procOut = 32
        elif year < 2015 and year > 2013:
            procOut = 22
        elif year <= 2008 and year > 2006:
            procOut = 65
        elif year <= 2011 and year > 2008:
            procOut = 45
        else:
            procOut = 22
    else:
        procOut = int(value.split(' ')[0])
    return procOut

#############################################################################################
datapath = pd.read_csv('Clean/CPUMasterPDIntel.csv')
FeatureData = datapath[datapath['Price'].notna()]

FeatureData=FeatureData.fillna(-1)

#col_names =  ['Brand','Name','year','Memory', 'Memory_speed', 'Memory_bus', 'Memory_Type','Memory_bandwidth', 'power', 'openGl', 'process', 'L2Cache', 'DirectX','Resolution','price','G2DMark', 'G3DMark']
col_names =  ['name','year','process','noCores','noThreads','baseFreq','CacheVal','maxMem','MemType', 'MemType_class','MemChannels', 'PCI_express', 'HyperTh', 'virtualTh','intel64', 'TDP', 'price', 'CPUMark', 'ThreadMark']
my_df  = pd.DataFrame(columns = col_names)

for i in FeatureData['Processor_Number']:
    x = FeatureData[FeatureData['Processor_Number']==i]
    
    name = 'Intel' +' '+ (x.Processor_Number).tolist()[0]

    price = priceEx((x.Price).tolist()[0])
    noCores = int((x.nb_of_Cores).tolist()[0])
    TDP = (x.TDP).tolist()[0]
    CPUMark = float((x.CPU_Mark).tolist()[0])
    ThreadMark = float((x.Thread_Mark).tolist()[0])
    #########################
    if (x.Launch_Date).tolist()[0] == -1:
        year = 2015
    else:
        year = yearEx((x.Launch_Date).tolist()[0])
    #########################
    process = processEx((x.Lithography).tolist()[0],year)
    ########################
    if (x.nb_of_Threads).tolist()[0] == -1:
        noThreads = 1
    else:
        noThreads = int((x.nb_of_Threads).tolist()[0])
    ##############################
    baseFreq = float((x.Base_Frequency).tolist()[0].split(' ')[0])
    ##############################
    if (x.Cache).tolist()[0] == -1:
        CacheVal = 1
    else:
        CacheVal = float((x.Cache).tolist()[0].split(' ')[0])
    ################################
    if (x.Max_Memory).tolist()[0] == -1:
        maxMem = 1
    else:
        maxMem = float((x.Max_Memory).tolist()[0].split(' ')[0])
    ################################
    if (x.Memory_Types).tolist()[0] == -1:
        MemType = 'DDR3'
    else:
        MemType = MemTypeEx((x.Memory_Types).tolist()[0])
    ################################
    if MemType == 'DDR2':
        MemType_class = 0
    elif MemType == 'DDR3':
        MemType_class = 1
    elif MemType == 'DDR4':
        MemType_class = 2   
    ################################
    if (x.Max_Mem_Channels).tolist()[0] == -1:
        MemChannels = 1
    else:
        MemChannels = int((x.Max_Mem_Channels).tolist()[0])
    ################################
    if (x.Max_PCI_ExpLanes).tolist()[0] == -1:
        PCI_express = 1
    else:
        PCI_express = int((x.Max_PCI_ExpLanes).tolist()[0])
    ################################
    if (x.HyperThreading).tolist()[0] == -1:
        HyperTh = 0
    else:
        if (x.HyperThreading).tolist()[0] == 'Yes':
            HyperTh = 1
        else:
            HyperTh = 0
    ################################
    if (x.Virtualization_Tech).tolist()[0] == -1:
        virtualTh = 0
    else:
        if (x.Virtualization_Tech).tolist()[0] == 'Yes':
            virtualTh = 1
        else:
            virtualTh = 0
    ################################
    if (x.Intel_64).tolist()[0] == -1:
        intel64 = 0
    else:
        if (x.Intel_64).tolist()[0] == 'Yes':
            intel64 = 1
        else:
            intel64 = 0
    ################################
    rowDf = [name,year,process,noCores,noThreads,baseFreq,CacheVal,maxMem,\
              MemType, MemType_class, MemChannels, PCI_express, HyperTh, virtualTh,\
              intel64, TDP, price, CPUMark, ThreadMark]
    
    my_df.loc[len(my_df)] = rowDf
    
my_df.to_csv('CPUCleanedIntel_display.csv')