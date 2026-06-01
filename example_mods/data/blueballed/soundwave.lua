-- script made by zokx on discord, had to change some stuff here and there tho
local numBars = 30 --count
local barWidth = 0.8
local spacing = 50
local BarX = 0
local BarY = 1720
local heightMult = 250 -- height
local smooth = 0.1 -- smooth

local bars = {}
local barHeights = {}

function onCreate()
	if lowQuality then 
	close(true)
	end

for i = 1, numBars do
local x = BarX + (i-1) * (barWidth + spacing)
local tag = 'bar'..i
makeLuaSprite(tag, 'circle', x, BarY)
setProperty(tag..'.scale.x', barWidth)
setProperty(tag..'.width', barWidth)
setProperty(tag..'.angle',180)
setProperty(tag..'.origin.y', 1)
setProperty(tag..'.scale.y', 0.001)
setProperty(tag..'.visible',false)
setScrollFactor(tag, 0.4, 0.4)
addLuaSprite(tag)

bars[i] = tag
barHeights[i] = 0
end
end

function onCreatePost()
	for i = 1, numBars do
local tag = 'bar'..i
setObjectOrder(tag, getObjectOrder('skyBG'))

end
end

local startVisualizer = false

function onSongStart()
startVisualizer = true
end

function onUpdatePost(elapsed)
if curStep <= 2208 then
if not startVisualizer then return end

local time = getPropertyFromClass('flixel.FlxG', 'sound.music.time')
if time == nil then return end

local khz = runHaxeCode([[return (FlxG.sound.music._sound.__buffer.sampleRate / 1000);]])
local channels = runHaxeCode([[return FlxG.sound.music._sound.__buffer.channels;]])

if khz == nil or channels == nil then return end

local index = math.floor(time * khz)
local samples = {}

for i = 1, numBars do
local sampleIndex = index + (i * 100)

local byte = runHaxeCode([[
            var buf = FlxG.sound.music._sound.__buffer.data.buffer;
            var pos = ]]..sampleIndex..[[ * ]]..channels..[[ * 2;
            if (pos >= 0 && pos < buf.length - 2) {
                return buf.getUInt16(pos);
            }
            return 0;
        ]])

if byte == nil then byte = 0 end

if byte > 32767 then
byte = byte - 65535
end

table.insert(samples, math.abs(byte) / 32767 * 1.5)
end


	for i = 1, numBars do
		local targetHeight = math.max(0, samples[i] * heightMult)
		barHeights[i] = barHeights[i] + (targetHeight - barHeights[i]) * smooth

		local finalScale = math.max(0.001, barHeights[i])
		setProperty(bars[i]..'.scale.y', finalScale / 40 + 1)
	end

end
end