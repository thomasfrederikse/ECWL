# Process masks
rm *.ps
ps=msl_scenarios.ps

gmt set PS_MEDIA=Custom_8.5cx13.0c
gmt set PS_PAGE_ORIENTATION=portrait

gmt set MAP_FRAME_WIDTH=0.06c
gmt set MAP_FRAME_PEN=thinner,20/20/20
gmt set MAP_FRAME_TYPE=plain
gmt set MAP_LABEL_OFFSET=1p
gmt set MAP_TITLE_OFFSET=-0.22c
gmt set MAP_TICK_LENGTH_PRIMARY=0.03c
gmt set MAP_GRID_PEN_PRIMARY=thinner,lightgrey
gmt set MAP_ANNOT_OFFSET_PRIMARY=1.5p

gmt set FONT_ANNOT_PRIMARY             = 8p,Helvetica,black
gmt set FONT_ANNOT_SECONDARY           = 8p,Helvetica,black
gmt set FONT_LABEL                     = 8p,Helvetica,black
gmt set FONT_LOGO                      = 8p,Helvetica,black
gmt set FONT_TITLE                     = 8p,Helvetica,black

gmt makecpt -Clajolla -T0/1.5/0.075 -D >endcpt.cpt
gmt makecpt -Clajolla -T0/1.5/0.075 -D >midcpt.cpt

J=X4.0c/2.0c
xjump=4.1c
yjump=-2.35c
yjump2=-2.75c

dirname=~/Data/Extremes/Paper/msl_scenarios

### 2050
gmt grdimage $dirname/msl_rcp26_2050.nc?total_slr[0] -Q -J$J -Rg -Y10.7c -X0.3c -K -Bwesn+t"RCP2.6 0 cm" -nn -Cmidcpt.cpt > $ps
gmt pscoast -R -J -Dc -A5000/0/1+ai -G170/170/170  -K -O >> $ps
echo "3 -78 a 23 cm" | gmt pstext -R -J -F+f8,Helvetica-Bold+jLM -O -K >> $ps

gmt grdimage $dirname/msl_rcp85_2050.nc?total_slr[0] -Q -J$J -Rg -X$xjump -O -K -Bwesn+t"RCP8.5 0cm" -nn -Cmidcpt.cpt >> $ps
gmt pscoast -R -J -Dc -A5000/0/1+ai -G170/170/170  -K -O >> $ps
echo "3 -78 b 28 cm" | gmt pstext -R -J -F+f8,Helvetica-Bold+jLM -O -K >> $ps

gmt grdimage $dirname/msl_rcp26_2050.nc?total_slr[2] -Q -J$J -Rg -Y$yjump -X-$xjump -O -K -Bwesn+t'RCP2.6 10 cm' -nn -Cmidcpt.cpt >> $ps
gmt pscoast -R -J -Dc -A5000/0/1+ai -G170/170/170  -K -O >> $ps
echo "3 -78 c 33 cm" | gmt pstext -R -J -F+f8,Helvetica-Bold+jLM -O -K >> $ps
echo "180 100 2046-2065" |  gmt pstext -D-2.15c/0c -R -J -N -F+f8,Helvetica-Bold+jCM+a90 -O -K >> $ps

gmt grdimage $dirname/msl_rcp85_2050.nc?total_slr[2] -Q -J$J -Rg -X$xjump -O -K -Bwesn+t'RCP8.5 10 cm'  -nn -Cmidcpt.cpt >> $ps
gmt pscoast -R -J -Dc -A5000/0/1+ai -G170/170/170  -K -O >> $ps
echo "3 -78 d 38 cm" | gmt pstext -R -J -F+f8,Helvetica-Bold+jLM -O -K >> $ps

### 2100

gmt grdimage $dirname/msl_rcp26_2100.nc?total_slr[0] -Q -J$J -Rg -Y$yjump2 -X-$xjump -O -K -Bwesn+t'RCP2.6 0 cm'  -nn -Cendcpt.cpt >> $ps
gmt pscoast -R -J -Dc -A5000/0/1+ai -G170/170/170  -K -O >> $ps
echo "3 -78 e 36 cm" | gmt pstext -R -J -F+f8,Helvetica-Bold+jLM -O -K >> $ps

gmt grdimage $dirname/msl_rcp85_2100.nc?total_slr[0] -Q -J$J -Rg -X$xjump -O -K -Bwesn+t'RCP8.5 0 cm'  -nn -Cendcpt.cpt >> $ps
gmt pscoast -R -J -Dc -A5000/0/1+ai -G170/170/170  -K -O >> $ps
echo "3 -78 f 60 cm" | gmt pstext -R -J -F+f8,Helvetica-Bold+jLM -O -K >> $ps

gmt grdimage $dirname/msl_rcp26_2100.nc?total_slr[3] -Q -J$J -Rg -Y$yjump -X-$xjump -O -K -Bwesn+t'RCP2.6 15 cm'  -nn -Cendcpt.cpt >> $ps
gmt pscoast -R -J -Dc -A5000/0/1+ai -G170/170/170  -K -O >> $ps
echo "3 -74 g 51 cm" | gmt pstext -R -J -F+f8,Helvetica-Bold+jLM -O -K >> $ps
echo "180 0 2081-2100" |  gmt pstext -D-2.15c/0c -R -J -N -F+f8,Helvetica-Bold+jCM+a90 -O -K >> $ps

gmt grdimage $dirname/msl_rcp85_2100.nc?total_slr[5] -Q -J$J -Rg -X$xjump -O -K -Bwesn+t'RCP8.5 30 cm'  -nn -Cendcpt.cpt >> $ps
gmt pscoast -R -J -Dc -A5000/0/1+ai -G170/170/170  -K -O >> $ps
echo "3 -78 h 90 cm" | gmt pstext -R -J -F+f8,Helvetica-Bold+jLM -O -K >> $ps

gmt grdimage $dirname/msl_rcp26_2100.nc?total_slr[5] -Q -J$J -Rg -Y$yjump -X-$xjump -O -K -Bwesn+t'RCP2.6 30 cm'  -nn -Cendcpt.cpt >> $ps
gmt pscoast -R -J -Dc -A5000/0/1+ai -G170/170/170  -K -O >> $ps
echo "3 -78 i 66 cm" | gmt pstext -R -J -F+f8,Helvetica-Bold+jLM -O -K >> $ps

gmt grdimage $dirname/msl_rcp85_2100.nc?total_slr[7] -Q -J$J -Rg -X$xjump -O -K -Bwesn+t'RCP8.5 60 cm'  -nn -Cendcpt.cpt >> $ps
gmt pscoast -R -J -Dc -A5000/0/1+ai -G170/170/170  -K -O >> $ps
echo "3 -74 j 120 cm" | gmt pstext -R -J -F+f8,Helvetica-Bold+jLM -O -K >> $ps
gmt psscale  -Dx-3.7c/-0.45c+w7.3c/0.3c+e+h -R -J -Np -Cendcpt.cpt -B0.15 -By+l'm' -O -K >> $ps

ps2pdf $ps
