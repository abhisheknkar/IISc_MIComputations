import sys, time
import matplotlib.pyplot as plt
import matplotlib.colors as colors

from sklearn.cluster import MiniBatchKMeans
from numpy import *
from itertools import cycle

dataFn1 = str(sys.argv[1])
data = loadtxt(dataFn1)

noOfClusters1 = int(sys.argv[2])
labelFn1 = str(sys.argv[3])

mbk = MiniBatchKMeans(init='k-means++', n_clusters=noOfClusters1, batch_size=1000,n_init=10,max_no_improvement=10, verbose=0, random_state=0)

mbk.fit_transform(data) 
#print mbk.labels_
#print type(mbk.labels_)

f = open(labelFn1, 'w')
for item in mbk.labels_:
	f.write('%s\n' % item)


#mbk_means_labels_unique = unique(mbk.labels_)

#fig = plt.figure(figsize=(12, 4))
#fig.subplots_adjust(left=0.04, right=0.98, bottom=0.1, top=0.9)
#ax = fig.add_subplot(1,1,1)

# Use all colors that matplotlib provides by default.
#colors_ = cycle(colors.cnames.keys())

#for this_centroid, k, col in zip(mbk.cluster_centers_,
#                                 range(noOfClusters1), colors_):
#    mask = mbk.labels_ == k
#    ax.plot(data[mask, 0], data[mask, 1], 'w', markerfacecolor=col, marker='.')
#    ax.plot(this_centroid[0], this_centroid[1], '+', markeredgecolor='k',
#            markersize=5)
#ax.set_xlim([0, 10])
#ax.set_ylim([0, 10])
#ax.set_title("MiniBatchKMeans")
#ax.set_autoscaley_on(False)
#plt.show()

