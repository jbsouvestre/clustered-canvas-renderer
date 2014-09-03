OpenLayers.Renderer.ClusteredCanvas = OpenLayers.Class OpenLayers.Renderer.Canvas,
	renderPath: (context, geometry, style, featureId, type) ->
		components = geometry.components
		len = components.length
		context.beginPath()
		start = @getLocalXY components[0]
		previous = start
		x = start[0]
		y = start[1]
		count = 0

		zoomFactors = [
			0.5
			0.5
			0.5
			0.7
			1
			1.3
			1.6
			2
		]

		zoomIndex = @map.zoom
		zoomFactor = zoomFactors[zoomIndex]

		while !zoomFactor
			zoomIndex--
			zoomFactor = zoomFactors[zoomIndex]
		
		if not isNaN(x) and not isNaN(y)
			context.moveTo start[0], start[1]
			i = 1

			while i < len
				pt = @getLocalXY components[i]

				dist = Math.abs(pt[0]-previous[0]) + Math.abs(pt[1]-previous[1])
				if dist > zoomFactor
					count++
					context.lineTo pt[0], pt[1]
				++i
				previous = pt
			if type is "fill"
				context.fill()
			else
				context.stroke()