//Pass through AHB master port to off-chip
module ahbpassthru_master
  #(
    parameter [31:0]        hindex = 3,
    parameter [31:0]        hirqnum = 3,
    parameter [31:0]        NUMMASTER = 1,  //Number of AHB masters
    parameter [31:0]        NUMIRQ = 32,    //Number of interrupts
    parameter [31:0]        DATAWIDTH = 32  //Data bus width
   )
  (
   //master inputs
    input [0:NUMMASTER-1]   hgrant,    //bus grant
    input                   hready,    //transfer done
    input [1:0]             hresp,     //response type
    input [DATAWIDTH-1:0]   hrdata,    //read data bus
    input                   hcache,    //cacheable
    input [NUMIRQ-1:0]      hirq,      //interrupt bus
   //master outputs
    output                  hbusreq,   //bus request
    output                  hlock,     //lock request
    output [1:0]            htrans,    //transfer type
    output [31:0]           haddr,     //address bus
    output                  hwrite,    //read/write
    output [2:0]            hsize,     //transfer size
    output [2:0]            hburst,    //burst type
    output [3:0]            hprot,     //protection control
    output [DATAWIDTH-1:0]  hwdata,    //write data bus
    output [NUMIRQ-1:0]     hirq_o,    //interrupt buss

   //pass-through ports
   //pass through outputs
    output [0:NUMMASTER-1]  pt_hgrant, //bus grant
    output                  pt_hready, //transfer done
    output [1:0]            pt_hresp,  //response type
    output [DATAWIDTH-1:0]  pt_hrdata, //read data bus
    output                  pt_hcache, //cacheable
    output [NUMIRQ-1:0]     pt_hirq,   //interrupt bus
   //pass through inputs
    input                   pt_hbusreq,//bus request
    input                   pt_hlock,  //lock request
    input [1:0]             pt_htrans, //transfer type
    input [31:0]            pt_haddr,  //address bus
    input                   pt_hwrite, //read/write
    input [2:0]             pt_hsize,  //transfer size
    input [2:0]             pt_hburst, //burst type
    input [3:0]             pt_hprot,  //protection control
    input [DATAWIDTH-1:0]   pt_hwdata, //write data bus
    input [NUMIRQ-1:0]      pt_hirq_o  //interrupt buss
   );


   assign                   pt_hgrant  = hgrant ; 
   assign                   pt_hready  = hready ; 
   assign                   pt_hresp   = hresp  ;  
   assign                   pt_hrdata  = hrdata ; 
   assign                   pt_hcache  = hcache ; 
   assign                   pt_hirq    = hirq   ;   
   
   assign                   hbusreq    = pt_hbusreq;
   assign                   hlock      = pt_hlock  ;  
   assign                   htrans     = pt_htrans ; 
   assign                   haddr      = pt_haddr  ;  
   assign                   hwrite     = pt_hwrite ; 
   assign                   hsize      = pt_hsize  ;  
   assign                   hburst     = pt_hburst ; 
   assign                   hprot      = pt_hprot  ;  
   assign                   hwdata     = pt_hwdata ; 
   assign                   hirq_o     = pt_hirq_o ;

endmodule
