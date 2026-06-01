local hideHud = {'iconP1', 'iconP2', 'healthBar', 'healthBarBG'}
local noPuase = false
local beat = 1

function onCreatePost()
	setOnScripts('folowcam', true)
	setOnScripts('camX', 570)
	setOnScripts('camY', 470)

	makeAnimatedLuaSprite('Particles', 'Particles', -120, 200)  
	addAnimationByPrefix('Particles', 'Anim', 'Anim', 24, false)  
	scaleObject('Particles', 2, 2)  
	setProperty('Particles.visible', false)  
	addLuaSprite('Particles', true)  

	if not flashingLights then  
		makeLuaSprite('blackAddF')  
		makeGraphic('blackAddF', screenWidth, screenHeight, '000000')  
		setObjectCamera('blackAddF', 'hud')  
		setProperty('blackAddF.alpha', 0)  
		addLuaSprite('blackAddF')  
	end  

	if flashingLights then  
		startVideo('retry', false, true, false, false)  
	else  
		startVideo('retryfl', false, true, false, false)  
	end

	setProperty('scoreTxt.visible', false)
	setProperty('timeBar.visible', false)
	setProperty('timeBarBG.visible', false)
	setProperty('timeTxt.visible', false)
end

function onUpdatePost()
	if folowcam then
		setCameraFollowPoint(camX, camY)
	end

	if curStep >= 1184 and flashingLights then  
		setShaderFloat("static", "iTime", os.clock())  
	end  

	if curStep <= 32 then  
		setShaderFloat('gf', 'Size', getProperty('blurDie.x'))  
	end
end

function onEvent(n, v1, v2)
	if n == 'camera_target' then
		if v1 == 'all' then
			folowcam = true
		else
			folowcam = false
		end
	end

	if n == 'hud' then  
		for i = 1, #hideHud do  
			if v1 == '1' then  
				setProperty(hideHud[i]..'.visible', false)  
			else  
				setProperty(hideHud[i]..'.visible', true)  
			end  
		end  
	end
end

function onBeatHit()
	if curBeat % 8 == 0 and beat == 1 then
		triggerEvent('notes')
	elseif curBeat % 4 == 2 and beat == 2 then  
		triggerEvent('notes')  
	elseif beat == 3 then  -- Optimized: curBeat % 1 == 0 is always true
		triggerEvent('NEW Add Camera Zoom', '0.05')  
	elseif curBeat % 8 == 0 and beat == 4 then  
		triggerEvent('NEW Add Camera Zoom', '0.05')  
	elseif curBeat % 2 == 1 and beat == 5 then  
		triggerEvent('NEW Add Camera Zoom', '0.05')  
	elseif curBeat % 4 == 0 and beat == 6 then  
		triggerEvent('notes')  
	elseif curBeat % 4 == 2 and beat == 7 then  
		triggerEvent('NEW Add Camera Zoom', '0.05')  
	end
end

