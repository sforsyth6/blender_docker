import cupy as cp
import faulthandler

faulthandler.enable()

print (cp.eye(3))