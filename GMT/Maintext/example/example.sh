ps=example.ps
rm $ps
gmt set PS_MEDIA=Custom_17.6cx7.2c
gmt set PS_PAGE_ORIENTATION=portrait
gmt set MAP_FRAME_WIDTH=0.06c
gmt set MAP_FRAME_PEN=thinner,20/20/20
gmt set MAP_FRAME_TYPE=plain
gmt set MAP_LABEL_OFFSET=1p
gmt set MAP_TITLE_OFFSET=-0.18c
gmt set FORMAT_GEO_MAP=+D
gmt set MAP_TICK_LENGTH_PRIMARY=0.03c
gmt set MAP_GRID_PEN_PRIMARY=thinnest,lightgrey
gmt set MAP_ANNOT_OFFSET_PRIMARY=1.5p
gmt set FONT_ANNOT_PRIMARY             = 8p,Helvetica,black
gmt set FONT_ANNOT_SECONDARY           = 8p,Helvetica,black
gmt set FONT_LABEL                     = 8p,Helvetica,black
gmt set FONT_LOGO                      = 8p,Helvetica,black
gmt set FONT_TITLE                     = 8p,Helvetica,black
color1=#E94858
color2=#F3A32A
color3=#82BF6E
color4=#3CB4CB
color5=#9467bd
color6=#16434B

# Catcolors
redf1=#e31a1c
redf2=#fb9a99
purf1=#6a3d9a
purf2=#cab2d6
# blauw
bluef1=#3182bd
bluef2=#6baed6
bluef3=#9ecae1
#oranje
orf1=#e6550d
orf2=#fd8d3c
orf3=#fdae6b
# Constants
Bxopt=xa4
Jexa=X4.8cl/2.4c
Jslr=X1.2c/2.4c
Jopt=X3.6cl/2.4c

xslr=1.2c
xjumpl=5.95c
xback=-6.85c
xjumps=4.45c
yjump=3.05c
Jmap=X4.8c/2.4c
barwidth=0.12cb0
errwidth=3p
# Station map
gmt set MAP_LABEL_OFFSET=0p
gmt set MAP_TITLE_OFFSET=-0.15c
gmt set MAP_ANNOT_OFFSET_PRIMARY=0.5p

gmt psbasemap -J$Jmap -Rg -Y4.4c -X0.9c -K -BWeSn+t"Station sites" -Bx60 -By30 > $ps
gmt grdimage -R -J -O -K 30msk.nc -t60 -Cmsk.cpt >> $ps
gmt pscoast -R -J -Dc -A5000/0/1+ai -G170/170/170  -K -O >> $ps
gmt psxy stat_locs.txt -R -J -O -Sc0.05i -K -G#1f77b4 -Wthinnest >> $ps
gmt pstext stat_locs.txt -R -J -D-0.25c/0 -F+f8p,Helvetica-Bold+jLM -O -N -K >> $ps

# Example
gmt set MAP_LABEL_OFFSET=4p
gmt set MAP_TITLE_OFFSET=0.05c
gmt set MAP_ANNOT_OFFSET_PRIMARY=1.7p

gmt psbasemap -O -K -R1/1000/0/3.3 -J$Jexa -Y-$yjump -B$Bxopt+l'Return period (yr)' -By1+l"Height (m)" -BWeSn+t'Example' >> $ps
gmt psxy  -R -J -W0.5p,160/160/160,5_1.5:2 -O -K af_2.txt >> $ps
gmt psxy  -R -J -W0.5p,160/160/160,5_1.5:2 -O -K af_3.txt >> $ps

gmt psxy  -R -J -W1p,black   -O -K ex_gpd_pd.txt  >> $ps
gmt psxy  -R -J -W1p,$color4 -O -K ex_gpd_fut.txt >> $ps

# Visualize AF
gmt psxy  -R -J -W1p,$color3+a60+g$color3         -O -K af_1.txt >> $ps
gmt psxy  -R -J -W1p,$color3+vb0.15c+t-0.42c+a60+g$color3 -O -K af_1.txt >> $ps
gmt psxy  -R -J -W0.5p,160/160/160,5_1.5:2 -O -K af_2.txt >> $ps
gmt psxy  -R -J -W0.5p,160/160/160,5_1.5:2 -O -K af_3.txt >> $ps

