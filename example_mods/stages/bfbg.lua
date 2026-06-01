shadertrue = true
function onCreate()
	if not shadersEnabled then
		setPropertyFromClass('backend.ClientPrefs', 'data.shaders', true)
		shadertrue = false
	end
	setPropertyFromClass('backend.ClientPrefs', 'data.camZooms', false)

	addCharacterToList('bfnorm','boyfriend')
	addCharacterToList('Pump','dad')
	setProperty('dad.antialiasing',true)
	setProperty('dad.antialiasing',true)
	setProperty('dad.antialiasing',true)
	setProperty('dad.antialiasing',true)
	addCharacterToList('CBFF','dad')
	addCharacterToList('Skid','gf')
	precacheSound('thunder_1')
	precacheSound('thunder_2')
	changeTransStickers(nil,'bfonly')
end


local noteDir = {'noteLeft','noteDown','noteUp','noteRight'}
function onCreatePost()
	setOnScripts('shaderEna', shadertrue)

	makeLuaSprite('static',nil,-700,-300)
	makeGraphic('static',1,1, 'black')
	scaleObject('static',2500,2000)
	setSpriteShader("static", "static")
	addLuaSprite('static')

	makeLuaSprite('staticAlp',nil,-700,-300)
	makeGraphic('staticAlp', 1, 1, 'black')
	scaleObject('staticAlp',2500,2000)
	addLuaSprite('staticAlp')

	if not lowQuality then
		makeLuaSprite('carS','carS',900,190)
		setProperty('carS.angle',-15)
		addLuaSprite('carS')

		makeLuaSprite('trainS1','trainS1',50,640)
		setProperty('trainS1.angle',15)
		addLuaSprite('trainS1')

		makeLuaSprite('trainS2','trainS2',-510,640)
		setProperty('trainS2.angle',-10)
		addLuaSprite('trainS2')
	end

	if flashingLights then
		makeLuaSprite('hue','hue',0,-0)
		screenCenter('hue','x')
		scaleObject('hue',2.5,1.375)
		setScrollFactor('hue', 0, 0)
		addLuaSprite('hue')
	end


	for i = 1,(lowQuality and 6 or 9) do
		makeLuaSprite('leftBool'..i,noteDir[1])
		addLuaSprite('leftBool'..i)

		makeLuaSprite('downBool'..i,noteDir[2])
		addLuaSprite('downBool'..i)

		makeLuaSprite('upBool'..i,noteDir[3])
		addLuaSprite('upBool'..i)

		makeLuaSprite('rightBool'..i,noteDir[4])
		addLuaSprite('rightBool'..i)
	end

--Dad bg
	makeLuaSprite('stageback', 'stages/dad/bg', -600, -130)
	scaleObject('stageback',1.66,1.66)
	addLuaSprite('stageback')

	makeLuaSprite('stagefront', 'stages/dad/curtains', -630, -150)
	scaleObject('stagefront',1.66,1.66)
	setScrollFactor('stagefront', 1.3, 1.3)
	addLuaSprite('stagefront',true)

	if not lowQuality then
		makeLuaSprite('scafolding', 'stages/dad/scafolding', -680, -430)
		scaleObject("scafolding",1.66,1.66)
		addLuaSprite('scafolding',true)
	end
--------

