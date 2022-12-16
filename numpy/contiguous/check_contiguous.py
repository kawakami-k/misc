import numpy as np

x = np.array([[1,2,3],[4,5,6]], dtype=np.int8)
print('x.shape', x.shape)
print('x.flags', x.flags)
print('x', x)

y = x.T.copy()
print('y.shape', y.shape)
print('y.flags', y.flags)
print('y', y)

np.save('x.npy', x)
np.save('y.npy', y)
