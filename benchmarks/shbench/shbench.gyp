{
  'includes': [ '../common.gypi' ],
  'targets': [
    {
      'target_name': 'shbench',
      'product_name': 'shbench',
      'type' : 'executable',
      'conditions': [
        ['OS=="linux"', {
          'ldflags': [
            '-pthread'
          ]
        }],
      ],
      'defines': [
        'SYS_MULTI_THREAD'
      ],
      'sources': [
        'src/sh6bench.c'
      ],
      'include_dirs': [ 'src' ]
    }
  ]
}

