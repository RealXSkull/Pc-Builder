# -*- coding: utf-8 -*-
"""
Created on Thu Jun 11 15:02:07 2020

@author: Adithya Kommini
"""

import numpy as np
import pandas as pd
import math

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

def sizeEx(value):
    out = value[-4:]
    
    if out[0] == ' ':
        out = int(out[1])
    else:
        out = int(out[0:2])
    return out

def totsizeEx(name,minS):
    if name.split()[0] == 'Corsair':
        xStr = name.split()[1]
        found = 0
        for idx,i in enumerate(xStr):
            if i.isdigit() and found ==0:
                if xStr[idx+1].isdigit():
                    totSize = int(xStr[idx]+xStr[idx+1])
                    found =1
                else:
                    totSize = int(xStr[idx])
                    found =1
        if found == 0:
            totSize = minS
    else:
        totSize = minS
    return totSize
                
        
    
###################################################
datapath_2 = pd.read_csv('DDR3RAM.csv')
datapath = pd.read_csv('DDR4RAM.csv')
Top100 = pd.read_csv('Top_RAM.csv')

datapath  = datapath.drop(datapath[datapath['Name']=='Memory Name'].index)
datapath_2  = datapath_2.drop(datapath[datapath['Name']=='Memory Name'].index)

#FeatureData = datapath[datapath['Price'].notna()]
FeatureData=datapath.fillna(-1)
FeatureData_2=datapath_2.fillna(-1)


col_names =  ['name','DDR3_4','size','totalSize','latency','readRate','writeRate','Price','RAMmark']
my_df  = pd.DataFrame(columns = col_names)

for i in Top100['name']:
    if len(FeatureData[FeatureData['Name']==i]) !=0:
        x = FeatureData[FeatureData['Name']==i]
        DDR3_4 = 1
    elif len(FeatureData_2[FeatureData_2['Name']==i]) !=0:
        x = FeatureData_2[FeatureData_2['Name']==i]
        DDR3_4 = 0
    Name = (x.Name).tolist()[0][:-4]

    Price = Top100[Top100['name']==i]
    Price = float(Price.Price.tolist()[0][:-1])

    size = sizeEx((x.Name).tolist()[0])
    totalSize = totsizeEx((x.Name).tolist()[0],size)
    ##################################################
    if (x.LatencyNS).tolist()[0] == -1:
        latency = 40
    else:
        latency  = float((x.LatencyNS).tolist()[0])
        
    ##################################################
    if (x.Read_Uncached_GBs).tolist()[0] == -1:
        readRate = 40
    else:
        readRate  = float((x.Read_Uncached_GBs).tolist()[0])
    
    ##################################################
    if (x.Write_GBs).tolist()[0] == -1:
        writeRate = 15
    else:
        writeRate  = float((x.Write_GBs).tolist()[0])
    
    RAMark = 20637.99167225*(1.0/latency)+0.171576582*readRate+0.282054375*writeRate
    
    rowDf = [Name,DDR3_4,size,totalSize,latency,readRate,writeRate,Price,RAMark]
    
    my_df.loc[len(my_df)] = rowDf
    
    
my_df.to_csv('Top100Cleaned_2.csv')   