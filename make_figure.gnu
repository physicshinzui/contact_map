set terminal postscript enhanced color font "helvetica" 20
set output "contact_map.eps"
unset contour
unset surface
set pm3d at b
set view map

#set palette color rgbformulae 33, 13, 10
#set palette cubehelix start 1 cycles 0 saturation 2 negative
#set palette defined(0"#000000",1"#0000ff",2"#1e90ff",3"#00ffff")
set palette defined ( 0 '#000090',1 '#000fff',2 '#0090ff',3 '#0fffee',4 '#90ff70',5 '#ffee00',6 '#ff7000',7 '#ee0000',8 '#7f0000')

set border lw 3
set mxtics default #10
set mytics default #10

#set xrange [420:459]
#set yrange [420:459]

#set xrange [451:459]
#set yrange [451:459]

set xrange [0:10]
set yrange [0:10]

#set xtics ('F451' 450, 'N452' 451, 'T453' 452, 'P454' 453, 'S455' 454, 'I456' 455, 'E457' 456, 'K458' 457, 'P459' 458 )
#set xtics ('F451' 451, 'N452' 452, 'T453' 453, 'P454' 454, 'S455' 455, 'I456' 456, 'E457' 457, 'K458' 458, 'P459' 459 )

splot "c_mat.out" matrix notitle


#------------------
#XTICS="`awk 'BEGIN{getline}{printf "%s ",$1}' c_mat.out`"
#YTICS="`head -1 c_mat.out`"
#set for [i=1:words(XTICS)] xtics ( word(XTICS,i) i-1 )
#set for [i=1:words(YTICS)] ytics ( word(YTICS,i) i-1 )
#plot "<awk '{$1=\"\"}1' c_mat.out | sed '1 d'" matrix #w image
