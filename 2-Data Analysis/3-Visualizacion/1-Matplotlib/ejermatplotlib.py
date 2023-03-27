# Ejercicio
import matplotlib.pyplot as plt
import numpy as np
import math 
theta = np.linspace(0, 2*math.pi, 1000)
plt.plot(theta, np.sin(theta), color='k') # black
plt.show()
plt.plot(theta, 5 - 5 * np.sin(theta), color='red')
plt.show()
plt.polar(theta, (5 - 5 * np.sin(theta)), color='red')
plt.show()


