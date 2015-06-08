{
  'target_defaults': {
    'configurations': {
      'Debug': {
        'CFLAGS': ['-g', '-gdwarf-2', '-O0'],
        'xcode_settings': {
          'OTHER_CFLAGS': [ '-g', '-gdwarf-2', '-O0'],
        }
      },
      'Release': {
        'CFLAGS': [ '-O3' ],
        'xcode_settings': {
          'OTHER_CFLAGS': [ '-O3' ],
        }
      }
    }
  },
}
