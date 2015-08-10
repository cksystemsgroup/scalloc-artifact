set terminal postscript enhanced color eps 

load 'plot/common.inc.gp'

set format y '%g'
set format x '%g'

unset title
set xlabel 'number of threads'
set key below
set xtics (2,4,6,8,10,20,30,40)
set xrange [1:41]


# 95% confidence interval for n = 10, t = 1.833
n = 10
t = 1.833

ci_lower(mean, stddev) = mean - t * stddev/sqrt(n)
ci_upper(mean, stddev) = mean + t * stddev/sqrt(n)

scale=2000000000
set ylabel offset 1,0 'total per-thread allocator time in seconds\n(less is better)'
set output 'out/prod-cons-throughput.eps'
set yrange [0:0.4]

print "plotting throughput..."
plot for [i=1:words(allocators)] \
  'data/ACDC/prod-cons/'.word(allocators,i).'-combined.dat' \
  using 1:($2/scale):(ci_lower($2/scale,$3/scale)):(ci_upper($2/scale,$3/scale)) \
  with errorlines ls word(styles,i) title word(labels,i);

scale=1024
set ylabel offset 1,0 'average per-thread memory consumption in MB\n(less is better)'
set autoscale y
set yrange [0:]
set output 'out/prod-cons-memory.eps'

print "plotting memory consumption..."
plot for [i=1:words(allocators)] \
  'data/ACDC/prod-cons/'.word(allocators,i).'-memcons.dat' \
  using 1:($2/scale):(ci_lower($2/scale,$3/scale)):(ci_upper($2/scale,$3/scale)) \
  with errorlines ls word(styles,i) title word(labels,i);
