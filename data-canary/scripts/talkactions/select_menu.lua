-- Menu com lista de seleção
local selectMenu = TalkAction("!select")

function selectMenu.onSay(player, words, param)
    local window = ModalWindow {
        title = "Seletor de Local",
        message = "Para onde você quer ir?"
    }
    
    -- Adicionar choices (lista de seleção)
    window:addChoice("Temple de Thais", function(player, button, choice)
        player:teleportTo({x = 32369, y = 32241, z = 7})
        player:sendTextMessage(MESSAGE_INFO_DESCR, "Teleportado para Thais!")
    end)
    
    window:addChoice("Depot de Carlin", function(player, button, choice)
        player:teleportTo({x = 32360, y = 31782, z = 7})
        player:sendTextMessage(MESSAGE_INFO_DESCR, "Teleportado para Carlin!")
    end)
    
    window:addChoice("Kazordoon", function(player, button, choice)
        player:teleportTo({x = 32649, y = 31925, z = 11})
        player:sendTextMessage(MESSAGE_INFO_DESCR, "Teleportado para Kazordoon!")
    end)
    
    -- Botões de ação
    window:addButton("Ir", function(player, button, choice)
        if choice.callback then
            choice.callback(player, button, choice)
        end
    end)
    
    window:addButton("Cancelar", function(player, button, choice)
        -- Apenas fecha
    end)
    
    window:sendToPlayer(player)
    return false
end

selectMenu:groupType("normal")
selectMenu:register()