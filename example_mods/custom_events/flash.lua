function onCreatePost()
	if flashingLights then
		makeLuaSprite('whiteAddF');
		makeGraphic('whiteAddF',screenWidth,screenHeight,'ffffff')
		addLuaSprite('whiteAddF', true);
		setObjectCamera('whiteAddF', 'other')
		setBlendMode('whiteAddF', 'add')
		setProperty('whiteAddF.alpha',0)
	end
end

function onEvent(n,v1,v2)
	if n == 'flash' and flashingLights then
		setProperty('whiteAddF.alpha',1)
		doTweenAlpha('flTw','whiteAddF',0,v1)
	end
end