

import streamlit as st
import numpy as np
import pandas as pd
from scipy.stats import norm
import webbrowser
import math


# Import database
# RAM
pdDDR4 = pd.read_csv('C:\\Users\\zawat\\OneDrive\\Desktop\\PCvalueBuilder-master\\src\\data\\RAM_DDR43_Cleaned.csv')
# Harddrive
HDDSDD = pd.read_csv('C:\\Users\\zawat\\OneDrive\\Desktop\\PCvalueBuilder-master\\src\\data\\HDDSSDclean.csv') 
# CPU
CPUIntel = pd.read_csv('C:\\Users\\zawat\\OneDrive\\Desktop\\PCvalueBuilder-master\\src\\data\\CPUCleanedprice.csv')
CPUIntel_price = pd.read_csv('C:\\Users\\zawat\\OneDrive\\Desktop\\PCvalueBuilder-master\\src\\data\\CPUCleanedprice.csv')
# GPU
GPU = pd.read_csv('C:\\Users\\zawat\\OneDrive\\Desktop\\PCvalueBuilder-master\\src\\data\\GPUprice_G3Dmark.csv')
GPU_price = pd.read_csv('C:\\Users\\zawat\\OneDrive\\Desktop\\PCvalueBuilder-master\\src\\data\\GPUprice_G3Dmark.csv')
coeffMark = pd.read_csv('C:\\Users\\zawat\\OneDrive\\Desktop\\PCvalueBuilder-master\\src\\data\\Coefficients.csv')
# Title and description of the streamlit app
st.title('PCvalueBuilder')
st.subheader('Predicting the performance and value of replacement PC parts')
st.markdown('This tool recommends a replacement part for your PC. Please select three parts among processor, GPU, RAM and hard drive for the tool to recommend the available choices for the fourth part.')
##################################################################
# Part 1 display select box
part_avail = ['Processor','GPU','Hard Drive','RAM']
part_1 = st.selectbox('Select Part', ['Processor','GPU','Hard Drive','RAM'])

# Display the processor options
if part_1 == 'Processor':
    options_1 = st.selectbox('Part 1: Processor', CPUIntel['name'])
    CPU_Mark = CPUIntel[CPUIntel['name'] == options_1].CPUMark.tolist()[0]
    CPU_year = CPUIntel[CPUIntel['name'] == options_1].year.tolist()[0]
    CPU_Mark_p = CPUIntel_price[CPUIntel_price['name'] == options_1].CPUMark.tolist()[0]/CPUIntel_price[CPUIntel_price['name'] == options_1].price.tolist()[0]
# Display the GPU options
elif part_1 == 'GPU':
    options_1 = st.selectbox('Part 1: GPU', GPU['name'])
    GPU_Mark = GPU[GPU['name'] == options_1].G3DMark.tolist()[0]
    GPU_Mark_p = GPU_price[GPU_price['name'] == options_1].G3DMark.tolist()[0]/GPU_price[GPU_price['name'] == options_1].price.tolist()[0]
    GPU_year = GPU[GPU['name'] == options_1].year.tolist()[0]
# Display the Harddrive options
elif part_1 == 'Hard Drive':
    options_1 = st.selectbox('Part 1: Hard Drive', HDDSDD['name'])
    Hard_Mark = HDDSDD[HDDSDD['name'] == options_1].HardMark.tolist()[0]
    Hard_Mark_year = HDDSDD[HDDSDD['name'] == options_1].year.tolist()[0]
    Hard_Mark_p = HDDSDD[HDDSDD['name'] == options_1].HardMark.tolist()[0]/HDDSDD[HDDSDD['name'] == options_1].price.tolist()[0]
# Display the RAM options
elif part_1 == 'RAM':
    options_1 = st.selectbox('Part 1: RAM', pdDDR4['name'])
    RAM_Mark = pdDDR4[pdDDR4['name'] == options_1].RAMmark.tolist()[0]
    RAM_Mark_p = pdDDR4[pdDDR4['name'] == options_1].RAMmark.tolist()[0]/pdDDR4[pdDDR4['name'] == options_1].Price.tolist()[0]

##################################################################
# Part 2 display select box
part2_specs = ['GPU','Hard Drive','RAM','Processor']
part_2 = st.selectbox('Select Part 2', part2_specs)