# Visualize Allowance
gmt psxy  -R -J -W1p,$color1+ve0.15c+a60+g$color1 -O -K all_1.txt >> $ps

echo -e "1.2 1.32 \n 2.1 1.32" | gmt psxy -R -J -O -K -W1.0p,black >> $ps
echo "2.3 1.32 Present-day return curve" | gmt pstext -R -J -F+f8+jLM -O -K >> $ps
echo -e "1.2 0.98 \n 2.1 0.98" | gmt psxy -R -J -O -K -W1.0p,$color4 >> $ps
echo "2.3 0.98 Future return curve" | gmt pstext -R -J -F+f8+jLM -O -K >> $ps
echo -e "1.2 0.62 \n 2.0 0.62" | gmt psxy -R -J -O -K -W1p,$color3+a60+g$color3 >> $ps
echo -e "1.2 0.62 \n 2.1 0.62" | gmt psxy -R -J -O -K -W1p,$color3+ve0.15c+t-0.02c+a60+g$color3 >> $ps
echo "2.3 0.62 AF@-100@-" | gmt pstext -R -J -F+f8+jLM -O -K >> $ps
echo -e "1.2 0.28 \n 2.0 0.28" | gmt psxy -R -J -O -K -W1p,$color1+a60+g$color1 >> $ps
echo -e "1.2 0.28 \n 2.1 0.28" | gmt psxy -R -J -O -K -W1p,$color1+ve0.15c+t-0.02c+a60+g$color1 >> $ps
echo "2.3 0.28 Al@-100@-" | gmt pstext -R -J -F+f8+jLM -O -K >> $ps

gmt set MAP_LABEL_OFFSET=2.5p

# Brest
i=113
# Trends
gmt psbasemap -O -K -R0/10/0/6 -J$Jslr -X$xjumpl -Y$yjump -Bxctrendannots.txt -By1+l"Height (m)" -BWesn >> $ps
gmt psxy -R -J -Sb$barwidth -N -G$purf2  -O -K slr_2050_26_0_$i.txt >> $ps
gmt psxy -R -J -Sb$barwidth -N -G$purf1  -O -K slr_2050_26_0.1_$i.txt >> $ps
gmt psxy -R -J -Sb$barwidth -N -G$redf2  -O -K slr_2050_85_0_$i.txt >> $ps
gmt psxy -R -J -Sb$barwidth -N -G$redf1  -O -K slr_2050_85_0.1_$i.txt >> $ps
gmt psxy -R -J -Sb$barwidth -N -G$bluef3  -O -K slr_2100_26_0_$i.txt >> $ps
gmt psxy -R -J -Sb$barwidth -N -G$bluef2  -O -K slr_2100_26_0.15_$i.txt >> $ps
gmt psxy -R -J -Sb$barwidth -N -G$bluef1  -O -K slr_2100_26_0.3_$i.txt >> $ps
gmt psxy -R -J -Sb$barwidth -N -G$orf3  -O -K slr_2100_85_0_$i.txt >> $ps
gmt psxy -R -J -Sb$barwidth -N -G$orf2  -O -K slr_2100_85_0.3_$i.txt >> $ps
gmt psxy -R -J -Sb$barwidth -N -G$orf1  -O -K slr_2100_85_0.6_$i.txt >> $ps
gmt psxy  -R -J  -N -O -K slr_2050_26_0_$i.txt -Ey$errwidth  >> $ps
gmt psxy  -R -J  -N -O -K slr_2050_26_0.1_$i.txt -Ey$errwidth  >> $ps
gmt psxy  -R -J  -N -O -K slr_2050_85_0_$i.txt -Ey$errwidth  >> $ps
gmt psxy  -R -J  -N -O -K slr_2050_85_0.1_$i.txt -Ey$errwidth  >> $ps
gmt psxy  -R -J  -N -O -K slr_2100_26_0_$i.txt -Ey$errwidth  >> $ps
gmt psxy  -R -J  -N -O -K slr_2100_26_0.15_$i.txt -Ey$errwidth  >> $ps
gmt psxy  -R -J  -N -O -K slr_2100_26_0.3_$i.txt -Ey$errwidth  >> $ps
gmt psxy  -R -J  -N -O -K slr_2100_85_0_$i.txt -Ey$errwidth  >> $ps
gmt psxy  -R -J  -N -O -K slr_2100_85_0.3_$i.txt -Ey$errwidth  >> $ps
gmt psxy  -R -J  -N -O -K slr_2100_85_0.6_$i.txt -Ey$errwidth  >> $ps
gmt psbasemap -O -K -R1/1000/0/6 -J$Jopt -X$xslr -B$Bxopt -Bwesn+t'1 Brest' >> $ps
gmt psxy  -R -J -L -t80 -N -Gblack   -O -K rp_pd_ste_$i.txt  >> $ps
# Allowances
gmt psxy  -R -J -W0.75p,$bluef3 -O -K rp_2100_26_0_rc_best_$i.txt  >> $ps
gmt psxy  -R -J -W0.75p,$bluef2 -O -K rp_2100_26_0.15_rc_best_$i.txt  >> $ps
gmt psxy  -R -J -W0.75p,$bluef1 -O -K rp_2100_26_0.3_rc_best_$i.txt  >> $ps
gmt psxy  -R -J -W0.75p,$orf3 -O -K rp_2100_85_0_rc_best_$i.txt  >> $ps
gmt psxy  -R -J -W0.75p,$orf2 -O -K rp_2100_85_0.3_rc_best_$i.txt  >> $ps
gmt psxy  -R -J -W0.75p,$orf1 -O -K rp_2100_85_0.6_rc_best_$i.txt  >> $ps
gmt psxy  -R -J -W0.75p,$purf2,3_1.5:2 -O -K rp_2050_26_0_rc_best_$i.txt  >> $ps
gmt psxy  -R -J -W0.75p,$purf1,3_1.5:2 -O -K rp_2050_26_0.1_rc_best_$i.txt  >> $ps
gmt psxy  -R -J -W0.75p,$redf2,3_1.5:2 -O -K rp_2050_85_0_rc_best_$i.txt  >> $ps
gmt psxy  -R -J -W0.75p,$redf1,3_1.5:2 -O -K rp_2050_85_0.1_rc_best_$i.txt  >> $ps


