set terminal postscript

load 'plot/common.inc.gp'

set format y '%g'
set format x '%g'
set xlabel 'number of threads'
set key below
set datafile separator ","

# 95% confidence interval for n = 10, t = 1.833
n = 10
t = 1.833

base_value = 182.1

ci_lower(mean, stddev) = mean - t * stddev/sqrt(n)
ci_upper(mean, stddev) = mean + t * stddev/sqrt(n)

set xrange [.5:40.5]
set xtics (1,2,4,6,8,10,20,30,40)

set ylabel offset 1,0 'speedup with respect to ptmalloc2 (more is better)'
set output 'out/shbench-throughput.eps'

print "plotting throughput..."
plot for [i=1:words(allocators)] \
  'data/shbench/'.word(allocators,i).'.dat' \
  using 1:(base_value/$2) \
  with errorlines ls word(styles,i) title word(labels,i);


unset logscale y
set yrange[0:]
set ylabel offset 1,0 'memory consumption in GB (less is better)'
set output 'out/shbench-memory.eps'
memscale = (1024*1024)

print "plotting memory consumption..."
plot for [i=1:words(allocators)] \
  'data/shbench/'.word(allocators,i).'.dat' \
  using 1:($4/memscale):(ci_lower($4/memscale,$5/memscale)):(ci_upper($4/memscale,$5/memscale)) \
  with errorlines ls word(styles,i) title word(labels,i);
