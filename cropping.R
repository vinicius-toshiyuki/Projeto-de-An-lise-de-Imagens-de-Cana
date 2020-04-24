library(raster)
library(rgdal)
library(glue)

b1 = raster('C://Users/vtmsu/Desktop/FAZ-0001/Raster/FAZ-0001.tif', band=1)
b2 = raster('C://Users/vtmsu/Desktop/FAZ-0001/Raster/FAZ-0001.tif', band=2)
b3 = raster('C://Users/vtmsu/Desktop/FAZ-0001/Raster/FAZ-0001.tif', band=3)

s = stack(b1, b2, b3)
s = projectRaster(from=s, crs=crs('+proj=longlat +ellps=GRS80 +towgs84=0,0,0,0,0,0,0 +units=m +no_defs'))

width = xmax(s) - xmin(s)
height = ymax(s) - ymin(s)
width = width - width %% 100
height = height - height %% 100

for(i in 0:(width / 10 - 1)){
	for(j in 0:(height / 10 - 1)){
		print(paste("Loop", i, j))

		frame = as(extent(xmin(s) + i * 10, xmin(s) + (i + 1) * 10, ymin(s) + j * 10, ymin(s) + (j + 1) * 10), 'SpatialPolygons')
		crs(frame) = crs(s)
		c = crop(s, frame)
		min = minValue(c)
		max = maxValue(c)
		if(min[1] == min[2] && min[1] == min[3] && min[1] == 255){
			print(paste("Ignoring", i, j))
		}else{
			writeRaster(c, glue('C://Users/vtmsu/Desktop/Crops2/crop{i}_{j}.tif'))
		}
	}
}