# Display the processor options
if part_2 == 'Processor':
    options_2 = st.selectbox('Part 2: Processor', CPUIntel['name'])
    CPU_Mark = CPUIntel[CPUIntel['name'] == options_2].CPUMark.tolist()[0]
    CPU_year = CPUIntel[CPUIntel['name'] == options_2].year.tolist()[0]
    CPU_Mark_p = CPUIntel_price[CPUIntel_price['name'] == options_2].CPUMark.tolist()[0]/CPUIntel_price[CPUIntel_price['name'] == options_2].price.tolist()[0]
# Display the GPU options
elif part_2 == 'GPU':
    options_2 = st.selectbox('Part 2: GPU', GPU['name'])
    GPU_Mark = GPU[GPU['name'] == options_2].G3DMark.tolist()[0]
    GPU_Mark_p = GPU_price[GPU_price['name'] == options_2].G3DMark.tolist()[0]/GPU_price[GPU_price['name'] == options_2].price.tolist()[0]
    GPU_year = GPU[GPU['name'] == options_2].year.tolist()[0]
# Display the Harddrive options
elif part_2 == 'Hard Drive':
    options_2 = st.selectbox('Part 2: Hard Drive', HDDSDD['name'])
    Hard_Mark = HDDSDD[HDDSDD['name'] == options_2].HardMark.tolist()[0]
    Hard_Mark_year = HDDSDD[HDDSDD['name'] == options_2].year.tolist()[0]
    Hard_Mark_p = HDDSDD[HDDSDD['name'] == options_2].HardMark.tolist()[0]/HDDSDD[HDDSDD['name'] == options_2].price.tolist()[0]
# Display the RAM options
elif part_2 == 'RAM':
    options_2 = st.selectbox('Part 2: RAM', pdDDR4['name'])
    RAM_Mark = pdDDR4[pdDDR4['name'] == options_2].RAMmark.tolist()[0]
    RAM_Mark_p = pdDDR4[pdDDR4['name'] == options_2].RAMmark.tolist()[0]/pdDDR4[pdDDR4['name'] == options_2].Price.tolist()[0]

##################################################################
# Part 2 display select box
part3_specs = ['RAM','Processor','GPU','Hard Drive',]
part_3 = st.selectbox('Select Part 3', part3_specs)
# Display the processor options
if part_3 == 'Processor':
    options_3 = st.selectbox('Part 3: Processor', CPUIntel['name'])
    CPU_Mark = CPUIntel[CPUIntel['name'] == options_3].CPUMark.tolist()[0]
    CPU_year = CPUIntel[CPUIntel['name'] == options_3].year.tolist()[0]
    CPU_Mark_p = CPUIntel_price[CPUIntel_price['name'] == options_3].CPUMark.tolist()[0]/CPUIntel_price[CPUIntel_price['name'] == options_3].price.tolist()[0]
# Display the GPU options
elif part_3 == 'GPU':
    options_3 = st.selectbox('Part 3: GPU', GPU['name'])
    GPU_Mark = GPU[GPU['name'] == options_3].G3DMark.tolist()[0]
    GPU_Mark_p = GPU_price[GPU_price['name'] == options_3].G3DMark.tolist()[0]/GPU_price[GPU_price['name'] == options_3].price.tolist()[0]
    GPU_year = GPU[GPU['name'] == options_3].year.tolist()[0]
# Display the Harddrive options
elif part_3 == 'Hard Drive':
    options_3 = st.selectbox('Part 3: Hard Drive', HDDSDD['name'])
    Hard_Mark = HDDSDD[HDDSDD['name'] == options_3].HardMark.tolist()[0]
    Hard_Mark_year = HDDSDD[HDDSDD['name'] == options_3].year.tolist()[0]
    Hard_Mark_p = HDDSDD[HDDSDD['name'] == options_3].HardMark.tolist()[0]/HDDSDD[HDDSDD['name'] == options_3].price.tolist()[0]
# Display the RAM options
elif part_3 == 'RAM':
    options_3 = st.selectbox('Part 3: RAM', pdDDR4['name'])
    RAM_Mark = pdDDR4[pdDDR4['name'] == options_3].RAMmark.tolist()[0]
    RAM_Mark_p = pdDDR4[pdDDR4['name'] == options_3].RAMmark.tolist()[0]/pdDDR4[pdDDR4['name'] == options_3].Price.tolist()[0]

