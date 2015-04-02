"""
Database Project, Part III - Plot a histogram
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
avx = []
avy = []
for i in range(1, len(transposed[1])-1):
    avx.append(transposed[0][i])
    avy.append((transposed[1][i-1]+transposed[1][i]+transposed[1][i+1])/3)

plt.figure()
plt.plot(avx, avy, color='gray', linewidth='4.0')
plt.plot(transposed[0], transposed[1], 'o', color='red')
plt.axis([0, 24, 0, 100000])
plt.text(13.5, 80000, '3hr Moving Average', color='gray', style='oblique')
plt.ylabel("Number of Fines Issued", style='italic')
plt.xlabel("Time of Day (24h)", style='italic')
plt.title("Baltimore City Parking Violations, Feb 2013 - Feb 2015")
plt.show()
