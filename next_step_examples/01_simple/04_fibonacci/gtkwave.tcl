# gtkwave::loadFile "dump.vcd"

lappend all_signals tb.clk
lappend all_signals tb.rst
lappend all_signals tb.num

set num_added [ gtkwave::addSignalsFromList $all_signals ]

gtkwave::/Time/Zoom/Zoom_Full