function onStepHit()
	if curStep == 152 then
		doTweenY('ca', 'S1', 10, 0.7, 'expoIn')

	elseif curStep == 160 then  
		beat = 2  
		doTweenY('ca', 'S1', 0, 0.7, 'expoOut')  

	elseif curStep == 540 or curStep == 2596 then  
		beat = 2  

	elseif curStep == 288 then  
		beat = 3  

	elseif curStep == 319 or curStep == 1305 or curStep == 2448 or curStep == 2688 or curStep == 2957 or curStep == 3232 then  
		beat = 0  

	elseif curStep == 408 then  
		doTweenX('ehdkjiue', 'S7', 2, 0.7, 'expoIn')  

	elseif curStep == 413 and not flashingLights then  
		doTweenAlpha('dele0', 'blackAddF', 1, 0.2, 'quadOut')  

	elseif curStep == 416 then  
		beat = 4  
		setProperty('S7.x', 4)  
		doTweenX('ehdkjiue', 'S7', 0, 0.05)  
		setShaderFloat('S6', 'Outlining', 1)  

		setProperty('cityNight.visible', true)  
		setProperty('cityNight2.visible', true)  

		setProperty('HardL.x', 1.2)  
		setProperty('boyfriend.colorTransform.greenOffset', -60)  
		setProperty('boyfriend.colorTransform.blueOffset', -60)  
		setProperty('dad.colorTransform.greenOffset', -60)  
		setProperty('dad.colorTransform.blueOffset', -60)  
		setProperty('gf.colorTransform.greenOffset', -60)  
		setProperty('gf.colorTransform.blueOffset', -60)  

		doTweenAlpha('dele0', 'blackAddF', 0, 0.2, 'quadOut')  

	elseif curStep == 669 and not flashingLights then  
		doTweenAlpha('dele0', 'blackAddF', 1, 0.2, 'quadOut')  

	elseif curStep == 672 then  
		beat = 0  

		-- ADDED 'true' FLAG TO FLUSH MEMORY
		removeLuaSprite('cityNight', true)  
		removeLuaSprite('cityNight2', true)  

		doTweenX('3', 'HardL', 1, 0.01)  
		setProperty('boyfriend.colorTransform.greenOffset', 0)  
		setProperty('boyfriend.colorTransform.blueOffset', 0)  
		setProperty('dad.colorTransform.greenOffset', 0)  
		setProperty('dad.colorTransform.blueOffset', 0)  
		setProperty('gf.colorTransform.greenOffset', 0)  
		setProperty('gf.colorTransform.blueOffset', 0)  
		setShaderFloat('S6', 'Outlining', 0)  
		doTweenAlpha('dele0', 'blackAddF', 0, 0.2, 'quadOut')  

	elseif curStep == 797 and not flashingLights then  
		doTweenAlpha('dele0', 'blackAddF', 1, 0.2, 'quadOut')  

	elseif curStep == 800 then  
		beat = 5  
		setProperty('cityNight3.visible', true)  
		setProperty('cityNight4.visible', true)  

		setProperty('HardL.x', 1.2)  
		setProperty('boyfriend.colorTransform.greenOffset', -60)  
		setProperty('boyfriend.colorTransform.redOffset', -60)  
		setProperty('dad.colorTransform.greenOffset', -60)  
		setProperty('dad.colorTransform.redOffset', -60)  
		setProperty('gf.colorTransform.greenOffset', -60)  
		setProperty('gf.colorTransform.redOffset', -60)  
		setShaderFloat('S6', 'Outlining', 1)  
		doTweenAlpha('dele0', 'blackAddF', 0, 0.2, 'quadOut')  

	elseif curStep == 928 then  
		beat = 2  

	elseif curStep == 1181 and not flashingLights then  
		doTweenAlpha('dele0', 'blackAddF', 1, 0.2, 'quadOut')  

	elseif curStep == 1184 then  
		beat = 3  
		removeLuaSprite('cityNight3', true)  
		removeLuaSprite('cityNight4', true)  

		doTweenX('3', 'HardL', 1, 0.01)  
		setProperty('boyfriend.colorTransform.greenOffset', 0)  
		setProperty('boyfriend.colorTransform.blueOffset', 0)  
		setProperty('boyfriend.colorTransform.redOffset', 0)  

		setProperty('dad.colorTransform.greenOffset', 0)  
		setProperty('dad.colorTransform.blueOffset', 0)  
		setProperty('dad.colorTransform.redOffset', 0)  

		setProperty('gf.colorTransform.greenOffset', 0)  
		setProperty('gf.colorTransform.blueOffset', 0)  
		setProperty('gf.colorTransform.redOffset', 0)  

		setShaderFloat('S6', 'Outlining', 0)  
		doTweenAlpha('dele0', 'blackAddF', 0, 0.2, 'quadOut')  

	elseif curStep == 1432 or curStep == 1436 then  
		setProperty('static.visible', true)  
		if flashingLights then  
			setProperty('staticAlp.alpha', 0)  
		else  
			setProperty('staticAlp.alpha', 0.7)  
		end  

		setProperty('dad.color', getColorFromHex('000000'))  
		setProperty('boyfriend.color', getColorFromHex('000000'))  
		setProperty('gf.color', getColorFromHex('000000'))  

		doTweenAngle('eid', 'carS', 0, 3)  
		doTweenAngle('eid2', 'trainS1', 0, 3)  
		doTweenAngle('eid3', 'trainS2', 0, 3)  

		setProperty('carS.visible', true)  
		setProperty('trainS1.visible', true)  
		setProperty('trainS2.visible', true)  

	elseif curStep == 1434 or curStep == 1438 then  
		setProperty('staticAlp.alpha', 1)  

		setProperty('carS.visible', false)  
		setProperty('trainS1.visible', false)  
		setProperty('trainS2.visible', false)  

		setProperty('dad.color', getColorFromHex('ffffff'))  
		setProperty('boyfriend.color', getColorFromHex('ffffff'))  
		setProperty('gf.color', getColorFromHex('ffffff'))  

	elseif curStep == 1440 then  
		beat = 6  

	elseif curStep == 1552 then  
		doTweenAlpha('ekeb', 'staticAlp', 0, 2, 'sineInOut')  
		beat = 0  
		camX = 570  
		camY = 410  

	elseif curStep == 1565 and not flashingLights then  
		doTweenAlpha('dele0', 'blackAddF', 1, 0.2, 'quadOut')  

	elseif curStep == 1568 then  
		beat = 5  

		setSpriteShader("dad", "adjustColor")  
		setShaderFloat('dad', 'contrast', -14)  
		setShaderFloat('dad', 'brightness', -48)  
		setShaderFloat('dad', 'saturation', -31)  
		setShaderFloat('dad', 'hue', -27)  
		
		setSpriteShader("boyfriend", "adjustColor")  
		setShaderFloat('boyfriend', 'contrast', -14)  
		setShaderFloat('boyfriend', 'brightness', -48)  
		setShaderFloat('boyfriend', 'saturation', -31)  
		setShaderFloat('boyfriend', 'hue', -27)  

		playAnim('Particles', 'Anim', true)  
		setProperty('Particles.visible', true)  

		setProperty('stageback.visible', true)  
		setProperty('stagefront.visible', true)  
		setProperty('scafolding.visible', true)  

		setProperty('gf.visible', false)  
		triggerEvent('hud', '1')  
		doTweenAlpha('dele0', 'blackAddF', 0, 0.2, 'quadOut')  

	elseif curStep == 1580 then  
		setProperty('Particles.visible', false)  
		setProperty('static.visible', true)  

	elseif curStep == 1680 then  
		doTweenAlpha('1', 'stageback', 0, 1.36)  
		doTweenAlpha('2', 'stagefront', 0, 1.36)  
		doTweenAlpha('3', 'scafolding', 0, 1.36)  

	elseif curStep == 1693 and not flashingLights then  
		doTweenAlpha('dele0', 'blackAddF', 1, 0.2, 'quadOut')  

	elseif curStep == 1695 then  
		removeSpriteShader('dad')  

	elseif curStep == 1696 then  
		setSpriteShader("dad", "adjustColor")  
		setShaderFloat('dad', 'contrast', -24)  
		setShaderFloat('dad', 'brightness', -36)  
		setShaderFloat('dad', 'saturation', -39)  
		setShaderFloat('dad', 'hue', -22)  

		setShaderFloat('boyfriend', 'contrast', -24)  
		setShaderFloat('boyfriend', 'brightness', -36)  
		setShaderFloat('boyfriend', 'saturation', -39)  
		setShaderFloat('boyfriend', 'hue', -22)  

		removeLuaSprite('stageback', true)  
		removeLuaSprite('stagefront', true)  
		removeLuaSprite('scafolding', true)  

		setProperty('skyBG.visible', true)  
		setProperty('lamp post.visible', true)  
		setProperty('bgLimo.visible', true)  
		setProperty('limo.visible', true)  
		setProperty('car.visible', true)  

		setProperty('Particles.x', -80)  
		setProperty('Particles.y', 380)  
		playAnim('Particles', 'Anim', true)  
		setProperty('Particles.visible', true)  
		setProperty('static.visible', true)  
		doTweenAlpha('dele0', 'blackAddF', 0, 0.2, 'quadOut')  

	elseif curStep == 1710 then  
		setProperty('Particles.visible', false)  

	elseif curStep == 1810 then  
		setProperty('text.visible', true)  
		playAnim('text', 'Anim', true)  

	elseif curStep == 1824 then  
		beat = 3  
		removeLuaSprite('text', true)  
		if not lowQuality then  
			setShaderFloat('S6', 'iIntensity', 0.25)  
			setShaderFloat('S6', 'iTimescale', 0.7)  
			for i = 1, 30 do  
				doTweenY('bar'..i, 'bar'..i, 920, 0.3)  
				setProperty('bar'..i..'.visible', true)  
			end  
		end  

	elseif curStep == 1936 then  
		camX = 100  
		camY = 720  
		folowcam = true  
		doTweenAlpha('1', 'skyBG', 0, 1.36)  
		doTweenAlpha('2', 'bgLimo', 0, 1.36)  
		doTweenAlpha('3', 'limo', 0, 1.36)  
		doTweenAlpha('8', 'lamp', 0, 1.36)  
		doTweenAlpha('9', 'lamp post', 0, 1.36)  
		doTweenAlpha('10', 'car', 0, 1.36)  
		if not lowQuality then  
			for i = 1, 30 do  
				doTweenAlpha('bar'..i, 'bar'..i, 0, 1.36)  
			end  
		end  

	elseif curStep == 1949 and not flashingLights then  
		setProperty('static.visible', false)  
		doTweenAlpha('dele0', 'blackAddF', 1, 0.2, 'quadOut')  

	elseif curStep == 1951 then  
		removeSpriteShader('dad')  

	elseif curStep == 1952 then  
		setSpriteShader("dad", "adjustColor")  
		setShaderFloat('dad', 'contrast', -33)  
		setShaderFloat('dad', 'brightness', -36)  
		setShaderFloat('dad', 'saturation', -40)  
		setShaderFloat('dad', 'hue', -29)  

		setShaderFloat('boyfriend', 'contrast', -33)  
		setShaderFloat('boyfriend', 'brightness', -36)  
		setShaderFloat('boyfriend', 'saturation', -40)  
		setShaderFloat('boyfriend', 'hue', -29)  

		beat = 0  
		setProperty('sky.visible', true)  
		setProperty('city.visible', true)  
		setProperty('win.visible', true)  
		setProperty('behindTrain.visible', true)  
		setProperty('Train.visible', true)  
		setProperty('Trainwin.visible', true)  
		setProperty('street.visible', true)  
		setProperty('hatch.visible', true)  

		removeLuaSprite('skyBG', true)  
		removeLuaSprite('limo', true)  
		removeLuaSprite('bgLimo', true)  
		removeLuaSprite('lamp', true)  
		removeLuaSprite('lamp post', true)  
		removeLuaSprite('car', true)  
		if not lowQuality then  
			for i = 1, 30 do  
				removeLuaSprite('bar'..i, true)  
			end  
		end  

		setProperty('Particles.x', -120)  
		setProperty('Particles.y', 360)  
		playAnim('Particles', 'Anim', true)  
		setProperty('Particles.visible', true)  
		camX = 570  
		camY = 590  
		setProperty('static.visible', true)  
		doTweenAlpha('dele0', 'blackAddF', 0, 0.2, 'quadOut')  

	elseif curStep == 1972 then  
		setProperty('Particles.visible', false)  

	elseif curStep == 2192 then  
		doTweenAlpha('1', 'sky', 0, 1.36)  
		doTweenAlpha('2', 'city', 0, 1.36)  
		doTweenAlpha('3', 'win', 0, 1.36)  
		doTweenAlpha('4', 'behindTrain', 0, 1.36)  
		doTweenAlpha('5', 'Train', 0, 1.36)  
		doTweenAlpha('6', 'Trainwin', 0, 1.36)  
		doTweenAlpha('7', 'street', 0, 1.36)  
		doTweenAlpha('8', 'hatch', 0, 1.36)  

	elseif curStep == 2205 and not flashingLights then  
		setProperty('static.visible', false)  
		doTweenAlpha('dele0', 'blackAddF', 1, 0.2, 'quadOut')  

	elseif curStep == 2207 then  
		removeSpriteShader('dad')  

	elseif curStep == 2208 then  
		setSpriteShader("dad", "adjustColor")  
		setShaderFloat('dad', 'contrast', -37)  
		setShaderFloat('dad', 'brightness', -80)  
		setShaderFloat('dad', 'saturation', 0)  
		setShaderFloat('dad', 'hue', -35)  

		setSpriteShader("gf", "adjustColor")  
		setShaderFloat('gf', 'contrast', -37)  
		setShaderFloat('gf', 'brightness', -80)  
		setShaderFloat('gf', 'saturation', 0)  
		setShaderFloat('gf', 'hue', -35)  

		setShaderFloat('boyfriend', 'contrast', -37)  
		setShaderFloat('boyfriend', 'brightness', -80)  
		setShaderFloat('boyfriend', 'saturation', 0)  
		setShaderFloat('boyfriend', 'hue', -35)  

		beat = 7  
		setScrollFactor('gf', 1, 1)  
		setProperty('Particles.x', -60)  
		playAnim('Particles', 'Anim', true)  
		setProperty('Particles.visible', true)  
		setProperty('halloweenBG.visible', true)  
		
		removeLuaSprite('sky', true)  
		removeLuaSprite('city', true)  
		removeLuaSprite('win', true)  
		removeLuaSprite('behindTrain', true)  
		removeLuaSprite('street', true)  
		removeLuaSprite('Train', true)  
		removeLuaSprite('Trainwin', true)  
		removeLuaSprite('hatch', true)  
		
		setProperty('static.visible', true)  
		doTweenAlpha('dele0', 'blackAddF', 0, 0.2, 'quadOut')  

	elseif curStep == 2228 then  
		removeLuaSprite('Particles', true)  

	elseif curStep == 2236 then  
		camX = 990  
		camY = 620  
		folowcam = true  

	elseif curStep == 2458 then  
		doTweenX('93;9', 'S6', 357, 0.42, 'quintIn')  
		setProperty('staticAlp.alpha', 1)  

	elseif curStep == 2463 then  
		cameraFlash('game', '000000', 0.5, true)  
		removeSpriteShader('dad')  
		removeSpriteShader('gf')  
		removeSpriteShader('boyfriend')  
		removeLuaSprite('static', true)  
		removeLuaSprite('staticAlp', true)  

	elseif curStep == 2464 then  
		camX = 590  
		camY = 580  
		setProperty('gf.scale.x', 1.3)  
		setProperty('gf.scale.y', 1.3)  
		setScrollFactor('gf', 0.95, 0.95)  
		setProperty('gf.x', 290)  
		setProperty('gf.y', 190)  
		playAnim('gf', 'loop', true)  
		
		removeLuaSprite('halloweenBG', true)  
		removeSpriteShader('static')  
		removeLuaSprite('static', true)  
		removeLuaSprite('staticAlp', true)  
		
		cameraShake('camGame', '0.01', '0.2')  
		if not lowQuality then  
			playAnim('crack1', 'crack1', true)  
		end  
		setProperty('crack1.visible', true)  

	elseif curStep == 2528 then  
		cameraShake('camGame', '0.01', '0.2')  
		if not lowQuality then  
			playAnim('crack1', 'crack2', true)  
		else  
			setProperty('crack2.visible', true)  
			removeLuaSprite('crack1', true)  
		end  

	elseif curStep == 2540 then  
		if not lowQuality then  
			playAnim('crack1', 'crack2loop', true)  
		end  

	elseif curStep == 2600 then  
		cameraShake('camGame', '0.01', '0.2')  
		if not lowQuality then  
			playAnim('crack3', 'crack3', true)  
			setProperty('crack3.visible', true)  
			removeLuaSprite('crack1', true)  
		else  
			setProperty('crack3.visible', true)  
			removeLuaSprite('crack2', true)  
		end  

	elseif curStep == 2612 then  
		if not lowQuality then  
			playAnim('crack3', 'crack3loop', true)  
		end  

	elseif curStep == 2656 then  
		cameraShake('camGame', '0.01', '0.2')  
		if not lowQuality then  
			playAnim('crack4', 'crack4', true)  
			setProperty('crack4.visible', true)  
		else  
			setProperty('2crack4.visible', true)  
		end  
		removeLuaSprite('crack3', true)  

	elseif curStep == 2666 then  
		if not lowQuality then  
			playAnim('2crack4', '2crack4', true)  
			setProperty('2crack4.visible', true)  
			removeLuaSprite('crack4', true)  
		end  

	elseif curStep == 2722 then  
		removeLuaSprite('2crack4', true)  

	elseif curStep == 2718 and not flashingLights then  
		doTweenAlpha('dele0', 'blackAddF', 1, 0.2, 'quadOut')  

	elseif curStep == 2724 then  
		beat = 3  
		setProperty('Ffg1.visible', true)  
		setProperty('Ffg2.visible', true)  
		setProperty('Ffg3.visible', true)  
		setProperty('Ffg4.visible', true)  
		setProperty('Ffg5.visible', true)  
		setProperty('Fbg1.visible', true)  
		setProperty('Fbg2.visible', true)  
		setProperty('Fbg3.visible', true)  
		setProperty('Fbg4.visible', true)  
		if flashingLights then  
			playAnim('gf', 'tuff', true)  
			setProperty('Fbg1.alpha', 1)  
		else  
			doTweenAlpha('bgFade', 'Fbg1', 0.7, 0.2, 'quadOut')  
		end  
		doTweenAlpha('dele0', 'blackAddF', 0, 0.2, 'quadOut')  

	elseif curStep == 2848 then  
		doTweenY('0nd7r', 'Ffg1', 750, 11, 'sineInOut')  

	elseif curStep == 2973 and not flashingLights then  
		doTweenAlpha('dele0', 'blackAddF', 1, 0.2, 'quadOut')  

	elseif curStep == 2976 then  
		beat = 5  
		doTweenAlpha('dele0', 'blackAddF', 0, 0.2, 'quadOut')  

	elseif curStep == 3133 and not flashingLights then  
		doTweenAlpha('dele0', 'blackAddF', 1, 0.2, 'quadOut')  

	elseif curStep == 3136 and not flashingLights then  
		doTweenAlpha('dele0', 'blackAddF', 0, 0.2, 'quadOut')  

	elseif curStep == 3139 and not flashingLights then  
		doTweenAlpha('dele0', 'blackAddF', 1, 0.2, 'quadOut')  

	elseif curStep == 3142 and not flashingLights then  
		doTweenAlpha('dele0', 'blackAddF', 0, 0.2, 'quadOut')  

	elseif curStep == 3145 and not flashingLights then  
		doTweenAlpha('dele0', 'blackAddF', 1, 0.2, 'quadOut')  

	elseif curStep == 3148 and not flashingLights then  
		doTweenAlpha('dele0', 'blackAddF', 0, 0.2, 'quadOut')  

	elseif curStep == 3304 then  
		doTweenX('oe3jfu', 'S6', 100, 2)  
		doTweenAlpha('uuoe', 'camGame', 0, 2)  
		doTweenAlpha('uuole', 'camHUD', 0, 2)  

	elseif curStep == 3340 then  
		noPuase = true  

	elseif curStep == 3344 then  
		callMethod("videoCutscene.play")  
		setObjectCamera('videoCutscene', 'other')  

	end  

	if not lowQuality then  
		if curStep > 1696 and curStep < 1936 then  
			setProperty('lamp.visible', getRandomBool(getRandomInt(10, 30)))  
		end  
	end
end

function onPause()
	if noPuase then
		return Function_Stop
	end
end
-- optimize memory by maylow opt