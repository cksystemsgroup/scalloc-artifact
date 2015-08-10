set terminal postscript

load 'plot/common.inc.gp'

set format y '%g'
set format x '%g'

set key below
unset title
set xlabel 'object size range in bytes (logscale)'

set xtics 0,2,25
set xtics add ("16-64B" 4)
set xtics add ("64-256B" 6)
set xtics add ("256-1KB" 8)
set xtics add ("1-4KB" 10)
set xtics add ("4-16KB" 12)
set xtics add ("16-64KB" 14)
set xtics add ("64-256KB" 16)
set xtics add ("256KB-1MB" 18)
set xtics add ("1-4MB" 20)
set xrange [3.5:20.5]
set xtics rotate by 45 right

# 95% confidence interval for n = 10, t = 1.833
n = 10
t = 1.833

ci_lower(mean, stddev) = mean - t * stddev/sqrt(n)
ci_upper(mean, stddev) = mean + t * stddev/sqrt(n)

scale=2000000000
set output 'out/object-size-throughput.eps'
set logscale y
set ylabel offset 1.5,0 'total allocator time in seconds (logscale, less is better)'

plot for [i=1:words(allocators)] \
  'data/ACDC/object-size/'.word(allocators,i).'-combined.dat' \
  using 1:($2/scale):(ci_lower($2/scale,$3/scale)):(ci_upper($2/scale,$3/scale)) \
  with errorlines ls word(styles,i) title word(labels,i);

scale=1024
set ylabel offset 1.5,0 'average memory consumption in MB (logscale, less is better)'
set logscale y
set output 'out/object-size-memory.eps'

plot for [i=1:words(allocators)] \
  'data/ACDC/object-size/'.word(allocators,i).'-memcons.dat' \
  using 1:($2/scale):(ci_lower($2/scale,$3/scale)):(ci_upper($2/scale,$3/scale)) \
  with errorlines ls word(styles,i) title word(labels,i);

