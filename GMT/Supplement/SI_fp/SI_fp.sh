# Process masks
rm *.ps
ps=SI_fp.ps

gmt set PS_MEDIA=Custom_4.45cx2.85c

gmt set PS_MEDIA=Custom_6.2cx3.0c
gmt set MAP_FRAME_WIDTH=0.06c
gmt set MAP_FRAME_PEN=thinner,20/20/20
gmt set MAP_FRAME_TYPE=plain
gmt set MAP_LABEL_OFFSET=1p
gmt set MAP_TITLE_OFFSET=-0.18c

gmt set MAP_TICK_LENGTH_PRIMARY=0.03c
gmt set MAP_GRID_PEN_PRIMARY=thinner,lightgrey
gmt set MAP_ANNOT_OFFSET_PRIMARY=1.5p

gmt set FONT_ANNOT_PRIMARY             = 6p,Helvetica,black
gmt set FONT_ANNOT_SECONDARY           = 6p,Helvetica,black
gmt set FONT_LABEL                     = 6p,Helvetica,black
gmt set FONT_LOGO                      = 6p,Helvetica,black
gmt set FONT_TITLE                     = 6p,Helvetica,black

gmt makecpt -CcbcRdBu.cpt -I -T-1.5/1.5/0.25 -D >divcpt.cpt

J=X4.8c/2.4c

gmt grdimage SI_fp.nc -Q -J$J -Rg -X0.25c -Y0.3c -K -Bwesn+t'AIS fingerprint' -nn -Cdivcpt.cpt > $ps
gmt pscoast -R -J -Dc -A5000/0/1+ai -G170/170/170  -K -O >> $ps
#gmt psscale  -Dx0.2c/-0.4c+w3.6c/0.2c+e+h -R -J -Cdivcpt.cpt -B0.5 -By+l'm' -O -K >> $ps
gmt psscale -Dx5.1c/0.1c+w2.2c/0.25c+e -R -J -Cdivcpt.cpt -Np -B0.5 -O -By+l'm' -S    >> $ps

ps2pdf $ps
