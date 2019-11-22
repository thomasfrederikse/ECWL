# Process masks
rm *.ps
ps=SI_AF_2100.ps

gmt set PS_MEDIA=Custom_15.3cx22.2c

gmt set MAP_FRAME_WIDTH=0.06c
gmt set MAP_FRAME_PEN=thinner,20/20/20
gmt set MAP_FRAME_TYPE=plain
gmt set MAP_LABEL_OFFSET=1p
gmt set MAP_TITLE_OFFSET=-0.22c
gmt set PS_PAGE_ORIENTATION=portrait
gmt set MAP_TICK_LENGTH_PRIMARY=0.03c
gmt set MAP_GRID_PEN_PRIMARY=thinner,lightgrey
gmt set MAP_ANNOT_OFFSET_PRIMARY=1.5p

gmt set FONT_ANNOT_PRIMARY             = 6p,Helvetica,black
gmt set FONT_ANNOT_SECONDARY           = 6p,Helvetica,black
gmt set FONT_LABEL                     = 6p,Helvetica,black
gmt set FONT_LOGO                      = 6p,Helvetica,black
gmt set FONT_TITLE                     = 6p,Helvetica,black

gmt makecpt -Clajolla -D -T0/105/5 > amp_cpt.cpt

J=X4.8c/2.4c
xjump=4.9c
xback=-9.8c

yjump=-2.65c
yjump2=-2.65c
circrad=0.07c

#AIS 0
gmt psbasemap -K -J$J -Rg -Y19.2c -X0.55c -Bwesn+t"RCP2.6"  > $ps
gmt pscoast -R -J -Dc -A5000/0/1+ai -G170/170/170 -S#c6dbef -K -O >> $ps
gmt psxy af_RCP26_0.txt -R -J -O -K -Sc$circrad  -t35  -Camp_cpt.cpt  >> $ps
echo "180 0 0 cm" |  gmt pstext -D-2.55c/0c -R -J -N -F+f6,Helvetica+jCM+a90 -O -K >> $ps

gmt psbasemap -J$J -Rg -X$xjump -O -K -Bwesn+t"RCP4.5" >> $ps
gmt pscoast -R -J -Dc -A5000/0/1+ai -G170/170/170 -S#c6dbef -K -O >> $ps
gmt psxy af_RCP45_0.txt -R -J -O -K -Sc$circrad  -t35  -Camp_cpt.cpt  >> $ps
echo "180 0 Emission scenario" |  gmt pstext -D0c/1.6c -R -J -N -F+f6,Helvetica-Bold+jCM -O -K >> $ps

gmt psbasemap -J$J -Rg -X$xjump -O -K -Bwesn+t"RCP8.5" >> $ps
gmt pscoast -R -J -Dc -A5000/0/1+ai -G170/170/170 -S#c6dbef -K -O >> $ps
gmt psxy af_RCP85_0.txt -R -J -O -K -Sc$circrad  -t35  -Camp_cpt.cpt  >> $ps

#AIS 15
gmt psbasemap -O -K -J$J -Rg -Y$yjump -X$xback -Bwesn  >> $ps
gmt pscoast -R -J -Dc -A5000/0/1+ai -G170/170/170 -S#c6dbef -K -O >> $ps
gmt psxy af_RCP26_0.15.txt -R -J -O -K -Sc$circrad  -t35  -Camp_cpt.cpt  >> $ps
echo "180 0 15 cm" |  gmt pstext -D-2.55c/0c -R -J -N -F+f6,Helvetica+jCM+a90 -O -K >> $ps

gmt psbasemap -J$J -Rg -X$xjump -O -K -Bwesn+t >> $ps
gmt pscoast -R -J -Dc -A5000/0/1+ai -G170/170/170 -S#c6dbef -K -O >> $ps
gmt psxy af_RCP45_0.15.txt -R -J -O -K -Sc$circrad  -t35  -Camp_cpt.cpt  >> $ps

gmt psbasemap -J$J -Rg -X$xjump -O -K -Bwesn >> $ps
gmt pscoast -R -J -Dc -A5000/0/1+ai -G170/170/170 -S#c6dbef -K -O >> $ps
gmt psxy af_RCP85_0.15.txt -R -J -O -K -Sc$circrad  -t35  -Camp_cpt.cpt  >> $ps

