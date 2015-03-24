"""
Parking Fines Project, Part III - Plot a histogram
David C. Wallace
Updated March 3rd, 2015.
"""

import csv
import matplotlib.pyplot as plt
import numpy as np

with open('timehist.txt', 'rU') as hist:
    reader = csv.reader(hist)
    data = []
    for line in reader:
	data.append(line)

histogram = np.array(data, dtype=float)
transposed = np.transpose(histogram)

plt.plot(transposed[0], transposed[1], 'o-')
plt.axis([0, 24, 0, 100000])
plt.ylabel("Number of Fines Issued (2 Year Total)")
plt.xlabel("Time of Day (24h)")
plt.title("Baltimore City Parking Violations, Feb 2013 - Feb 2015")
plt.show()