##################################################################
# Identify the part to be suggested
parts_select = [part_1,part_2,part_3]
part_options = []
for i in part_avail:
    if i not in parts_select:
        part_options.append(i)

# Display options for recommendations
st.write("Recommending the available options for", part_options[0],":")
st.markdown('Enter your preference between value and performance. If the preference is value, then the tool recommends the parts that provide best performance for the price.') 
# options_pref = st.selectbox('Preference', ['Value','Performance'])
options_pref ='Performance'

if len(part_options) == 1:
    # Suggesting processor options
    if part_options[0] == 'Processor':
        otherMark = (GPU_Mark*coeffMark.GPU_coeff[0])+(RAM_Mark*coeffMark.RAM_coeff[0])+(Hard_Mark*coeffMark.HDD_coeff[0])
         # Idnetifying the year 
        if GPU_year >= 2018:
            maxyear = 2020
            minyear = 2016
        elif GPU_year <= 2015:
            maxyear = 2018
            minyear = 2015
        else:
            maxyear = GPU_year+2
            minyear = GPU_year-2
        # CPU data extract
        CPU_data = CPUIntel[(CPUIntel['year']<=maxyear) & (CPUIntel['year']>=minyear)]
        # Calculating the normal distribution
        mu, std = norm.fit(np.array(CPU_data.CPUMark.tolist()))
        # Getting the price data
        priceSort = np.asarray((CPU_data.price.tolist()))
        min_price = int(np.sort(priceSort)[5])
        # get the budget data
        Budprice = st.number_input('Enter your budget: (By default shows best performing processors)',min_value = min_price,max_value = int(max(CPU_data.price.tolist()))+100)
        # Identify the processors based on budget
        if Budprice == min_price:
            CPU_data = CPU_data[(CPU_data['price'] < int(max(GPU.price.tolist()))+100)]
        else:
            CPU_data = CPU_data[(CPU_data['price'] < Budprice)]
        # Identify the processors based on budget
        if options_pref == 'Performance':
            CPU_Mark = np.array(CPU_data.CPUMark.tolist())*coeffMark.CPU_coeff[0]
            #mu, std = norm.fit(np.array(CPU_data.CPUMark.tolist()))
            sysScore = ((otherMark+CPU_Mark)/5.0)
            indices = np.argsort(sysScore)
            
            result = pd.DataFrame()
            for i in range(5):
                if i == 0:
                    result = pd.concat([result,(pd.Series([CPU_data.iloc[indices[-(i+1)]]['name'], int(sysScore[indices[-(i+1)]]), int((sysScore[indices[-(i+1)]]-mu)*10/np.array(CPU_data.iloc[indices[-(i+1)]]['price'])),CPU_data.iloc[indices[-(i+1)]]['price']]))],ignore_index=True)
                else:
                    result = pd.concat([result,(pd.Series([CPU_data.iloc[indices[-(i+1)]]['name'], int(sysScore[indices[-(i+1)]]), int((sysScore[indices[-(i+1)]]-mu)*10/np.array(CPU_data.iloc[indices[-(i+1)]]['price'])),CPU_data.iloc[indices[-(i+1)]]['price']]))], axis=1,ignore_index=True)
            result.index = [part_options[0] + " name", "PC Performance score", "Value Score(/$)", "Price"]
            result= result.T
            result.index = ["1","2","3","4","5"]
            st.write("Showing", part_options[0], 'options with best',options_pref )
            st.table(result)

        elif options_pref == 'Value':

            CPU_Mark = np.array(CPU_data.CPUMark.tolist())*coeffMark.CPU_coeff[0]
            sysScore = ((otherMark+CPU_Mark)/5.0)
            CPU_data = CPU_data[CPU_data['CPUMark'] >=mu]
            CPU_Mark_p = np.array(CPU_data.CPUMark.tolist())*coeffMark.CPU_coeff[0]
            sysScore_p = ((otherMark+CPU_Mark_p)/5.0)
            valueScore = (sysScore_p-mu)*10/np.array(CPU_data.price.tolist())
            indices = np.argsort(valueScore)
            result = pd.DataFrame()
            for i in range(5):
                if i == 0:
                    result = pd.concat([result,(pd.Series([CPU_data.iloc[indices[-(i+1)]]['name'], int(sysScore[indices[-(i+1)]]), int(valueScore[indices[-(i+1)]]), CPU_data.iloc[indices[-(i+1)]]['price']]))],ignore_index=True)
                else:
                    result = pd.concat([result,(pd.Series([CPU_data.iloc[indices[-(i+1)]]['name'], int(sysScore[indices[-(i+1)]]), int(valueScore[indices[-(i+1)]]), CPU_data.iloc[indices[-(i+1)]]['price']]))], axis=1,ignore_index=True)
            result.index = [part_options[0] + " name", "Performance score", "Value Score(/$)", "Price"]
            result= result.T
            result.index = ["1","2","3","4","5"]
            st.write("Showing", part_options[0], 'options with best',options_pref )
            st.table(result)

    
    elif part_options[0] == 'GPU':
        if CPU_year >= 2018:
            maxyear = 2020
            minyear = 2016
        elif CPU_year <= 2015:
            maxyear = 2018
            minyear = 2015
        else:
            maxyear = CPU_year+2
            minyear = CPU_year-2
        
        GPU_data = GPU[(GPU['year']<=maxyear) & (GPU['year']>=minyear)]
        mu, std = norm.fit(np.array(GPU_data.G3DMark.tolist()))
        priceSort = np.asarray((GPU_data.price.tolist()))
        min_price = int(np.sort(priceSort)[5])
        Budprice = st.number_input('Enter your budget: (By default shows the best available GPU options)',min_value = min_price,max_value = int(max(GPU.price.tolist()))+100)
        if Budprice == min_price:
            GPU_data = GPU_data[(GPU_data['price'] < int(max(GPU.price.tolist()))+100)]
        else:
            GPU_data = GPU_data[(GPU_data['price'] < Budprice)]
        if options_pref == 'Performance':
            otherMark = (RAM_Mark*coeffMark.RAM_coeff[0])+(Hard_Mark*coeffMark.HDD_coeff[0])+(CPU_Mark*coeffMark.CPU_coeff[0])
            GPU_Mark = np.array(GPU_data.G3DMark.tolist())*coeffMark.GPU_coeff[0]
            sysScore = ((otherMark+GPU_Mark)/5.0)
            indices = np.argsort(sysScore)
            
            
            result = pd.DataFrame()
            if GPU_data.shape[0]>10:
                for i in range(5):
                    if i == 0:
                        #result = pd.concat([result,(pd.Series([GPU_data.iloc[indices[-(i+1)]]['name'], int(sysScore[indices[-(i+1)]]), int((GPU_data.iloc[indices[-(i+1)]]['G3DMark']-mu-std)/np.array(GPU_data.iloc[indices[-(i+1)]]['price'])),GPU_data.iloc[indices[-(i+1)]]['price']]))],ignore_index=True)
                        result = pd.concat([result,(pd.Series([GPU_data.iloc[indices[-(i+1)]]['name'], int(sysScore[indices[-(i+1)]]), int((sysScore[indices[-(i+1)]]-mu)*10/np.array(GPU_data.iloc[indices[-(i+1)]]['price'])),GPU_data.iloc[indices[-(i+1)]]['price']]))],ignore_index=True)
                    else:
                        #result = pd.concat([result,(pd.Series([GPU_data.iloc[indices[-(i+1)]]['name'], int(sysScore[indices[-(i+1)]]), int((GPU_data.iloc[indices[-(i+1)]]['G3DMark']-mu-std)/np.array(GPU.iloc[indices[-(i+1)]]['price'])),GPU_data.iloc[indices[-(i+1)]]['price']]))], axis=1,ignore_index=True)
                        result = pd.concat([result,(pd.Series([GPU_data.iloc[indices[-(i+1)]]['name'], int(sysScore[indices[-(i+1)]]), int((sysScore[indices[-(i+1)]]-mu)*10/np.array(GPU.iloc[indices[-(i+1)]]['price'])),GPU_data.iloc[indices[-(i+1)]]['price']]))], axis=1,ignore_index=True)
                result.index = [part_options[0] +" name", "PC Performance score", "Value Score(/$)", "Price"]
                result= result.T
                result.index = ["1","2","3","4","5"]
                st.write("Showing", part_options[0], 'options with best',options_pref )
                st.table(result)
            else:
                st.subheader("Please increase your budget")
            
        elif options_pref == 'Value':
            otherMark = (RAM_Mark*coeffMark.RAM_coeff[0])+(Hard_Mark*coeffMark.HDD_coeff[0])+(CPU_Mark*coeffMark.CPU_coeff[0])
            GPU_Mark = np.array(GPU_data.G3DMark.tolist())*coeffMark.GPU_coeff[0]
            sysScore = ((otherMark+GPU_Mark)/5.0)
            GPU_data = GPU_data[(GPU_data['G3DMark'] >= mu)]
            GPU_Mark_p = (np.array(GPU_data.G3DMark.tolist()))*coeffMark.GPU_coeff[0]
            sysScore_p = ((otherMark+GPU_Mark_p)/5.0)
            valueScore = (sysScore_p-mu)*10/np.array(GPU_data.price.tolist())
            indices = np.argsort(valueScore)
            
            result = pd.DataFrame()
            if GPU_data.shape[0]>10:
                for i in range(5):
                    if i == 0:
                        result = pd.concat([result,(pd.Series([GPU_data.iloc[indices[-(i+1)]]['name'], int(sysScore[indices[-(i+1)]]), int(valueScore[indices[-(i+1)]]), GPU_data.iloc[indices[-(i+1)]]['price']]))],ignore_index=True)
                    else:
                        result = pd.concat([result,(pd.Series([GPU_data.iloc[indices[-(i+1)]]['name'], int(sysScore[indices[-(i+1)]]), int(valueScore[indices[-(i+1)]]), GPU_data.iloc[indices[-(i+1)]]['price']]))], axis=1,ignore_index=True)
                result.index = [part_options[0] + " name", "PC Performance score", "Value Score(/$)", "Price"]
                result= result.T
                result.index = ["1","2","3","4","5"]
                st.write("Showing", part_options[0], 'options with best',options_pref )
                st.table(result)
            else:
                st.subheader("Please increase your budget")
            
            
    elif part_options[0] == 'Hard Drive':
        if CPU_year >= 2018:
            maxyear = 2020
            minyear = 2016
        elif CPU_year <= 2015:
            maxyear = 2018
            minyear = 2015
        else:
            maxyear = CPU_year+2
            minyear = CPU_year-2
            
        otherMark = (RAM_Mark*coeffMark.RAM_coeff[0])+(GPU_Mark*coeffMark.GPU_coeff[0])+(CPU_Mark*coeffMark.CPU_coeff[0])
        HDD_data = HDDSDD[(HDDSDD['year']<=maxyear) & (HDDSDD['year']>=minyear)]
        mu, std = norm.fit(np.array(HDD_data.HardMark.tolist()))
        if options_pref == 'Performance':
            HDDSize = st.number_input('Enter the minimum hard drive size preferred in GB (<=2000): (By default shows best performing hard drive options)',min_value = 128,max_value = 2000,key = 1253)
            HDDSize = math.log2(HDDSize)
            HDD_data = HDD_data[(HDD_data['size'] >= pow(2,math.floor(HDDSize)))]
            priceSort = np.asarray((HDD_data.price.tolist()))
            min_price = int(np.sort(priceSort)[5])
            Budprice = st.number_input('Enter your budget in $: (By default shows best performing hard drive options)',min_value = min_price,max_value = int(max(HDD_data.price.tolist()))+100)
            if Budprice == min_price:
                HDD_data = HDD_data[(HDD_data['price'] < int(max(HDD_data.price.tolist()))+100)]
            else:
                HDD_data = HDD_data[(HDD_data['price'] < Budprice)]
            Hard_Mark = np.array(HDD_data.HardMark.tolist())*coeffMark.HDD_coeff[0]
            sysScore = ((otherMark+Hard_Mark)/5.0)
            
            indices = np.argsort(sysScore)
            
            result = pd.DataFrame()
            if HDD_data.shape[0]>10:
                for i in range(5):
                    if i == 0:
                        sizeHDD = float(HDD_data.iloc[indices[-(i+1)]]['size'])
                        if sizeHDD > 1000:
                            sizeHDD = str(sizeHDD/1000) + ' TB'
                        else:
                            sizeHDD = str(sizeHDD) + ' GB'
                        result = pd.concat([result,(pd.Series([HDD_data.iloc[indices[-(i+1)]]['name'],  sizeHDD ,int(sysScore[indices[-(i+1)]]), int((sysScore[indices[-(i+1)]]-mu)*10/np.array(HDD_data.iloc[indices[-(i+1)]]['price'])),HDD_data.iloc[indices[-(i+1)]]['price']]))],ignore_index=True)
                    else:
                        sizeHDD = float(HDD_data.iloc[indices[-(i+1)]]['size'])
                        if sizeHDD > 1000:
                            sizeHDD = str(sizeHDD/1000) + ' TB'
                        else:
                            sizeHDD = str(sizeHDD) + ' GB'
                        result = pd.concat([result,(pd.Series([HDD_data.iloc[indices[-(i+1)]]['name'],  sizeHDD ,int(sysScore[indices[-(i+1)]]), int((sysScore[indices[-(i+1)]]-mu)*10/np.array(HDD_data.iloc[indices[-(i+1)]]['price'])),HDD_data.iloc[indices[-(i+1)]]['price']]))], axis=1,ignore_index=True)
                result.index = [part_options[0] +" name", "Size" ,"PC Performance score", "Value Score(/$)", "Price"]
                result= result.T
                result.index = ["1","2","3","4","5"]
                st.write("Showing", part_options[0], 'options with best',options_pref )
                st.table(result)
            else:
                st.subheader("Please increase your budget")
            
            
        elif options_pref == 'Value':
            HDDSize = st.number_input('Enter the minimum hard drive size preferred in GB (<=2000): (By default shows best value hard drive options)',min_value = 128,max_value = 2000,key = 1253)
            HDDSize = math.log2(HDDSize)
            HDD_data = HDD_data[(HDD_data['size'] >= pow(2,math.floor(HDDSize)))]
            priceSort = np.asarray((HDD_data.price.tolist()))
            min_price = int(np.sort(priceSort)[5])
            Budprice = st.number_input('Enter your budget in $: (By default shows best value hard drive options)',min_value = min_price,max_value = int(max(HDD_data.price.tolist()))+100)
            if Budprice == min_price:
                HDD_data = HDD_data[(HDD_data['price'] < int(max(HDD_data.price.tolist()))+100)]
            else:
                HDD_data = HDD_data[(HDD_data['price'] < Budprice)]
            Hard_Mark = np.array(HDD_data.HardMark.tolist())*coeffMark.HDD_coeff[0]
            sysScore = ((otherMark+Hard_Mark)/5.0)
            HDD_data = HDD_data[(HDD_data['HardMark'] >= mu)]
            Hard_Mark_p = (np.array(HDD_data.HardMark.tolist()))*coeffMark.HDD_coeff[0]
            sysScore_p = ((otherMark+Hard_Mark_p)/5.0)
            valueScore = (sysScore_p-mu)*10/np.array(HDD_data.price.tolist())
            indices = np.argsort(valueScore)
            
            result = pd.DataFrame()
            if HDD_data.shape[0]>10:
                for i in range(5):
                    if i == 0:
                        sizeHDD = float(HDD_data.iloc[indices[-(i+1)]]['size'])
                        if sizeHDD < 10:
                            sizeHDD = str(sizeHDD/1000) + ' TB'
                        else:
                            sizeHDD = str(sizeHDD) + ' GB'
                        result = pd.concat([result,(pd.Series([HDD_data.iloc[indices[-(i+1)]]['name'], sizeHDD ,int(sysScore_p[indices[-(i+1)]]), int(valueScore[indices[-(i+1)]]), HDD_data.iloc[indices[-(i+1)]]['price']]))],ignore_index=True)
                    else:
                        sizeHDD = float(HDD_data.iloc[indices[-(i+1)]]['size'])
                        if sizeHDD < 10:
                            sizeHDD = str(sizeHDD/1000) + ' TB'
                        else:
                            sizeHDD = str(sizeHDD) + ' GB'
                        result = pd.concat([result,(pd.Series([HDD_data.iloc[indices[-(i+1)]]['name'], sizeHDD , int(sysScore_p[indices[-(i+1)]]), int(valueScore[indices[-(i+1)]]), HDD_data.iloc[indices[-(i+1)]]['price']]))], axis=1,ignore_index=True)
                result.index = [part_options[0] + " name", "Size", "PC Performance score", "Value Score(/$)", "Price"]
                result= result.T
                result.index = ["1","2","3","4","5"]
                st.write("Showing", part_options[0], 'options with best',options_pref )
                st.table(result)
            else:
                st.subheader("Please increase your budget")
            
            
    elif part_options[0] == 'RAM':
        if CPU_year >= 2014 and CPU_year < 2017:
            min_size = 4
            RAM_data = pdDDR4[(pdDDR4['DDR3_4'] == 1) & (pdDDR4['size'] >= 4)]
            max_size = 16
        elif CPU_year >= 2017:
            RAM_data = pdDDR4[(pdDDR4['DDR3_4'] == 1) & (pdDDR4['size'] >= 8)]
            min_size = 8
            max_size = 32
        else:
            RAM_data = pdDDR4[(pdDDR4['DDR3_4'] == 0) & (pdDDR4['size'] <= 8) & (pdDDR4['size'] >= 4)]
            min_size = 4
            max_size = 8
        
        mu, std = norm.fit(np.array(RAM_data.RAMmark.tolist()))


        
        if options_pref == 'Performance':
            ramSize = st.number_input('Enter your preferred minimum size in GB (<=32): (By default shows best performing RAM)',min_value = min_size,max_value = max_size,key = 1253)
            RAM_data = RAM_data[RAM_data['totalSize'] >= ramSize ]
            priceSort = np.asarray((RAM_data.Price.tolist()))
            min_price = int(np.sort(priceSort)[15])
            Budprice = st.number_input('Enter your budget in $: (By default shows best performing RAM)',min_value = min_price,max_value = int(max(RAM_data.Price.tolist()))+100,key = 1254)
            
            if Budprice == min_price:
                RAM_data = RAM_data[(RAM_data['Price'] < int(max(RAM_data.Price.tolist()))+100)]
            else:
                RAM_data = RAM_data[(RAM_data['Price'] < Budprice)]
                
            otherMark = (Hard_Mark*coeffMark.HDD_coeff[0])+(GPU_Mark*coeffMark.GPU_coeff[0])+(CPU_Mark*coeffMark.CPU_coeff[0])
            
            RAM_Mark = np.array(RAM_data.RAMmark.tolist())*coeffMark.RAM_coeff[0]
            sysScore = ((otherMark+RAM_Mark)/5.0)
            
            #mu, std = norm.fit(sysScore)
            indices = np.argsort(sysScore)
            
            
            result = pd.DataFrame()
            if RAM_data.shape[0]>10:
                for i in range(5):
                    if i == 0:
                        sizeHDD = str(RAM_data.iloc[indices[-(i+1)]]['totalSize'])+ ' GB'                    
                        #result = pd.concat([result,(pd.Series([RAM_data.iloc[indices[-(i+1)]]['name'], sizeHDD ,int(RAM_data.iloc[indices[-(i+1)]]['RAMmark']), int((RAM_data.iloc[indices[-(i+1)]]['RAMmark']*100)/np.array(RAM_data.iloc[indices[-(i+1)]]['Price'])), RAM_data.iloc[indices[-(i+1)]]['Price']]))],ignore_index=True)
                        result = pd.concat([result,(pd.Series([RAM_data.iloc[indices[-(i+1)]]['name'], sizeHDD ,int(sysScore[indices[-(i+1)]]), int((sysScore[indices[-(i+1)]]-mu)*10/np.array(RAM_data.iloc[indices[-(i+1)]]['Price'])), RAM_data.iloc[indices[-(i+1)]]['Price']]))],ignore_index=True)
                    else:
                        sizeHDD = str(RAM_data.iloc[indices[-(i+1)]]['totalSize'])+ ' GB'
                        #result = pd.concat([result,(pd.Series([RAM_data.iloc[indices[-(i+1)]]['name'], sizeHDD , int(RAM_data.iloc[indices[-(i+1)]]['RAMmark']), int((RAM_data.iloc[indices[-(i+1)]]['RAMmark']*100)/np.array(RAM_data.iloc[indices[-(i+1)]]['Price'])), RAM_data.iloc[indices[-(i+1)]]['Price']]))], axis=1,ignore_index=True)
                        result = pd.concat([result,(pd.Series([RAM_data.iloc[indices[-(i+1)]]['name'], sizeHDD , int(sysScore[indices[-(i+1)]]), int((sysScore[indices[-(i+1)]]-mu)*10/np.array(RAM_data.iloc[indices[-(i+1)]]['Price'])), RAM_data.iloc[indices[-(i+1)]]['Price']]))], axis=1,ignore_index=True)
                result.index = [part_options[0] + " name", "Size", "PC Performance score", "Value Score(/$)", "Price"]
                result= result.T
                result.index = ["1","2","3","4","5"]
                st.write("Showing", part_options[0], 'options with best',options_pref )
                st.table(result)
            else:
                st.subheader("Please increase your budget")
            
            
        elif options_pref == 'Value':
            ramSize = st.number_input('Enter your preferred minimum size in GB (<=32): (By default shows best value RAM)',min_value = min_size,max_value = max_size,key = 1253)
            RAM_data = RAM_data[RAM_data['totalSize'] >= ramSize ]
            priceSort = np.asarray((RAM_data.Price.tolist()))
            min_price = int(np.sort(priceSort)[15])
            Budprice = st.number_input('Enter your budget in $: (By default shows best value RAM)',min_value = min_price,max_value = int(max(RAM_data.Price.tolist()))+100,key = 1254)
            
            
            if Budprice == min_price:
                RAM_data = RAM_data[(RAM_data['Price'] < int(max(RAM_data.Price.tolist()))+100)]
            else:
                RAM_data = RAM_data[(RAM_data['Price'] < Budprice)]
            otherMark = (Hard_Mark*coeffMark.HDD_coeff[0])+(GPU_Mark*coeffMark.GPU_coeff[0])+(CPU_Mark*coeffMark.CPU_coeff[0])
            RAM_Mark = np.array(RAM_data.RAMmark.tolist())*coeffMark.RAM_coeff[0]
            sysScore = ((otherMark+RAM_Mark)/5.0)
            #mu, std = norm.fit(np.array(RAM_data.RAMmark.tolist()))
            RAM_data = RAM_data[RAM_data['RAMmark']>=(mu)]
            RAM_Mark_p = np.array(RAM_data.RAMmark.tolist())*coeffMark.RAM_coeff[0]
            
            sysScore_p = ((otherMark+RAM_Mark_p)/5.0)
            valueScore = (sysScore_p-mu)*10/np.array(RAM_data.Price.tolist())
            indices = np.argsort(valueScore)
            
            result = pd.DataFrame()
            if RAM_data.shape[0]>10:
                for i in range(5):
                    if i == 0:
                        sizeHDD = str(RAM_data.iloc[indices[-(i+1)]]['totalSize'])+ ' GB'                    
                        #result = pd.concat([result,(pd.Series([RAM_data.iloc[indices[-(i+1)]]['name'], sizeHDD ,int(RAM_data.iloc[indices[-(i+1)]]['RAMmark']), int(valueScore[indices[-(i+1)]]), RAM_data.iloc[indices[-(i+1)]]['Price']]))],ignore_index=True)
                        result = pd.concat([result,(pd.Series([RAM_data.iloc[indices[-(i+1)]]['name'], sizeHDD ,int(sysScore_p[indices[-(i+1)]]), int(valueScore[indices[-(i+1)]]), RAM_data.iloc[indices[-(i+1)]]['Price']]))],ignore_index=True)
                    else:
                        sizeHDD = str(RAM_data.iloc[indices[-(i+1)]]['totalSize'])+ ' GB'
                        #result = pd.concat([result,(pd.Series([RAM_data.iloc[indices[-(i+1)]]['name'], sizeHDD , int(RAM_data.iloc[indices[-(i+1)]]['RAMmark']), int(valueScore[indices[-(i+1)]]), RAM_data.iloc[indices[-(i+1)]]['Price']]))], axis=1,ignore_index=True)
                        result = pd.concat([result,(pd.Series([RAM_data.iloc[indices[-(i+1)]]['name'], sizeHDD , int(sysScore_p[indices[-(i+1)]]), int(valueScore[indices[-(i+1)]]), RAM_data.iloc[indices[-(i+1)]]['Price']]))], axis=1,ignore_index=True)
                result.index = [part_options[0] + " name", "Size", "PC Performance score", "Value Score(/$)", "Price"]
                result= result.T
                result.index = ["1","2","3","4","5"]
                st.write("Showing", part_options[0], 'options with best',options_pref )
                st.table(result)
            else:
                st.subheader("Compatable matches not found. Please increase your budget")
            
            