#AIS 30
gmt psbasemap -O -K -J$J -Rg -Y$yjump -X$xback -Bwesn  >> $ps
gmt pscoast -R -J -Dc -A5000/0/1+ai -G170/170/170 -S#c6dbef -K -O >> $ps
gmt psxy af_RCP26_0.3.txt -R -J -O -K -Sc$circrad  -t35  -Camp_cpt.cpt  >> $ps
echo "180 0 30 cm" |  gmt pstext -D-2.55c/0c -R -J -N -F+f6,Helvetica+jCM+a90 -O -K >> $ps

gmt psbasemap -J$J -Rg -X$xjump -O -K -Bwesn+t >> $ps
gmt pscoast -R -J -Dc -A5000/0/1+ai -G170/170/170 -S#c6dbef -K -O >> $ps
gmt psxy af_RCP45_0.3.txt -R -J -O -K -Sc$circrad  -t35  -Camp_cpt.cpt  >> $ps

gmt psbasemap -J$J -Rg -X$xjump -O -K -Bwesn >> $ps
gmt pscoast -R -J -Dc -A5000/0/1+ai -G170/170/170 -S#c6dbef -K -O >> $ps
gmt psxy af_RCP85_0.3.txt -R -J -O -K -Sc$circrad  -t35  -Camp_cpt.cpt  >> $ps

#AIS 45
gmt psbasemap -O -K -J$J -Rg -Y$yjump -X$xback -Bwesn  >> $ps
gmt pscoast -R -J -Dc -A5000/0/1+ai -G170/170/170 -S#c6dbef -K -O >> $ps
gmt psxy af_RCP26_0.45.txt -R -J -O -K -Sc$circrad  -t35  -Camp_cpt.cpt  >> $ps
echo "180 0 45 cm" |  gmt pstext -D-2.55c/0c -R -J -N -F+f6,Helvetica+jCM+a90 -O -K >> $ps
echo "180 0 Antarctic Ice Sheet contribution" |  gmt pstext -D-2.85c/-1.325c -R -J -N -F+f6,Helvetica-Bold+jCM+a90 -O -K >> $ps

gmt psbasemap -J$J -Rg -X$xjump -O -K -Bwesn+t >> $ps
gmt pscoast -R -J -Dc -A5000/0/1+ai -G170/170/170 -S#c6dbef -K -O >> $ps
gmt psxy af_RCP45_0.45.txt -R -J -O -K -Sc$circrad  -t35  -Camp_cpt.cpt  >> $ps

gmt psbasemap -J$J -Rg -X$xjump -O -K -Bwesn >> $ps
gmt pscoast -R -J -Dc -A5000/0/1+ai -G170/170/170 -S#c6dbef -K -O >> $ps
gmt psxy af_RCP85_0.45.txt -R -J -O -K -Sc$circrad  -t35  -Camp_cpt.cpt  >> $ps

#AIS 60
gmt psbasemap -O -K -J$J -Rg -Y$yjump -X$xback -Bwesn  >> $ps
gmt pscoast -R -J -Dc -A5000/0/1+ai -G170/170/170 -S#c6dbef -K -O >> $ps
gmt psxy af_RCP26_0.6.txt -R -J -O -K -Sc$circrad  -t35  -Camp_cpt.cpt  >> $ps
echo "180 0 60 cm" |  gmt pstext -D-2.55c/0c -R -J -N -F+f6,Helvetica+jCM+a90 -O -K >> $ps

gmt psbasemap -J$J -Rg -X$xjump -O -K -Bwesn+t >> $ps
gmt pscoast -R -J -Dc -A5000/0/1+ai -G170/170/170 -S#c6dbef -K -O >> $ps
gmt psxy af_RCP45_0.6.txt -R -J -O -K -Sc$circrad  -t35  -Camp_cpt.cpt  >> $ps

gmt psbasemap -J$J -Rg -X$xjump -O -K -Bwesn >> $ps
gmt pscoast -R -J -Dc -A5000/0/1+ai -G170/170/170 -S#c6dbef -K -O >> $ps
gmt psxy af_RCP85_0.6.txt -R -J -O -K -Sc$circrad  -t35  -Camp_cpt.cpt  >> $ps
echo '7'

