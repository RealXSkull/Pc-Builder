import numpy as np
import pandas as pd
import math
from sklearn.model_selection import train_test_split
from sklearn.preprocessing import StandardScaler
from sklearn import preprocessing
from sklearn.ensemble import RandomForestRegressor
from sklearn import metrics
from sklearn.utils.extmath import cartesian


coeffMark = pd.read_csv('../data/Coefficients.csv')
#%%

CPUIntel = pd.read_csv('../data/CPUCleanedIntel.csv')


X = CPUIntel.iloc[:, 4:17].values
y = CPUIntel.iloc[:, 18].values

#X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=0)

X_train= np.load('../data/Xtrain_CPU_intel.npy')
X_test= np.load('../data/Xtest_CPU_intel.npy')
y_train= np.load('../data/Ytrain_CPU_intel.npy')
y_test = np.load('../data/Ytest_CPU_intel.npy')

CPUasm = np.empty([ 200, X_train.shape[1]+1])
CPUasm[:,0:X_train.shape[1]]=X_train[0:200,:]
CPUasm[:,X_train.shape[1]]=y_train[0:200,]

CPUindex = np.array(range(200))

CPUasm_test = np.empty([ 30, X_test.shape[1]+1])
CPUasm_test[:,0:X_test.shape[1]]=X_test[0:30,:]
CPUasm_test[:,X_test.shape[1]]=y_test[0:30,]

CPUindex_test = np.array(range(30))
#%%

GPU = pd.read_csv('../data/GPUCleaned.csv')


X = GPU.iloc[:, 4:14].values
y = GPU.iloc[:, 17].values

#X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=0)

X_train= np.load('../data/Xtrain_GPU.npy')
X_test= np.load('../data/Xtest_GPU.npy')
y_train= np.load('../data/Ytrain_GPU.npy')
y_test = np.load('../data/Ytest_GPU.npy')

GPUasm = np.empty([ 150, X_train.shape[1]+1])
GPUasm[:,0:X_train.shape[1]]=X_train[0:150,:]
GPUasm[:,X_train.shape[1]]=y_train[0:150,]

GPUindex = np.array(range(150))

GPUasm_test = np.empty([ 30, X_test.shape[1]+1])
GPUasm_test[:,0:X_test.shape[1]]=X_test[0:30,:]
GPUasm_test[:,X_test.shape[1]]=y_test[0:30,]

GPUindex_test = np.array(range(30))
#%%

HDDSDD = pd.read_csv('../data/HDDSSDclean.csv')
X = HDDSDD.iloc[:, 0].values
y = HDDSDD.iloc[:, 3].values
#X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=0)

X_train= np.load('../data/Xtrain_HDD.npy')
X_test= np.load('../data/Xtest_HDD.npy')

HDDasm = X_train
HDDindex = np.array(range(X_train.shape[0]))
#%%

RAMdata = pd.read_csv('../data/RAM_DDR43_Cleaned.csv')

X = RAMdata.iloc[:, 3:6].values
y = RAMdata.iloc[:, 7].values
#X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=0)

X_train= np.load('../data/Xtrain_RAM.npy')
X_test= np.load('../data/Xtest_RAM.npy')
y_train= np.load('../data/Ytrain_RAM.npy')
y_test = np.load('../data/Ytest_RAM.npy')


RAMasm = np.empty([ 200, X_train.shape[1]+1])
RAMasm[:,0:X_train.shape[1]]=X_train[0:200,:]
RAMasm[:,X_train.shape[1]]=y_train[0:200,]
RAMindex = np.array(range(X_train.shape[0]))

RAMasm_test = np.empty([ 30, X_test.shape[1]+1])
RAMasm_test[:,0:X_test.shape[1]]=X_test[0:30,:]
RAMasm_test[:,X_test.shape[1]]=y_train[0:30,]
RAMindex_test = np.array(range(30))
#%%
rangeVlaues = 750000
df = pd.DataFrame(cartesian((RAMindex, CPUindex, GPUindex)))
#df_2 = [CPUasm[df.iloc[0:rangeVlaues,0],:],GPUasm[df.iloc[0:rangeVlaues,1],:]]
df_2 = np.hstack((CPUasm[df.iloc[0:rangeVlaues,1],:],GPUasm[df.iloc[0:rangeVlaues,2],:],RAMasm[df.iloc[0:rangeVlaues,0],:]))
y_train = ((df_2[:,24]*coeffMark.GPU_coeff[0]+df_2[:,28]*coeffMark.RAM_coeff[0])+(df_2[:,13]*coeffMark.CPU_coeff[0]))/3
df_2 = np.delete(df_2,np.s_[13], axis=1)
df_2 = np.delete(df_2,np.s_[23], axis=1)
df_2 = np.delete(df_2,np.s_[26], axis=1)


