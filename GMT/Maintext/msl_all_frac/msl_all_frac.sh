# Process masks
rm *.ps
ps=msl_all_frac.ps


gmt set PS_MEDIA=Custom_12.6cx7.6c

gmt set MAP_FRAME_WIDTH=0.06c
gmt set MAP_FRAME_PEN=thinner,20/20/20
gmt set MAP_FRAME_TYPE=plain
gmt set MAP_LABEL_OFFSET=1p
gmt set MAP_TITLE_OFFSET=-0.21c
gmt set PS_PAGE_ORIENTATION=portrait
gmt set MAP_TICK_LENGTH_PRIMARY=0.03c
gmt set MAP_GRID_PEN_PRIMARY=thinner,lightgrey
gmt set MAP_ANNOT_OFFSET_PRIMARY=1.5p

gmt set FONT_ANNOT_PRIMARY             = 8p,Helvetica,black
gmt set FONT_ANNOT_SECONDARY           = 8p,Helvetica,black
gmt set FONT_LABEL                     = 8p,Helvetica,black
gmt set FONT_LOGO                      = 8p,Helvetica,black
gmt set FONT_TITLE                     = 8p,Helvetica,black


gmt makecpt -Csolar.cpt -D -T0/50/1.25 > frac_cpt.cpt

J1=X6.0c/3.0c
J2=X1c/3.0c
R2=0/1/0/1
xjump=6.2c
xback=-13.1c

yjump=-3.4c
yjump2=-3.7c

circrad=0.11c
barwidth=0.13cb0
color1=#1f77b4
color2=#2ca02c
color3=#ff7f0e

gmt psbasemap -J$J1 -Rg -Y4.3c -X0.3c -K -Bwesn+t"RCP2.6"  > $ps
gmt pscoast -R -J -Dc -A5000/0/1+ai -G170/170/170 -S#c6dbef -K -O >> $ps
gmt psxy frac_RCP26_2050_0.txt -R -J -O -K -Sc$circrad -t35  -Cfrac_cpt.cpt  >> $ps
echo "180 0 2046-2065" |  gmt pstext -D-3.15c/0c -R -J -N -F+f8,Helvetica+jCM+a90 -O -K >> $ps

gmt psbasemap -J$J1 -Rg -X$xjump -O -K -Bwesn+t"RCP8.5"  >> $ps
gmt pscoast -R -J -Dc -A5000/0/1+ai -G170/170/170 -S#c6dbef -K -O >> $ps
gmt psxy frac_RCP85_2050_0.txt -R -J -O -K -Sc$circrad -t35  -Cfrac_cpt.cpt  >> $ps

gmt psbasemap -J$J1 -Rg -Y-3.2cm -X-$xjump -O -K -Bwesn  >> $ps
gmt pscoast -R -J -Dc -A5000/0/1+ai -G170/170/170 -S#c6dbef -K -O >> $ps
gmt psxy frac_RCP26_2100_0.txt -R -J -O -K -Sc$circrad -t35  -Cfrac_cpt.cpt  >> $ps
echo "180 0 2081-2100" |  gmt pstext -D-3.15c/0c -R -J -N -F+f8,Helvetica+jCM+a90 -O -K >> $ps

gmt psbasemap -J$J1 -Rg -X$xjump -O -K -Bwesn  >> $ps
gmt pscoast -R -J -Dc -A5000/0/1+ai -G170/170/170 -S#c6dbef -K -O >> $ps
gmt psxy frac_RCP85_2100_0.txt -R -J -O -K -Sc$circrad -t35  -Cfrac_cpt.cpt  >> $ps

gmt psscale  -Dx-5.1c/-0.45c+w10c/0.3c+ef+h-R -J -Np -Cfrac_cpt.cpt  -B5  -O -Bx+l'Allowance minus expected MSL change (cm)' -S -K >> $ps


gmt psconvert -Tf $ps
