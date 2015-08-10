set terminal postscript

load 'plot/common.inc.gp'

set format y '%g'
set format x '%g'

unset title
set xlabel 'percentage of object accesses in allocation order'
set ylabel offset 1,0 'total memory access time in seconds (less is better)'
set yrange [0:]
set key below

set xrange [-2:102]

# 95% confidence interval for n = 10, t = 1.833
n = 10
t = 1.833

ci_lower(mean, stddev) = mean - t * stddev/sqrt(n)
ci_upper(mean, stddev) = mean + t * stddev/sqrt(n)

scale=2000000000
set output 'out/locality.eps'

plot for [i=1:words(allocators)] \
  'data/ACDC/locality/'.word(allocators,i).'-access.dat' \
  using 1:($2/scale):(ci_lower($2/scale,$3/scale)):(ci_upper($2/scale,$3/scale)) \
  with errorlines ls word(styles,i) title word(labels,i);

