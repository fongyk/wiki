归一化
============

归一化
-----------


.. py:function:: numpy.linalg.norm(x, ord=None, axis=None, keepdims=False)


.. py:function:: sklearn.preprocessing.normalize(X, norm=’l2’, axis=1, copy=True, return_norm=False)


.. py:function:: torch.nn.functional.normalize(input, p=2, dim=1, eps=1e-12)

.. code-block:: python
  :linenos:

  >>> import numpy as np
  >>> import numpy.linalg as la
  >>> arr = np.array([[2,1,2],[2,1,1]], dtype=np.float32)
  >>> print arr
  [[ 2.  1.  2.]
   [ 2.  1.  1.]]
  >>> norm = la.norm(arr, axis=0, keepdims=True)
  >>> print norm
  [[ 2.82842708  1.41421354  2.23606801]]
  >>> print arr / np.tile(norm,(2,1))
  [[ 0.70710677  0.70710677  0.89442718]
   [ 0.70710677  0.70710677  0.44721359]]

  >>> from sklearn import preprocessing
  >>> print preprocessing.normalize(arr, axis=0, norm='l2')
  [[ 0.70710677  0.70710677  0.89442718]
   [ 0.70710677  0.70710677  0.44721359]]

  >>> import torch.nn.functional as F
  >>> print F.normalize(torch.from_numpy(arr), p=2, dim=0)
  0.7071  0.7071  0.8944
  0.7071  0.7071  0.4472
  [torch.FloatTensor of size 2x3]


k-means 实现
-------------------

.. code-block:: python
  :linenos:

  import numpy as np

  ## feature initialization
  np.random.seed(1)
  n = 10000
  d = 3
  K = 50
  data = np.random.randn(n, d) ## n x d

  ## feature  normalization
  data = data / np.tile(np.linalg.norm(data, axis=1, keepdims=True), (1, data.shape[1]))

  ## center initialization
  center = data[np.random.permutation(n)[0:K]]

  itr = 0
  ## loop
  while itr < 20:
      itr += 1
      ## quantization
      similarity = np.dot(data, center.T)
      quan_id = np.argsort(-similarity, axis=1)[:, 0]

      ## update center
      new_error = 0.0
      for c in range(K):
          data_c = data[quan_id == c]
          if data_c.shape[0] != 0:
            center[c] = np.mean(data_c, axis=0)
            new_error += np.sum((data_c - center[c])**2)

      if itr > 1 and abs(1 - new_error/old_error) < 1e-3:
          break
      old_error = new_error

参考资料
--------------

1. numpy.linalg.norm

  https://docs.scipy.org/doc/numpy-1.13.0/reference/generated/numpy.linalg.norm.html

2. sklearn.preprocessing.normalize

  https://scikit-learn.org/stable/modules/generated/sklearn.preprocessing.normalize.html

3. torch.nn.functional.normalize

  https://pytorch.org/docs/0.3.0/nn.html?highlight=normalize#torch.nn.functional.normalize
