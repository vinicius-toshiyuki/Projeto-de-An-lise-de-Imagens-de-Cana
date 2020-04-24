library(raster)
library(rgdal)

loadRaster = function(file, plot=FALSE){
	r1 = raster(file, band=1)
	r2 = raster(file, band=2)
	r3 = raster(file, band=3)

	s = stack(r1, r2, r3)
	print(s)
	s = projectRaster(from=s, crs=crs('+proj=longlat +ellps=GRS80 +towgs84=0,0,0,0,0,0,0 +units=m +no_defs'), method='ngb')
	print(s)

	if(plot)
		plotRGB(s, r=1, g=2, b=3)
	s
}