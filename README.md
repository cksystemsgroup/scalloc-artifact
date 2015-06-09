# Scalloc Artifact Repository

This repository contains the tools and benchmarks needed to build interesting
allocators (including scalloc) and evaluate them in various benchmarks.

## Evaluation

The current stable release for the artifact is 1.0.0.

The artifact has been tested on Ubuntu 14.04 LTS.

The following commands can be used to prepare a new artifact environment

```bash
git clone https://github.com/cksystemsgroup/scalloc-artifact.git
cd scalloc-artifact
tools/make_deps.sh
tools/create_env.sh
```
