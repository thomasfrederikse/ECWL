rm *.ps
ps=SI_All_frac_2050.ps

gmt set PS_MEDIA=Custom_15cx16.7c

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

gmt makecpt -CcbcGnBu.cpt -D -T1/1.5/0.025 > all_cpt.cpt

J=X4.8c/2.4c
xjump=4.9c
xback=-9.8c

yjump=-2.65c
yjump2=-2.65c

#AIS 0 
gmt psbasemap -K -J$J -Rg -Y14.0c -X0.25c -Bwesn+t"RCP2.6"  > $ps
gmt pscoast -R -J -Dc -A5000/0/1+ai -G170/170/170  -K -O >> $ps
gmt psxy al_RCP26_0.txt -R -J -O -K -Sc0.10c   -Call_cpt.cpt -Wthinnest >> $ps
echo "180 0 0 cm" |  gmt pstext -D-2.55c/0c -R -J -N -F+f6,Helvetica-Bold+jCM+a90 -O -K >> $ps

gmt psbasemap -J$J -Rg -X$xjump -O -K -Bwesn+t"RCP4.5" >> $ps
gmt pscoast -R -J -Dc -A5000/0/1+ai -G170/170/170  -K -O >> $ps
gmt psxy al_RCP45_0.txt -R -J -O -K -Sc0.10c -Call_cpt.cpt -Wthinnest >> $ps

gmt psbasemap -J$J -Rg -X$xjump -O -K -Bwesn+t"RCP8.5" >> $ps
gmt pscoast -R -J -Dc -A5000/0/1+ai -G170/170/170  -K -O >> $ps
gmt psxy al_RCP85_0.txt -R -J -O -K -Sc0.10c -Call_cpt.cpt -Wthinnest >> $ps

#AIS 15
gmt psbasemap -O -K -J$J -Rg -Y$yjump -X$xback -Bwesn  >> $ps
gmt pscoast -R -J -Dc -A5000/0/1+ai -G170/170/170  -K -O >> $ps
gmt psxy al_RCP26_0.15.txt -R -J -O -K -Sc0.10c   -Call_cpt.cpt -Wthinnest >> $ps
echo "180 0 15 cm" |  gmt pstext -D-2.55c/0c -R -J -N -F+f6,Helvetica-Bold+jCM+a90 -O -K >> $ps

gmt psbasemap -J$J -Rg -X$xjump -O -K -Bwesn+t >> $ps
gmt pscoast -R -J -Dc -A5000/0/1+ai -G170/170/170  -K -O >> $ps
gmt psxy al_RCP45_0.15.txt -R -J -O -K -Sc0.10c -Call_cpt.cpt -Wthinnest >> $ps

gmt psbasemap -J$J -Rg -X$xjump -O -K -Bwesn >> $ps
gmt pscoast -R -J -Dc -A5000/0/1+ai -G170/170/170  -K -O >> $ps
gmt psxy al_RCP85_0.15.txt -R -J -O -K -Sc0.10c -Call_cpt.cpt -Wthinnest >> $ps

#AIS 30
gmt psbasemap -O -K -J$J -Rg -Y$yjump -X$xback -Bwesn  >> $ps
gmt pscoast -R -J -Dc -A5000/0/1+ai -G170/170/170  -K -O >> $ps
gmt psxy al_RCP26_0.3.txt -R -J -O -K -Sc0.10c   -Call_cpt.cpt -Wthinnest >> $ps
echo "180 0 30 cm" |  gmt pstext -D-2.55c/0c -R -J -N -F+f6,Helvetica-Bold+jCM+a90 -O -K >> $ps

gmt psbasemap -J$J -Rg -X$xjump -O -K -Bwesn+t >> $ps
gmt pscoast -R -J -Dc -A5000/0/1+ai -G170/170/170  -K -O >> $ps
gmt psxy al_RCP45_0.3.txt -R -J -O -K -Sc0.10c -Call_cpt.cpt -Wthinnest >> $ps

gmt psbasemap -J$J -Rg -X$xjump -O -K -Bwesn >> $ps
gmt pscoast -R -J -Dc -A5000/0/1+ai -G170/170/170  -K -O >> $ps
gmt psxy al_RCP85_0.3.txt -R -J -O -K -Sc0.10c -Call_cpt.cpt -Wthinnest >> $ps

