# Process masks
rm *.ps
ps=SI_msl_mean_2050.ps

gmt set PS_MEDIA=Custom_15cx19.3c

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

gmt makecpt -CcbcRdBu.cpt -I -T-1.0/1.0/0.0625 -D >divcpt.cpt

J=X4.8c/2.4c
xjump=4.9c
xback=-9.8c

yjump=-2.65c
yjump2=-2.65c
#0
gmt grdimage ~/Data/Extremes/Paper/msl_scenarios/msl_rcp26_2050.nc?total_slr[0] -Q -J$J -Rg -Y16.6c -X0.25c -K -Bwesn+t"RCP2.6" -nn -Cdivcpt.cpt > $ps
gmt pscoast -R -J -Dc -A5000/0/1+ai -G170/170/170  -K -O >> $ps
echo "180 0 0 cm" |  gmt pstext -D-2.55c/0c -R -J -N -F+f6,Helvetica-Bold+jCM+a90 -O -K >> $ps

gmt grdimage ~/Data/Extremes/Paper/msl_scenarios/msl_rcp45_2050.nc?total_slr[0] -Q -J$J -Rg -X$xjump -O -K -Bwesn+t"RCP4.5" -nn -Cdivcpt.cpt >> $ps
gmt pscoast -R -J -Dc -A5000/0/1+ai -G170/170/170  -K -O >> $ps

gmt grdimage ~/Data/Extremes/Paper/msl_scenarios/msl_rcp85_2050.nc?total_slr[0] -Q -J$J -Rg -X$xjump -O -K -Bwesn+t"RCP8.5" -nn -Cdivcpt.cpt >> $ps
gmt pscoast -R -J -Dc -A5000/0/1+ai -G170/170/170  -K -O >> $ps

#R5
gmt grdimage ~/Data/Extremes/Paper/msl_scenarios/msl_rcp26_2050.nc?total_slr[1] -Q -J$J -Rg -Y$yjump2 -X$xback -O -K -Bwesn -nn -Cdivcpt.cpt >> $ps
gmt pscoast -R -J -Dc -A5000/0/1+ai -G170/170/170  -K -O >> $ps
echo "180 0 5 cm" |  gmt pstext -D-2.55c/0c -R -J -N -F+f6,Helvetica-Bold+jCM+a90 -O -K >> $ps

gmt grdimage ~/Data/Extremes/Paper/msl_scenarios/msl_rcp45_2050.nc?total_slr[1] -Q -J$J -Rg -X$xjump -O -K -Bwesn -nn -Cdivcpt.cpt >> $ps
gmt pscoast -R -J -Dc -A5000/0/1+ai -G170/170/170  -K -O >> $ps

gmt grdimage ~/Data/Extremes/Paper/msl_scenarios/msl_rcp85_2050.nc?total_slr[1] -Q -J$J -Rg -X$xjump -O -K -Bwesn -nn -Cdivcpt.cpt >> $ps
gmt pscoast -R -J -Dc -A5000/0/1+ai -G170/170/170  -K -O >> $ps

#R10
gmt grdimage ~/Data/Extremes/Paper/msl_scenarios/msl_rcp26_2050.nc?total_slr[2] -Q -J$J -Rg -Y$yjump2 -X$xback -O -K -Bwesn -nn -Cdivcpt.cpt >> $ps
gmt pscoast -R -J -Dc -A5000/0/1+ai -G170/170/170  -K -O >> $ps
echo "180 0 10 cm" |  gmt pstext -D-2.55c/0c -R -J -N -F+f6,Helvetica-Bold+jCM+a90 -O -K >> $ps

gmt grdimage ~/Data/Extremes/Paper/msl_scenarios/msl_rcp45_2050.nc?total_slr[2] -Q -J$J -Rg -X$xjump -O -K -Bwesn -nn -Cdivcpt.cpt >> $ps
gmt pscoast -R -J -Dc -A5000/0/1+ai -G170/170/170  -K -O >> $ps

gmt grdimage ~/Data/Extremes/Paper/msl_scenarios/msl_rcp85_2050.nc?total_slr[2] -Q -J$J -Rg -X$xjump -O -K -Bwesn -nn -Cdivcpt.cpt >> $ps
gmt pscoast -R -J -Dc -A5000/0/1+ai -G170/170/170  -K -O >> $ps

#R15
gmt grdimage ~/Data/Extremes/Paper/msl_scenarios/msl_rcp26_2050.nc?total_slr[3] -Q -J$J -Rg -Y$yjump2 -X$xback -O -K -Bwesn -nn -Cdivcpt.cpt >> $ps
gmt pscoast -R -J -Dc -A5000/0/1+ai -G170/170/170  -K -O >> $ps
echo "180 0 15 cm" |  gmt pstext -D-2.55c/0c -R -J -N -F+f6,Helvetica-Bold+jCM+a90 -O -K >> $ps

