//Pass through AHB slave port to off-chip
module ahbpassthru_slave
  #(
    parameter [31:0]        hindex = 3,
    parameter [31:0]        hirqnum = 3,
    parameter [31:0]        NUMSLAVE = 1,   //Number of AHB slaves
    parameter [31:0]        NUMIRQ = 32,    //Number of interrupts
    parameter [31:0]        NUMBANK = 1,    //Number of Banks
    parameter [31:0]        DATAWIDTH = 32  //Data bus width
    )
    (
     //Slave inputs
    input                   hsel,      //slave select
    input [31:0]            haddr,     //slave address (byte addressing)
    input                   hwrite,    //read/write
    input [1:0]             htrans,    //transfer type
    input [2:0]             hsize,     //transfer size
    input [2:0]             hburst,    //burst type
    input [DATAWIDTH-1:0]   hwdata,    //write data
    input [3:0]             hprot,     //protection control
    input                   hready,    //transfer done
    input [3:0]             hmaster,   //current master
    input                   hmastlock, //locked access
    input [NUMBANK-1:0]     hmbsel,    //memory bank select
    input                   hcache,    //cacheable
    input                   hirq,      //interrupt
   //Slave outputs
    output                  hready_o,  //transfer done
    output [1:0]            hresp,     //response type
    output [DATAWIDTH-1:0]  hrdata,    //read data
    output [15:0]           hsplit,    //split completion
    output                  hcache_o,  //cacheable
    output [NUMIRQ-1:0]     hirq_o,    //interrupt out

   //pass-through ports
   //pass through outputs
    output                  pt_hsel,      //slave select
    output [31:0]           pt_haddr,     //slave address (byte addressing)
    output                  pt_hwrite,    //read/write
    output [1:0]            pt_htrans,    //transfer type
    output [2:0]            pt_hsize,     //transfer size
    output [2:0]            pt_hburst,    //burst type
    output [DATAWIDTH-1:0]  pt_hwdata,    //write data
    output [3:0]            pt_hprot,     //protection control
    output                  pt_hready_o,  //transfer done
    output [3:0]            pt_hmaster,   //current master
    output                  pt_hmastlock, //locked access
    output [NUMBANK-1:0]    pt_hmbsel,    //memory bank select
    output                  pt_hcache_o,  //cacheable
    output                  pt_hirq_o,    //interrupt
    //pass through inputs
    input                   pt_hready,    //transfer done
    input [1:0]             pt_hresp,     //response type
    input [DATAWIDTH-1:0]   pt_hrdata,    //read data
    input [15:0]            pt_hsplit,    //split completion
    input                   pt_hcache,    //cacheable
    input [NUMIRQ-1:0]      pt_hirq       //interrupt out
     );
   
    assign                  pt_hsel = hsel;
    assign                  pt_haddr = haddr;
    assign                  pt_hwrite = hwrite;
    assign                  pt_htrans = htrans;
    assign                  pt_hsize = hsize;
    assign                  pt_hburst = hburst;
    assign                  pt_hwdata = hwdata;
    assign                  pt_hprot = hprot;
    assign                  pt_hready_o = hready;
    assign                  pt_hmaster = hmaster;
    assign                  pt_hmastlock = hmastlock;
    assign                  pt_hmbsel = hmbsel;
    assign                  pt_hcache_o = hcache;
    assign                  pt_hirq_o = hirq;

    assign                  hready_o = pt_hready;
    assign                  hresp = pt_hresp;
    assign                  hrdata = pt_hrdata;
    assign                  hsplit = pt_hsplit;
    assign                  hcache_o = pt_hcache;
    assign                  hirq_o = pt_hirq;
   
   
endmodule
   