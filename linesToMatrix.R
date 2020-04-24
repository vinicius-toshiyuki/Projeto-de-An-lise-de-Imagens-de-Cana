linesToMatrix = function(lines){
	new = list()
	for(i in 1:length(lines)){
		line = c()
		for(j in 1:length(lines[[i]])){
			line = c(line, as.double(strsplit(lines[[i]][[j]], ',')[[1]][1:2]))
		}
		line = matrix(line, ncol=2, byrow=TRUE)
		new[[i]] = line
	}
	new
}