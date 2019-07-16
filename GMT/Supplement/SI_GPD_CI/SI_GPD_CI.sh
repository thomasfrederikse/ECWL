# Process masks
rm *.ps
ps=SI_GPD_CI.ps


gmt set PS_MEDIA=Custom_16.0cx5.2c

gmt set MAP_FRAME_WIDTH=0.06c
gmt set MAP_FRAME_PEN=thinner,20/20/20
gmt set MAP_FRAME_TYPE=plain
gmt set MAP_LABEL_OFFSET=1p
gmt set MAP_TITLE_OFFSET=-0.2c
gmt set PS_PAGE_ORIENTATION=portrait
gmt set MAP_TICK_LENGTH_PRIMARY=0.03c
gmt set MAP_GRID_PEN_PRIMARY=thinner,lightgrey
gmt set MAP_ANNOT_OFFSET_PRIMARY=1.5p

gmt set FONT_ANNOT_PRIMARY             = 6p,Helvetica,black
gmt set FONT_ANNOT_SECONDARY           = 6p,Helvetica,black
gmt set FONT_LABEL                     = 6p,Helvetica,black
gmt set FONT_LOGO                      = 6p,Helvetica,black
gmt set FONT_TITLE                     = 6p,Helvetica,black


gmt makecpt -Cvik           -D -T-0.5/0.5/0.05 > shape.cpt
gmt makecpt -CcbcYlOrRd.cpt -D -T0/0.4/0.02 > scale.cpt

J1=X4.8c/2.4c
xjump=5c
xback=-10c
yjump=-2.5c

circrad=0.07c
barwidth=0.13cb0
color1=#1f77b4
color2=#2ca02c
color3=#ff7f0e

gmt psbasemap -J$J1 -Rg -Y2.55c -X0.3c -K -Bwesn+t"5%"  > $ps
gmt pscoast -R -J -Dc -A5000/0/1+ai -G170/170/170 -S#c6dbef -K -O >> $ps
gmt psxy shape_5.txt -R -J -O -K -Sc$circrad -t35  -Cshape.cpt >> $ps
echo "180 0 Shape" |  gmt pstext -D-2.55c/0c -R -J -N -F+f6,Helvetica-Bold+jCM+a90 -O -K >> $ps

gmt psbasemap -J$J1 -Rg -X$xjump -O -K -Bwesn+t"50%"  >> $ps
gmt pscoast -R -J -Dc -A5000/0/1+ai -G170/170/170 -S#c6dbef -K -O >> $ps
gmt psxy shape_50.txt -R -J -O -K -Sc$circrad -t35  -Cshape.cpt >> $ps

gmt psbasemap -J$J1 -Rg -X$xjump -O -K -Bwesn+t"95%"  >> $ps
gmt pscoast -R -J -Dc -A5000/0/1+ai -G170/170/170 -S#c6dbef -K -O >> $ps
gmt psxy shape_95.txt -R -J -O -K -Sc$circrad -t35  -Cshape.cpt >> $ps
gmt psscale  -Dx4.9c/0.2c+w2.0c/0.25c+e-R -J -Np -Cshape.cpt  -B0.2 -O  -S -K >> $ps

gmt psbasemap -J$J1 -Rg -Y$yjump -X$xback -O -K -Bwesn  >> $ps
gmt pscoast -R -J -Dc -A5000/0/1+ai -G170/170/170 -S#c6dbef -K -O >> $ps
gmt psxy scale_5.txt -R -J -O -K -Sc$circrad -t35  -Cscale.cpt >> $ps
echo "180 0 Scale" |  gmt pstext -D-2.55c/0c -R -J -N -F+f6,Helvetica-Bold+jCM+a90 -O -K >> $ps

gmt psbasemap -J$J1 -Rg -X$xjump -O -K -Bwesn  >> $ps
gmt pscoast -R -J -Dc -A5000/0/1+ai -G170/170/170 -S#c6dbef -K -O >> $ps
gmt psxy scale_50.txt -R -J -O -K -Sc$circrad -t35  -Cscale.cpt >> $ps

gmt psbasemap -J$J1 -Rg -X$xjump -O -K -Bwesn  >> $ps
gmt pscoast -R -J -Dc -A5000/0/1+ai -G170/170/170 -S#c6dbef -K -O >> $ps
gmt psxy scale_95.txt -R -J -O -K -Sc$circrad -t35  -Cscale.cpt >> $ps
gmt psscale  -Dx4.9c/0.2c+w2.0c/0.25c+ef-R -J -Np -Cscale.cpt  -B0.1 -O  -S -K >> $ps



gmt psconvert -Tf $ps
