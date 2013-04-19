#! /usr/bin/tclsh
#
# Utility to generate checkbit data for ddr2spa
# Copyright 2010, Aeroflex Gaisler AB.
#
# Usage: tclsh ddr2rs.tcl 32 <sdram.srec >checkbits.srec
#
# Limitations:
# - Each line of the SREC must contain a multiple of 8 bytes of data
# - Records other than S1-3 are passed on unchanged
# - SREC checksums are not correct
#
# Revision history:
#   2010-11-08, MH, First version
#   2011-01-21, MH, Added new GF4 BCH code
#



# ----------------------------------------------------------
# RS & GF4-BCH Encoding Routines

#               0  1  2  3  4  5  6  7  8  9 10 11 12 13 14 15
set valtable {  0  1  2  3  4  5  6  7  8  9  A  B  C  D  E  F }
set pwrtable {  1  2  4  8  3  6  C  B  5  A  7  E  F  D  9 }

for { set i 0 } { $i < 15 } { incr i } {
    set logtable([lindex $pwrtable $i]) $i
}

for { set i 0 } { $i < 16 } { incr i } {
    set symval([lindex $valtable $i]) $i
}

proc gf4mul { a b } {
    global pwrtable;
    global logtable;
    # puts "gf4mul $a x $b"
    if { $a == 0 || $b == 0 } then { return 0; }
    return [ lindex $pwrtable [ expr { ($logtable($a) + $logtable($b)) % 15 } ] ];
}

proc gf4add { a b } {
    global symval
    global valtable;
    return [ lindex $valtable [ expr { $symval($a) ^ $symval($b) } ] ]
}

proc rsencode { data } {
    set m0 0
    set m1 0
    for {set i 0} {$i < [string length $data]} {incr i} {
	set fb [ gf4add $m1 [ string index $data $i ] ]
	set m1 [ gf4add $m0 [ gf4mul $fb E ] ]
	set m0 $fb
    }
    return "$m1$m0"
}

proc bch4encode { data } {
    global valtable;
    set l [ string length $data ]
    set s $l
    set c15 0
    set c16 0
    for {set i 0} {$i < $l} {incr i} {
	set k [ string index $data $i ]
	set c15 [ gf4add $c15 [ gf4mul $k [ lindex $valtable $s ] ] ]
	set c16 [ gf4add $c16 $k ]
	set s [ expr { $s - 1 } ]
    }
    return "$c15$c16"
}

# Remove first char of invar and put it at end of outvar
proc movechar { invar outvar } {
    upvar $invar  i
    upvar $outvar o
    set c [ string index $i 0 ]
    set i [ string range $i 1 [ string length $i ] ]
    set o "$o$c"
}

proc i4encode { data code ddrbits } {
    # Split into interleaved parts using eval trick
    set perm_pattern { C D A B A B C D B A D C D C B A }
    set A ""
    set B ""
    set C ""
    set D ""
    foreach x $perm_pattern { movechar data $x }    
    # puts "A: $A B: $B C: $C D: $D"    
    if { $code eq "BRS" } then {
	set Acs [ rsencode "$C$A" ]
	set Bcs [ rsencode "$D$B" ]
	set Ccs "00"
	set Dcs "00"
    } elseif { $code eq "ARS" } {
	set Acs [ rsencode $A ]
	set Bcs [ rsencode $B ]
	set Ccs [ rsencode $C ]
	set Dcs [ rsencode $D ]
    } elseif { $code eq "BBCH" } {
	set Acs [ bch4encode "$C$A" ]
	set Bcs [ bch4encode "$D$B" ]
	set Ccs "00"
	set Dcs "00"	
    } else {
	set Acs [ bch4encode $A ]
	set Bcs [ bch4encode $B ]
	set Ccs [ bch4encode $C ]
	set Dcs [ bch4encode $D ]
    }

    if { [string index $code 0] eq "B" } then {
	set cb_perm_pattern [switch $ddrbits { 
	    16      { subst "_ _ _ A _ _ _ B _ _ _ A _ _ _ A" }
	    32      { subst "_ _ _ _ _ _ A B _ _ _ _ _ _ B A" }
	    default { subst "_ _ _ _ _ _ _ _ _ _ _ _ A B A B" } } ]
	set _cs "000000000000"
    } else {
	set cb_perm_pattern [switch $ddrbits { 
	    16      { subst "_ _ B A _ _ A B _ _ D C _ _ C D" }
	    32      { subst "_ _ _ _ C D A B _ _ _ _ B A D C" }
	    default { subst "_ _ _ _ _ _ _ _ C D A B C D A B" } } ]
	set _cs "00000000"
    }
    set r ""
    foreach x $cb_perm_pattern { movechar [ format "%s%s" "$x" "cs" ] r }
    return $r;
}

# -------------------------------------------------------------
# SREC processing

proc hex2int { h } {
    global symval
    set l [string length $h]
    set r 0
    for {set i 0} {$i < $l} {incr i} {
	set r [expr {($r << 4) + $symval([string index $h $i])}]
    }
    return $r;
}

# puts [ i4encode "0123456789ABCDEF" A 64 ]

if {$argc > 0} then {
    set ddrbits [lindex $argv 0]
} else {
    puts stderr "Syntax: $argv0 <ddrbits> \[code\]"
    puts stderr "\nData SREC on standard input, checkbit SREC on standard output"
    puts stderr "Valid ddrbits: 16,32,64"
    puts stderr "Valid codes: ABCH (default) BBCH ARS BRS"
    exit
}
set code "A"
if {$argc > 1} then {
    set code [lindex $argv 1]
}

set lineno 0
while { ! [eof stdin] } {
    set l [gets stdin]
    incr lineno
    set llen [string length $l]
    if { $llen == 0 } then continue
    set rt [string index $l 1 ]
    if { $rt > 0 && $rt < 4 } then {
	# Byte count and data position
	set bc [expr { [hex2int [string range $l 2 3]] - 2 - $rt } ]
	set dp [expr {6 + $rt*2}]

	if { [expr {$bc & 7}] != 0 } then {
	    puts stderr "Warning: Padding line $lineno to even multiple of 8 bytes"
	    while { [expr {$bc & 7}] != 0 } {
		set l0 [ string range $l 0 [expr {$llen-3}] ]
		set l1 [ string range $l [expr {$llen-2}] $llen ]
		set l [format "%s%s%s" $l0 "00" $l1]
		incr bc
		incr llen
		incr llen
	    }
	    # puts stderr "Became: $l"
	}
	# puts "Before: $l"

	while { $bc > 0 } {
	    set cb [i4encode [string range $l $dp [expr {$dp+15}]] A $ddrbits ]
	    set p0 [string range "$l" 0 [expr {$dp-1}]]
	    set pn [string range "$l" [expr $dp+16] [string length $l]]
	    # puts "bc: $bc dp: $dp cb: $cb p0: $p0 pn: $pn"
	    set l [ format "%s%s%s" "$p0" "$cb" "$pn" ]
	    set bc [ expr {$bc-8} ]
	    set dp [ expr {$dp+16} ]
	}	
	# puts "After: $l"		
    }
    puts $l
}


