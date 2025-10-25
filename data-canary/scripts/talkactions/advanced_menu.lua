-- Sistema de menu hierárquico
local advancedMenu = TalkAction("!advanced")

local function createMainMenu(player)
    local window = ModalWindow {
        title = "Menu Principal",
        message = "Selecione uma categoria:"
    }
    
    window:addButton("Teleports", function(player, button, choice)
        createTeleportMenu(player)
    end)
    
    window:addButton("Itens", function(player, button, choice)
        createItemMenu(player)
    end)
    
    window:addButton("Configurações", function(player, button, choice)
        createConfigMenu(player)
    end)
    
    window:addButton("Sair", function(player, button, choice)
        -- Fecha
    end)
    
    window:sendToPlayer(player)
end

function createTeleportMenu(player)
    local window = ModalWindow {
        title = "Menu de Teleports",
        message = "Escolha um destino:"
    }
    
    window:addChoice("Thais", {x = 32369, y = 32241, z = 7})
    window:addChoice("Carlin", {x = 32360, y = 31782, z = 7})
    window:addChoice("Venore", {x = 32957, y = 32076, z = 7})
    
    window:addButton("Teleportar", function(player, button, choice)
        if choice.data then
            player:teleportTo(choice.data)
            player:sendTextMessage(MESSAGE_INFO_DESCR, "Teleportado para " .. choice.text .. "!")
        end
    end)
    
    window:addButton("Voltar", function(player, button, choice)
        createMainMenu(player)
    end)
    
    window:sendToPlayer(player)
end

function createItemMenu(player)
    local window = ModalWindow {
        title = "Menu de Itens",
        message = "Que tipo de item você quer?"
    }
    
    window:addChoice("Potions", {id = 266, count = 10})
    window:addChoice("Gold", {id = 3031, count = 1000})
    window:addChoice("Crystal Coin", {id = 3043, count = 10})
    
    window:addButton("Receber", function(player, button, choice)
        if choice.data then
            player:addItem(choice.data.id, choice.data.count)
            player:sendTextMessage(MESSAGE_INFO_DESCR, "Você recebeu " .. choice.text .. "!")
        end
    end)
    
    window:addButton("Voltar", function(player, button, choice)
        createMainMenu(player)
    end)
    
    window:sendToPlayer(player)
end

function createConfigMenu(player)
    local window = ModalWindow {
        title = "Configurações",
        message = "O que você quer fazer?"
    }
    
    window:addButton("Reset Skills", function(player, button, choice)
        for i = 0, 6 do
            player:setSkillLevel(i, 10)
        end
        player:sendTextMessage(MESSAGE_INFO_DESCR, "Skills resetados!")
    end)
    
    window:addButton("Full Bless", function(player, button, choice)
        for i = 1, 8 do
            player:addBlessing(i)
        end
        player:sendTextMessage(MESSAGE_INFO_DESCR, "Blessings recebidas!")
    end)
    
    window:addButton("Voltar", function(player, button, choice)
        createMainMenu(player)
    end)
    
    window:sendToPlayer(player)
end

function advancedMenu.onSay(player, words, param)
    createMainMenu(player)
    return false
end

advancedMenu:groupType("normal")
advancedMenu:register()