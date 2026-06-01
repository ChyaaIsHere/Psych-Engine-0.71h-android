function onCreatePost()
	target = false
	speedcamMov = getProperty('cameraSpeed')
end

function onEvent(n,v1,v2)
	if n == 'camera_target' then
		target = v1
	if v2 == 'snap' then
		cameraSetTarget(v1)
		callMethod('camGame.snapToTarget', {})
	else
		speedcamMov = (v2 == '' and speedcamMov or v2)
		setProperty('cameraSpeed',speedcamMov)
		end
	end
end

function onUpdatePost()
	if target == 'bf' then
		cameraSetTarget('boyfriend')

	elseif target == 'dad' then
		cameraSetTarget('dad')

	elseif target == 'gf' then
		cameraSetTarget('gf')
	else
		triggerEvent('Camera Follow Pos')

	end
end