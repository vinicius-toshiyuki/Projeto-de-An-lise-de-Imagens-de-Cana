source('loadRaster.R')
source('getLines.R')
source('linesToMatrix.R')
source('cropLines.R')
source('plotLines.R')

file = readline('Raster image path: ') 
if(file == '')
	file = '/opt/Users/vtmsu/Desktop/Crops2/crop50_33.tif'
print(file)
img = loadRaster(file, plot=TRUE)
#x11()
par(new=TRUE)
par(lwd=3)

lines = readline('Lines path: ')
if(lines == '')
	lines = '/opt/Users/vtmsu/Desktop/FAZ-0001/Linhas/LinhasCana0001.kml'
lines = getLines(lines)
lines = linesToMatrix(lines)

imgLines = cropLines(lines, extent(img))
plotLines(imgLines, type='o', col='red')
