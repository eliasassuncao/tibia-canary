-- Exemplo de Menu Customizado usando Modal Window
local customMenu = TalkAction("!menu")

function customMenu.onSay(player, words, param)
    -- Criar uma nova modal window
    local window = ModalWindow {
        title = "Menu Customizado",
        message = "Escolha uma opção:"
    }
    
    -- Adicionar botões
    window:addButton("Teleport", function(player, button, choice)
        player:teleportTo({x = 1000, y = 1000, z = 7})
        player:sendTextMessage(MESSAGE_INFO_DESCR, "Você foi teleportado!")
    end)
    
    window:addButton("Bless", function(player, button, choice)
        for i = 1, 8 do
            player:addBlessing(i)
        end
        player:sendTextMessage(MESSAGE_INFO_DESCR, "Você recebeu todas as blessings!")
    end)
    
    window:addButton("Items", function(player, button, choice)
        player:addItem(3031, 100) -- 100 gold coins
        player:addItem(266, 10)   -- 10 health potions
        player:sendTextMessage(MESSAGE_INFO_DESCR, "Você recebeu itens!")
    end)
    
    window:addButton("Fechar", function(player, button, choice)
        -- Apenas fecha a janela
    end)
    
    -- Enviar para o player
    window:sendToPlayer(player)
    return false
end

customMenu:groupType("normal")
customMenu:register()