# Observed and fitted return curve
gmt psxy  -R -J -W0.75p,black -O -K rp_pd_mn_$i.txt  >> $ps
gmt psxy  -R -J -O -K -Sx0.12c rp_pd_obs_$i.txt  >> $ps

# Galveston
i=352
gmt psbasemap -O -K -R0/10/0/9 -J$Jslr -X$xjumps -Bxctrendannots.txt -By2 -BWesn >> $ps
gmt psxy -R -J -Sb$barwidth -N -G$purf2  -O -K slr_2050_26_0_$i.txt >> $ps
gmt psxy -R -J -Sb$barwidth -N -G$purf1  -O -K slr_2050_26_0.1_$i.txt >> $ps
gmt psxy -R -J -Sb$barwidth -N -G$redf2  -O -K slr_2050_85_0_$i.txt >> $ps
gmt psxy -R -J -Sb$barwidth -N -G$redf1  -O -K slr_2050_85_0.1_$i.txt >> $ps
gmt psxy -R -J -Sb$barwidth -N -G$bluef3  -O -K slr_2100_26_0_$i.txt >> $ps
gmt psxy -R -J -Sb$barwidth -N -G$bluef2  -O -K slr_2100_26_0.15_$i.txt >> $ps
gmt psxy -R -J -Sb$barwidth -N -G$bluef1  -O -K slr_2100_26_0.3_$i.txt >> $ps
gmt psxy -R -J -Sb$barwidth -N -G$orf3  -O -K slr_2100_85_0_$i.txt >> $ps
gmt psxy -R -J -Sb$barwidth -N -G$orf2  -O -K slr_2100_85_0.3_$i.txt >> $ps
gmt psxy -R -J -Sb$barwidth -N -G$orf1  -O -K slr_2100_85_0.6_$i.txt >> $ps
gmt psxy  -R -J  -N -O -K slr_2050_26_0_$i.txt -Ey$errwidth  >> $ps
gmt psxy  -R -J  -N -O -K slr_2050_26_0.1_$i.txt -Ey$errwidth  >> $ps
gmt psxy  -R -J  -N -O -K slr_2050_85_0_$i.txt -Ey$errwidth  >> $ps
gmt psxy  -R -J  -N -O -K slr_2050_85_0.1_$i.txt -Ey$errwidth  >> $ps
gmt psxy  -R -J  -N -O -K slr_2100_26_0_$i.txt -Ey$errwidth  >> $ps
gmt psxy  -R -J  -N -O -K slr_2100_26_0.15_$i.txt -Ey$errwidth  >> $ps
gmt psxy  -R -J  -N -O -K slr_2100_26_0.3_$i.txt -Ey$errwidth  >> $ps
gmt psxy  -R -J  -N -O -K slr_2100_85_0_$i.txt -Ey$errwidth  >> $ps
gmt psxy  -R -J  -N -O -K slr_2100_85_0.3_$i.txt -Ey$errwidth  >> $ps
gmt psxy  -R -J  -N -O -K slr_2100_85_0.6_$i.txt -Ey$errwidth  >> $ps
gmt psbasemap -O -K -R1/1000/0/9 -J$Jopt -X$xslr -B$Bxopt -Bwesn+t'2 Galveston' >> $ps
gmt psxy  -R -J -L -t80 -N -Gblack   -O -K rp_pd_ste_$i.txt  >> $ps
# Allowances
gmt psxy  -R -J -W0.75p,$bluef3 -O -K rp_2100_26_0_rc_best_$i.txt  >> $ps
gmt psxy  -R -J -W0.75p,$bluef2 -O -K rp_2100_26_0.15_rc_best_$i.txt  >> $ps
gmt psxy  -R -J -W0.75p,$bluef1 -O -K rp_2100_26_0.3_rc_best_$i.txt  >> $ps
gmt psxy  -R -J -W0.75p,$orf3 -O -K rp_2100_85_0_rc_best_$i.txt  >> $ps
gmt psxy  -R -J -W0.75p,$orf2 -O -K rp_2100_85_0.3_rc_best_$i.txt  >> $ps
gmt psxy  -R -J -W0.75p,$orf1 -O -K rp_2100_85_0.6_rc_best_$i.txt  >> $ps
gmt psxy  -R -J -W0.75p,$purf2,3_1.5:2 -O -K rp_2050_26_0_rc_best_$i.txt  >> $ps
gmt psxy  -R -J -W0.75p,$purf1,3_1.5:2 -O -K rp_2050_26_0.1_rc_best_$i.txt  >> $ps
gmt psxy  -R -J -W0.75p,$redf2,3_1.5:2 -O -K rp_2050_85_0_rc_best_$i.txt  >> $ps
gmt psxy  -R -J -W0.75p,$redf1,3_1.5:2 -O -K rp_2050_85_0.1_rc_best_$i.txt  >> $ps
# Observed and fitted return curve
gmt psxy  -R -J -W1p,black -O -K rp_pd_mn_$i.txt  >> $ps
gmt psxy  -R -J -O -K -Sx0.15c rp_pd_obs_$i.txt  >> $ps

