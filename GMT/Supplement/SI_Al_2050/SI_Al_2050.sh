# Process masks
rm *.ps
ps=SI_Al_2050.ps

gmt set PS_MEDIA=Custom_15.3cx19.6c

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

gmt makecpt -Cviridis -I -D -T0/100/2.5 > all_cpt.cpt

J=X4.8c/2.4c
xjump=4.9c
xback=-9.8c

yjump=-2.65c
yjump2=-2.65c
circrad=0.07c

#AIS 0
gmt psbasemap -K -J$J -Rg -Y16.6c -X0.55c -Bwesn+t"RCP2.6"  > $ps
gmt pscoast -R -J -Dc -A5000/0/1+ai -G170/170/170 -S#c6dbef -K -O >> $ps
gmt psxy al_RCP26_0.txt -R -J -O -K -Sc$circrad  -t35  -Call_cpt.cpt  >> $ps
echo "180 0 0 cm" |  gmt pstext -D-2.55c/0c -R -J -N -F+f6,Helvetica+jCM+a90 -O -K >> $ps

gmt psbasemap -J$J -Rg -X$xjump -O -K -Bwesn+t"RCP4.5" >> $ps
gmt pscoast -R -J -Dc -A5000/0/1+ai -G170/170/170 -S#c6dbef -K -O >> $ps
gmt psxy al_RCP45_0.txt -R -J -O -K -Sc$circrad  -t35  -Call_cpt.cpt  >> $ps
echo "180 0 Emission scenario" |  gmt pstext -D0c/1.6c -R -J -N -F+f6,Helvetica-Bold+jCM -O -K >> $ps

gmt psbasemap -J$J -Rg -X$xjump -O -K -Bwesn+t"RCP8.5" >> $ps
gmt pscoast -R -J -Dc -A5000/0/1+ai -G170/170/170 -S#c6dbef -K -O >> $ps
gmt psxy al_RCP85_0.txt -R -J -O -K -Sc$circrad  -t35  -Call_cpt.cpt  >> $ps

#AIS 15
gmt psbasemap -O -K -J$J -Rg -Y$yjump -X$xback -Bwesn  >> $ps
gmt pscoast -R -J -Dc -A5000/0/1+ai -G170/170/170 -S#c6dbef -K -O >> $ps
gmt psxy al_RCP26_0.05.txt -R -J -O -K -Sc$circrad  -t35  -Call_cpt.cpt  >> $ps
echo "180 0 5 cm" |  gmt pstext -D-2.55c/0c -R -J -N -F+f6,Helvetica+jCM+a90 -O -K >> $ps

gmt psbasemap -J$J -Rg -X$xjump -O -K -Bwesn+t >> $ps
gmt pscoast -R -J -Dc -A5000/0/1+ai -G170/170/170 -S#c6dbef -K -O >> $ps
gmt psxy al_RCP45_0.05.txt -R -J -O -K -Sc$circrad  -t35  -Call_cpt.cpt  >> $ps

gmt psbasemap -J$J -Rg -X$xjump -O -K -Bwesn >> $ps
gmt pscoast -R -J -Dc -A5000/0/1+ai -G170/170/170 -S#c6dbef -K -O >> $ps
gmt psxy al_RCP85_0.05.txt -R -J -O -K -Sc$circrad  -t35  -Call_cpt.cpt  >> $ps

#AIS 30
gmt psbasemap -O -K -J$J -Rg -Y$yjump -X$xback -Bwesn  >> $ps
gmt pscoast -R -J -Dc -A5000/0/1+ai -G170/170/170 -S#c6dbef -K -O >> $ps
gmt psxy al_RCP26_0.1.txt -R -J -O -K -Sc$circrad  -t35  -Call_cpt.cpt  >> $ps
echo "180 0 10 cm" |  gmt pstext -D-2.55c/0c -R -J -N -F+f6,Helvetica+jCM+a90 -O -K >> $ps

gmt psbasemap -J$J -Rg -X$xjump -O -K -Bwesn+t >> $ps
gmt pscoast -R -J -Dc -A5000/0/1+ai -G170/170/170 -S#c6dbef -K -O >> $ps
gmt psxy al_RCP45_0.1.txt -R -J -O -K -Sc$circrad  -t35  -Call_cpt.cpt  >> $ps

gmt psbasemap -J$J -Rg -X$xjump -O -K -Bwesn >> $ps
gmt pscoast -R -J -Dc -A5000/0/1+ai -G170/170/170 -S#c6dbef -K -O >> $ps
gmt psxy al_RCP85_0.1.txt -R -J -O -K -Sc$circrad  -t35  -Call_cpt.cpt  >> $ps

#AIS 45
gmt psbasemap -O -K -J$J -Rg -Y$yjump -X$xback -Bwesn  >> $ps
gmt pscoast -R -J -Dc -A5000/0/1+ai -G170/170/170 -S#c6dbef -K -O >> $ps
gmt psxy al_RCP26_0.15.txt -R -J -O -K -Sc$circrad  -t35  -Call_cpt.cpt  >> $ps
echo "180 0 15 cm" |  gmt pstext -D-2.55c/0c -R -J -N -F+f6,Helvetica+jCM+a90 -O -K >> $ps
echo "180 0 Antarctic Ice Sheet contribution" |  gmt pstext -D-2.85c/0c -R -J -N -F+f6,Helvetica-Bold+jCM+a90 -O -K >> $ps

