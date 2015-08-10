# use PODO style colors but style them manually with appropriate dashtypes

# pt ... pointtype
# dt ... dashtype
# lc ... linecolor

# gnuplot 5

set linestyle  1 pt 1   dt 2 lc rgb "#000000" lw 2  # jemalloc
set linestyle  2 pt 2   dt 3 lc rgb "#009e73" lw 2  # llalloc
set linestyle  3 pt 14  dt 4 lc rgb "#56b4e9" lw 2  # ptmalloc2
set linestyle  4 pt 4   dt 5 lc rgb "#e69f00" lw 2  # tbb
set linestyle  5 pt 5   dt 6 lc rgb "#f0e442" lw 2  # tcmalloc
set linestyle  6 pt 6   dt 7 lc rgb "#0072b2" lw 2  # streamflow
set linestyle  7 pt 7   dt 8 lc rgb "#d55e00" lw 2  # hoard
set linestyle  8 pt 8   dt 2 lc rgb "#cc79a7" lw 2  # michael
set linestyle  9 pt 9   dt 3 lc rgb "#000000" lw 2  # compact
set linestyle 10 pt 10  dt 4 lc rgb "#e69f00" lw 2  # SuperMalloc

set linestyle 40 pt 11  dt 1 lc rgb "#000000" lw 2  # scalloc default
set linestyle 41 pt 12  dt 7 lc rgb "#e69f00" lw 2  # scalloc span-pool 1 backend
set linestyle 42 pt 13  dt 8 lc rgb "#56b4e9" lw 2  # scalloc no madvise
set linestyle 43 pt 5   dt 2 lc rgb "#009e73" lw 2  # scalloc transparent hugepages
set linestyle 44 pt 2   dt 3 lc rgb "#f0e442" lw 2  # scalloc transparent hugepages, no madvise
set linestyle 45 pt 5   dt 4 lc rgb "#d55e00" lw 2  # scalloc no cleanup in free