#### L2
# Gan
i=356
gmt psbasemap -O -K -R0/10/0/3 -J$Jslr -X$xback -Y-$yjump -Bxctrendannots.txt -By1+l"Height (m)" -BWesn >> $ps
gmt psxy -R -J -Sb$barwidth -N -G$purf2  -O -K slr_2050_26_0_$i.txt >> $ps
gmt psxy -R -J -Sb$barwidth -N -G$purf1  -O -K slr_2050_26_0.1_$i.txt >> $ps
gmt psxy -R -J -Sb$barwidth -N -G$redf2  -O -K slr_2050_85_0_$i.txt >> $ps
gmt psxy -R -J -Sb$barwidth -N -G$redf1  -O -K slr_2050_85_0.1_$i.txt >> $ps
gmt psxy -R -J -Sb$barwidth -N -G$bluef3  -O -K slr_2100_26_0_$i.txt >> $ps
gmt psxy -R -J -Sb$barwidth -N -G$bluef2  -O -K slr_2100_26_0.15_$i.txt >> $ps
gmt psxy -R -J -Sb$barwidth -N -G$bluef1  -O -K slr_2100_26_0.3_$i.txt >> $ps
gmt psxy -R -J -Sb$barwidth -N -G$orf3  -O -K slr_2100_85_0_$i.txt >> $ps
gmt psxy -R -J -Sb$barwidth -N -G$orf2  -O -K slr_2100_85_0.3_$i.txt >> $ps
gmt psxy -R -J -Sb$barwidth -N -G$orf1  -O -K slr_2100_85_0.6_$i.txt >> $ps
gmt psxy  -R -J  -N -O -K slr_2050_26_0_$i.txt -Ey$errwidth  >> $ps
gmt psxy  -R -J  -N -O -K slr_2050_26_0.1_$i.txt -Ey$errwidth  >> $ps
gmt psxy  -R -J  -N -O -K slr_2050_85_0_$i.txt -Ey$errwidth  >> $ps
gmt psxy  -R -J  -N -O -K slr_2050_85_0.1_$i.txt -Ey$errwidth  >> $ps
gmt psxy  -R -J  -N -O -K slr_2100_26_0_$i.txt -Ey$errwidth  >> $ps
gmt psxy  -R -J  -N -O -K slr_2100_26_0.15_$i.txt -Ey$errwidth  >> $ps
gmt psxy  -R -J  -N -O -K slr_2100_26_0.3_$i.txt -Ey$errwidth  >> $ps
gmt psxy  -R -J  -N -O -K slr_2100_85_0_$i.txt -Ey$errwidth  >> $ps
gmt psxy  -R -J  -N -O -K slr_2100_85_0.3_$i.txt -Ey$errwidth  >> $ps
gmt psxy  -R -J  -N -O -K slr_2100_85_0.6_$i.txt -Ey$errwidth  >> $ps
gmt psbasemap -O -K -R1/1000/0/3 -J$Jopt -X$xslr  -B$Bxopt+l'Return period (yr)' -BweSn+t'3 Gan (Maldives)' >> $ps
gmt psxy  -R -J -L -t80 -N -Gblack   -O -K rp_pd_ste_$i.txt  >> $ps
# Allowances
gmt psxy  -R -J -W0.75p,$bluef3 -O -K rp_2100_26_0_rc_best_$i.txt  >> $ps
gmt psxy  -R -J -W0.75p,$bluef2 -O -K rp_2100_26_0.15_rc_best_$i.txt  >> $ps
gmt psxy  -R -J -W0.75p,$bluef1 -O -K rp_2100_26_0.3_rc_best_$i.txt  >> $ps
gmt psxy  -R -J -W0.75p,$orf3 -O -K rp_2100_85_0_rc_best_$i.txt  >> $ps
gmt psxy  -R -J -W0.75p,$orf2 -O -K rp_2100_85_0.3_rc_best_$i.txt  >> $ps
gmt psxy  -R -J -W0.75p,$orf1 -O -K rp_2100_85_0.6_rc_best_$i.txt  >> $ps
gmt psxy  -R -J -W0.75p,$purf2,3_1.5:2 -O -K rp_2050_26_0_rc_best_$i.txt  >> $ps
gmt psxy  -R -J -W0.75p,$purf1,3_1.5:2 -O -K rp_2050_26_0.1_rc_best_$i.txt  >> $ps
gmt psxy  -R -J -W0.75p,$redf2,3_1.5:2 -O -K rp_2050_85_0_rc_best_$i.txt  >> $ps
gmt psxy  -R -J -W0.75p,$redf1,3_1.5:2 -O -K rp_2050_85_0.1_rc_best_$i.txt  >> $ps
# Observed and fitted return curve
gmt psxy  -R -J -W1p,black -O -K rp_pd_mn_$i.txt  >> $ps
gmt psxy  -R -J -O -K -Sx0.15c rp_pd_obs_$i.txt  >> $ps