#AIS 75
gmt psbasemap -O -K -J$J -Rg -Y$yjump -X$xback -Bwesn  >> $ps
gmt pscoast -R -J -Dc -A5000/0/1+ai -G170/170/170 -S#c6dbef -K -O >> $ps
gmt psxy af_RCP26_0.9.txt -R -J -O -K -Sc$circrad  -t35  -Camp_cpt.cpt  >> $ps
echo "180 0 90 cm" |  gmt pstext -D-2.55c/0c -R -J -N -F+f6,Helvetica+jCM+a90 -O -K >> $ps

gmt psbasemap -J$J -Rg -X$xjump -O -K -Bwesn+t >> $ps
gmt pscoast -R -J -Dc -A5000/0/1+ai -G170/170/170 -S#c6dbef -K -O >> $ps
gmt psxy af_RCP45_0.9.txt -R -J -O -K -Sc$circrad  -t35  -Camp_cpt.cpt  >> $ps

gmt psbasemap -J$J -Rg -X$xjump -O -K -Bwesn >> $ps
gmt pscoast -R -J -Dc -A5000/0/1+ai -G170/170/170 -S#c6dbef -K -O >> $ps
gmt psxy af_RCP85_0.9.txt -R -J -O -K -Sc$circrad  -t35  -Camp_cpt.cpt  >> $ps

#AIS 75
gmt psbasemap -O -K -J$J -Rg -Y$yjump -X$xback -Bwesn  >> $ps
gmt pscoast -R -J -Dc -A5000/0/1+ai -G170/170/170 -S#c6dbef -K -O >> $ps
gmt psxy af_RCP26_1.2.txt -R -J -O -K -Sc$circrad  -t35  -Camp_cpt.cpt  >> $ps
echo "180 0 120 cm" |  gmt pstext -D-2.55c/0c -R -J -N -F+f6,Helvetica+jCM+a90 -O -K >> $ps

gmt psbasemap -J$J -Rg -X$xjump -O -K -Bwesn+t >> $ps
gmt pscoast -R -J -Dc -A5000/0/1+ai -G170/170/170 -S#c6dbef -K -O >> $ps
gmt psxy af_RCP45_1.2.txt -R -J -O -K -Sc$circrad  -t35  -Camp_cpt.cpt  >> $ps

gmt psbasemap -J$J -Rg -X$xjump -O -K -Bwesn >> $ps
gmt pscoast -R -J -Dc -A5000/0/1+ai -G170/170/170 -S#c6dbef -K -O >> $ps
gmt psxy af_RCP85_1.2.txt -R -J -O -K -Sc$circrad  -t35  -Camp_cpt.cpt  >> $ps

#AIS 75
gmt psbasemap -O -K -J$J -Rg -Y$yjump -X$xback -Bwesn  >> $ps
gmt pscoast -R -J -Dc -A5000/0/1+ai -G170/170/170 -S#c6dbef -K -O >> $ps
gmt psxy af_RCP26_1.5.txt -R -J -O -K -Sc$circrad  -t35  -Camp_cpt.cpt  >> $ps
echo "180 0 150 cm" |  gmt pstext -D-2.55c/0c -R -J -N -F+f6,HelveticajCM+a90 -O -K >> $ps

gmt psbasemap -J$J -Rg -X$xjump -O -K -Bwesn+t >> $ps
gmt pscoast -R -J -Dc -A5000/0/1+ai -G170/170/170 -S#c6dbef -K -O >> $ps
gmt psxy af_RCP45_1.5.txt -R -J -O -K -Sc$circrad  -t35  -Camp_cpt.cpt  >> $ps

gmt psbasemap -J$J -Rg -X$xjump -O -K -Bwesn >> $ps
gmt pscoast -R -J -Dc -A5000/0/1+ai -G170/170/170 -S#c6dbef -K -O >> $ps
gmt psxy af_RCP85_1.5.txt -R -J -O -K -Sc$circrad  -t35  -Camp_cpt.cpt  >> $ps

echo '8'
gmt psscale  -Dx-5.9c/-0.3c+w6.8c/0.2c+ef+h -R -J -Camp_cpt.cpt -B10 -By -O -K >> $ps
echo '9'

gmt psconvert -Tf $ps