--Mom bg
	makeLuaSprite('skyBG', 'stages/mom/cloudy sky', -400, -200)
	scaleObject('skyBG',1.66,1.66)
	setScrollFactor('skyBG', 0.1, 0.1)
	addLuaSprite('skyBG')
	if not lowQuality then
		makeLuaSprite('lamp post', 'stages/mom/lamp post', 800, 100)
		setScrollFactor('lamp post', 0.3, 0.3)
		addLuaSprite('lamp post')

		makeLuaSprite('lamp', 'stages/mom/lamp', 823, 115)
		setScrollFactor('lamp', 0.3, 0.3)
		scaleObject('lamp',0.804,0.804)
		addLuaSprite('lamp')

		makeLuaSprite('car', 'stages/mom/car', -1600, 1000)
		scaleObject('car',1.66,1.66)
		setScrollFactor('car', 1.9, 1.9)
		addLuaSprite('car',true)
	end

	makeLuaSprite('bgLimo', 'stages/mom/limo back', -300, 600)
	scaleObject('bgLimo',1.66,1.66)
	setScrollFactor('bgLimo', 0.4, 0.4)
	addLuaSprite('bgLimo')

	if flashingLights then
		makeAnimatedLuaSprite('text', 'text', -200,200)
		scaleObject('text',2,2)
		setProperty('text.antialiasing',true)
		addAnimationByPrefix('text', 'Anim', 'Anim', 24, false)
		addLuaSprite('text')
	end

	makeLuaSprite('limo', 'stages/mom/limo front', -440, 800)
	scaleObject('limo',1.83,1.66)
	addLuaSprite('limo')
--------


--pico bg
	makeLuaSprite('sky', 'stages/pico/sky', -650, -100);
	scaleObject('sky',1.66,1.66)
	setScrollFactor('sky', 0.1, 0.1);
	addLuaSprite('sky');

	makeLuaSprite('city', 'stages/pico/city', -200, -100);
	setScrollFactor('city', 0.3, 0.3);
	scaleObject('city', 1.66,1.41);
	addLuaSprite('city');

	if lowQuality == false and flashingLights then
		makeLuaSprite('win', 'stages/pico/window', -200, -100);
		setScrollFactor('win', 0.3, 0.3);
		scaleObject('win', 1.66,1.41);
		addLuaSprite('win');
	end

	makeLuaSprite('behindTrain', 'stages/pico/overhang', -200, 200);
	scaleObject('behindTrain', 1.35, 1);
	addLuaSprite('behindTrain');

	if lowQuality == false and flashingLights then
		makeLuaSprite('Trainwin', 'stages/pico/trainwin', -500, 350);
		setProperty('Trainwin.alpha',0.8)
		addLuaSprite('Trainwin');
	end

	if lowQuality == false then
		makeLuaSprite('hatch', 'stages/pico/hatch', -150, 880);
		scaleObject('hatch', 1, 1);
		addLuaSprite('hatch', true);
	end

	makeLuaSprite('Train', 'stages/pico/trains', -500, 350);
	addLuaSprite('Train');

	makeLuaSprite('street', 'stages/pico/ground', -650, 200);
	scaleObject('street', 1.35, 1);
	addLuaSprite('street');
--------

--Spooky bg
	if lowQuality == false and flashingLights then
		makeAnimatedLuaSprite('halloweenBG', 'stages/Spooky/halloween_bg', -650, -250);
		addAnimationByPrefix('halloweenBG', 'thunder', 'halloweem bg lightning strike', 20, false);
		scaleObject('halloweenBG',3.25,3.25);
		addLuaSprite('halloweenBG');
		setProperty('halloweenBG.antialiasing',true)
	else
		makeLuaSprite('halloweenBG', 'stages/Spooky/halloween_bglow', -600, -100);
		scaleObject('halloweenBG',2.6,2.6);
		addLuaSprite('halloweenBG');
	end
--------

