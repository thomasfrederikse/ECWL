# Process masks
rm *.ps
ps=ratio.ps


gmt set PS_MEDIA=Custom_15.6cx11.2c

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


#gmt makecpt -CWhiteYellowOrangeRed.cpt -D -T0.0/1.8/0.1 > all_cpt.cpt
gmt makecpt -Cthermal.cpt -Q -I -D -T-1/3/0.1 > ratio_cpt.cpt

J1=X6.0c/3.0c
J2=X1c/3.0c
R2=0/1/0/1
xjump=1.1c
xback=-13.1c

yjump=-3.4c
yjump2=-3.7c

circrad=0.11c
barwidth=0.13cb0
color1=#1f77b4
color2=#2ca02c
color3=#ff7f0e

gmt psbasemap -J$J1 -Rg -Y7.9c -X0.3c -K -Bwesn+t"RCP2.6 AIS: 0 cm"  > $ps
gmt pscoast -R -J -Dc -A5000/0/1+ai -G170/170/170 -S#c6dbef -K -O >> $ps
gmt psxy ratio_RCP26_2100_0.txt -R -J -O -K -Sc$circrad -t35  -Cratio_cpt.cpt  >> $ps
gmt psbasemap -J$J2 -R$R2 -X6c -O -K -Byg0.2 -Bxg0.5 -Bwesn  >> $ps
gmt psxy  -R -J -SB$barwidth -N -G$color1  -O -K hist_all_RCP26_2100_0.txt >> $ps
gmt psxy  -R -J -SB$barwidth -N -G$color2  -O -K hist_ntr_RCP26_2100_0.txt >> $ps
gmt psxy  -R -J -SB$barwidth -N -G$color3  -O -K hist_tr_RCP26_2100_0.txt >> $ps

gmt psbasemap -J$J1 -Rg -X$xjump -O -K -Bwesn+t"RCP8.5 AIS: 0 cm"  >> $ps
gmt pscoast -R -J -Dc -A5000/0/1+ai -G170/170/170 -S#c6dbef -K -O >> $ps
gmt psxy ratio_RCP85_2100_0.txt -R -J -O -K -Sc$circrad -t35  -Cratio_cpt.cpt  >> $ps
gmt psbasemap -J$J2 -R$R2 -X6c -O -K -Bychistannots.txt -Bxg0.5 -BwEsn  >> $ps
gmt psxy  -R -J -SB$barwidth -N -G$color1  -O -K hist_all_RCP85_2100_0.txt >> $ps
gmt psxy  -R -J -SB$barwidth -N -G$color2  -O -K hist_ntr_RCP85_2100_0.txt >> $ps
gmt psxy  -R -J -SB$barwidth -N -G$color3  -O -K hist_tr_RCP85_2100_0.txt >> $ps

gmt psbasemap -J$J1 -Rg -Y$yjump -X$xback -O -K -Bwesn+t"RCP2.6 AIS: 15 cm"  >> $ps
echo "180 0 2081-2100" |  gmt pstext -D-3.15c/0c -R -J -N -F+f8,Helvetica-Bold+jCM+a90 -O -K >> $ps
gmt pscoast -R -J -Dc -A5000/0/1+ai -G170/170/170 -S#c6dbef -K -O >> $ps
gmt psxy ratio_RCP26_2100_0.15.txt -R -J -O -K -Sc$circrad -t35  -Cratio_cpt.cpt  >> $ps
gmt psbasemap -J$J2 -R$R2 -X6c -O -K -Byg0.2 -Bxg0.5 -Bwesn  >> $ps
gmt psxy  -R -J -SB$barwidth -N -G$color1  -O -K hist_all_RCP26_2100_0.15.txt >> $ps
gmt psxy  -R -J -SB$barwidth -N -G$color2  -O -K hist_ntr_RCP26_2100_0.15.txt >> $ps
gmt psxy  -R -J -SB$barwidth -N -G$color3  -O -K hist_tr_RCP26_2100_0.15.txt >> $ps

