# Download
# https://data-coriolis.ifremer.fr/tmp/co0501/DataSelection_20220109_170824_13164538.tgz
# (which will not likely exist a few days after my initial download on
# 2022-01-19), expand it, and then navigate within until you get to the
# directory with the file named as below.


library(oce)
file <- "drifting-buoys-4201703.csv"
d <- read.csv(file)
lon <- d[["LONGITUDE..degree_east."]]
lat <- d[["LATITUDE..degree_north."]]
t <- as.POSIXct(d[["DATE..yyyy.mm.ddThh.mi.ssZ."]], format="%Y-%m-%dT%H:%M:%SZ", tz="UTC")
T <- d[["TEMP.LEVEL0..degree_Celsius."]]
Patm <- d[["ATMS.LEVEL0..hectopascal."]] # not used here

# Extract a segment that looks interesting
look <- 900:1000
t <- t[look]
T <- T[look]
lon <- lon[look]
lat <- lat[look]
table(is.finite(T))
# Remove NA values (and there are lots of them)
ok <- is.finite(T)
t <- t[ok]
T <- T[ok]
lon <- lon[ok]
lat <- lat[ok]

# Position plot, with colours being hours since first point in this subset.
par(mar=c(3.3,3.3,1,1), mgp=c(2,0.7,0))
hour <- difftime(t, t[1], unit="hours")
cmt <- colormap(z=hour, col=oceColorsViridis)
drawPalette(colormap=cmt)# tformat="%d %H%Mh")
plot(lon, lat,asp=1/cos(pi/180*mean(lat)),
    xlab=expression("Longitude ["*degree*"E]"),
    ylab=expression("Latitude ["*degree*"N]"),
    pch=20, col=cmt$zcol)
grid()


#mtext(format(t[1],format="%b %Y"))
stop()

cmT <- colormap(z=T, col=oceColorsTemperature)
par(mfrow=c(2,1))
par(mar=c(3,3,1,1), mgp=c(2,0.7,0))
drawPalette(colormap=cmT)
plot(lon, lat, asp=1/cos(pi/180*mean(lat)), type="p", pch=20, cex=2, col=cmT$zcol)

par(mfrow=c(2,1))
plot(t,lon)
plot(t,lat)
