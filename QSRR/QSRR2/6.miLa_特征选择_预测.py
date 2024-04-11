# -*- coding: utf-8 -*-
"""
Created on Fri Mar 22 16:27:17 2024

@author: yj991
"""

#查看当前工作目录
import os
os.getcwd()
#更改当前工作目录
os.chdir('D:\R_work\master-s-thesis-project\QSRR\QSRR2')
os.getcwd()#更改成功

#导入数据
#读取数据集
#读取SMILES特征文件
input6="MDs.csv"
import pandas as pd
d1=pd.read_csv(input6,header=0)


## split into train and test sets
from sklearn.model_selection import train_test_split
from sklearn.preprocessing import StandardScaler

scaler = StandardScaler()
X=d1.iloc[:,3:d1.shape[1]]
X= scaler.fit_transform(X)
y=d1.iloc[:,1]
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.3, random_state=1)

# #区别于lr调整lasso回归参数
# from sklearn.linear_model import Lasso
# from sklearn.model_selection import train_test_split, GridSearchCV
# from sklearn.metrics import mean_absolute_error
# # 定义参数网格
# param_grid = {'alpha': [0.0001,0.001, 0.01,1,10,100]}
# # 初始化Lasso回归模型
# lasso = Lasso()
# # 初始化GridSearchCV
# grid_search = GridSearchCV(lasso, param_grid, cv=5, scoring='neg_mean_squared_error')
# # 执行网格搜索
# grid_search.fit(X_train, y_train)
# # 打印最佳参数
# print("Best Parameters:", grid_search.best_params_)#0.1
# # 获取最佳模型
# best_lasso = grid_search.best_estimator_
# # 在测试集上进行预测
# y_pred_best = best_lasso.predict(X_test)
# # 评估最佳模型性能
# mae = mean_absolute_error(y_test, y_pred_best)
# print("Mean Squared Error (Best Model):", mae)#0.9818




#调整选择特征的个数
#1.mi+La
#首先定义评估模型的方法
from sklearn.model_selection import  RepeatedKFold
cv = RepeatedKFold(n_splits=5, n_repeats=3, random_state=707)
#n_splits=10十折交叉验证
#n_repeats=3重复三次十折交叉验证

#建立评估模型流水线
from sklearn.linear_model import Lasso
from sklearn.feature_selection import SelectKBest, mutual_info_regression
model = Lasso(alpha=0.1)
fs = SelectKBest(score_func=mutual_info_regression)#cs

from sklearn.pipeline import Pipeline
pipeline = Pipeline(steps=[('sel', fs), ('la', model)])
#第一步是特征选择fs，然后是建模lr

# 定义网格define the grid
grid = dict()#dict()创建一个空的搜索目录
grid['sel__k'] = [i for i in range(1, X.shape[1]+1)]
#sel_k表示一个机器学习pipeline中的超参数
#从0到所有特征数，创建一个list的超参数

# 定义网格搜索define the grid search
from sklearn.model_selection import GridSearchCV
search = GridSearchCV(pipeline, grid, scoring='neg_mean_absolute_error', n_jobs=-1, cv=cv)
#pipeline如前已定义：第一步fs，第二步lr
#grid网格搜索的方法
#scoring对模型评分的方法：neg_mean_absolute_error（负的MAE；0是最好的）
#n_jobs=-1调用所有cpu
#cv带着参数的交叉验证法
# perform the search
results = search.fit(X, y)
#总结最好的分数和最合适的特征数
print('Best MAE: %.3f' % results.best_score_)#1.228
print('Best Config: %s' % results.best_params_)#192
#总结所有的特征数和它对应的MAE
means = results.cv_results_['mean_test_score']
params = results.cv_results_['params']
list1=[]
list2=[]
for mean, param in zip(means, params):
    list1.append(-mean)
    list2.append(param)

mean1=pd.DataFrame(list1)
mean1.columns={"MAE"}
param1=pd.DataFrame(list2)
resultmi=pd.concat([param1,mean1],axis=1)
#存储特征数和得分
resultmi.to_csv('特征数_MAE\milafs_no.csv',header=True,index=False);

#输出最优特征数的score
from sklearn.feature_selection import SelectKBest, mutual_info_regression
def select_features(X_train, y_train, X_test):
	# configure to select a subset of features
	fs = SelectKBest(score_func=mutual_info_regression, k=192)
	# learn relationship from training data
	fs.fit(X_train, y_train)
	# transform train input data
	X_train_fs = fs.transform(X_train)
	# transform test input data
	X_test_fs = fs.transform(X_test)
	return X_train_fs, X_test_fs, fs

#使用相关性选择20个特征
X_train_fs, X_test_fs, fs = select_features(X_train, y_train, X_test)
model = Lasso(alpha=0.1)
model.fit(X_train_fs,y_train)
# evaluate the model
yhat = model.predict(X_test_fs)
# evaluate predictions
from sklearn.metrics import mean_absolute_error
mae = mean_absolute_error(y_test, yhat)
print('MAE: %.3f' % mae)#0.982
#可视化20个特征的得分
sc=[]
for i in range(len(fs.scores_)):
	sc.append(fs.scores_[i])
#将得分list转化为得分frame
import pandas as pd
scd=pd.DataFrame(sc)
#合并特征名称和得分
fe=pd.DataFrame(d1.columns[4:d1.shape[1]])
scd1=pd.concat([fe,scd],axis=1)
scd1.columns=("Feature","Score")#取列名
#降序排列后取前20个
scd20=scd1.sort_values(by='Score', ascending=False).iloc[0:192,:]
#储存得分
scd20.to_csv('fs_score\milascore.csv',header=True,index=False);

#建立模型且预测
#预测所有的物质的保留时间
X_fs=fs.transform(X)#转换到只有33个特征的形式
yall=model.predict(X_fs)
mae = mean_absolute_error(y, yall)
print('MAE: %.3f' % mae)#所有数据的MAE是0.628
#预测数据和实验数据合并
yall=pd.DataFrame(yall)
yall.columns=['Predicted RT']
all=pd.concat([d1.iloc[:,0:2],yall],axis=1)
MAE=abs(all.iloc[:,1]-all.iloc[:,2])
max(MAE)#2.68
min(MAE)#0.02
pdMAE=pd.DataFrame(MAE)
pdMAE.columns=['mae']
all1=pd.concat([all,pdMAE],axis=1)
all1.to_csv('result\Predict_mila.csv',header=True,index=False)














