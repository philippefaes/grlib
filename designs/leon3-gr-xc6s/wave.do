onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -format Logic /testbench/cpu/resetn
add wave -noupdate -format Logic /testbench/cpu/clk
add wave -noupdate -format Logic /testbench/cpu/clk2
add wave -noupdate -format Logic /testbench/cpu/wdogn
add wave -noupdate -format Literal -radix hexadecimal /testbench/cpu/address
add wave -noupdate -format Literal -radix hexadecimal /testbench/cpu/data
add wave -noupdate -format Logic /testbench/cpu/oen
add wave -noupdate -format Logic /testbench/cpu/writen
add wave -noupdate -format Logic /testbench/cpu/romsn
add wave -noupdate -format Logic /testbench/cpu/ddr_clk
add wave -noupdate -format Logic /testbench/cpu/ddr_clkb
add wave -noupdate -format Logic /testbench/cpu/ddr_cke
add wave -noupdate -format Logic /testbench/cpu/ddr_odt
add wave -noupdate -format Logic /testbench/cpu/ddr_we
add wave -noupdate -format Logic /testbench/cpu/ddr_ras
add wave -noupdate -format Logic /testbench/cpu/ddr_cas
add wave -noupdate -format Literal /testbench/cpu/ddr_dm
add wave -noupdate -format Literal /testbench/cpu/ddr_dqs
add wave -noupdate -format Literal -radix hexadecimal /testbench/cpu/ddr_ad
add wave -noupdate -format Literal -radix hexadecimal /testbench/cpu/ddr_ba
add wave -noupdate -format Literal -radix hexadecimal /testbench/cpu/ddr_dq
add wave -noupdate -format Logic /testbench/cpu/ddr_rzq
add wave -noupdate -format Logic /testbench/cpu/ddr_zio
add wave -noupdate -format Logic /testbench/cpu/txd1
add wave -noupdate -format Logic /testbench/cpu/rxd1
add wave -noupdate -format Logic /testbench/cpu/ctsn1
add wave -noupdate -format Logic /testbench/cpu/rtsn1
add wave -noupdate -format Logic /testbench/cpu/txd2
add wave -noupdate -format Logic /testbench/cpu/rxd2
add wave -noupdate -format Logic /testbench/cpu/ctsn2
add wave -noupdate -format Logic /testbench/cpu/rtsn2
add wave -noupdate -format Logic /testbench/cpu/erx_clk
add wave -noupdate -format Logic /testbench/cpu/emdio
add wave -noupdate -format Literal -radix hexadecimal /testbench/cpu/erxd
add wave -noupdate -format Logic /testbench/cpu/erx_dv
add wave -noupdate -format Logic /testbench/cpu/emdint
add wave -noupdate -format Logic /testbench/cpu/etx_clk
add wave -noupdate -format Literal -radix hexadecimal /testbench/cpu/etxd
add wave -noupdate -format Logic /testbench/cpu/etx_en
add wave -noupdate -format Logic /testbench/cpu/emdc
add wave -noupdate -format Literal /testbench/cpu/pio
add wave -noupdate -format Literal /testbench/cpu/genio
add wave -noupdate -format Literal /testbench/cpu/switch
add wave -noupdate -format Literal /testbench/cpu/led
add wave -noupdate -format Literal /testbench/cpu/ps2clk
add wave -noupdate -format Literal /testbench/cpu/ps2data
add wave -noupdate -format Logic /testbench/cpu/iic_scl
add wave -noupdate -format Logic /testbench/cpu/iic_sda
add wave -noupdate -format Logic /testbench/cpu/ddc_scl
add wave -noupdate -format Logic /testbench/cpu/ddc_sda
add wave -noupdate -format Logic /testbench/cpu/dvi_iic_scl
add wave -noupdate -format Logic /testbench/cpu/dvi_iic_sda
add wave -noupdate -format Literal /testbench/cpu/tft_lcd_data
add wave -noupdate -format Logic /testbench/cpu/tft_lcd_clk_p
add wave -noupdate -format Logic /testbench/cpu/tft_lcd_clk_n
add wave -noupdate -format Logic /testbench/cpu/tft_lcd_hsync
add wave -noupdate -format Logic /testbench/cpu/tft_lcd_vsync
add wave -noupdate -format Logic /testbench/cpu/tft_lcd_de
add wave -noupdate -format Logic /testbench/cpu/tft_lcd_reset_b
add wave -noupdate -format Logic /testbench/cpu/spw_clk
add wave -noupdate -format Literal /testbench/cpu/spw_rxdp
add wave -noupdate -format Literal /testbench/cpu/spw_rxdn
add wave -noupdate -format Literal /testbench/cpu/spw_rxsp
add wave -noupdate -format Literal /testbench/cpu/spw_rxsn
add wave -noupdate -format Literal /testbench/cpu/spw_txdp
add wave -noupdate -format Literal /testbench/cpu/spw_txdn
add wave -noupdate -format Literal /testbench/cpu/spw_txsp
add wave -noupdate -format Literal /testbench/cpu/spw_txsn
add wave -noupdate -format Logic /testbench/cpu/usb_clk
add wave -noupdate -format Literal /testbench/cpu/usb_d
add wave -noupdate -format Logic /testbench/cpu/usb_nxt
add wave -noupdate -format Logic /testbench/cpu/usb_stp
add wave -noupdate -format Logic /testbench/cpu/usb_dir
add wave -noupdate -format Logic /testbench/cpu/usb_resetn
add wave -noupdate -format Logic /testbench/cpu/spi_sel_n
add wave -noupdate -format Logic /testbench/cpu/spi_clk
add wave -noupdate -format Logic /testbench/cpu/spi_mosi
add wave -noupdate -format Literal -radix hexadecimal /testbench/cpu/apbi
add wave -noupdate -format Literal -radix hexadecimal /testbench/cpu/apbo
add wave -noupdate -format Literal -radix hexadecimal /testbench/cpu/ahbsi
add wave -noupdate -format Literal -radix hexadecimal /testbench/cpu/ahbso
add wave -noupdate -format Literal -radix hexadecimal /testbench/cpu/ahbmi
add wave -noupdate -format Literal -radix hexadecimal /testbench/cpu/ahbmo
add wave -noupdate -format Logic /testbench/cpu/clkm
add wave -noupdate -format Logic /testbench/cpu/rstn
add wave -noupdate -format Logic /testbench/cpu/rstraw
add wave -noupdate -format Logic /testbench/cpu/mig_gen/ddrc/mcb_inst/c3_sys_clk
add wave -noupdate -format Logic /testbench/cpu/mig_gen/ddrc/mcb_inst/c3_sys_rst_n
add wave -noupdate -format Logic /testbench/cpu/mig_gen/ddrc/mcb_inst/c3_calib_done
add wave -noupdate -format Logic /testbench/cpu/vgadvi/dvi0/clk
add wave -noupdate -format Literal /testbench/cpu/vgadvi/dvi0/vgao
add wave -noupdate -format Logic /testbench/cpu/vgadvi/dvi0/vgaclk
add wave -noupdate -format Logic /testbench/cpu/vgadvi/dvi0/dclk_p
add wave -noupdate -format Logic /testbench/cpu/vgadvi/dvi0/dclk_n
add wave -noupdate -format Logic /testbench/cpu/svga/svga0/vgaclk
add wave -noupdate -format Literal -radix hexadecimal /testbench/cpu/svga/svga0/vgao
add wave -noupdate -format Literal -radix hexadecimal /testbench/cpu/svga/svga0/clk_sel
add wave -noupdate -format Literal -radix hexadecimal /testbench/cpu/svga/svga0/t
add wave -noupdate -format Literal -radix hexadecimal /testbench/cpu/svga/svga0/r
add wave -noupdate -format Literal -radix hexadecimal /testbench/cpu/svga/svga0/dmai
add wave -noupdate -format Literal -radix hexadecimal /testbench/cpu/svga/svga0/dmao
add wave -noupdate -format Logic /testbench/cpu/mig_gen/ddrc/calib_done
add wave -noupdate -format Literal -radix hexadecimal /testbench/cpu/mig_gen/ddrc/r
add wave -noupdate -format Literal -radix hexadecimal /testbench/cpu/mig_gen/ddrc/i
add wave -noupdate -format Literal -radix hexadecimal /testbench/cpu/mig_gen/ddrc/ahbmi
add wave -noupdate -format Literal -radix hexadecimal /testbench/cpu/mig_gen/ddrc/ahbmo
add wave -noupdate -format Literal -radix hexadecimal /testbench/cpu/mig_gen/ddrc/r2
add wave -noupdate -format Literal -radix hexadecimal /testbench/cpu/mig_gen/ddrc/p2
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {6662738 ps} 0} {{Cursor 3} {341676502 ps} 0}
configure wave -namecolwidth 212
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {337706096 ps} {349485406 ps}