#AIS 45
gmt psbasemap -O -K -J$J -Rg -Y$yjump -X$xback -Bwesn  >> $ps
gmt pscoast -R -J -Dc -A5000/0/1+ai -G170/170/170  -K -O >> $ps
gmt psxy al_RCP26_0.45.txt -R -J -O -K -Sc0.10c   -Call_cpt.cpt -Wthinnest >> $ps
echo "180 0 45 cm" |  gmt pstext -D-2.55c/0c -R -J -N -F+f6,Helvetica-Bold+jCM+a90 -O -K >> $ps

gmt psbasemap -J$J -Rg -X$xjump -O -K -Bwesn+t >> $ps
gmt pscoast -R -J -Dc -A5000/0/1+ai -G170/170/170  -K -O >> $ps
gmt psxy al_RCP45_0.45.txt -R -J -O -K -Sc0.10c -Call_cpt.cpt -Wthinnest >> $ps

gmt psbasemap -J$J -Rg -X$xjump -O -K -Bwesn >> $ps
gmt pscoast -R -J -Dc -A5000/0/1+ai -G170/170/170  -K -O >> $ps
gmt psxy al_RCP85_0.45.txt -R -J -O -K -Sc0.10c -Call_cpt.cpt -Wthinnest >> $ps

#AIS 60
gmt psbasemap -O -K -J$J -Rg -Y$yjump -X$xback -Bwesn  >> $ps
gmt pscoast -R -J -Dc -A5000/0/1+ai -G170/170/170  -K -O >> $ps
gmt psxy al_RCP26_0.6.txt -R -J -O -K -Sc0.10c   -Call_cpt.cpt -Wthinnest >> $ps
echo "180 0 60 cm" |  gmt pstext -D-2.55c/0c -R -J -N -F+f6,Helvetica-Bold+jCM+a90 -O -K >> $ps

gmt psbasemap -J$J -Rg -X$xjump -O -K -Bwesn+t >> $ps
gmt pscoast -R -J -Dc -A5000/0/1+ai -G170/170/170  -K -O >> $ps
gmt psxy al_RCP45_0.6.txt -R -J -O -K -Sc0.10c -Call_cpt.cpt -Wthinnest >> $ps

gmt psbasemap -J$J -Rg -X$xjump -O -K -Bwesn >> $ps
gmt pscoast -R -J -Dc -A5000/0/1+ai -G170/170/170  -K -O >> $ps
gmt psxy al_RCP85_0.6.txt -R -J -O -K -Sc0.10c -Call_cpt.cpt -Wthinnest >> $ps
echo '7'

#AIS 75
gmt psbasemap -O -K -J$J -Rg -Y$yjump -X$xback -Bwesn  >> $ps
gmt pscoast -R -J -Dc -A5000/0/1+ai -G170/170/170  -K -O >> $ps
gmt psxy al_RCP26_0.75.txt -R -J -O -K -Sc0.10c   -Call_cpt.cpt -Wthinnest >> $ps
echo "180 0 75 cm" |  gmt pstext -D-2.55c/0c -R -J -N -F+f6,Helvetica-Bold+jCM+a90 -O -K >> $ps

gmt psbasemap -J$J -Rg -X$xjump -O -K -Bwesn+t >> $ps
gmt pscoast -R -J -Dc -A5000/0/1+ai -G170/170/170  -K -O >> $ps
gmt psxy al_RCP45_0.75.txt -R -J -O -K -Sc0.10c -Call_cpt.cpt -Wthinnest >> $ps

gmt psbasemap -J$J -Rg -X$xjump -O -K -Bwesn >> $ps
gmt pscoast -R -J -Dc -A5000/0/1+ai -G170/170/170  -K -O >> $ps
gmt psxy al_RCP85_0.75.txt -R -J -O -K -Sc0.10c -Call_cpt.cpt -Wthinnest >> $ps

echo '8'
gmt psscale  -Dx-5.9c/-0.4c+w6.8c/0.2c+e+h -R -J -Call_cpt.cpt -B0.1 -By -O -K >> $ps
echo '9'

ps2pdf $ps
