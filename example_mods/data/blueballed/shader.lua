function onCreate()
	if shaderEna then
		initLuaShader('rain')
		initLuaShader('darkn')
	end
end

function onCreatePost()
	makeLuaSprite('HardL',nil,1)
	makeLuaSprite("S1",nil,1)
	setSpriteShader("S1", "mirrorRepeat")

	if shaderEna then
		makeLuaSprite("S4",nil,1,1)
		setProperty('S4.angle',1)
		setSpriteShader("S4", "adjustColor")
		makeLuaSprite("S5")
		setSpriteShader("S5", (flashingLights and 'Glitchy' or 'GlitchynoC'))
		makeLuaSprite("S6")
		setSpriteShader("S6", "outline")
		makeLuaSprite("S7")
		setSpriteShader("S7", "pix_n_tv")

		runHaxeCode([[
			trace(ShaderFilter);

			game.camGame.setFilters([new ShaderFilter(game.getLuaObject("S1").shader),new ShaderFilter(game.getLuaObject("S4").shader),new ShaderFilter(game.getLuaObject("S5").shader),new ShaderFilter(game.getLuaObject("S6").shader),new ShaderFilter(game.getLuaObject("S7").shader)]);

			game.camHUD.setFilters([new ShaderFilter(game.getLuaObject("S1").shader),new ShaderFilter(game.getLuaObject("S5").shader)]);
		]])


		setShaderFloat('S2','lightness',0)

		setShaderFloat('S4','contrast',0)
		setShaderFloat('S4','brightness',0)
		setShaderFloat('S4','saturation',0)
		setShaderFloat('S4','hue',0)

		setShaderFloat('S5','AMT',0)
		setShaderFloat('S5','SPEED',1)
		setShaderFloat('S6','Outlining',0)
		setShaderFloat('S7','amount',0)
	else
		runHaxeCode([[
			trace(ShaderFilter);

			game.camGame.setFilters([new ShaderFilter(game.getLuaObject("S1").shader)]);

			game.camHUD.setFilters([new ShaderFilter(game.getLuaObject("S1").shader)]);
		]])
	end
end