# Saipan
i=1009
gmt psbasemap -O -K -R0/10/0/6 -J$Jslr -X$xjumps -Bxctrendannots.txt -By1 -BWesn >> $ps
gmt psxy -R -J -Sb$barwidth -N -G$purf2  -O -K slr_2050_26_0_$i.txt >> $ps
gmt psxy -R -J -Sb$barwidth -N -G$purf1  -O -K slr_2050_26_0.1_$i.txt >> $ps
gmt psxy -R -J -Sb$barwidth -N -G$redf2  -O -K slr_2050_85_0_$i.txt >> $ps
gmt psxy -R -J -Sb$barwidth -N -G$redf1  -O -K slr_2050_85_0.1_$i.txt >> $ps
gmt psxy -R -J -Sb$barwidth -N -G$bluef3  -O -K slr_2100_26_0_$i.txt >> $ps
gmt psxy -R -J -Sb$barwidth -N -G$bluef2  -O -K slr_2100_26_0.15_$i.txt >> $ps
gmt psxy -R -J -Sb$barwidth -N -G$bluef1  -O -K slr_2100_26_0.3_$i.txt >> $ps
gmt psxy -R -J -Sb$barwidth -N -G$orf3  -O -K slr_2100_85_0_$i.txt >> $ps
gmt psxy -R -J -Sb$barwidth -N -G$orf2  -O -K slr_2100_85_0.3_$i.txt >> $ps
gmt psxy -R -J -Sb$barwidth -N -G$orf1  -O -K slr_2100_85_0.6_$i.txt >> $ps
gmt psxy  -R -J  -N -O -K slr_2050_26_0_$i.txt -Ey$errwidth  >> $ps
gmt psxy  -R -J  -N -O -K slr_2050_26_0.1_$i.txt -Ey$errwidth  >> $ps
gmt psxy  -R -J  -N -O -K slr_2050_85_0_$i.txt -Ey$errwidth  >> $ps
gmt psxy  -R -J  -N -O -K slr_2050_85_0.1_$i.txt -Ey$errwidth  >> $ps
gmt psxy  -R -J  -N -O -K slr_2100_26_0_$i.txt -Ey$errwidth  >> $ps
gmt psxy  -R -J  -N -O -K slr_2100_26_0.15_$i.txt -Ey$errwidth  >> $ps
gmt psxy  -R -J  -N -O -K slr_2100_26_0.3_$i.txt -Ey$errwidth  >> $ps
gmt psxy  -R -J  -N -O -K slr_2100_85_0_$i.txt -Ey$errwidth  >> $ps
gmt psxy  -R -J  -N -O -K slr_2100_85_0.3_$i.txt -Ey$errwidth  >> $ps
gmt psxy  -R -J  -N -O -K slr_2100_85_0.6_$i.txt -Ey$errwidth  >> $ps
gmt psbasemap -O -K -R1/1000/0/6 -J$Jopt -X$xslr -B$Bxopt+l'Return period (yr)' -BweSn+t'4 Saipan' >> $ps
gmt psxy  -R -J -L -t80 -N -Gblack   -O -K rp_pd_ste_$i.txt  >> $ps
# Allowances
gmt psxy  -R -J -W0.75p,$bluef3 -O -K rp_2100_26_0_rc_best_$i.txt  >> $ps
gmt psxy  -R -J -W0.75p,$bluef2 -O -K rp_2100_26_0.15_rc_best_$i.txt  >> $ps
gmt psxy  -R -J -W0.75p,$bluef1 -O -K rp_2100_26_0.3_rc_best_$i.txt  >> $ps

