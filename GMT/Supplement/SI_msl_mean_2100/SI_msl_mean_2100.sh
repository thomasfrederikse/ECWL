# Process masks
rm *.ps
ps=SI_msl_mean_2100.ps

gmt set PS_MEDIA=Custom_15cx21.9c

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

gmt makecpt -CcbcRdBu.cpt -I -T-2.5/2.5/0.125 -D >divcpt.cpt

J=X4.8c/2.4c
xjump=4.9c
xback=-9.8c

yjump=-2.65c
yjump2=-2.65c

#0
IDX=0
gmt grdimage ~/Data/Extremes/Paper/msl_scenarios/msl_rcp26_2100.nc?total_slr[$IDX] -Q -J$J -Rg -Y19.2c -X0.25c -K -Bwesn+t"RCP2.6" -nn -Cdivcpt.cpt > $ps
gmt pscoast -R -J -Dc -A5000/0/1+ai -G170/170/170  -K -O >> $ps
echo "180 0 0 cm" |  gmt pstext -D-2.55c/0c -R -J -N -F+f6,Helvetica-Bold+jCM+a90 -O -K >> $ps

gmt grdimage ~/Data/Extremes/Paper/msl_scenarios/msl_rcp45_2100.nc?total_slr[$IDX] -Q -J$J -Rg -X$xjump -O -K -Bwesn+t"RCP4.5" -nn -Cdivcpt.cpt >> $ps
gmt pscoast -R -J -Dc -A5000/0/1+ai -G170/170/170  -K -O >> $ps

gmt grdimage ~/Data/Extremes/Paper/msl_scenarios/msl_rcp85_2100.nc?total_slr[$IDX] -Q -J$J -Rg -X$xjump -O -K -Bwesn+t"RCP8.5" -nn -Cdivcpt.cpt >> $ps
gmt pscoast -R -J -Dc -A5000/0/1+ai -G170/170/170  -K -O >> $ps

#R15
IDX=3
gmt grdimage ~/Data/Extremes/Paper/msl_scenarios/msl_rcp26_2100.nc?total_slr[$IDX] -Q -J$J -Rg -Y$yjump2 -X$xback -O -K -Bwesn -nn -Cdivcpt.cpt >> $ps
gmt pscoast -R -J -Dc -A5000/0/1+ai -G170/170/170  -K -O >> $ps
echo "180 0 15 cm" |  gmt pstext -D-2.55c/0c -R -J -N -F+f6,Helvetica-Bold+jCM+a90 -O -K >> $ps

gmt grdimage ~/Data/Extremes/Paper/msl_scenarios/msl_rcp45_2100.nc?total_slr[$IDX] -Q -J$J -Rg -X$xjump -O -K -Bwesn -nn -Cdivcpt.cpt >> $ps
gmt pscoast -R -J -Dc -A5000/0/1+ai -G170/170/170  -K -O >> $ps

gmt grdimage ~/Data/Extremes/Paper/msl_scenarios/msl_rcp85_2100.nc?total_slr[$IDX] -Q -J$J -Rg -X$xjump -O -K -Bwesn -nn -Cdivcpt.cpt >> $ps
gmt pscoast -R -J -Dc -A5000/0/1+ai -G170/170/170  -K -O >> $ps

#R30
IDX=5
gmt grdimage ~/Data/Extremes/Paper/msl_scenarios/msl_rcp26_2100.nc?total_slr[$IDX] -Q -J$J -Rg -Y$yjump2 -X$xback -O -K -Bwesn -nn -Cdivcpt.cpt >> $ps
gmt pscoast -R -J -Dc -A5000/0/1+ai -G170/170/170  -K -O >> $ps
echo "180 0 30 cm" |  gmt pstext -D-2.55c/0c -R -J -N -F+f6,Helvetica-Bold+jCM+a90 -O -K >> $ps

gmt grdimage ~/Data/Extremes/Paper/msl_scenarios/msl_rcp45_2100.nc?total_slr[$IDX] -Q -J$J -Rg -X$xjump -O -K -Bwesn -nn -Cdivcpt.cpt >> $ps
gmt pscoast -R -J -Dc -A5000/0/1+ai -G170/170/170  -K -O >> $ps

gmt grdimage ~/Data/Extremes/Paper/msl_scenarios/msl_rcp85_2100.nc?total_slr[$IDX] -Q -J$J -Rg -X$xjump -O -K -Bwesn -nn -Cdivcpt.cpt >> $ps
gmt pscoast -R -J -Dc -A5000/0/1+ai -G170/170/170  -K -O >> $ps

#R45
IDX=6
gmt grdimage ~/Data/Extremes/Paper/msl_scenarios/msl_rcp26_2100.nc?total_slr[$IDX] -Q -J$J -Rg -Y$yjump2 -X$xback -O -K -Bwesn -nn -Cdivcpt.cpt >> $ps
gmt pscoast -R -J -Dc -A5000/0/1+ai -G170/170/170  -K -O >> $ps
echo "180 0 45 cm" |  gmt pstext -D-2.55c/0c -R -J -N -F+f6,Helvetica-Bold+jCM+a90 -O -K >> $ps

gmt grdimage ~/Data/Extremes/Paper/msl_scenarios/msl_rcp45_2100.nc?total_slr[$IDX] -Q -J$J -Rg -X$xjump -O -K -Bwesn -nn -Cdivcpt.cpt >> $ps
gmt pscoast -R -J -Dc -A5000/0/1+ai -G170/170/170  -K -O >> $ps

