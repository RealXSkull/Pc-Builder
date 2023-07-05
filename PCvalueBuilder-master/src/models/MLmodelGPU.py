import numpy as np
import pandas as pd
import math
from sklearn.model_selection import train_test_split
from sklearn.preprocessing import StandardScaler
from sklearn import preprocessing
from sklearn.ensemble import RandomForestRegressor
from sklearn import metrics


CPUIntel = pd.read_csv('../GPU/cleaned/GPUCleaned.csv')



X = CPUIntel.iloc[:, 4:14].values
y = CPUIntel.iloc[:, 17].values

#X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=0)

X_train= np.load('cleaned/Xtrain_GPU.npy')
X_test= np.load('cleaned/Xtest_GPU.npy')
y_train= np.load('cleaned/Ytrain_GPU.npy')
y_test = np.load('cleaned/Ytest_GPU.npy')

y_train = y_train - np.mean(y_train)
y_test = y_test - np.mean(y_test)
#%%
regressor = RandomForestRegressor(n_estimators=20, random_state=0)
regressor.fit(X_train, y_train)
y_pred = regressor.predict(X_test)
print('Mean Squared Error:', metrics.mean_squared_error(y_test, y_pred))
print('Root Mean Squared Error:', np.sqrt(metrics.mean_squared_error(y_test, y_pred)))
print('R2 error:', metrics.r2_score(y_test, y_pred))

#%%
from sklearn import linear_model
clf = linear_model.Lasso(alpha=0.2)
clf.fit(X_train, y_train)
y_pred = clf.predict(X_test)
print('Mean Squared Error:', metrics.mean_squared_error(y_test, y_pred))
print('Root Mean Squared Error:', np.sqrt(metrics.mean_squared_error(y_test, y_pred)))
print('R2 error:', metrics.r2_score(y_test, y_pred))

#%%
from sklearn.linear_model import Ridge
clf = Ridge(alpha=0.2)
clf.fit(X_train, y_train)
y_pred = clf.predict(X_test)
print('Mean Squared Error:', metrics.mean_squared_error(y_test, y_pred))
print('Root Mean Squared Error:', np.sqrt(metrics.mean_squared_error(y_test, y_pred)))
print('R2 error:', metrics.r2_score(y_test, y_pred))

#%%
from sklearn.linear_model import LinearRegression
clf = LinearRegression().fit(X_train, y_train)
y_pred = clf.predict(X_test)

print('Mean Squared Error:', metrics.mean_squared_error(y_test, y_pred))
print('Root Mean Squared Error:', np.sqrt(metrics.mean_squared_error(y_test, y_pred)))
print('R2 error:', metrics.r2_score(y_test, y_pred))
coeff = clf.coef_