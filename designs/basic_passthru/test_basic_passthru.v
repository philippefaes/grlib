//Testbench doesn't do anything except toggle the clock and release reset.
`timescale 1ns / 100ps
module test_basic_passthru;

   reg         leon_clk;
   reg         leon_clk_reset_n;
   reg [31:0]  gpio_in;
   wire [31:0] gpio_out;
   wire [31:0] gpio_oen;
   reg         usb_uart_rxd;
   reg         dsurx;
   reg         miso_i;
   wire [7:0]  ssn_o;
   
   initial leon_clk = 0; always #5 leon_clk <= !leon_clk; //100MHz clock
   initial begin
      leon_clk_reset_n = 0;
      gpio_in = 0;
      usb_uart_rxd = 1; //UART's should be '1' when idle
      dsurx = 1;
      miso_i = 0; //SPI should be '0' when idle
      repeat (10) @(posedge leon_clk);
      leon_clk_reset_n <= 1;
      repeat (10000) @(posedge leon_clk);
      $stop;
   end
   
   basic_passthru basic_passthru 
       (
        // Outputs
        .usb_uart_txd         (usb_uart_txd),
        .dsutx                (dsutx),
        .gpio_out             (gpio_out[31:0]),
        .gpio_oen             (gpio_oen[31:0]),
        .sck_o                (sck_o),
        .mosi_o               (mosi_o),
        .ssn_o                (ssn_o[7:0]),
        // Inputs
        .gpio_in              (gpio_in[31:0]),
        .leon_clk             (leon_clk),
        .leon_clk_reset_n     (leon_clk_reset_n),
        .usb_uart_rxd         (usb_uart_rxd),
        .dsurx                (dsurx),
        .miso_i               (miso_i));
   
endmodule // test_basic_passthru

   