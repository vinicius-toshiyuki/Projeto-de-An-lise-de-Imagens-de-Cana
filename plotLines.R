plotLines = function(lines, img=NULL, type='l', col='yellow'){
	if(is.null(img)){
		minx = min(lines[[1]][,1])
		maxx = max(lines[[1]][,1])

		miny = min(lines[[1]][,2])
		maxy = max(lines[[1]][,2])

		for(i in 2:length(lines)){
			t = min(lines[[i]][,1])
			if(t < minx) minx = t
			t = max(lines[[i]][,1])
			if(t > maxx) maxx = t

			t = min(lines[[i]][,2])
			if(t < miny) miny = t
			t = max(lines[[i]][,2])
			if(t > maxy) maxy = t
		}
	}else{
		minx = xmin(img)
		maxx = xmax(img)
		miny = ymin(img)
		maxy = ymax(img)
	}

	plot(matrix(c(minx,maxx,miny,maxy), ncol=2), type='n')
	for(i in 1:length(lines)){
		lines(lines[[i]], type=type, col=col)
	}
}
