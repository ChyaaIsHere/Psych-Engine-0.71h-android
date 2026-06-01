function onCreatePost()
	runTimer('killthemall',0.1)
end

function onTimerCompleted(t)
	if t == 'killthemall' then
		setProperty('hue.alpha',0)

	for i = 1,(lowQuality and 6 or 9) do
		setProperty('leftBool'..i..'.alpha',0)
		setProperty('downBool'..i..'.alpha',0)
		setProperty('upBool'..i..'.alpha',0)
		setProperty('rightBool'..i..'.alpha',0)
	end

		setProperty('stageback.visible',false)
		setProperty('stagefront.visible',false)
		setProperty('skyBG.visible',false)
		setProperty('bgLimo.visible',false)
		setProperty('limo.visible',false)

		setProperty('text.visible',false)
		setProperty('sky.visible',false)
		setProperty('city.visible',false)
		setProperty('behindTrain.visible',false)
		setProperty('Train.visible',false)
		setProperty('street.visible',false)
		setProperty('halloweenBG.visible',false)
		setProperty('cityNight.visible',false)
		setProperty('cityNight3.visible',false)
		setProperty('2crack4.visible',false)
		setProperty('crack1.visible',false)
		setProperty('crack3.visible',false)
		setProperty('Fbg1.visible',false)
		setProperty('Ffg1.visible',false)
		setProperty('Ffg2.visible',false)
		setProperty('Fbg3.visible',false)
		setProperty('Fbg4.visible',false)
		setProperty('Ffg4.visible',false)
		setProperty('Ffg5.visible',false)

		if not lowQuality then
			setProperty('carS.visible',false)
			setProperty('trainS1.visible',false)
			setProperty('trainS2.visible',false)
			setProperty('scafolding.visible',false)
			setProperty('lamp post.visible',false)
			setProperty('lamp.visible',false)
			setProperty('car.visible',false)
			setProperty('win.visible',false)
			setProperty('win.alpha',0)
			setProperty('Trainwin.visible',false)
			setProperty('hatch.visible',false)
			setProperty('cityNight2.visible',false)
			setProperty('cityNight4.visible',false)
			setProperty('crack4.visible',false)
			setProperty('Fbg2.visible',false)
			setProperty('Ffg3.visible',false)
		else
			setProperty('crack2.visible',false)
		end
	end
end
