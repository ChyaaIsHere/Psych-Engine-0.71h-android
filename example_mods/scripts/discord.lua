disc = 0
function onCreatePost()
	changeDiscordClientID('1483555003779256510')
end

function onUpdatePost()
	if disc == 0 then
		changeDiscordPresence('currently playing', songName, 'bfc', true,0,'coco')
	elseif disc == 1 then
		changeDiscordPresence('paused the game', songName, 'bfc', true,0,'coco')
	end
end

function onPause()
	disc = 1
	return Function_Continue;
end

function onResume()
	disc = 0
end