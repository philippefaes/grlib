//Example design with a slave pass through port and a verilog top level
module basic_passthru
  (
    input [31:0]      gpio_in,
    input             leon_clk,
    input             leon_clk_reset_n,
    input             usb_uart_rxd,
    output            usb_uart_txd,
    input             dsurx,
    output            dsutx,
    output [31:0]     gpio_out,
    output [31:0]     gpio_oen,

   //SPI with 8 chip-selects
    output            sck_o,
    output            mosi_o,
    output [7:0]      ssn_o,
    input             miso_i

   );

   parameter [31:0] DATAWIDTH = 32;
   parameter [31:0] CORE_ACDM = 1;

   //S0 used internally & not going to i/o ports, so declare vectors
   wire [31:0]             s0_haddr;
   wire [1:0]              s0_htrans;
   wire [2:0]              s0_hsize;
   wire [2:0]              s0_hburst;
   wire [DATAWIDTH-1:0]    s0_hwdata;
   wire [3:0]              s0_hprot;
   wire [3:0]              s0_hmaster;
   wire [0:3]              s0_hmbsel;
   wire [1:0]              s0_hresp;
   wire [DATAWIDTH-1:0]    s0_hrdata;
   wire [15:0]             s0_hsplit;
   wire                    s0_hcache_o = 0;
   wire                    s0_hirq_o = 0;

   //S1 .. S3 Unused, so declare vectors and tie off the inputs
   wire [31:0]             s1_haddr;
   wire [1:0]              s1_htrans;
   wire [2:0]              s1_hsize;
   wire [2:0]              s1_hburst;
   wire [DATAWIDTH-1:0]    s1_hwdata;
   wire [3:0]              s1_hprot;
   wire [3:0]              s1_hmaster;
   wire [0:3]              s1_hmbsel;
   wire                    s1_hready_o = 1;
   wire [1:0]              s1_hresp = 0;
   wire [63:0]             s1_hrdata = 0;
   wire [15:0]             s1_hsplit = 0;
   wire                    s1_hcache_o = 0;
   wire                    s1_hirq_o = 0;

   wire [31:0]             s2_haddr;
   wire [1:0]              s2_htrans;
   wire [2:0]              s2_hsize;
   wire [2:0]              s2_hburst;
   wire [DATAWIDTH-1:0]    s2_hwdata;
   wire [3:0]              s2_hprot;
   wire [3:0]              s2_hmaster;
   wire [0:3]              s2_hmbsel;
   wire                    s2_hready_o = 1;
   wire [1:0]              s2_hresp = 0;
   wire [63:0]             s2_hrdata = 0;
   wire [15:0]             s2_hsplit = 0;
   wire                    s2_hcache_o = 0;
   wire                    s2_hirq_o = 0;
   
   wire [31:0]             s3_haddr;
   wire [1:0]              s3_htrans;
   wire [2:0]              s3_hsize;
   wire [2:0]              s3_hburst;
   wire [DATAWIDTH-1:0]    s3_hwdata;
   wire [3:0]              s3_hprot;
   wire [3:0]              s3_hmaster;
   wire [0:3]              s3_hmbsel;
   wire                    s3_hready_o = 1;
   wire [1:0]              s3_hresp = 0;
   wire [63:0]             s3_hrdata = 0;
   wire [15:0]             s3_hsplit = 0;
   wire                    s3_hcache_o = 0;
   wire                    s3_hirq_o = 0;

   //M0 .. M1 Unused, so declare vectors and tie off the inputs
   wire [1:0]              m0_hresp;
   wire [DATAWIDTH-1:0]    m0_hrdata;
   wire                    m0_hbusreq = 0;
   wire                    m0_hlock = 0;
   wire [1:0]              m0_htrans = 0;
   wire [31:0]             m0_haddr = 0;
   wire                    m0_hwrite = 0;
   wire [2:0]              m0_hsize = 0;
   wire [2:0]              m0_hburst = 0;
   wire [3:0]              m0_hprot = 0;
   wire [63:0]             m0_hwdata = 0;
   wire                    m0_hirq_o = 0;

   wire [1:0]              m1_hresp;
   wire [DATAWIDTH-1:0]    m1_hrdata;
   wire                    m1_hbusreq = 0;
   wire                    m1_hlock = 0;
   wire [1:0]              m1_htrans = 0;
   wire [31:0]             m1_haddr = 0;
   wire                    m1_hwrite = 0;
   wire [2:0]              m1_hsize = 0;
   wire [2:0]              m1_hburst = 0;
   wire [3:0]              m1_hprot = 0;
   wire [63:0]             m1_hwdata = 0;
   wire                    m1_hirq_o = 0;

   
   leon3mp_core #
     (
      .CFG_AHBDW(DATAWIDTH),
      .CFG_AHB_ACDM(CORE_ACDM)
      ) leon3mp_core
     (
      .clk             (leon_clk)
      ,.rstn           (leon_clk_reset_n)
      ,.dsurx          (dsurx)
      ,.rxd1           (usb_uart_rxd)
      ,.dsutx          (dsutx)
      ,.txd1           (usb_uart_txd)
      ,.dsubreak       (1'b0)
      ,.dsuactive      ()
      ,.gpio_in        (gpio_in)
      ,.gpio_out       (gpio_out)
      ,.gpio_oen       (gpio_oen)
      
      // Master #0 pass through
      ,.m0_hgrant      (m0_hgrant)
      ,.m0_hready      (m0_hready)
      ,.m0_hresp       (m0_hresp[1:0])
      ,.m0_hrdata      (m0_hrdata[DATAWIDTH-1:0])
      ,.m0_hcache      (m0_hcache)
      ,.m0_hirq        (m0_hirq)
      ,.m0_hbusreq     (m0_hbusreq)
      ,.m0_hlock       (m0_hlock)
      ,.m0_htrans      (m0_htrans[1:0])
      ,.m0_haddr       (m0_haddr[31:0])
      ,.m0_hwrite      (m0_hwrite)
      ,.m0_hsize       (m0_hsize[2:0])
      ,.m0_hburst      (m0_hburst[2:0])
      ,.m0_hprot       (m0_hprot[3:0])
      ,.m0_hwdata      (m0_hwdata[DATAWIDTH-1:0])
      ,.m0_hirq_o      (m0_hirq_o)

      // Master #1 pass through
      ,.m1_hgrant      (m1_hgrant)
      ,.m1_hready      (m1_hready)
      ,.m1_hresp       (m1_hresp[1:0])
      ,.m1_hrdata      (m1_hrdata[DATAWIDTH-1:0])
      ,.m1_hcache      (m1_hcache)
      ,.m1_hirq        (m1_hirq)
      ,.m1_hbusreq     (m1_hbusreq)
      ,.m1_hlock       (m1_hlock)
      ,.m1_htrans      (m1_htrans[1:0])
      ,.m1_haddr       (m1_haddr[31:0])
      ,.m1_hwrite      (m1_hwrite)
      ,.m1_hsize       (m1_hsize[2:0])
      ,.m1_hburst      (m1_hburst[2:0])
      ,.m1_hprot       (m1_hprot[3:0])
      ,.m1_hwdata      (m1_hwdata[DATAWIDTH-1:0])
      ,.m1_hirq_o      (m1_hirq_o)

      // Slave #0 pass through
      ,.s0_hsel        (s0_hsel)
      ,.s0_haddr       (s0_haddr[31:0])
      ,.s0_hwrite      (s0_hwrite)
      ,.s0_htrans      (s0_htrans[1:0])
      ,.s0_hsize       (s0_hsize[2:0])
      ,.s0_hburst      (s0_hburst[2:0])
      ,.s0_hwdata      (s0_hwdata[DATAWIDTH-1:0])
      ,.s0_hprot       (s0_hprot[3:0])
      ,.s0_hready_o    (s0_hready_o)
      ,.s0_hmaster     (s0_hmaster[3:0])
      ,.s0_hmastlock   (s0_hmastlock)
      ,.s0_hmbsel      (s0_hmbsel[0:3])
      ,.s0_hcache_o    (s0_hcache_o)
      ,.s0_hirq_o      (s0_hirq_o)
      ,.s0_hready      (s0_hready)
      ,.s0_hresp       (s0_hresp[1:0])
      ,.s0_hrdata      (s0_hrdata[DATAWIDTH-1:0])
      ,.s0_hsplit      (s0_hsplit)
      ,.s0_hcache      (s0_hcache)
      ,.s0_hirq        (s0_hirq)

      // Slave #1 pass through
      ,.s1_hsel        (s1_hsel)
      ,.s1_haddr       (s1_haddr[31:0])
      ,.s1_hwrite      (s1_hwrite)
      ,.s1_htrans      (s1_htrans[1:0])
      ,.s1_hsize       (s1_hsize[2:0])
      ,.s1_hburst      (s1_hburst[2:0])
      ,.s1_hwdata      (s1_hwdata[DATAWIDTH-1:0])
      ,.s1_hprot       (s1_hprot[3:0])
      ,.s1_hready_o    (s1_hready_o)
      ,.s1_hmaster     (s1_hmaster[3:0])
      ,.s1_hmastlock   (s1_hmastlock)
      ,.s1_hmbsel      (s1_hmbsel[0:3])
      ,.s1_hcache_o    (s1_hcache_o)
      ,.s1_hirq_o      (s1_hirq_o)
      ,.s1_hready      (s1_hready)
      ,.s1_hresp       (s1_hresp[1:0])
      ,.s1_hrdata      (s1_hrdata[DATAWIDTH-1:0])
      ,.s1_hsplit      (s1_hsplit)
      ,.s1_hcache      (s1_hcache)
      ,.s1_hirq        (s1_hirq)

      // Slave #2 pass through
      ,.s2_hsel        (s2_hsel)
      ,.s2_haddr       (s2_haddr[31:0])
      ,.s2_hwrite      (s2_hwrite)
      ,.s2_htrans      (s2_htrans[1:0])
      ,.s2_hsize       (s2_hsize[2:0])
      ,.s2_hburst      (s2_hburst[2:0])
      ,.s2_hwdata      (s2_hwdata[DATAWIDTH-1:0])
      ,.s2_hprot       (s2_hprot[3:0])
      ,.s2_hready_o    (s2_hready_o)
      ,.s2_hmaster     (s2_hmaster[3:0])
      ,.s2_hmastlock   (s2_hmastlock)
      ,.s2_hmbsel      (s2_hmbsel[0:3])
      ,.s2_hcache_o    (s2_hcache_o)
      ,.s2_hirq_o      (s2_hirq_o)
      ,.s2_hready      (s2_hready)
      ,.s2_hresp       (s2_hresp[1:0])
      ,.s2_hrdata      (s2_hrdata[DATAWIDTH-1:0])
      ,.s2_hsplit      (s2_hsplit)
      ,.s2_hcache      (s2_hcache)
      ,.s2_hirq        (s2_hirq)

      // Slave #3 pass through
      ,.s3_hsel        (s3_hsel)
      ,.s3_haddr       (s3_haddr[31:0])
      ,.s3_hwrite      (s3_hwrite)
      ,.s3_htrans      (s3_htrans[1:0])
      ,.s3_hsize       (s3_hsize[2:0])
      ,.s3_hburst      (s3_hburst[2:0])
      ,.s3_hwdata      (s3_hwdata[DATAWIDTH-1:0])
      ,.s3_hprot       (s3_hprot[3:0])
      ,.s3_hready_o    (s3_hready_o)
      ,.s3_hmaster     (s3_hmaster[3:0])
      ,.s3_hmastlock   (s3_hmastlock)
      ,.s3_hmbsel      (s3_hmbsel[0:3])
      ,.s3_hcache_o    (s3_hcache_o)
      ,.s3_hirq_o      (s3_hirq_o)
      ,.s3_hready      (s3_hready)
      ,.s3_hresp       (s3_hresp[1:0])
      ,.s3_hrdata      (s3_hrdata[DATAWIDTH-1:0])
      ,.s3_hsplit      (s3_hsplit)
      ,.s3_hcache      (s3_hcache)
      ,.s3_hirq        (s3_hirq)
      );

   //Wishbone signals
   wire                 wbm_we_o;
   wire                 wbm_stb_o;
   wire                 wbm_cyc_o;
   wire [31:0]          wbm_adr_o;
   wire [DATAWIDTH-1:0] wbm_dat_o;
   wire [3:0]           wbm_sel_o;
   wire                 wb_inta_i;
   wire                 wbm_ack_i;
   wire                 wbm_rty_i;
   wire                 wbm_err_i;
   wire [DATAWIDTH-1:0] wbm_dat_i;
   
   ahb2wb #
     (
      .HAMAX                            (32),
      .HDMAX                            (DATAWIDTH)
      ) ahb2wb
     (
      // Outputs
      .hready                           (s0_hready_o),
      .hresp                            (s0_hresp[1:0] ),
      .hrdata                           (s0_hrdata[DATAWIDTH-1:0]),
      .hsplit                           (s0_hsplit[15:0]),
      .wbm_we_o                         (wbm_we_o),
      .wbm_stb_o                        (wbm_stb_o),
      .wbm_cyc_o                        (wbm_cyc_o),
      .wbm_adr_o                        (wbm_adr_o[31:0]),
      .wbm_dat_o                        (wbm_dat_o[DATAWIDTH-1:0]),
      .wbm_sel_o                        (wbm_sel_o[3:0]),
      .irq_o                            (s0_hirq),

      // Inputs
      .hclk                             (leon_clk),
      .hresetn                          (leon_clk_reset_n),
      .hsel                             (s0_hsel),
      .hready_ba                        (s0_hready),
      .hwrite                           (s0_hwrite),
      .hmastlock                        (s0_hmastlock),
      .haddr                            (s0_haddr[31:0]),
      .htrans                           (s0_htrans[1:0]),
      .hsize                            (s0_hsize[2:0]),
      .hburst                           (s0_hburst[2:0]),
      .hwdata                           (s0_hwdata[DATAWIDTH-1:0]),
      .hmaster                          (s0_hmaster[3:0]),
      .wb_inta_i                        (wb_inta_i),
      .wbm_ack_i                        (wbm_ack_i),
      .wbm_rty_i                        (wbm_rty_i),
      .wbm_err_i                        (wbm_err_i),
      .wbm_dat_i                        (wbm_dat_i[DATAWIDTH-1:0]));

   simple_spi_top simple_spi_top
     (
      // Outputs
      .prdata_o                         (wbm_dat_i[7:0]),
      .pirq_o                           (wb_inta_i),
      .sck_o                            (sck_o),
      .mosi_o                           (mosi_o),
      .ssn_o                            (ssn_o[7:0]),

      // Inputs
      .pclk_i                           (leon_clk),
      .prst_i                           (!leon_clk_reset_n),
      .psel_i                           (wbm_cyc_o),
      .penable_i                        (wbm_stb_o),
      .paddr_i                          (wbm_adr_o[2:0]),
      .pwrite_i                         (wbm_we_o),
      .pwdata_i                         (wbm_dat_o[7:0]),
      .miso_i                           (miso_i));
   
endmodule // basic_passthru