rangeVlauestest = 750000
df = pd.DataFrame(cartesian((RAMindex_test, CPUindex_test, GPUindex_test)))
#df_2 = [CPUasm[df.iloc[0:rangeVlaues,0],:],GPUasm[df.iloc[0:rangeVlaues,1],:]]
df_3 = np.hstack((CPUasm_test[df.iloc[0:rangeVlauestest,1],:],GPUasm_test[df.iloc[0:rangeVlauestest,2],:],RAMasm_test[df.iloc[0:rangeVlauestest,0],:]))
y_test = ((df_3[:,24]*coeffMark.GPU_coeff[0]+df_3[:,28]*coeffMark.RAM_coeff[0])+(df_3[:,13]*coeffMark.CPU_coeff[0]))/3
df_3 = np.delete(df_3,np.s_[13], axis=1)
df_3 = np.delete(df_3,np.s_[23], axis=1)
df_3 = np.delete(df_3,np.s_[26], axis=1)


#%%%%%%%

X_train = df_2
X_test = df_3


#%%


regressor = RandomForestRegressor(n_estimators=20, random_state=0)

regressor.fit(X_train, y_train)
y_pred = regressor.predict(X_test)
MSE_RFregg = metrics.mean_squared_error(y_test, y_pred)
RMSE_RFregg = np.sqrt(metrics.mean_squared_error(y_test, y_pred))
R2_score_RFregg = metrics.r2_score(y_test, y_pred)
print('Mean Squared Error:', metrics.mean_squared_error(y_test, y_pred))
print('Root Mean Squared Error:', np.sqrt(metrics.mean_squared_error(y_test, y_pred)))
print('R2 error:', metrics.r2_score(y_test, y_pred))

#%%
from sklearn import linear_model
clf = linear_model.Lasso(alpha=0.01)
clf.fit(X_train, y_train)
y_pred = clf.predict(X_test)
MSE_lasso = metrics.mean_squared_error(y_test, y_pred)
RMSE_lasso = np.sqrt(metrics.mean_squared_error(y_test, y_pred))
R2_score_lasso = metrics.r2_score(y_test, y_pred)
print('Mean Squared Error:', metrics.mean_squared_error(y_test, y_pred))
print('Root Mean Squared Error:', np.sqrt(metrics.mean_squared_error(y_test, y_pred)))
print('R2 error:', metrics.r2_score(y_test, y_pred))

#%%
from sklearn import linear_model
clf_ridge = linear_model.Ridge(alpha=0.01)
clf_ridge.fit(X_train, y_train)
y_pred = clf_ridge.predict(X_test)
MSE_ridge = metrics.mean_squared_error(y_test, y_pred)
RMSE_ridge = np.sqrt(metrics.mean_squared_error(y_test, y_pred))
R2_score_ridge = metrics.r2_score(y_test, y_pred)
print('Mean Squared Error:', metrics.mean_squared_error(y_test, y_pred))
print('Root Mean Squared Error:', np.sqrt(metrics.mean_squared_error(y_test, y_pred)))
print('R2 error:', metrics.r2_score(y_test, y_pred))

#%%
from sklearn.linear_model import LinearRegression
#clf_lr = LinearRegression().fit(X_train, y_train)
clf_lr = LinearRegression().fit(X_train, y_train)
y_pred = clf_lr.predict(X_test)
MSE_LR = metrics.mean_squared_error(y_test, y_pred)
RMSE_LR = np.sqrt(metrics.mean_squared_error(y_test, y_pred))
R2_score_LR = metrics.r2_score(y_test, y_pred)
print('Mean Squared Error:', metrics.mean_squared_error(y_test, y_pred))
print('Root Mean Squared Error:', np.sqrt(metrics.mean_squared_error(y_test, y_pred)))
print('R2 error:', metrics.r2_score(y_test, y_pred))
coeff = clf_lr.coef_
#%%
from sklearn.preprocessing import StandardScaler
from sklearn.decomposition import PCA
pca = PCA(n_components=6, svd_solver='arpack')
pca.fit(X_train)
X_pca = pca.fit_transform(X_train)

