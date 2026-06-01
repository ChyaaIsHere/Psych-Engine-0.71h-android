function onPause()
	if not shaderEna then
		setPropertyFromClass('backend.ClientPrefs', 'data.shaders', false)
	end
	return Function_Continue;
end

function onEndSong()
	if not shaderEna then
		setPropertyFromClass('backend.ClientPrefs', 'data.shaders', false)
	end
	return Function_Continue;
end