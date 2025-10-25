-- Comando simples para abrir o menu
local openMenu = TalkAction("!openmenu", "!menu")

function openMenu.onSay(player, words, param)
    -- Enviar extended opcode para o cliente (se ele suportar)
    -- Isso pode ser usado para adicionar botões na interface
    player:sendExtendedOpcode(1, "open_custom_menu")
    
    -- Também abrir o menu diretamente
    createMainMenu(player)
    return false
end

local function createMainMenu(player)
    local window = ModalWindow {
        title = "🎮 Menu Customizado",
        message = "Escolha uma opção do menu:"
    }
    
    window:addButton("🏃 Teleports", function(player, button, choice)
        createTeleportMenu(player)
    end)
    
    window:addButton("🎁 Itens", function(player, button, choice)
        createItemMenu(player)
    end)
    
    window:addButton("⚙️ Config", function(player, button, choice)
        createConfigMenu(player)
    end)
    
    window:addButton("❌ Fechar", function(player, button, choice)
        player:sendTextMessage(MESSAGE_INFO_DESCR, "Menu fechado!")
    end)
    
    window:sendToPlayer(player)
end

function createTeleportMenu(player)
    local window = ModalWindow {
        title = "🏃 Teleports",
        message = "Para onde você quer ir?"
    }
    
    window:addChoice("🏰 Thais Temple", {x = 32369, y = 32241, z = 7})
    window:addChoice("🌸 Carlin Depot", {x = 32360, y = 31782, z = 7})
    window:addChoice("💰 Venore Bank", {x = 32957, y = 32076, z = 7})
    window:addChoice("⛏️ Kazordoon", {x = 32649, y = 31925, z = 11})
    
    window:addButton("✈️ Ir", function(player, button, choice)
        if choice.data then
            player:teleportTo(choice.data)
            player:sendTextMessage(MESSAGE_INFO_DESCR, "✈️ Teleportado para " .. choice.text .. "!")
            player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
        end
    end)
    
    window:addButton("⬅️ Voltar", function(player, button, choice)
        createMainMenu(player)
    end)
    
    window:sendToPlayer(player)
end

function createItemMenu(player)
    local window = ModalWindow {
        title = "🎁 Menu de Itens",
        message = "O que você gostaria de receber?"
    }
    
    window:addChoice("🧪 Health Potions (10x)", {id = 266, count = 10})
    window:addChoice("💰 Gold Coins (1000x)", {id = 3031, count = 1000})
    window:addChoice("💎 Crystal Coins (10x)", {id = 3043, count = 10})
    window:addChoice("🍖 Food (20x)", {id = 3577, count = 20})
    
    window:addButton("🎁 Receber", function(player, button, choice)
        if choice.data then
            player:addItem(choice.data.id, choice.data.count)
            player:sendTextMessage(MESSAGE_INFO_DESCR, "🎁 Você recebeu " .. choice.text .. "!")
            player:getPosition():sendMagicEffect(CONST_ME_GIFT_WRAPS)
        end
    end)
    
    window:addButton("⬅️ Voltar", function(player, button, choice)
        createMainMenu(player)
    end)
    
    window:sendToPlayer(player)
end

function createConfigMenu(player)
    local window = ModalWindow {
        title = "⚙️ Configurações",
        message = "Configurações do personagem:"
    }
    
    window:addButton("🔄 Reset Skills", function(player, button, choice)
        for i = 0, 6 do
            player:setSkillLevel(i, 10)
        end
        player:sendTextMessage(MESSAGE_INFO_DESCR, "🔄 Skills resetados para level 10!")
        player:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
    end)
    
    window:addButton("✨ Full Bless", function(player, button, choice)
        for i = 1, 8 do
            player:addBlessing(i)
        end
        player:sendTextMessage(MESSAGE_INFO_DESCR, "✨ Todas as blessings recebidas!")
        player:getPosition():sendMagicEffect(CONST_ME_HOLYAREA)
    end)
    
    window:addButton("❤️ Full HP/MP", function(player, button, choice)
        player:addHealth(player:getMaxHealth())
        player:addMana(player:getMaxMana())
        player:sendTextMessage(MESSAGE_INFO_DESCR, "❤️ HP e MP restaurados!")
        player:getPosition():sendMagicEffect(CONST_ME_MAGIC_GREEN)
    end)
    
    window:addButton("⬅️ Voltar", function(player, button, choice)
        createMainMenu(player)
    end)
    
    window:sendToPlayer(player)
end

openMenu:groupType("normal")
openMenu:register()