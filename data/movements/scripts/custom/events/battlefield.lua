function onStepIn(creature, item, position, fromPosition)

	local player = creature:getPlayer()
	
	if not player then
		return true
	end

	if BATTLEFIELD.level.active and player:getLevel() < BATTLEFIELD.level.levelMin then
		player:sendCancelMessage(BATTLEFIELD.messages.prefix .."Voc� precisa ter level " .. BATTLEFIELD.level.levelMin .. " ou maior para entrar no evento.")
		player:teleportTo(fromPosition, true)
		player:getPosition():sendMagicEffect(CONST_ME_POFF)
		return true
	end

	if player:getItemCount(2165) >= 1 then
		player:sendCancelMessage(BATTLEFIELD.messages.prefix .."Voc� n�o pode entrar no evento com um stealth ring.")
		player:teleportTo(fromPosition, true)
		player:getPosition():sendMagicEffect(CONST_ME_POFF)
		return false
	end

	local ring = player:getSlotItem(CONST_SLOT_RING)
	if ring then
		if ring:getId() == 2202 then
			player:sendCancelMessage(BATTLEFIELD.messages.prefix .."Voc� n�o pode entrar no evento usando um stealth ring.")
			player:teleportTo(fromPosition, true)
			player:getPosition():sendMagicEffect(CONST_ME_POFF)
			return false
		end
	end

	for a, b in pairs(BATTLEFIELD.players) do
		local target = Player(b)
        if player:getIp() == b:getIp() then
            player:sendCancelMessage(BATTLEFIELD.messages.prefix .. "Voc� j� possui um outro player dentro do evento.")
            player:teleportTo(fromPosition, true)
            player:getPosition():sendMagicEffect(CONST_ME_POFF)
            return true
        end
    end

	if BATTLEFIELD:totalPlayers() >= BATTLEFIELD.maxPlayers then
		player:sendCancelMessage(BATTLEFIELD.messages.prefix .."O evento j� atingiu o m�ximo de participantes.")
		player:teleportTo(fromPosition, true)
		player:getPosition():sendMagicEffect(CONST_ME_POFF)
		return false
	end

	BATTLEFIELD:insertPlayer(player:getId())

	return true
end