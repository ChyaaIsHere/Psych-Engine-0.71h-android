function mysplit (inputstr, sep)
	if sep == nil then
		sep = "%s";
	end
	local t = {};
	for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
		table.insert(t, str);
	end
	return t;
end

function onCreatePost()
	makeLuaSprite('CAMfake',nil,getProperty('defaultCamZoom'))
end

function onUpdatePost()
	setProperty('camGame.zoom',getProperty('CAMfake.x'))--fixes cam snaping
end

function onEvent(n,v1,v2)
	local table = mysplit(v1,",");
	local tabledos = mysplit(v2,",");
	if n == 'Camera zoom with tween' then
		cancelTween('zoomeventvalue')
		doTweenX('zoomeventvalue', 'CAMfake', tabledos[2], tabledos[1], table[1])
		setProperty('defaultCamZoom', tabledos[2])
	end
end