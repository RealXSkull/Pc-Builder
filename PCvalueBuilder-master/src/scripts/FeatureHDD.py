# -*- coding: utf-8 -*-
"""
Created on Thu Jun  4 21:41:51 2020

@author: NTSL6
"""

import numpy as np
import pandas as pd
import math


def MarkEx(value_1):
    if ',' in value_1:
        resolValue = value_1.split(',')[0]+value_1.split(',')[1]
        resolValue = float(resolValue)
    else:
        resolValue = float(value_1)
    return resolValue

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


def dateEx(value):
    out = value.split('-')
    if out[0].isdigit():
        out = '20' + out[0]
    elif out[1].isdigit():
        out = '20' + out[1]
    return out

###################################################
datapath = pd.read_csv('masterHDDClean.csv')
FeatureData = datapath[datapath['Price'].notna()]
FeatureData=FeatureData.fillna(-1)
col_names =  ['name','year','size','HardMark','SSD_HDD','price']
my_df  = pd.DataFrame(columns = col_names)


for i in FeatureData['Name']:
    x = FeatureData[FeatureData['Name']==i]
    
    Name = (x.Name).tolist()[0]
    year = dateEx((x.Date).tolist()[0])
    size = float((x.Size).tolist()[0].split(' ')[0])
    HardMark = MarkEx((x.HardDiskMark).tolist()[0])
    price = priceStrip((x.Price).tolist()[0])
    if size < 10:
        size = size*1000
    if (x.SSD_HDD).tolist()[0] == 'SSD':
        SSD_HDD = 1
    elif (x.SSD_HDD).tolist()[0] == 'HDD':
        SSD_HDD = 0
        
    rowDf = [Name,year,size,HardMark,SSD_HDD,price]
    
    my_df.loc[len(my_df)] = rowDf
        
my_df.to_csv('hardDriveCleaned_3.csv')   