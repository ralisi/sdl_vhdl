mkdir Work 2> /dev/null


gcc -c sdl.c


ghdl -a -fexplicit --ieee=synopsys --workdir=Work    *.vhd
ghdl -e --ieee=synopsys -fexplicit --workdir=Work -Wl,sdl.o -Wl,-lSDL ram_tb

mv ram_tb Work
#Work/ram_tb --stop-time=3000ns --wave=ram_tb.ghw
Work/ram_tb --stop-time=1500000ns
#gtkwave ram_tb.ghw ram_tb.traces
#rm ram_tb.ghw

rm -rf Work/
rm *.o
