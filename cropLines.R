fixPoint = function(this, new, max, min, again=TRUE){
	if(new[1] < this[1])
		bound = min[1]
	else
		bound = max[1]

	if(new[1] >= min[1] && new[1] <= max[1]){
		bound = if(new[2] < min[2]) min[2] else max[2]
		p = (new[2] - this[2])/(bound - this[2])
	}else{	
		p = (new[1] - this[1])/(bound - this[1])
	}

	newDotX = (new[1] - this[1]) / p + this[1]
	newDotY = (new[2] - this[2]) / p + this[2]

	new =	c(newDotX, newDotY)

	if(again && (new[1] < min[1] || new[1] > max[1] || new[2] < min[2] || new[2] > max[2]))
		new = fixPoint(this, new, max, min, again=FALSE)
	new
}

cropLines = function(lines, ext, fullline=FALSE, offset=0){
	xoffset = (xmax(ext) - xmin(ext)) * offset
	latmin = xmin(ext) - xoffset
	latmax = xmax(ext) + xoffset

	yoffset = (ymax(ext) - ymin(ext)) * offset
	lonmin = ymin(ext) - yoffset
	lonmax = ymax(ext) + yoffset
	new = list()
	k = 1
	for(i in 1:length(lines)){
		line = c()
		first = NA
		last = NA
		for(j in 1:(length(lines[[i]])/2)){
			lat = lines[[i]][j,1]
			lon = lines[[i]][j,2]
			if(
				lat >= latmin && lat <= latmax &&
				lon >= lonmin && lon <= lonmax
			){
				if(fullline){
					line = lines[[i]]
					break
				}else
					if(is.na(first))
						first = j
					last = j
					line = c(line, lat, lon)
			}else if(!is.na(first))
				break
		}
		if(!is.na(first)){
			min = c(latmin, lonmin)
			max = c(latmax, lonmax)
			points = lines[[i]]
			if(first > 1)
				line = c(fixPoint(points[first,], points[first-1,], max, min), line)
			if(last < length(points)/2)
				line = c(line, fixPoint(points[last,], points[last+1,], max, min))
		}

		if(length(line) > 0){
			if(!fullline)
				line = matrix(line, ncol=2, byrow=TRUE)
			new[[k]] = line
			k = k + 1
		}
	}
	new
}