function onUpdatePost()
	setShaderFloat('S1','zoom', getProperty('S1.x'))
	if curStep >= 0 and curStep < 180 then
		setShaderFloat('S1','angle', getProperty('S1.y'))
	end

	if flashingLights then
		setProperty("boyfriend.colorTransform.alphaMultiplier", getProperty('HardL.x'))
		setProperty("dad.colorTransform.alphaMultiplier", getProperty('HardL.x'))
		setProperty("gf.colorTransform.alphaMultiplier", getProperty('HardL.x'))
	end

	if shaderEna then
		setShaderFloat('S2','lightness', getProperty('S2.x'))
		setShaderFloat('S5','iTime', getRandomInt(-10,10))

		if curStep >= 0 and curStep < 1567 or curStep >= 2463 then
			setShaderFloat('S4','brightness', getProperty('S4.x'))
			setShaderFloat('S4','hue', getProperty('S4.y'))
			setShaderFloat('S4','saturation', getProperty('S4.angle'))
		end

		if curStep >= 408 and curStep < 416 then
			setShaderFloat('S7','amount',getProperty('S7.x'))
		end

		if curStep > 1696 and curStep < 1952 then
		setShaderFloat("S6", "iTime", os.clock())
		end

		if curStep > 1952 and curStep < 2464 then
			setShaderFloat('S6','iTime', 1)
			setShaderFloat('S6','maxInputBlack',getProperty('S6.x'))
		end

		if curStep == 416 then
			runHaxeCode([[
				trace(ShaderFilter);
				game.camGame.setFilters([new ShaderFilter(game.getLuaObject("S1").shader),new ShaderFilter(game.getLuaObject("S4").shader),new ShaderFilter(game.getLuaObject("S5").shader),new ShaderFilter(game.getLuaObject("S6").shader)]);
				game.camHUD.setFilters([new ShaderFilter(game.getLuaObject("S1").shader),new ShaderFilter(game.getLuaObject("S5").shader)]);
			]])

		elseif curStep == 1565 then
			runHaxeCode([[
				trace(ShaderFilter);
				game.camGame.setFilters([new ShaderFilter(game.getLuaObject("S1").shader),new ShaderFilter(game.getLuaObject("S5").shader)]);
				game.camHUD.setFilters([new ShaderFilter(game.getLuaObject("S1").shader),new ShaderFilter(game.getLuaObject("S5").shader)]);
			]])

		elseif curStep == 1696 then
			makeLuaSprite("S6")
			setSpriteShader("S6", "rain")
			runHaxeCode([[
				trace(ShaderFilter);
				game.camGame.setFilters([new ShaderFilter(game.getLuaObject("S1").shader),new ShaderFilter(game.getLuaObject("S4").shader),new ShaderFilter(game.getLuaObject("S5").shader),new ShaderFilter(game.getLuaObject("S6").shader)]);
				game.camHUD.setFilters([new ShaderFilter(game.getLuaObject("S1").shader),new ShaderFilter(game.getLuaObject("S5").shader)]);
			]])
			setShaderFloat('S6', 'iIntensity', 0.03)
			setShaderFloat('S6', 'iTimescale', 0.5)

		elseif curStep == 1952 then
			makeLuaSprite("S6")
			setSpriteShader("S6", "darkn")
			runHaxeCode([[
				trace(ShaderFilter);
				game.camGame.setFilters([new ShaderFilter(game.getLuaObject("S1").shader),new ShaderFilter(game.getLuaObject("S4").shader),new ShaderFilter(game.getLuaObject("S5").shader),new ShaderFilter(game.getLuaObject("S6").shader)]);
				game.camHUD.setFilters([new ShaderFilter(game.getLuaObject("S1").shader),new ShaderFilter(game.getLuaObject("S5").shader)]);
			]])

		elseif curStep == 2464 then
			if flashingLights then
				makeLuaSprite("S6",nil,0)
				setSpriteShader("S6", "pix_n_tv")
				runHaxeCode([[
					trace(ShaderFilter);
					game.camGame.setFilters([new ShaderFilter(game.getLuaObject("S1").shader),new ShaderFilter(game.getLuaObject("S4").shader),new ShaderFilter(game.getLuaObject("S5").shader),new ShaderFilter(game.getLuaObject("S6").shader)]);
					game.camHUD.setFilters([new ShaderFilter(game.getLuaObject("S1").shader),new ShaderFilter(game.getLuaObject("S5").shader),new ShaderFilter(game.getLuaObject("S6").shader)]);
				]])
			else
				runHaxeCode([[
					trace(ShaderFilter);
					game.camGame.setFilters([new ShaderFilter(game.getLuaObject("S1").shader),new ShaderFilter(game.getLuaObject("S4").shader),new ShaderFilter(game.getLuaObject("S5").shader)]);
					game.camHUD.setFilters([new ShaderFilter(game.getLuaObject("S1").shader),new ShaderFilter(game.getLuaObject("S5").shader)]);
				]])
			end

		elseif curStep >= 3294 then
			setShaderFloat('S6','pixel', getProperty('S6.x'))
		end
	end
end


function opponentNoteHit(id, dir, NT)
	if shaderEna then
		if NT == 'Alt Animation' or NT == 'alt2' then
			setShaderFloat('S5','AMT',getRandomFloat(0.05,0.1))
			runTimer('endGlit',0.1)
		end
	end

	if NT == 'Alt Animation' and flashingLights == false then
		if dadName == 'mom' or dadName == 'CBF' then
			playAnim('dad', getProperty('singAnimations')[dir + 1], true);
		end
	end

	if NT == 'Alt Animation' and dadName == 'CBFF' then
		playAnim('dad', getProperty('singAnimations')[dir + 1], true);
	end
end

function onTimerCompleted(tag)
	if tag == 'endGlit' then
		setShaderFloat('S5','AMT',0)
	end
end

function onEvent(n,v1,v2)
	if n == 'NEW Add Camera Zoom' then
		cancelTween('ZoomX')
		setProperty('S1.x',getProperty('S1.x') + v1 * -1)
		doTweenX('ZoomX','S1',1,0.8,'expoOut')
	end
end