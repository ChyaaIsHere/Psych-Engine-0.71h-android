function onCreatePost()
	setProperty('showRating', false)
	setProperty('showComboNum', false)
end

function onGameOver()
	setProperty('camGame.visible',false)
	setProperty('camHUD.visible',false)
	setProperty('camOther.visible',false)
	if not shaderEna then
		setPropertyFromClass('backend.ClientPrefs', 'data.shaders', false)
	end
	return Function_Continue;
end

function onGameOverStart()
	setProperty('camGame.visible',false)
	setProperty('camHUD.visible',false)
	setProperty('camOther.visible',false)
	if not shaderEna then
		setPropertyFromClass('backend.ClientPrefs', 'data.shaders', false)
	end
	restartSong(false)
end

function opponentNoteHit()
    setProperty('vocals.volume', 1)
end