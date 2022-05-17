# -*- coding: utf-8 -*-
import numpy as np
from scipy.optimize import leastsq
import pylab as pl

def func(x, p):
    """
    数据拟合所用的函数: A*sin(2*pi*k*x + theta)
    """
    a, ab, k = p
    return a+(ab-a)/100.*(x+50+k-np.sqrt((x+50+k).*(x+50+k)-200.*x))   

def residuals(p, y, x):
    """
    实验数据x, y和拟合函数之间的差，p为拟合需要找到的系数
    """
    return y - func(x, p)

import numpy as np
dat=np.loadtxt('E:/dbox/oc/data/smfret/kd.dat')
x=dat[:,0]
y=dat[:,1]

p0 = [0.5, 0.2, 20] # 第一次猜测的函数拟合参数

# 调用leastsq进行数据拟合
# residuals为计算误差的函数
# p0为拟合参数的初始值
# args为需要拟合的实验数据
plsq = leastsq(residuals, p0, args=(y, x))

#print u"真实参数:", [a, ab, k ] 
print u"拟合参数", plsq[0] # 实验数据拟合后的参数

#pl.plot(x, y0, label=u"真实数据")
pl.plot(x, y, label=u"实验数据")
pl.plot(x, func(x, plsq[0]), label=u"拟合数据")
pl.legend()
pl.show()
