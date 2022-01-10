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
# I think next two are atmopheric
Tatm <- d[["TEMP.LEVEL0..degree_Celsius."]]
Patm <- d[["ATMS.LEVEL0..hectopascal."]]

# Extract a segment that looks interesting
look <- 700:1000
t <- t[look]
Tatm <- Tatm[look]
Patm <- Patm[look]
lon <- lon[look]
lat <- lat[look]
print(table(is.finite(lon)))
print(table(is.finite(lat)))
print(table(is.finite(Tatm)))
print(table(is.finite(Patm)))
# Remove NA values (about half the data).  Note that the pattern (seen in close
# examination of first 10 'look' data) seems to be that that there will be two
# values in quick succession, either at identical times or a minute apart, and
# one of them will have NA for T.  Thus, dropping the is.na(T) values
# seems to retain only good data.  We can see that in the red dots (good
# data)
if (!interactive())
    pdf("00.pdf")
par(mar=c(3,3,1,1),mgp=c(2,0.7,0))
plot(lon,lat,asp=1/cos(pi/180*mean(lat)))
ok <- is.finite(Tatm)
t <- t[ok]
lon <- lon[ok]
lat <- lat[ok]
Tatm <- Tatm[ok]
Patm <- Patm[ok]
dt <- mean(diff(as.numeric(t)))
cat("mean(dt)=", mean(diff(as.numeric(t))), "s (i.e. close to 1h)\n")
cat("sd(dt)=", sd(diff(as.numeric(t))), "s\n")
points(lon, lat, pch=20, col=2, cex=0.3)

par(mar=c(3.3,3.3,1,1), mgp=c(2,0.7,0))
hour <- as.numeric(difftime(t, t[1], unit="hours"))
cmt <- colormap(z=hour, col=oceColorsTurbo)#Viridis)
drawPalette(colormap=cmt)# tformat="%d %H%Mh")
plot(lon, lat,asp=1/cos(pi/180*mean(lat)),
    xlab=expression("Longitude ["*degree*"E]"),
    ylab=expression("Latitude ["*degree*"N]"),
    type="o",
    pch=21, cex=1.4, bg=cmt$zcol)
grid()

db <- data.frame(t=t, lon=lon, lat=lat, Tatm=Tatm, Patm=Patm)
save(db, file="drifter.rda", version=2)




if (!interactive())
    dev.off()