gmt grdimage ~/Data/Extremes/Paper/msl_scenarios/msl_rcp85_2100.nc?total_slr[$IDX] -Q -J$J -Rg -X$xjump -O -K -Bwesn -nn -Cdivcpt.cpt >> $ps
gmt pscoast -R -J -Dc -A5000/0/1+ai -G170/170/170  -K -O >> $ps

#R60
IDX=7
gmt grdimage ~/Data/Extremes/Paper/msl_scenarios/msl_rcp26_2100.nc?total_slr[$IDX] -Q -J$J -Rg -Y$yjump2 -X$xback -O -K -Bwesn -nn -Cdivcpt.cpt >> $ps
gmt pscoast -R -J -Dc -A5000/0/1+ai -G170/170/170  -K -O >> $ps
echo "180 0 60 cm" |  gmt pstext -D-2.55c/0c -R -J -N -F+f6,Helvetica-Bold+jCM+a90 -O -K >> $ps

gmt grdimage ~/Data/Extremes/Paper/msl_scenarios/msl_rcp45_2100.nc?total_slr[$IDX] -Q -J$J -Rg -X$xjump -O -K -Bwesn -nn -Cdivcpt.cpt >> $ps
gmt pscoast -R -J -Dc -A5000/0/1+ai -G170/170/170  -K -O >> $ps

gmt grdimage ~/Data/Extremes/Paper/msl_scenarios/msl_rcp85_2100.nc?total_slr[$IDX] -Q -J$J -Rg -X$xjump -O -K -Bwesn -nn -Cdivcpt.cpt >> $ps
gmt pscoast -R -J -Dc -A5000/0/1+ai -G170/170/170  -K -O >> $ps

#R90
IDX=8
gmt grdimage ~/Data/Extremes/Paper/msl_scenarios/msl_rcp26_2100.nc?total_slr[$IDX] -Q -J$J -Rg -Y$yjump2 -X$xback -O -K -Bwesn -nn -Cdivcpt.cpt >> $ps
gmt pscoast -R -J -Dc -A5000/0/1+ai -G170/170/170  -K -O >> $ps
echo "180 0 90 cm" |  gmt pstext -D-2.55c/0c -R -J -N -F+f6,Helvetica-Bold+jCM+a90 -O -K >> $ps

gmt grdimage ~/Data/Extremes/Paper/msl_scenarios/msl_rcp45_2100.nc?total_slr[$IDX] -Q -J$J -Rg -X$xjump -O -K -Bwesn -nn -Cdivcpt.cpt >> $ps
gmt pscoast -R -J -Dc -A5000/0/1+ai -G170/170/170  -K -O >> $ps

gmt grdimage ~/Data/Extremes/Paper/msl_scenarios/msl_rcp85_2100.nc?total_slr[$IDX] -Q -J$J -Rg -X$xjump -O -K -Bwesn -nn -Cdivcpt.cpt >> $ps
gmt pscoast -R -J -Dc -A5000/0/1+ai -G170/170/170  -K -O >> $ps


#R120
IDX=9
gmt grdimage ~/Data/Extremes/Paper/msl_scenarios/msl_rcp26_2100.nc?total_slr[$IDX] -Q -J$J -Rg -Y$yjump2 -X$xback -O -K -Bwesn -nn -Cdivcpt.cpt >> $ps
gmt pscoast -R -J -Dc -A5000/0/1+ai -G170/170/170  -K -O >> $ps
echo "180 0 120 cm" |  gmt pstext -D-2.55c/0c -R -J -N -F+f6,Helvetica-Bold+jCM+a90 -O -K >> $ps

gmt grdimage ~/Data/Extremes/Paper/msl_scenarios/msl_rcp45_2100.nc?total_slr[$IDX] -Q -J$J -Rg -X$xjump -O -K -Bwesn -nn -Cdivcpt.cpt >> $ps
gmt pscoast -R -J -Dc -A5000/0/1+ai -G170/170/170  -K -O >> $ps

gmt grdimage ~/Data/Extremes/Paper/msl_scenarios/msl_rcp85_2100.nc?total_slr[$IDX] -Q -J$J -Rg -X$xjump -O -K -Bwesn -nn -Cdivcpt.cpt >> $ps
gmt pscoast -R -J -Dc -A5000/0/1+ai -G170/170/170  -K -O >> $ps

#R150
IDX=10

gmt grdimage ~/Data/Extremes/Paper/msl_scenarios/msl_rcp26_2100.nc?total_slr[$IDX] -Q -J$J -Rg -Y$yjump2 -X$xback -O -K -Bwesn -nn -Cdivcpt.cpt >> $ps
gmt pscoast -R -J -Dc -A5000/0/1+ai -G170/170/170  -K -O >> $ps
echo "180 0 150 cm" |  gmt pstext -D-2.55c/0c -R -J -N -F+f6,Helvetica-Bold+jCM+a90 -O -K >> $ps

gmt grdimage ~/Data/Extremes/Paper/msl_scenarios/msl_rcp45_2100.nc?total_slr[$IDX] -Q -J$J -Rg -X$xjump -O -K -Bwesn -nn -Cdivcpt.cpt >> $ps
gmt pscoast -R -J -Dc -A5000/0/1+ai -G170/170/170  -K -O >> $ps

gmt grdimage ~/Data/Extremes/Paper/msl_scenarios/msl_rcp85_2100.nc?total_slr[$IDX] -Q -J$J -Rg -X$xjump -O -K -Bwesn -nn -Cdivcpt.cpt >> $ps
gmt pscoast -R -J -Dc -A5000/0/1+ai -G170/170/170  -K -O >> $ps

gmt psscale  -Dx-5.9c/-0.3c+w6.8c/0.2c+e+h -R -J -Cdivcpt.cpt -B0.5 -By+l'm' -O -K >> $ps

ps2pdf $ps
