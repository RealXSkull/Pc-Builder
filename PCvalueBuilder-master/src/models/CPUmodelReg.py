# -*- coding: utf-8 -*-
"""
Created on Fri Jun  5 02:25:37 2020

@author: NTSL6
"""

import numpy as np
import pandas as pd
import math
from sklearn.model_selection import train_test_split
from sklearn.preprocessing import StandardScaler
from sklearn import preprocessing
from sklearn.ensemble import RandomForestRegressor
from sklearn import metrics


# Data read
CPUIntel = pd.read_csv('Clean/CPUCleanedIntel.csv')

# Rading the features and 
X = CPUIntel.iloc[:, 4:17].values
y = CPUIntel.iloc[:, 18].values

#X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=0)

X_train= np.load('Clean/Xtrain_CPU_intel.npy')
X_test= np.load('Clean/Xtest_CPU_intel.npy')
y_train= np.load('Clean/Ytrain_CPU_intel.npy')
y_test = np.load('Clean/Ytest_CPU_intel.npy')

y_train = y_train - np.mean(y_train)
y_test = y_test - np.mean(y_test)
#%%
regressor = RandomForestRegressor(n_estimators=13, random_state=0)

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
#Mean Squared Error: 698358.5235560217
#Root Mean Squared Error: 835.6784809698175
#R2 error: 0.9616449671203645