set loadpath './plot'

if (GPVAL_VERSION < 5) { load 'common.inc.4.gp'  } else { load 'common.inc.5.gp' } 

allocators  = "hoard jemalloc llalloc ptmalloc2 streamflow supermalloc tbbmalloc_proxy tcmalloc compact scalloc"
labels      = "Hoard jemalloc llalloc ptmalloc2 Streamflow SuperMalloc TBB TCMalloc compact scalloc"
styles      = "7 1 2 3 6 10 4 5 9 40"
