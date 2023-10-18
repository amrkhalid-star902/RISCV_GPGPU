`ifndef RV_PLATFORM
`define RV_PLATFORM


`define IGNORE_UNUSED_BEGIN  

`define IGNORE_UNUSED_END     

`define IGNORE_WARNINGS_BEGIN 

`define IGNORE_WARNINGS_END   

`define UNUSED_PARAM(x)  /* verilator lint_off UNUSED */ \
                         localparam  __``x = x; \
                         /* verilator lint_on UNUSED */

`define UNUSED_VAR(x) always @(x) begin end

`define UNUSED_PIN(x)  /* verilator lint_off PINCONNECTEMPTY */ \
                       . x () \
                       /* verilator lint_on PINCONNECTEMPTY */
                       
`define LOG2UP(x)   (((x) > 1) ? $clog2(x) : 1)
`define UP(x)       (((x) > 0) ? (x) : 1)
`define CLOG2(x)    $clog2(x)


`endif
