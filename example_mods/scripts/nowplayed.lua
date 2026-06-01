-- Script Now Playing "Hyper-Futuristic" (2026 Version)
-- Pasang di mods/scripts/nowPlaying.lua

local boxWidth = 420
local boxHeight = 110
local startX = -460
local endX = 35
local posY = 50

-- Fungsi untuk mengubah detik menjadi format menit:detik
local function formatTime(seconds)
    local min = math.floor(seconds / 60)
    local sec = math.floor(seconds % 60)
    return string.format("%02d:%02d", min, sec)
end

function onCreatePost()
    -- 1. BASE BOX (Glassmorphism Berkabut)
    makeLuaSprite('npBox', '', startX, posY)
    makeGraphic('npBox', boxWidth, boxHeight, '05050A') -- Hitam kebiruan pekat ala tema siber
    setObjectCamera('npBox', 'hud')
    setProperty('npBox.alpha', 0)
    addLuaSprite('npBox', true)

    -- 2. DYNAMIC NEON GLOW LINE (Menggunakan warna BF)
    local bfColor = getProperty('boyfriend.healthColorArray[0]') .. getProperty('boyfriend.healthColorArray[1]') .. getProperty('boyfriend.healthColorArray[2]')
    
    makeLuaSprite('npLine', '', startX, posY + boxHeight - 4)
    makeGraphic('npLine', boxWidth, 4, bfColor)
    setObjectCamera('npLine', 'hud')
    setProperty('npLine.alpha', 0)
    addLuaSprite('npLine', true)

    -- 3. DECORATIVE CORNER ACCENT (Detail kecil pemanis di pojok kiri atas)
    makeLuaSprite('npCorner', '', startX, posY)
    makeGraphic('npCorner', 6, 20, bfColor)
    setObjectCamera('npCorner', 'hud')
    setProperty('npCorner.alpha', 0)
    addLuaSprite('npCorner', true)

    -- 4. TEXT: SUB-TITLE (Cyberpunk Tag dengan spacing)
    makeLuaText('npTitle', 'TRACK IDENTIFIED //', boxWidth, startX + 25, posY + 15)
    setTextSize('npTitle', 13)
    setTextAlignment('npTitle', 'left')
    setTextFont('npTitle', 'vcr.ttf')
    setTextColor('npTitle', '808080')
    setObjectCamera('npTitle', 'hud')
    addLuaText('npTitle')

    -- 5. TEXT: SONG NAME (Bold & Sharp)
    makeLuaText('npSong', string.upper(songName), boxWidth - 40, startX + 25, posY + 33)
    setTextSize('npSong', 34)
    setTextAlignment('npSong', 'left')
    setTextFont('npSong', 'vcr.ttf')
    setObjectCamera('npSong', 'hud')
    addLuaText('npSong')

    -- 6. TEXT: TOTAL TIME (Micro-details di kanan bawah)
    -- Mengambil durasi lagu asli lewat songLength
    local totalSeconds = getProperty('songLength') / 1000
    makeLuaText('npTime', '[' .. formatTime(totalSeconds) .. ']', boxWidth, startX - 25, posY + boxHeight - 28)
    setTextSize('npTime', 14)
    setTextAlignment('npTime', 'right')
    setTextFont('npTime', 'vcr.ttf')
    setTextColor('npTime', '606060')
    setObjectCamera('npTime', 'hud')
    addLuaText('npTime')
end

function onSongStart()
    -- ANIMASI MASUK: Pakai 'elasticOut' biar ada efek membal/bouncing yang super smooth!
    local durIn = 1.2
    
    doTweenX('boxIn', 'npBox', endX, durIn, 'elasticOut')
    doTweenX('lineIn', 'npLine', endX, durIn, 'elasticOut')
    doTweenX('cornerIn', 'npCorner', endX, durIn, 'elasticOut')
    doTweenX('titleIn', 'npTitle', endX + 25, durIn, 'elasticOut')
    doTweenX('songIn', 'npSong', endX + 25, durIn, 'elasticOut')
    doTweenX('timeIn', 'npTime', endX - 25, durIn, 'elasticOut')

    -- Fade In Alphas
    doTweenAlpha('boxFadeIn', 'npBox', 0.8, durIn, 'cubeOut')
    doTweenAlpha('lineFadeIn', 'npLine', 1, durIn, 'cubeOut')
    doTweenAlpha('cornerFadeIn', 'npCorner', 1, durIn, 'cubeOut')
    doTweenAlpha('titleFadeIn', 'npTitle', 1, durIn, 'cubeOut')
    doTweenAlpha('songFadeIn', 'npSong', 1, durIn, 'cubeOut')
    doTweenAlpha('timeFadeIn', 'npTime', 1, durIn, 'cubeOut')

    -- Biarkan pamer di layar selama 3.5 detik
    runTimer('nowPlayingStay', 3.5)
end

-- EFEK AUDIO-REACTIVE (Garis neon berdenyut tipis mengikuti detak lagu/BPM)
function onBeatHit()
    if getProperty('npLine.alpha') > 0.5 then
        -- Setiap beat, garis neon membesar sedikit ke atas
        setProperty('npLine.scale.y', 2.5)
        setProperty('npLine.alpha', 1)
        
        -- Kembalikan ukurannya secara smooth dalam sekejap
        doTweenY('lineScaleReset', 'npLine.scale', 1, 0.2, 'cubeOut')
    end
end

function onTimerCompleted(tag, loops, loopsLeft)
    if tag == 'nowPlayingStay' then
        -- ANIMASI KELUAR: Cepat dan menghilang ke kiri (expoIn)
        local durOut = 0.5
        
        doTweenX('boxOut', 'npBox', startX, durOut, 'expoIn')
        doTweenX('lineOut', 'npLine', startX, durOut, 'expoIn')
        doTweenX('cornerOut', 'npCorner', startX, durOut, 'expoIn')
        doTweenX('titleOut', 'npTitle', startX + 25, durOut, 'expoIn')
        doTweenX('songOut', 'npSong', startX + 25, durOut, 'expoIn')
        doTweenX('timeOut', 'npTime', startX - 25, durOut, 'expoIn')

        doTweenAlpha('boxFadeOut', 'npBox', 0, durOut, 'cubeIn')
        doTweenAlpha('lineFadeOut', 'npLine', 0, durOut, 'cubeIn')
        doTweenAlpha('cornerFadeOut', 'npCorner', 0, durOut, 'cubeIn')
        doTweenAlpha('titleFadeOut', 'npTitle', 0, durOut, 'cubeIn')
        doTweenAlpha('songFadeOut', 'npSong', 0, durOut, 'cubeIn')
        doTweenAlpha('timeFadeOut', 'npTime', 0, durOut, 'cubeIn')
    end
end