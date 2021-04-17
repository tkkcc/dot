c.InteractiveShellApp.exec_lines = [
      'import numpy as np',
      'import torch',
      'from torch import nn',
      'import torch.nn.functional as F',
      'a1=np.random.randn(2,3,4)',
      'a2=np.random.randn(2,3,4)',
      'b1=torch.rand(2,3,4)',
      'b2=torch.rand(2,3,4)'
]
c.StoreMagics.autorestore = True