--kickstarter
	makeAnimatedLuaSprite('cityNight', 'city', -450, -250)
	addAnimationByPrefix('cityNight', 'cityNight', 'City', 24, true)
	scaleObject('cityNight',2.4,2.4)
	setScrollFactor('cityNight',0.1,0.1)
	addLuaSprite('cityNight')

	if not lowQuality then
		makeAnimatedLuaSprite('cityNight2', 'city', -450, -250)
		addAnimationByPrefix('cityNight2', 'cityNight', 'City', 24, true)
		scaleObject('cityNight2',2.4,2.4)
		setBlendMode('cityNight2','subtract')
		setScrollFactor('cityNight2',0.1,0.1)

		setProperty('cityNight2.colorTransform.greenOffset', 255)
		setProperty('cityNight2.colorTransform.redOffset', 255)
		setProperty('cityNight2.colorTransform.blueOffset', 255)

		setProperty('cityNight2.colorTransform.alphaMultiplier',0.20)
		setProperty('cityNight2.colorTransform.redMultiplier', -1)
		setProperty('cityNight2.colorTransform.greenMultiplier', -1)
		setProperty('cityNight2.colorTransform.blueMultiplier', -1)

		addLuaSprite('cityNight2',true)
	end

	makeAnimatedLuaSprite('cityNight3', 'city2', -450, -250)
	addAnimationByPrefix('cityNight3', 'cityNight', 'city', 24, true)
	scaleObject('cityNight3',2.4,2.4)
	setScrollFactor('cityNight3',0.1,0.1)
	addLuaSprite('cityNight3')

	if not lowQuality then
		makeAnimatedLuaSprite('cityNight4', 'city2', -450, -250)
		addAnimationByPrefix('cityNight4', 'cityNight', 'city', 24, true)
		scaleObject('cityNight4',2.4,2.4)
		setBlendMode('cityNight4','subtract')
		setScrollFactor('cityNight4',0.1,0.1)

		setProperty('cityNight4.colorTransform.greenOffset', 255)
		setProperty('cityNight4.colorTransform.redOffset', 255)
		setProperty('cityNight4.colorTransform.blueOffset', 255)

		setProperty('cityNight4.colorTransform.alphaMultiplier',0.20)
		setProperty('cityNight4.colorTransform.redMultiplier', -1)
		setProperty('cityNight4.colorTransform.greenMultiplier', -1)
		setProperty('cityNight4.colorTransform.blueMultiplier', -1)

		addLuaSprite('cityNight4',true)
	end

--------


--finale
if not lowQuality then
		makeAnimatedLuaSprite('crack1', 'stages/finale/1-2crack', 355, 320)
		addAnimationByPrefix('crack1', 'crack1', '1crack', 24, false)
		addAnimationByPrefix('crack1', 'crack2', '2crack0', 20, false)
		addAnimationByPrefix('crack1', 'crack2loop', '2crackloop', 20, true)
		scaleObject('crack1',2.5,2.5)
		addOffset('crack1', 'crack2', 100,100)
		setProperty('crack1.antialiasing',true)
		addLuaSprite('crack1')

		makeAnimatedLuaSprite('crack3', 'stages/finale/3crack', -425, -110)
		addAnimationByPrefix('crack3', 'crack3', '3crack0', 20, false)
		addAnimationByPrefix('crack3', 'crack3loop', 'static 3crack0', 20, true)
		setProperty('crack3.antialiasing',true)
		scaleObject('crack3',2.5,2.5)
		addLuaSprite('crack3')

		makeAnimatedLuaSprite('crack4', 'stages/finale/4crack', -432, -123)
		scaleObject('crack4',2.5,2.5)
		addAnimationByPrefix('crack4', 'crack4', '4crack', 20, false)
		addLuaSprite('crack4')
		setProperty('crack4.antialiasing',true)
	else
		makeLuaSprite('crack1', 'stages/finale/crack1low', 355, 320);
		addLuaSprite('crack1');

		makeAnimatedLuaSprite('crack2', 'stages/finale/2cracklow', 110, 87)
		addAnimationByPrefix('crack2', 'crack2loop', '2crackloop', 20, true)
		scaleObject('crack2', 4, 4)
		addLuaSprite('crack2')

		makeAnimatedLuaSprite('crack3', 'stages/finale/3cracklow', -425, -110)
		addAnimationByPrefix('crack3', 'crack3loop', 'static 3crack0', 20, true)
		scaleObject('crack3', 4, 4)
		addLuaSprite('crack3')
	end
	makeAnimatedLuaSprite('2crack4', 'stages/finale/4crack2', -432, -123)
	addAnimationByPrefix('2crack4', '2crack4', 'static 4crack', 20, true)
	scaleObject('2crack4',4,4)
	addLuaSprite('2crack4')
	if flashingLights == false then
		setProperty('crack1.color',getColorFromHex('808080'))
		setProperty('crack2.color',getColorFromHex('808080'))
		setProperty('crack3.color',getColorFromHex('808080'))
		setProperty('crack4.color',getColorFromHex('808080'))
		setProperty('2crack4.color',getColorFromHex('808080'))
	end
