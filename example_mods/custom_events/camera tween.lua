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
	makeLuaSprite('camval')
end

smoothcamstill = false
function onEvent(n,v1,v2)
	local table = mysplit(v1,",");
	local tabledos = mysplit(v2,",");
	if n == 'camera tween' then
		setProperty('camval.x', getProperty('camFollow.x'))
		setProperty('camval.y', getProperty('camFollow.y'))
		setOnScripts('folowcam', false)
		cancelTween('camSmootX')
		cancelTween('camSmootY')
		smoothcamstill = true
		setProperty('cameraSpeed',tabledos[3])

		doTweenX('camSmootX','camval',(v1 == 'dad' and (getMidpointX('dad') + 150) + (getProperty('dad.cameraPosition[0]') + getProperty('opponentCameraOffset[0]')) or v1 == 'gf' and getMidpointX('gf') + (getProperty('gf.cameraPosition[0]') + getProperty('girlfriendCameraOffset[0]')) or v1 == 'bf' and (getMidpointX('boyfriend') + 100) + (getProperty('boyfriend.cameraPosition[0]') + getProperty('boyfriendCameraOffset[0]')) or table[1]),tabledos[2],tabledos[1])

		doTweenY('camSmootY','camval',(v1 == 'dad' and (getMidpointY('dad') - 100) + (getProperty('dad.cameraPosition[1]') + getProperty('opponentCameraOffset[1]')) or v1 == 'gf' and getMidpointY('gf') + (getProperty('gf.cameraPosition[1]') + getProperty('girlfriendCameraOffset[1]')) or v1 == 'bf' and (getMidpointY('boyfriend') - 100) + (getProperty('boyfriend.cameraPosition[1]') + getProperty('boyfriendCameraOffset[1]')) or table[2]),tabledos[2],tabledos[1])
		end

	if n == 'camera_target' then
		cancelTween('camSmootX')
		cancelTween('camSmootY')
		smoothcamstill = false
	end
end


function onUpdatePost()
	if smoothcamstill then
		setProperty('camFollow.x', getProperty('camval.x'))
		setProperty('camFollow.y', getProperty('camval.y'))
	end
end