gmt psbasemap -J$J -Rg -X$xjump -O -K -Bwesn+t >> $ps
gmt pscoast -R -J -Dc -A5000/0/1+ai -G170/170/170 -S#c6dbef -K -O >> $ps
gmt psxy al_RCP45_0.15.txt -R -J -O -K -Sc$circrad  -t35  -Call_cpt.cpt  >> $ps

gmt psbasemap -J$J -Rg -X$xjump -O -K -Bwesn >> $ps
gmt pscoast -R -J -Dc -A5000/0/1+ai -G170/170/170 -S#c6dbef -K -O >> $ps
gmt psxy al_RCP85_0.15.txt -R -J -O -K -Sc$circrad  -t35  -Call_cpt.cpt  >> $ps

#AIS 60
gmt psbasemap -O -K -J$J -Rg -Y$yjump -X$xback -Bwesn  >> $ps
gmt pscoast -R -J -Dc -A5000/0/1+ai -G170/170/170 -S#c6dbef -K -O >> $ps
gmt psxy al_RCP26_0.2.txt -R -J -O -K -Sc$circrad  -t35  -Call_cpt.cpt  >> $ps
echo "180 0 20 cm" |  gmt pstext -D-2.55c/0c -R -J -N -F+f6,Helvetica+jCM+a90 -O -K >> $ps

gmt psbasemap -J$J -Rg -X$xjump -O -K -Bwesn+t >> $ps
gmt pscoast -R -J -Dc -A5000/0/1+ai -G170/170/170 -S#c6dbef -K -O >> $ps
gmt psxy al_RCP45_0.2.txt -R -J -O -K -Sc$circrad  -t35  -Call_cpt.cpt  >> $ps

gmt psbasemap -J$J -Rg -X$xjump -O -K -Bwesn >> $ps
gmt pscoast -R -J -Dc -A5000/0/1+ai -G170/170/170 -S#c6dbef -K -O >> $ps
gmt psxy al_RCP85_0.2.txt -R -J -O -K -Sc$circrad  -t35  -Call_cpt.cpt  >> $ps
echo '7'

#AIS 75
gmt psbasemap -O -K -J$J -Rg -Y$yjump -X$xback -Bwesn  >> $ps
gmt pscoast -R -J -Dc -A5000/0/1+ai -G170/170/170 -S#c6dbef -K -O >> $ps
gmt psxy al_RCP26_0.3.txt -R -J -O -K -Sc$circrad  -t35  -Call_cpt.cpt  >> $ps
echo "180 0 30 cm" |  gmt pstext -D-2.55c/0c -R -J -N -F+f6,Helvetica+jCM+a90 -O -K >> $ps

gmt psbasemap -J$J -Rg -X$xjump -O -K -Bwesn+t >> $ps
gmt pscoast -R -J -Dc -A5000/0/1+ai -G170/170/170 -S#c6dbef -K -O >> $ps
gmt psxy al_RCP45_0.3.txt -R -J -O -K -Sc$circrad  -t35  -Call_cpt.cpt  >> $ps

gmt psbasemap -J$J -Rg -X$xjump -O -K -Bwesn >> $ps
gmt pscoast -R -J -Dc -A5000/0/1+ai -G170/170/170 -S#c6dbef -K -O >> $ps
gmt psxy al_RCP85_0.3.txt -R -J -O -K -Sc$circrad  -t35  -Call_cpt.cpt  >> $ps

#AIS 75
gmt psbasemap -O -K -J$J -Rg -Y$yjump -X$xback -Bwesn  >> $ps
gmt pscoast -R -J -Dc -A5000/0/1+ai -G170/170/170 -S#c6dbef -K -O >> $ps
gmt psxy al_RCP26_0.45.txt -R -J -O -K -Sc$circrad  -t35  -Call_cpt.cpt  >> $ps
echo "180 0 45 cm" |  gmt pstext -D-2.55c/0c -R -J -N -F+f6,Helvetica+jCM+a90 -O -K >> $ps

gmt psbasemap -J$J -Rg -X$xjump -O -K -Bwesn+t >> $ps
gmt pscoast -R -J -Dc -A5000/0/1+ai -G170/170/170 -S#c6dbef -K -O >> $ps
gmt psxy al_RCP45_0.45.txt -R -J -O -K -Sc$circrad  -t35  -Call_cpt.cpt  >> $ps

gmt psbasemap -J$J -Rg -X$xjump -O -K -Bwesn >> $ps
gmt pscoast -R -J -Dc -A5000/0/1+ai -G170/170/170 -S#c6dbef -K -O >> $ps
gmt psxy al_RCP85_0.45.txt -R -J -O -K -Sc$circrad  -t35  -Call_cpt.cpt  >> $ps

echo '8'
gmt psscale  -Dx-5.9c/-0.3c+w6.8c/0.2c+ef+h -R -J -Call_cpt.cpt -B10 -By+l'cm' -O -K >> $ps
echo '9'

gmt psconvert -Tf $ps