--------


--finaleBG
	makeLuaSprite('Ffg1','stages/BGfinale/Fg1',-360,1200)
	scaleObject('Ffg1',2.33,2.33)
	addLuaSprite('Ffg1',true)

	makeLuaSprite('Ffg2','stages/BGfinale/Fg2',-1000,-150)
	scaleObject('Ffg2',2.33,2.33)
	addLuaSprite('Ffg2',true)

	if not lowQuality then
		makeAnimatedLuaSprite('Fbg1','stages/BGfinale/Bg1',-500,-50)
		addAnimationByPrefix('Fbg1', 'Idle', 'Idle', 24, true)
		scaleObject('Fbg1',2.6,2.6)
		addLuaSprite('Fbg1')

		makeAnimatedLuaSprite('Fbg2','stages/BGfinale/Bg2',-530,500)
		addAnimationByPrefix('Fbg2', 'Idle', 'Idle', 24, true)
		scaleObject('Fbg2',2.7,2.16)
		addLuaSprite('Fbg2')

		makeLuaSprite('Ffg3','stages/BGfinale/Fg3',0,-220)
		scaleObject('Ffg3',1.5,1.4)
		addLuaSprite('Ffg3',true)

	elseif lowQuality or flashingLights == false then
		makeLuaSprite('Fbg1','stages/BGfinale/Bg1low',-500,-50)
		scaleObject('Fbg1',1.6,1.6)
		addLuaSprite('Fbg1')
		if flashingLights == false then
			setProperty('Fbg1.colorTransform.redMultiplier', 0.7)
			setProperty('Fbg1.colorTransform.greenMultiplier', 0.7)
			setProperty('Fbg1.colorTransform.blueMultiplier', 0.7)
			setProperty('Fbg1.color',getColorFromHex('808080'))
		end

	end

	makeAnimatedLuaSprite('Fbg3','stages/BGfinale/Bg3',-130,-100)
	addAnimationByPrefix('Fbg3', 'Idle', 'Idle', 24, true)
	scaleObject('Fbg3',2.33,2.41)
	addLuaSprite('Fbg3')

	makeAnimatedLuaSprite('Fbg4','stages/BGfinale/Bg4',-530,600)
	addAnimationByPrefix('Fbg4', 'Idle', 'Idle', 24, true)
	scaleObject('Fbg4',2.7,2.33)
	addLuaSprite('Fbg4')

	makeAnimatedLuaSprite('Ffg4','stages/BGfinale/Fg4',-580,600)
	addAnimationByPrefix('Ffg4', 'Idle', 'Idle', 24, true)
	scaleObject('Ffg4',2.75,2.33)
	addLuaSprite('Ffg4',true)

	makeLuaSprite('Ffg5','stages/BGfinale/Fg5',-500,-50)
	scaleObject('Ffg5',1.5,1.4)
	setBlendMode('Ffg5','add')
	setProperty('Ffg5.alpha',0.7)
	addLuaSprite('Ffg5',true)
--------

end


leftDan = true
randocolo = 0
function onBeatHit()
	if curBeat %20 == 0 and curStep >= 2208 and curStep <= 2463 and lowQuality == false and flashingLights then
		playAnim('halloweenBG','thunder',true)
		playSound('thunder_'..getRandomInt(1,2),1)
	end

	if curBeat %4 == 0 and curStep >= 1951 and curStep <= 2207 and lowQuality == false and flashingLights then
		randocolo = getRandomInt(1,4,''..randocolo)
		if randocolo == 1 then
			setProperty('win.color', getColorFromHex('12FA05'))
			setProperty('Trainwin.color', getColorFromHex('12FA05'))
		elseif randocolo == 2 then
			setProperty('win.color', getColorFromHex('F9393F'))
			setProperty('Trainwin.color', getColorFromHex('F9393F'))
		elseif randocolo == 3 then
			setProperty('win.color', getColorFromHex('00FFFF'))
			setProperty('Trainwin.color', getColorFromHex('00FFFF'))
		elseif randocolo == 4 then
			setProperty('win.color', getColorFromHex('C24B99'))
			setProperty('Trainwin.color', getColorFromHex('C24B99'))
		end
		setProperty('win.alpha',1)
		setProperty('Trainwin.alpha',1)
		doTweenAlpha(')-;','win',0,1)
		doTweenAlpha('uh)-;','Trainwin',0,1)
	end
