归一化
============

numpy.linalg.norm
-----------------------
::

  numpy.linalg.norm(x, ord=None, axis=None, keepdims=False)


sklearn.preprocessing.normalize
-------------------------------------

::

  sklearn.preprocessing.normalize(X, norm=’l2’, axis=1, copy=True, return_norm=False)

torch.nn.functional.normalize
--------------------------------------
::

  torch.nn.functional.normalize(input, p=2, dim=1, eps=1e-12)

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

参考资料
--------------

1. numpy.linalg.norm

  https://docs.scipy.org/doc/numpy-1.13.0/reference/generated/numpy.linalg.norm.html

2. sklearn.preprocessing.normalize

  https://scikit-learn.org/stable/modules/generated/sklearn.preprocessing.normalize.html

3. torch.nn.functional.normalize

  https://pytorch.org/docs/0.3.0/nn.html?highlight=normalize#torch.nn.functional.normalize
