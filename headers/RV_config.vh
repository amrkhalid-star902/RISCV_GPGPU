ifndef VX_CONFIG
`define VX_CONFIG

`ifndef XLEN
`define XLEN 32
`endif

`ifndef NUM_CLUSTERS
`define NUM_CLUSTERS 1
`endif

`ifndef NUM_CORES
`define NUM_CORES 1
`endif

`ifndef NUM_WARPS
`define NUM_WARPS 4
`endif

`ifndef NUM_THREADS
`define NUM_THREADS 1
`endif

`ifndef NUM_BARRIERS
`define NUM_BARRIERS 4
`endif

`ifndef L2_ENABLE
`define L2_ENABLE 0
`endif

`ifndef L3_ENABLE
`define L3_ENABLE 0
`endif

`ifndef SM_ENABLE
`define SM_ENABLE 1
`endif

`ifndef MEM_BLOCK_SIZE
`define MEM_BLOCK_SIZE 64
`endif

`ifndef L1_BLOCK_SIZE
`define L1_BLOCK_SIZE ((`L2_ENABLE || `L3_ENABLE) ? 16 : `MEM_BLOCK_SIZE)
`endif
