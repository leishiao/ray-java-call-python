# ray_demo.py

import ray

@ray.remote
class Counter(object):
  def __init__(self):
      self.value = 0

  def increment(self):
      self.value += 1
      return self.value

@ray.remote
def add(a, b):
    return a + b