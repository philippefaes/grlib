onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -format Logic /testbench/sys_clk
add wave -noupdate -format Logic /testbench/sys_rst_in
add wave -noupdate -format Literal /testbench/bus_error
add wave -noupdate -format Literal /testbench/sram_flash_addr
add wave -noupdate -format Literal /testbench/address
add wave -noupdate -format Literal /testbench/sram_flash_data
add wave -noupdate -format Literal /testbench/data
add wave -noupdate -format Logic /testbench/sram_cen
add wave -noupdate -format Literal /testbench/sram_bw
add wave -noupdate -format Logic /testbench/sram_oen
add wave -noupdate -format Logic /testbench/flash_oen
add wave -noupdate -format Logic /testbench/sram_flash_we_n
add wave -noupdate -format Logic /testbench/flash_cen
add wave -noupdate -format Logic /testbench/flash_adv_n
add wave -noupdate -format Logic /testbench/sram_clk
add wave -noupdate -format Logic /testbench/sram_clk_fb
add wave -noupdate -format Logic /testbench/sram_mode
add wave -noupdate -format Logic /testbench/sram_adv_ld_n
add wave -noupdate -format Logic /testbench/iosn
add wave -noupdate -format Literal /testbench/ddr_clk
add wave -noupdate -format Literal /testbench/ddr_clkb
add wave -noupdate -format Literal /testbench/ddr_cke
add wave -noupdate -format Literal /testbench/ddr_csb
add wave -noupdate -format Literal /testbench/ddr_odt
add wave -noupdate -format Logic /testbench/ddr_web
add wave -noupdate -format Logic /testbench/ddr_rasb
add wave -noupdate -format Logic /testbench/ddr_casb
add wave -noupdate -format Literal /testbench/ddr_dm
add wave -noupdate -format Literal /testbench/ddr_dqsp
add wave -noupdate -format Literal /testbench/ddr_dqsn
add wave -noupdate -format Literal /testbench/ddr_rdqs
add wave -noupdate -format Literal /testbench/ddr_ad
add wave -noupdate -format Literal /testbench/ddr_ba
add wave -noupdate -format Literal /testbench/ddr_dq
add wave -noupdate -format Literal /testbench/ddr_dq2
add wave -noupdate -format Logic /testbench/txd1
add wave -noupdate -format Logic /testbench/rxd1
add wave -noupdate -format Logic /testbench/txd2
add wave -noupdate -format Logic /testbench/rxd2
add wave -noupdate -format Literal /testbench/gpio
add wave -noupdate -format Literal /testbench/led
add wave -noupdate -format Logic /testbench/phy_mii_data
add wave -noupdate -format Logic /testbench/phy_tx_clk
add wave -noupdate -format Logic /testbench/phy_rx_clk
add wave -noupdate -format Literal /testbench/phy_rx_data
add wave -noupdate -format Logic /testbench/phy_dv
add wave -noupdate -format Logic /testbench/phy_rx_er
add wave -noupdate -format Logic /testbench/phy_col
add wave -noupdate -format Logic /testbench/phy_crs
add wave -noupdate -format Literal /testbench/phy_tx_data
add wave -noupdate -format Logic /testbench/phy_tx_en
add wave -noupdate -format Logic /testbench/phy_tx_er
add wave -noupdate -format Logic /testbench/phy_mii_clk
add wave -noupdate -format Logic /testbench/phy_rst_n
add wave -noupdate -format Logic /testbench/phy_gtx_clk
add wave -noupdate -format Logic /testbench/ps2_keyb_clk
add wave -noupdate -format Logic /testbench/ps2_keyb_data
add wave -noupdate -format Logic /testbench/ps2_mouse_clk
add wave -noupdate -format Logic /testbench/ps2_mouse_data
add wave -noupdate -format Logic /testbench/tft_lcd_clk
add wave -noupdate -format Logic /testbench/vid_blankn
add wave -noupdate -format Logic /testbench/vid_syncn
add wave -noupdate -format Logic /testbench/vid_hsync
add wave -noupdate -format Logic /testbench/vid_vsync
add wave -noupdate -format Literal /testbench/vid_r
add wave -noupdate -format Literal /testbench/vid_g
add wave -noupdate -format Literal /testbench/vid_b
add wave -noupdate -format Logic /testbench/usb_csn
add wave -noupdate -format Logic /testbench/usb_rstn
add wave -noupdate -format Logic /testbench/iic_scl_main
add wave -noupdate -format Logic /testbench/iic_sda_main
add wave -noupdate -format Logic /testbench/iic_scl_video
add wave -noupdate -format Logic /testbench/iic_sda_video
add wave -noupdate -format Literal /testbench/tft_lcd_data
add wave -noupdate -format Logic /testbench/tft_lcd_clk_p
add wave -noupdate -format Logic /testbench/tft_lcd_clk_n
add wave -noupdate -format Logic /testbench/tft_lcd_hsync
add wave -noupdate -format Logic /testbench/tft_lcd_vsync
add wave -noupdate -format Logic /testbench/tft_lcd_de
add wave -noupdate -format Logic /testbench/tft_lcd_reset_b
add wave -noupdate -format Literal /testbench/sysace_mpa
add wave -noupdate -format Logic /testbench/sysace_mpce
add wave -noupdate -format Logic /testbench/sysace_mpirq
add wave -noupdate -format Logic /testbench/sysace_mpoe
add wave -noupdate -format Logic /testbench/sysace_mpwe
add wave -noupdate -format Literal /testbench/sysace_d
add wave -noupdate -format Logic /testbench/clk_200_p
add wave -noupdate -format Logic /testbench/clk_200_n
add wave -noupdate -format Logic /testbench/clk_33
add wave -noupdate -divider {CPU 1}
add wave -noupdate -format Literal -radix hexadecimal /testbench/cpu/apbi
add wave -noupdate -format Literal -radix hexadecimal /testbench/cpu/apbo
add wave -noupdate -format Literal -radix hexadecimal /testbench/cpu/ahbsi
add wave -noupdate -format Literal -radix hexadecimal /testbench/cpu/ahbso
add wave -noupdate -format Literal -radix hexadecimal /testbench/cpu/ahbmi
add wave -noupdate -format Literal -radix hexadecimal /testbench/cpu/ahbmo
add wave -noupdate -format Logic /testbench/cpu/phy_gtx_clk
add wave -noupdate -format Literal /testbench/cpu/cgi
add wave -noupdate -format Literal /testbench/cpu/cgi2
add wave -noupdate -format Literal /testbench/cpu/cgo
add wave -noupdate -format Literal /testbench/cpu/cgo2
add wave -noupdate -format Logic /testbench/cpu/ps2_mouse_clk
add wave -noupdate -format Logic /testbench/cpu/ps2_mouse_data
add wave -noupdate -format Literal /testbench/cpu/clk_sel
add wave -noupdate -format Logic /testbench/cpu/clkvga
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {52212589 ps} 0}
configure wave -namecolwidth 397
configure wave -valuecolwidth 110
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
update
WaveRestoreZoom {0 ps} {912067800 ps}