gmt psxy  -R -J -W0.75p,$orf3 -O -K rp_2100_85_0_rc_best_$i.txt  >> $ps
gmt psxy  -R -J -W0.75p,$orf2 -O -K rp_2100_85_0.3_rc_best_$i.txt  >> $ps
gmt psxy  -R -J -W0.75p,$orf1 -O -K rp_2100_85_0.6_rc_best_$i.txt  >> $ps

gmt psxy  -R -J -W0.75p,$purf2,3_1.5:2 -O -K rp_2050_26_0_rc_best_$i.txt  >> $ps
gmt psxy  -R -J -W0.75p,$purf1,3_1.5:2 -O -K rp_2050_26_0.1_rc_best_$i.txt  >> $ps

gmt psxy  -R -J -W0.75p,$redf2,3_1.5:2 -O -K rp_2050_85_0_rc_best_$i.txt  >> $ps
gmt psxy  -R -J -W0.75p,$redf1,3_1.5:2 -O -K rp_2050_85_0.1_rc_best_$i.txt  >> $ps
# Observed and fitted return curve
gmt psxy  -R -J -W1p,black -O -K rp_pd_mn_$i.txt  >> $ps
gmt psxy  -R -J -O -K -Sx0.15c rp_pd_obs_$i.txt  >> $ps


