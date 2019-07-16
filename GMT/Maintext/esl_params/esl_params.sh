# Process masks
rm *.ps
ps=esl_params.ps


gmt set PS_MEDIA=Custom_14.5cx11.2c

gmt set MAP_FRAME_WIDTH=0.06c
gmt set MAP_FRAME_PEN=thinner,20/20/20
gmt set MAP_FRAME_TYPE=plain
gmt set MAP_LABEL_OFFSET=1p
gmt set MAP_TITLE_OFFSET=-0.2c
gmt set PS_PAGE_ORIENTATION=portrait
gmt set MAP_TICK_LENGTH_PRIMARY=0.03c
gmt set MAP_GRID_PEN_PRIMARY=thinner,lightgrey
gmt set MAP_ANNOT_OFFSET_PRIMARY=1.5p

gmt set FONT_ANNOT_PRIMARY             = 8p,Helvetica,black
gmt set FONT_ANNOT_SECONDARY           = 8p,Helvetica,black
gmt set FONT_LABEL                     = 8p,Helvetica,black
gmt set FONT_LOGO                      = 8p,Helvetica,black
gmt set FONT_TITLE                     = 8p,Helvetica,black


gmt makecpt -Cvik           -D -T-0.5/0.5/0.05 > shape.cpt
gmt makecpt -CcbcYlOrRd.cpt -D -T0/0.4/0.02 > scale.cpt
gmt makecpt -CcbcYlGnBu.cpt -D -T0/3/0.15 > location.cpt
gmt makecpt -Clajolla       -D -T0/4/0.2 > rp100.cpt
gmt makecpt -Ctokyo      -I -D -T0/1/0.05 > rp100ci.cpt
gmt makecpt -Cturku      -I -D -T20/100/5 > statyears.cpt

J1=X6.0c/3.0c
xjump=7.4c
xback=-7.4c
yjump=-3.8c

circrad=0.11c
barwidth=0.13cb0
color1=#1f77b4
color2=#2ca02c
color3=#ff7f0e

gmt psbasemap -J$J1 -Rg -Y7.85c -X0.1c -K -Bwesn+t"Shape"  > $ps
gmt pscoast -R -J -Dc -A5000/0/1+ai -G170/170/170 -S#c6dbef -K -O >> $ps
gmt psxy shape.txt -R -J -O -K -Sc$circrad -t35  -Cshape.cpt >> $ps
echo "3 -80 a" | gmt pstext -R -J -F+f8,Helvetica-Bold+jLM -O -K >> $ps
gmt psscale  -Dx6.1c/0c+w3c/0.25c+e-R -J -Np -Cshape.cpt  -B0.2 -O  -S -K >> $ps

gmt psbasemap -J$J1 -Rg -X$xjump -O -K -Bwesn+t"Scale"  >> $ps
gmt pscoast -R -J -Dc -A5000/0/1+ai -G170/170/170 -S#c6dbef -K -O >> $ps
gmt psxy scale.txt -R -J -O -K -Sc$circrad -t35  -Cscale.cpt >> $ps
echo "3 -80 b" | gmt pstext -R -J -F+f8,Helvetica-Bold+jLM -O -K >> $ps
gmt psscale  -Dx6.1c/0c+w3c/0.25c+ef-R -J -Np -Cscale.cpt  -B0.1 -O  -S -K >> $ps

gmt psbasemap -J$J1 -Rg -Y$yjump -X$xback -O -K -Bwesn+t"Location"  >> $ps
gmt pscoast -R -J -Dc -A5000/0/1+ai -G170/170/170 -S#c6dbef -K -O >> $ps
gmt psxy loc.txt -R -J -O -K -Sc$circrad -t35  -Clocation.cpt  >> $ps
echo "3 -80 c" | gmt pstext -R -J -F+f8,Helvetica-Bold+jLM -O -K >> $ps
gmt psscale  -Dx6.1c/0c+w3c/0.25c+ef-R -J -Np -Clocation.cpt -By+l'm' -B0.6 -O  -S -K >> $ps

gmt psbasemap -J$J1 -Rg -X$xjump -O -K -Bwesn+t"Record length"  >> $ps
gmt pscoast -R -J -Dc -A5000/0/1+ai -G170/170/170 -S#c6dbef -K -O >> $ps
gmt psxy num_years.txt -R -J -O -K -Sc$circrad -t25  -Cstatyears.cpt  >> $ps
echo "3 -80 d" | gmt pstext -R -J -F+f8,Helvetica-Bold+jLM -O -K >> $ps
gmt psscale  -Dx6.1c/0c+w3c/0.25c+ef-R -J -Np -Cstatyears.cpt  -By+l'yr' -B20 -O  -S -K >> $ps

gmt psbasemap -J$J1 -Rg -Y$yjump -X$xback -O -K -Bwesn+t"Present-day 100-yr return height"  >> $ps
gmt pscoast -R -J -Dc -A5000/0/1+ai -G170/170/170 -S#c6dbef -K -O >> $ps
gmt psxy rp100.txt -R -J -O -K -Sc$circrad -t35  -Crp100.cpt  >> $ps
echo "3 -80 e" | gmt pstext -R -J -F+f8,Helvetica-Bold+jLM -O -K >> $ps
gmt psscale  -Dx6.1c/0c+w3c/0.25c+ef-R -J -Np -Crp100.cpt  -By+l'm' -B0.8 -O  -S -K >> $ps

gmt psbasemap -J$J1 -Rg -X$xjump -O -K -Bwesn+t"100-yr return height 90% confidence interval"  >> $ps
gmt pscoast -R -J -Dc -A5000/0/1+ai -G170/170/170 -S#c6dbef -K -O >> $ps
gmt psxy rp100_spread.txt -R -J -O -K -Sc$circrad -t35 -Crp100ci.cpt  >> $ps
echo "3 -80 f" | gmt pstext -R -J -F+f8,Helvetica-Bold+jLM -O -K >> $ps
gmt psscale  -Dx6.1c/0c+w3c/0.25c+ef-R -J -Np -Crp100ci.cpt  -By+l'm' -B0.2 -O  -S -K >> $ps

gmt psconvert -Tf $ps
