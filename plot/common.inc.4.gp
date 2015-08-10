# gnuplot 4.6

set style line  1 pt  1  lc rgb "#000000" lw 2  # jemalloc
set style line  2 pt  2  lc rgb "#009e73" lw 2  # llalloc
set style line  3 pt 14  lc rgb "#56b4e9" lw 2  # ptmalloc2
set style line  4 pt  4  lc rgb "#e69f00" lw 2  # tbb
set style line  5 pt  5  lc rgb "#f0e442" lw 2  # tcmalloc
set style line  6 pt  6  lc rgb "#0072b2" lw 2  # streamflow
set style line  7 pt  7  lc rgb "#d55e00" lw 2  # hoard
set style line  8 pt  8  lc rgb "#cc79a7" lw 2  # michael
set style line  9 pt  9  lc rgb "#000000" lw 2  # compact
set style line 10 pt 10  lc rgb "#e69f00" lw 2  # SuperMalloc

set style line 40 pt 11  lc rgb "#000000" lw 2  # scalloc default
set style line 41 pt 12  lc rgb "#e69f00" lw 2  # scalloc span-pool 1 backend
set style line 42 pt 13  lc rgb "#56b4e9" lw 2  # scalloc no madvise
set style line 43 pt  5  lc rgb "#009e73" lw 2  # scalloc transparent hugepages
set style line 44 pt  2  lc rgb "#f0e442" lw 2  # scalloc transparent hugepages, no madvise
set style line 45 pt  5  lc rgb "#d55e00" lw 2  # scalloc no cleanup in free
