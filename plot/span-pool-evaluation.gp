set terminal postscript

load 'plot/common.inc.gp'

set format y '%g'
set format x '%g'
set datafile separator ','

set xlabel 'number of threads'

set key below

# 95% confidence interval for n = 10, t = 1.833
n = 10
t = 1.833

ci_lower(mean, stddev) = mean - t * stddev/sqrt(n)
ci_upper(mean, stddev) = mean + t * stddev/sqrt(n)

base_value = 138.33
set xrange [.5:40.5]
set xtics (1,2,4,6,8,10,20,30,40)

allocators  = "scalloc scalloc-sp-1-backend"
labels      = "scalloc scalloc~disabled~SP"
styles      = "40 41"

set ylabel offset 1,0 '\large speedup with respect to ptmalloc2 (more is better)'
set output 'out/scalloc-span-pool-evaluation-performance.eps'

plot for [i=1:words(allocators)] \
  'data/span-pool-evaluation/'.word(allocators,i).'.dat' \
  using 1:(base_value/$2) \
  with errorlines ls word(styles,i) title word(labels,i);

unset logscale y
set yrange[0:]
set ylabel offset 1,0 '\large memory consumption in MB (less is better)'
set output 'out/scalloc-span-pool-evaluation-memory.eps'
memscale = 1024

plot for [i=1:words(allocators)] \
  'data/span-pool-evaluation/'.word(allocators,i).'.dat' \
  using 1:($4/memscale):(ci_lower($4/memscale,$5/memscale)):(ci_upper($4/memscale,$5/memscale)) \
  with errorlines ls word(styles,i) title word(labels,i);