gmt psbasemap -J$J1 -Rg -X$xjump -O -K -Bwesn+t"RCP8.5 AIS: 30 cm"  >> $ps
gmt pscoast -R -J -Dc -A5000/0/1+ai -G170/170/170 -S#c6dbef -K -O >> $ps
gmt psxy ratio_RCP85_2100_0.3.txt -R -J -O -K -Sc$circrad -t35  -Cratio_cpt.cpt  >> $ps
gmt psbasemap -J$J2 -R$R2 -X6c -O -K -Bychistannots.txt -Bxg0.5 -BwEsn  >> $ps
gmt psxy  -R -J -SB$barwidth -N -G$color1  -O -K hist_all_RCP85_2100_0.3.txt >> $ps
gmt psxy  -R -J -SB$barwidth -N -G$color2  -O -K hist_ntr_RCP85_2100_0.3.txt >> $ps
gmt psxy  -R -J -SB$barwidth -N -G$color3  -O -K hist_tr_RCP85_2100_0.3.txt >> $ps


gmt psbasemap -J$J1 -Rg -Y$yjump -X$xback -O -K -Bwesn+t"RCP2.6 AIS: 30 cm"  >> $ps
gmt pscoast -R -J -Dc -A5000/0/1+ai -G170/170/170 -S#c6dbef -K -O >> $ps
gmt psxy ratio_RCP26_2100_0.3.txt -R -J -O -K -Sc$circrad -t35  -Cratio_cpt.cpt  >> $ps
gmt psscale  -Dx0c/-0.45c+w9.5c/0.3c+e+h-R -J -Np -Q -Cratio_cpt.cpt  -B0.2  -O -Bx+l'Present-day return frequency (years)' -S -K >> $ps
gmt psbasemap -J$J2 -R$R2 -X6c -O -K -Byg0.2 -Bxg0.5 -Bwesn  >> $ps
gmt psxy  -R -J -SB$barwidth -N -G$color1  -O -K hist_all_RCP26_2100_0.3.txt >> $ps
gmt psxy  -R -J -SB$barwidth -N -G$color2  -O -K hist_ntr_RCP26_2100_0.3.txt >> $ps
gmt psxy  -R -J -SB$barwidth -N -G$color3  -O -K hist_tr_RCP26_2100_0.3.txt >> $ps

gmt psbasemap -J$J1 -Rg -X$xjump -O -K -Bwesn+t"RCP8.5 AIS: 60 cm"  >> $ps
gmt pscoast -R -J -Dc -A5000/0/1+ai -G170/170/170 -S#c6dbef -K -O >> $ps
gmt psxy ratio_RCP85_2100_0.6.txt -R -J -O -K -Sc$circrad -t35  -Cratio_cpt.cpt  >> $ps
gmt psbasemap -J$J2 -R$R2 -X6c -O -K -Bychistannots.txt -Bxg0.5 -BwEsn  >> $ps
gmt psxy  -R -J -SB$barwidth -N -G$color1  -O -K hist_all_RCP85_2100_0.6.txt >> $ps
gmt psxy  -R -J -SB$barwidth -N -G$color2  -O -K hist_ntr_RCP85_2100_0.6.txt >> $ps
gmt psxy  -R -J -SB$barwidth -N -G$color3  -O -K hist_tr_RCP85_2100_0.6.txt >> $ps

# Legend
gmt psbasemap -O -K -R0/0.5/0/1 -JX3c/1c -X-2c -Y-1.1c -T1000/1000/0.1 >> $ps
echo -e "0 0.82 \n 0.10 0.82" | gmt psxy -R -J -O -K -W0.15c,$color1 >> $ps
echo -e "0 0.50 \n 0.10 0.50" | gmt psxy -R -J -O -K -W0.15c,$color2 >> $ps
echo -e "0 0.18 \n 0.10 0.18" | gmt psxy -R -J -O -K -W0.15c,$color3 >> $ps

echo "0.11 0.82 All locations" | gmt pstext -R -J -F+f8+jLM -O -K >> $ps
echo "0.11 0.50 Extratropics" | gmt pstext -R -J -F+f8+jLM -O -K >> $ps
echo "0.11 0.18 Tropics" | gmt pstext -R -J -F+f8+jLM -O -K >> $ps


gmt psconvert -Tf $ps
