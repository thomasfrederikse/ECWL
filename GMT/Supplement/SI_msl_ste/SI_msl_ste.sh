# Process masks
rm *.ps
ps=SI_msl_ste.ps

gmt set PS_MEDIA=Custom_15cx6.0c

gmt set MAP_FRAME_WIDTH=0.06c
gmt set MAP_FRAME_PEN=thinner,20/20/20
gmt set MAP_FRAME_TYPE=plain
gmt set MAP_LABEL_OFFSET=1p
gmt set MAP_TITLE_OFFSET=-0.24c
gmt set PS_PAGE_ORIENTATION=portrait
gmt set MAP_TICK_LENGTH_PRIMARY=0.03c
gmt set MAP_GRID_PEN_PRIMARY=thinner,lightgrey
gmt set MAP_ANNOT_OFFSET_PRIMARY=1.5p

gmt set FONT_ANNOT_PRIMARY             = 6p,Helvetica,black
gmt set FONT_ANNOT_SECONDARY           = 6p,Helvetica,black
gmt set FONT_LABEL                     = 6p,Helvetica,black
gmt set FONT_LOGO                      = 6p,Helvetica,black
gmt set FONT_TITLE                     = 6p,Helvetica,black

gmt makecpt -CcbcReds.cpt -T0/0.4/0.02 -D >divcpt.cpt

J=X4.8c/2.4c
xjump=4.9c
xback=-9.8c

yjump=-2.65c
yjump2=-2.65c

# 2050
gmt grdimage ~/Data/SROCC/msl_scenarios/msl_rcp26_2050.nc?total_slr_ste[0] -Q -J$J -Rg -Y3.375c -X0.25c -K -Bwesn+t"RCP2.6" -nn -Cdivcpt.cpt > $ps
gmt pscoast -R -J -Dc -A5000/0/1+ai -G170/170/170  -K -O >> $ps
echo "180 0 2046-2065" |  gmt pstext -D-2.55c/0c -R -J -N -F+f6,Helvetica-Bold+jCM+a90 -O -K >> $ps

gmt grdimage ~/Data/SROCC/msl_scenarios/msl_rcp45_2050.nc?total_slr_ste[0] -Q -J$J -Rg -X$xjump -O -K -Bwesn+t"RCP4.5" -nn -Cdivcpt.cpt >> $ps
gmt pscoast -R -J -Dc -A5000/0/1+ai -G170/170/170  -K -O >> $ps

gmt grdimage ~/Data/SROCC/msl_scenarios/msl_rcp85_2050.nc?total_slr_ste[0] -Q -J$J -Rg -X$xjump -O -K -Bwesn+t"RCP8.5" -nn -Cdivcpt.cpt >> $ps
gmt pscoast -R -J -Dc -A5000/0/1+ai -G170/170/170  -K -O >> $ps

# 2100
gmt grdimage ~/Data/SROCC/msl_scenarios/msl_rcp26_2100.nc?total_slr_ste[1] -Q -J$J -Rg -Y$yjump2 -X$xback -O -K -Bwesn -nn -Cdivcpt.cpt >> $ps
gmt pscoast -R -J -Dc -A5000/0/1+ai -G170/170/170  -K -O >> $ps
echo "180 0 2081-2100" |  gmt pstext -D-2.55c/0c -R -J -N -F+f6,Helvetica-Bold+jCM+a90 -O -K >> $ps

gmt grdimage ~/Data/SROCC/msl_scenarios/msl_rcp45_2100.nc?total_slr_ste[1] -Q -J$J -Rg -X$xjump -O -K -Bwesn -nn -Cdivcpt.cpt >> $ps
gmt pscoast -R -J -Dc -A5000/0/1+ai -G170/170/170  -K -O >> $ps

gmt grdimage ~/Data/SROCC/msl_scenarios/msl_rcp85_2100.nc?total_slr_ste[1] -Q -J$J -Rg -X$xjump -O -K -Bwesn -nn -Cdivcpt.cpt >> $ps
gmt pscoast -R -J -Dc -A5000/0/1+ai -G170/170/170  -K -O >> $ps

gmt psscale  -Dx-5.9c/-0.4c+w6.8c/0.2c+ef+h -R -J -Cdivcpt.cpt -B0.1 -By+l'm' -O -K >> $ps

ps2pdf $ps
