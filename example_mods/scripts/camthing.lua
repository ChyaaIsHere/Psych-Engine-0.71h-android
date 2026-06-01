offsetX = 20--offset for the X
offsetY = 20--offset for the Y

CLO = false--original cam switch from false or true
CLX = nil--original cam but X
CLY = nil--original cam but Y

CPX = nil--this is the cam movement it self supported by the offsetX
CPY = nil--this is the cam movement it self supported by the offsetY


function onEvent(n,v1,v2)
	if n == 'camera tween' then
        target = 'smooth'
	end

	if n == 'camera_target' then
        target = v1
	end
end

function onMoveCamera()
	CPX = getProperty('camFollow.x')
	CPY = getProperty('camFollow.y')
	CLO = false
end

function onUpdatePost()
--this is reset the offset without changing the actual tag it self
	if CLO and (target ~= 'bf' or target ~= 'dad' or target ~= 'gf' or target ~= 'all' or target ~= 'smooth') then
		setProperty('camFollow.x', CLX)
		setProperty('camFollow.y', CLY)
	end
end


--bf and gf if camera focus on gf
function goodNoteHit(id, dir)
    if target ~= 'bf' or target ~= 'dad' or target ~= 'gf' or target ~= 'all' or target ~= 'smooth' then
	    if mustHitSection or gfSection and mustHitSection then
		    CLO = true
		    CLX = (dir == 0 and CPX - offsetX or dir == 3 and CPX + offsetX or CPX)
		    CLY = (dir == 1 and CPY + offsetY or dir == 2 and CPY - offsetY or CPY)
        end
    end
end


--dad and gf if camera focus on gf
function opponentNoteHit(id, dir)
    if target ~= 'bf' or target ~= 'dad' or target ~= 'gf' or target ~= 'all' or target ~= 'smooth' then
	    if not mustHitSection or gfSection and not mustHitSection then
		    CLO = true
		    CLX = (dir == 0 and CPX - offsetX or dir == 3 and CPX + offsetX or CPX)
		    CLY = (dir == 1 and CPY + offsetY or dir == 2 and CPY - offsetY or CPY)
        end
    end
end