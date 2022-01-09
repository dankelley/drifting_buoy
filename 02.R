library(oce)
load("drifting_buoy.rda")

if (!interactive())
    pdf("02.pdf")

par(mar=c(3.3,3.3,1,1), mgp=c(2,0.7,0))
layout(matrix(c(1,3,2,3),nrow=2,byrow=TRUE))
hour <- as.numeric(difftime(t, t[1], unit="hours"))
plot(hour, lon, type="l")
plot(hour, lat, type="l")
cmt <- colormap(z=hour, col=oceColorsViridis)
drawPalette(colormap=cmt)# tformat="%d %H%Mh")
plot(lon, lat,asp=1/cos(pi/180*mean(lat)),
    xlab=expression("Longitude ["*degree*"E]"),
    ylab=expression("Latitude ["*degree*"N]"),
    pch=20, col=cmt$zcol)
grid()

if (!interactive())
    dev.off()

