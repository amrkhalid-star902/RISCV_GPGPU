`timescale 1ns / 1ps

`include "RV_define.vh"


module rv_fpu_tb();

reg clk , reset;
reg fpu_req_if_valid;
reg [`UUID_BITS-1 : 0]     fpu_req_if_uuid;
reg [`NW_BITS-1 : 0]       fpu_req_if_wid;
reg [`NUM_THREADS-1 : 0]   fpu_req_if_tmask;
reg [31 : 0]  fpu_req_if_PC;
reg [`INST_FPU_BITS-1 : 0]   fpu_req_if_op_type;
reg [`INST_MOD_BITS-1  : 0]   fpu_req_if_op_mod;
reg [(`NUM_THREADS*32)-1 : 0] fpu_req_if_rs1_data;
reg [(`NUM_THREADS*32)-1 : 0] fpu_req_if_rs2_data;
reg [(`NUM_THREADS*32)-1 : 0] fpu_req_if_rs3_data;
reg [`NR_BITS-1 : 0]        fpu_req_if_rd;
reg fpu_req_if_wb;
reg [`INST_FRM_BITS-1 : 0]      fpu_to_csr_if_read_frm;
reg fpu_commit_if_ready;
reg [`NUM_WARPS-1 : 0]          csr_pending;

wire                            fpu_req_if_ready;
wire                            fpu_to_csr_if_write_enable;
wire [`NW_BITS-1 : 0]                    fpu_to_csr_if_write_wid;
wire                            fpu_to_csr_if_write_fflags_NV;
wire                            fpu_to_csr_if_write_fflags_DZ;
wire                            fpu_to_csr_if_write_fflags_OF;
wire                            fpu_to_csr_if_write_fflags_UF;
wire                            fpu_to_csr_if_write_fflags_NX;
wire [`NW_BITS-1 : 0]                    fpu_to_csr_if_read_wid;
wire                            fpu_commit_if_valid;
wire [`UUID_BITS-1  : 0]                   fpu_commit_if_uuid;
wire [`NW_BITS-1 : 0]                    fpu_commit_if_wid;
wire [`NUM_THREADS-1 : 0]                    fpu_commit_if_tmask;
wire [31 : 0]                   fpu_commit_if_PC;
wire [(`NUM_THREADS*32)-1 : 0]             fpu_commit_if_data;
wire [`NR_BITS-1 : 0]                    fpu_commit_if_rd;
wire                            fpu_commit_if_wb;
wire                            fpu_commit_if_eop;
wire [`NUM_WARPS-1 : 0]                    pending;

RV_fpu_unit#(
    
    .CORE_ID(0)

)fpu(
    
    clk,
    reset,
      
    fpu_req_if_valid,
    fpu_req_if_uuid,
    fpu_req_if_wid,     //The ID of requested warp
    fpu_req_if_tmask,   //Thread Mask
    fpu_req_if_PC,
    fpu_req_if_op_type,
    fpu_req_if_op_mod,
    fpu_req_if_rs1_data,
    fpu_req_if_rs2_data,
    fpu_req_if_rs3_data,
    fpu_req_if_rd,
    fpu_req_if_wb,
    fpu_to_csr_if_read_frm,
    fpu_commit_if_ready,
    csr_pending,
    
    fpu_req_if_ready,
    fpu_to_csr_if_write_enable,
    fpu_to_csr_if_write_wid,
    fpu_to_csr_if_write_fflags_NV,
    fpu_to_csr_if_write_fflags_DZ,
    fpu_to_csr_if_write_fflags_OF,
    fpu_to_csr_if_write_fflags_UF,
    fpu_to_csr_if_write_fflags_NX,
    fpu_to_csr_if_read_wid,
    fpu_commit_if_valid,
    fpu_commit_if_uuid,
    fpu_commit_if_wid,
    fpu_commit_if_tmask,
    fpu_commit_if_PC,
    fpu_commit_if_data,
    fpu_commit_if_rd,
    fpu_commit_if_wb,
    fpu_commit_if_eop,
    pending
    
);

always@(*)
begin
    #5;
    clk <= ~clk;

end

 always@(posedge clk)
 begin
     
        if(fpu_commit_if_valid)
         begin
             
             $display("%0d" , $signed(fpu_commit_if_data));
         
         end
     
     
end

initial
begin

    clk = 0;
    reset = 1;
    fpu_req_if_valid = 0;
    fpu_req_if_uuid  = 0;
    fpu_req_if_wid   = 0;
    fpu_req_if_tmask = 0;
    fpu_req_if_PC    = 0;
    fpu_req_if_op_type = `INST_FPU_CVTWS;
    fpu_req_if_op_mod  = 0;
    fpu_req_if_rs1_data = 0;
    fpu_req_if_rs2_data = 0;
    fpu_req_if_rs3_data = 0;
    fpu_req_if_rd = 0;
    fpu_req_if_wb = 0;
    fpu_to_csr_if_read_frm = 0;
    fpu_commit_if_ready    = 0;
    csr_pending = 0;
    
    #10;
    reset = 0;
    fpu_req_if_valid = 1;
    fpu_req_if_uuid  = 16;
    fpu_req_if_wid   = 0;
    fpu_req_if_tmask = 4'hf;
    fpu_req_if_PC    = 4;
    fpu_req_if_op_mod  = 0;
    fpu_req_if_rd = 5;
    fpu_req_if_wb = 1;
    fpu_to_csr_if_read_frm = 0;
    fpu_commit_if_ready    = 1;
    csr_pending = 0;
    fpu_req_if_rs1_data = 32'h4296395f;
    fpu_req_if_rs2_data = 32'h444f7813;
    
    #10;
    fpu_req_if_rs1_data = 32'h43964613;
    fpu_req_if_rs2_data = 32'h438a4252;

    #10;
    fpu_req_if_rs1_data = 32'h443f90ea;
    fpu_req_if_rs2_data = 32'hc3b9cb23;
    
    #10;
    fpu_req_if_rs1_data = 32'h445ba402;
    fpu_req_if_rs2_data = 32'h440ee6c4;
    
    #10;
    fpu_req_if_rs1_data = 32'hc3e68323;
    fpu_req_if_rs2_data = 32'hc4455f24;
    
    #10;
    fpu_req_if_rs1_data = 32'hc469dbb9;
    fpu_req_if_rs2_data = 32'hc38e0258;
    
    #10;
    fpu_req_if_rs1_data = 32'hc33bb580;
    fpu_req_if_rs2_data = 32'hc400f1c3;
    
    ///////////////////////////////
    
    #10;
    fpu_req_if_rs1_data = 32'h4443396e;
    fpu_req_if_rs2_data = 32'h444f02de;
    
    #10;
    fpu_req_if_rs1_data = 32'hc351115a;
    fpu_req_if_rs2_data = 32'hc40ecf6c;
    
    
    #10;
    fpu_req_if_rs1_data = 32'hc3f19894;
    fpu_req_if_rs2_data = 32'hc44101ce;
    
    
    #10;
    fpu_req_if_rs1_data = 32'h43edda95;
    fpu_req_if_rs2_data = 32'hc406f76c;
    
    #10;
    fpu_req_if_rs1_data = 32'hc31d4b73;
    fpu_req_if_rs2_data = 32'hc443f533;
    

    
    #10;
    fpu_req_if_rs1_data = 32'hc44bfbcc;
    fpu_req_if_rs2_data = 32'h43bbe857;
    
    
    #10;
    fpu_req_if_rs1_data = 32'hc3890cb1;
    fpu_req_if_rs2_data = 32'h414d4178;
    
    
    #10;
    fpu_req_if_rs1_data = 32'h421f99c6;
    fpu_req_if_rs2_data = 32'hc46e03df;
    
    ////////////////////////////////////////////
    #10;
    fpu_req_if_rs1_data = 32'hc43427ca;
    fpu_req_if_rs2_data = 32'hc3508383;

    #10;
    fpu_req_if_rs1_data = 32'hc4595b48;
    fpu_req_if_rs2_data = 32'hc3c5f43f;
    
    #10;
    fpu_req_if_rs1_data = 32'hc2d80a0f;
    fpu_req_if_rs2_data = 32'hc399be75;
    
    #10;
    fpu_req_if_rs1_data = 32'h4424adfa;
    fpu_req_if_rs2_data = 32'h43d71c02;
    
    #10;
    fpu_req_if_rs1_data = 32'h444a918f;
    fpu_req_if_rs2_data = 32'h4477e589;
    
    #10;
    fpu_req_if_rs1_data = 32'hc3d26bf3;
    fpu_req_if_rs2_data = 32'hc39f42e9;
    
    ///////////////////////////////
    
    #10;
    fpu_req_if_rs1_data = 32'h43aeffc9;
    fpu_req_if_rs2_data = 32'h42627978;
    
    #10;
    fpu_req_if_rs1_data = 32'hc3d0e139;
    fpu_req_if_rs2_data = 32'h444878f6;
    
    
    #10;
    fpu_req_if_rs1_data = 32'hc4213cd2;
    fpu_req_if_rs2_data = 32'h441d97c1;
    
    
    #10;
    fpu_req_if_rs1_data = 32'hc273077d;
    fpu_req_if_rs2_data = 32'hc466155f;
    
    #10;
    fpu_req_if_rs1_data = 32'h42ced727;
    fpu_req_if_rs2_data = 32'hc364163f;
    

    
    #10;
    fpu_req_if_rs1_data = 32'hc2f23f77;
    fpu_req_if_rs2_data = 32'hc3c07bd8;
    
    
    #10;
    fpu_req_if_rs1_data = 32'hc4510d38;
    fpu_req_if_rs2_data = 32'hc3acf90b;
    
    
    #10;
    fpu_req_if_rs1_data = 32'hc39063fb;
    fpu_req_if_rs2_data = 32'h4475c7c7;
    
    
    #10;
    fpu_req_if_rs1_data = 32'h4479a83c;
    fpu_req_if_rs2_data = 32'hc3d1e2e0;
    
    
    #10;
    fpu_req_if_rs1_data = 32'h444e9b70;
    fpu_req_if_rs2_data = 32'h440dd6c1;
    
    
    #10;
    fpu_req_if_rs1_data = 32'h43f1cc1b;
    fpu_req_if_rs2_data = 32'h438c36d2;
    

    
    #20;
    $stop;

end

endmodule