end


local Size = {1,1.3,0.7,0.8,0.6,1.5}
function onEvent(n)
	if n == 'notes' then
		for i = 1,(lowQuality and 6 or 9) do
			SizeBool = Size[getRandomInt(1,6)]
			setProperty('leftBool'..i..'.alpha',1)
			setProperty('downBool'..i..'.alpha',1)
			setProperty('upBool'..i..'.alpha',1)
			setProperty('rightBool'..i..'.alpha',1)

			setProperty('leftBool'..i..'.x',getRandomInt(-1000,2000))
			setProperty('downBool'..i..'.x',getRandomInt(-1000,2000))
			setProperty('upBool'..i..'.x',getRandomInt(-1000,2000))
			setProperty('rightBool'..i..'.x',getRandomInt(-1000,2000))

			setProperty('leftBool'..i..'.y',1100)
			setProperty('downBool'..i..'.y',1100)
			setProperty('upBool'..i..'.y',1100)
			setProperty('rightBool'..i..'.y',1100)

			scaleObject('leftBool'..i,SizeBool,SizeBool,false)
			scaleObject('downBool'..i,SizeBool,SizeBool,false)
			scaleObject('upBool'..i,SizeBool,SizeBool,false)
			scaleObject('rightBool'..i,SizeBool,SizeBool,false)

			doTweenY('YleftBool'..i,'leftBool'..i,getRandomInt(400,1000),0.8,'expoOut')
			doTweenY('YdownBool'..i,'downBool'..i,getRandomInt(400,1000),0.8,'expoOut')
			doTweenY('YupBool'..i,'upBool'..i,getRandomInt(400,1000),0.8,'expoOut')
			doTweenY('YrightBool'..i,'rightBool'..i,getRandomInt(400,1000),0.8,'expoOut')

			doTweenAlpha('AlpleftBool'..i,'leftBool'..i,0,0.8,'expoOut')
			doTweenAlpha('AlpdownBool'..i,'downBool'..i,0,0.8,'expoOut')
			doTweenAlpha('AlpupBool'..i,'upBool'..i,0,0.8,'expoOut')
			doTweenAlpha('AlprightBool'..i,'rightBool'..i,0,0.8,'expoOut')

			doTweenAngle('AngleftBool'..i,'leftBool'..i,getRandomInt(100,360),0.8,'expoOut')
			doTweenAngle('AngdownBool'..i,'downBool'..i,getRandomInt(100,360),0.8,'expoOut')
			doTweenAngle('AngupBool'..i,'upBool'..i,getRandomInt(100,360),0.8,'expoOut')
			doTweenAngle('AngrightBool'..i,'rightBool'..i,getRandomInt(100,360),0.8,'expoOut')

		end

	if flashingLights then
		setProperty('hue.alpha',1)
		doTweenAlpha('huefade','hue',0,0.3)

		if (curStep >= 416 and curStep < 672) or (curStep >= 800 and curStep < 1184) then
			setProperty('HardL.x',1.7)
			doTweenX('3','HardL',1.2,0.8,'expoOut')
		else
			setProperty('HardL.x',1.5)
			doTweenX('3','HardL',1,0.8,'expoOut')
		end
	end


	if shaderEna and flashingLights then
		setProperty('S4.x',-2)
		setProperty('S4.angle',-26)
		setProperty('S4.y',-36)

		doTweenX('4','S4',0,0.8,'expoOut')
		doTweenY('5','S4',0,0.8,'expoOut')
		doTweenAngle('6','S4',0,0.8,'expoOut')
	end

		doTweenX('1','S2',0,0.8,'expoOut')
		triggerEvent('NEW Add Camera Zoom','0.05')
	end
end