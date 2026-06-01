function opponentNoteHit(id, dir, NT)
    if NT == 'alt2' then
        playAnim('dad', getProperty('singAnimations')[dir + 1]..'-alt2', true);
    end
end