gmt grdimage ~/Data/Extremes/Paper/msl_scenarios/msl_rcp45_2050.nc?total_slr[3] -Q -J$J -Rg -X$xjump -O -K -Bwesn -nn -Cdivcpt.cpt >> $ps
gmt pscoast -R -J -Dc -A5000/0/1+ai -G170/170/170  -K -O >> $ps

gmt grdimage ~/Data/Extremes/Paper/msl_scenarios/msl_rcp85_2050.nc?total_slr[3] -Q -J$J -Rg -X$xjump -O -K -Bwesn -nn -Cdivcpt.cpt >> $ps
gmt pscoast -R -J -Dc -A5000/0/1+ai -G170/170/170  -K -O >> $ps

#R20
gmt grdimage ~/Data/Extremes/Paper/msl_scenarios/msl_rcp26_2050.nc?total_slr[4] -Q -J$J -Rg -Y$yjump2 -X$xback -O -K -Bwesn -nn -Cdivcpt.cpt >> $ps
gmt pscoast -R -J -Dc -A5000/0/1+ai -G170/170/170  -K -O >> $ps
echo "180 0 20 cm" |  gmt pstext -D-2.55c/0c -R -J -N -F+f6,Helvetica-Bold+jCM+a90 -O -K >> $ps

gmt grdimage ~/Data/Extremes/Paper/msl_scenarios/msl_rcp45_2050.nc?total_slr[4] -Q -J$J -Rg -X$xjump -O -K -Bwesn -nn -Cdivcpt.cpt >> $ps
gmt pscoast -R -J -Dc -A5000/0/1+ai -G170/170/170  -K -O >> $ps

gmt grdimage ~/Data/Extremes/Paper/msl_scenarios/msl_rcp85_2050.nc?total_slr[4] -Q -J$J -Rg -X$xjump -O -K -Bwesn -nn -Cdivcpt.cpt >> $ps
gmt pscoast -R -J -Dc -A5000/0/1+ai -G170/170/170  -K -O >> $ps

#R30
gmt grdimage ~/Data/Extremes/Paper/msl_scenarios/msl_rcp26_2050.nc?total_slr[5] -Q -J$J -Rg -Y$yjump2 -X$xback -O -K -Bwesn -nn -Cdivcpt.cpt >> $ps
gmt pscoast -R -J -Dc -A5000/0/1+ai -G170/170/170  -K -O >> $ps
echo "180 0 30 cm" |  gmt pstext -D-2.55c/0c -R -J -N -F+f6,Helvetica-Bold+jCM+a90 -O -K >> $ps

gmt grdimage ~/Data/Extremes/Paper/msl_scenarios/msl_rcp45_2050.nc?total_slr[5] -Q -J$J -Rg -X$xjump -O -K -Bwesn -nn -Cdivcpt.cpt >> $ps
gmt pscoast -R -J -Dc -A5000/0/1+ai -G170/170/170  -K -O >> $ps

gmt grdimage ~/Data/Extremes/Paper/msl_scenarios/msl_rcp85_2050.nc?total_slr[5] -Q -J$J -Rg -X$xjump -O -K -Bwesn -nn -Cdivcpt.cpt >> $ps
gmt pscoast -R -J -Dc -A5000/0/1+ai -G170/170/170  -K -O >> $ps

#R45
gmt grdimage ~/Data/Extremes/Paper/msl_scenarios/msl_rcp26_2050.nc?total_slr[6] -Q -J$J -Rg -Y$yjump2 -X$xback -O -K -Bwesn -nn -Cdivcpt.cpt >> $ps
gmt pscoast -R -J -Dc -A5000/0/1+ai -G170/170/170  -K -O >> $ps
echo "180 0 45 cm" |  gmt pstext -D-2.55c/0c -R -J -N -F+f6,Helvetica-Bold+jCM+a90 -O -K >> $ps

gmt grdimage ~/Data/Extremes/Paper/msl_scenarios/msl_rcp45_2050.nc?total_slr[6] -Q -J$J -Rg -X$xjump -O -K -Bwesn -nn -Cdivcpt.cpt >> $ps
gmt pscoast -R -J -Dc -A5000/0/1+ai -G170/170/170  -K -O >> $ps

gmt grdimage ~/Data/Extremes/Paper/msl_scenarios/msl_rcp85_2050.nc?total_slr[6] -Q -J$J -Rg -X$xjump -O -K -Bwesn -nn -Cdivcpt.cpt >> $ps
gmt pscoast -R -J -Dc -A5000/0/1+ai -G170/170/170  -K -O >> $ps


gmt psscale  -Dx-5.9c/-0.3c+w6.8c/0.2c+e+h -R -J -Cdivcpt.cpt -B0.25 -By+l'm' -O -K >> $ps

gmt psconvert -Tf $ps
