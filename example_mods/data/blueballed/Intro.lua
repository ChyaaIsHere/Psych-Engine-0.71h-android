function onCreate()
	precacheSound('fnf_loss_sfx')
	addLuaScript('custom_events/camera tween')
	addLuaScript('custom_events/Camera zoom with tween')
	setProperty('skipCountdown', true)
end

function onCreatePost()
	setProperty('gf.angle',15)
	setProperty('HardL.x',1.2)
	setProperty('cameraSpeed',100)
	playAnim('gf','firstDeath',true)
	setProperty('gf.visible',false)

	if shaderEna then
		setSpriteShader("gf", "hard")
		setShaderFloat("gf", "binaryIntensity", -0.5)
		setShaderFloat("gf", "negativity", -100)
		setShaderFloat("gf", "redC", 1)
		setShaderFloat("gf", "bluC", 1)
		setShaderFloat("gf", "greC", 1)
		setProperty('S4.x',0.04)
	end

	makeLuaSprite('blurDie')

	setProperty('camHUD.alpha',0)

	setProperty('boyfriend.x',1020)
	setProperty('boyfriend.y',900)
	setProperty('dad.x',-300)
	setProperty('dad.y',1020)
	if checkFileExists('data/blueballed/warningMobile.lua') == false then
		setProperty('CAMfake.x',1.3)
		runTimer('bfDie',0.4)
	end
end


function onSongStart()
	setProperty('holdCoverPurple.x',defaultPlayerStrumX0 - 90)
	setProperty('holdCoverPurple.y',defaultPlayerStrumY0 - 85)
	setProperty('holdCoverBlue.x',defaultPlayerStrumX1 - 90)
	setProperty('holdCoverBlue.y',defaultPlayerStrumY1 - 85)
	setProperty('holdCoverGreen.x',defaultPlayerStrumX2 - 90)
	setProperty('holdCoverGreen.y',defaultPlayerStrumY2 - 85)
	setProperty('holdCoverRed.x',defaultPlayerStrumX3 - 90)
	setProperty('holdCoverRed.y',defaultPlayerStrumY3 - 85)
	for i = 0,7 do
		noteTweenY('N'..i,i,defaultPlayerStrumY1 - (downscroll and -200 or 200),0.01)
	end
end

function onTimerCompleted(t)
	if t == 'bfDie' then
		setProperty('gf.visible',true)
		doTweenAngle('1','gf',0,0.5,'expoOut')
		doTweenX('lsks','HardL',1,0.5,'expoOut')
		doTweenZoom('2','camGame',1.6,0.5,'expoOut')
		runTimer('bfDie2',0.1)
		playAnim('gf','firstDeath',true)
		playSound('fnf_loss_sfx',1)
		setProperty('cameraSpeed',0.05)
		if checkFileExists('data/blueballed/warningMobile.lua') == true then
			deleteFile('data/blueballed/warningMobile.lua')
			removeLuaSprite('redwar')
			removeLuaSprite('norwar')
			removeLuaSprite('clcwar')
			removeLuaSprite('buttngo')
			removeLuaSprite('buttnback')
		end

	elseif t == 'bfDie2' then
		removeSpriteShader('gf')
		setSpriteShader("gf", "chrblur")
		runTimer('TweenY',2.5)

	elseif t == 'TweenY' then
		doTweenY('1','boyfriend',440,4.7,'sineInOut')
		doTweenY('2','dad',510,4.7,'sineInOut')

		doTweenX('3','boyfriend',760,4.7,'sineInOut')
		doTweenX('4','dad',-40,4.7,'sineInOut')


		doTweenX('6','blurDie',6,4.7,'sineInOut')
		triggerEvent('Camera zoom with tween','sineInOut','4.7,0.8')
		doTweenX('S4','S4',0,4.2,'sineInOut')

		doTweenX('S5','gf.scale',1.3,4.7,'sineInOut')
		doTweenY('S6','gf.scale',1.3,4.7,'sineInOut')

		doTweenY('S7','gf',250,4.7,'sineInOut')
		setOnScripts('camX', 565)
		setOnScripts('camY', 590)
		runTimer('CD',1.93)

	elseif t == 'CD' then
		playAnim('gf','loop',true)
		CD = false
		startCountdown()
		runTimer('showNotes',2)

	elseif t == 'showNotes' then
		for i = 0,7 do
			noteTweenY('N'..i,i,defaultPlayerStrumY1,1,'backOut')
		end
		doTweenAlpha('19','camHUD',1,1,'sineInOut')
		setOnScripts('folowcam', false)

	end
end


CD = true
function onStartCountdown()
	if CD then
		return Function_Stop;
	else
		return Function_Continue;
	end
end