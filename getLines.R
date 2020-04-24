getLines = function(filename){
	library(XML)
	kml = xmlParse(filename)
	kml = xmlToList(kml)

	folder = kml[['Document']][['Folder']]

	lines = c()

	for(i in 2:length(folder)){
		lines = c(
			lines,
			c(strsplit(
				folder[i][['Placemark']][['LineString']][['coordinates']],
				' '
			))
		)
	}
	lines
}