# Legend
gmt set MAP_FRAME_TYPE=plain

gmt psbasemap -O -K -R-0.03/0.98/0/1 -JX17.8c/0.9c -X-13.9c -Y-1.4c -T1000/1000/0.1 >> $ps
echo -e "-0.01 0.66 \n 0.015 0.66" | gmt psxy -R -J -O -K -W1.5p,black >> $ps
echo "0.016 0.66 Present-day" | gmt pstext -R -J -F+f8+jLM -O -K >> $ps
echo -e "0.0025 0.33 1" | gmt psxy -R -J -O -K -Sx0.15c >> $ps
echo "0.016 0.33 Observed extremes" | gmt pstext -R -J -F+f8+jLM -O -K >> $ps

echo "0.17 0.50 2046-2065:" | gmt pstext -R -J -F+f8+jLM -O -K >> $ps

echo -e "0.255 0.66 \n 0.28 0.66" | gmt psxy -R -J -O -K -W1.5p,$purf2,3_1.5:2 >> $ps
echo -e "0.255 0.33 \n 0.28 0.33" | gmt psxy -R -J -O -K -W1.5p,$redf2,3_1.5:2 >> $ps

echo "0.281 0.66 RCP2.6 0cm" | gmt pstext -R -J -F+f8+jLM -O -K >> $ps
echo "0.281 0.33 RCP8.5 0cm" | gmt pstext -R -J -F+f8+jLM -O -K >> $ps

echo -e "0.375 0.66 \n 0.40 0.66" | gmt psxy -R -J -O -K -W1.5p,$purf1,3_1.5:2 >> $ps
echo -e "0.375 0.33 \n 0.40 0.33" | gmt psxy -R -J -O -K -W1.5p,$redf1,3_1.5:2 >> $ps

echo "0.401 0.66 RCP2.6 10cm" | gmt pstext -R -J -F+f8+jLM -O -K >> $ps
echo "0.401 0.33 RCP8.5 10cm" | gmt pstext -R -J -F+f8+jLM -O -K >> $ps

echo "0.52 0.52 2081-2100:" | gmt pstext -R -J -F+f8+jLM -O -K >> $ps
echo -e "0.605 0.66 \n 0.63 0.66" | gmt psxy -R -J -O -K -W1.5p,$bluef3 >> $ps
echo -e "0.605 0.33 \n 0.63 0.33" | gmt psxy -R -J -O -K -W1.5p,$orf3 >> $ps

echo "0.631 0.66 RCP2.6 0cm" | gmt pstext -R -J -F+f8+jLM -O -K >> $ps
echo "0.631 0.33 RCP8.5 0cm" | gmt pstext -R -J -F+f8+jLM -O -K >> $ps

echo -e "0.725 0.66 \n 0.75 0.66" | gmt psxy -R -J -O -K -W1.5p,$bluef2 >> $ps
echo -e "0.725 0.33 \n 0.75 0.33" | gmt psxy -R -J -O -K -W1.5p,$orf2 >> $ps

echo "0.751 0.66 RCP2.6 15cm" | gmt pstext -R -J -F+f8+jLM -O -K >> $ps
echo "0.751 0.33 RCP8.5 30cm" | gmt pstext -R -J -F+f8+jLM -O -K >> $ps

echo -e "0.855 0.66 \n 0.88 0.66" | gmt psxy -R -J -O -K -W1.5p,$bluef1 >> $ps
echo -e "0.855 0.33 \n 0.88 0.33" | gmt psxy -R -J -O -K -W1.5p,$orf1 >> $ps

echo "0.881 0.66 RCP2.6 30cm" | gmt pstext -R -J -F+f8+jLM -O -K >> $ps
echo "0.881 0.33 RCP8.5 60cm" | gmt pstext -R -J -F+f8+jLM -O -K >> $ps



gmt psconvert -Tf $ps
