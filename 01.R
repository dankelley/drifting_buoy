library(oce)
load("drifting_buoy.rda")

if (!interactive())
    pdf("01.pdf")

par(mfcol=c(2,2))
oce.plot.ts(t, Patm, grid=TRUE, drawTimeRange=FALSE)
oce.plot.ts(t, T, grid=TRUE, drawTimeRange=FALSE)
oce.plot.ts(t, lon, grid=TRUE, drawTimeRange=FALSE)
oce.plot.ts(t, lat, grid=TRUE, drawTimeRange=FALSE)

if (FALSE) {
    # FIXME: next not right, since diff(t) is not constant
    par(mfrow=c(2,1))
    acf(diff(lat))
    tau <- 2*pi/coriolis(mean(lat))/3600
    abline(v=tau,col="blue")
    data(tidedata)
    M2 <- 1/with(tidedata$const, freq[name=="M2"])
    abline(v=M2,col="red")
    mtext("acf(diff(lat)): red=M2, blue=Coriolis")
    acf(diff(lon))
    abline(v=tau,col="blue")
    data(tidedata)
    M2 <- 1/with(tidedata$const, freq[name=="M2"])
    abline(v=M2,col="red")
    mtext("acf(diff(lon)): red=M2, blue=Coriolis")
}

if (!interactive())
    dev.off()
