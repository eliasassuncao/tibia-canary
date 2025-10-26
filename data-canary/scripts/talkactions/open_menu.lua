-- Comando simples para abrir o menu
local openMenu = TalkAction("!openmenu", "!menu")

-- Definir a função ANTES de usar
local function createMainMenu(player)
    local window = ModalWindow {
        title = "Menu Customizado",
        message = "Escolha uma opcao do menu:"
    }
    
    window:addButton("Teleports", function(player, button, choice)
        createTeleportMenu(player)
    end)
    
    window:addButton("Itens", function(player, button, choice)
        createItemMenu(player)
    end)
    
    window:addButton("Config", function(player, button, choice)
        createConfigMenu(player)
    end)
    
    window:addButton("Fechar", function(player, button, choice)
        player:sendTextMessage(MESSAGE_STATUS, "Menu fechado!")
    end)
    
    window:sendToPlayer(player)
end

function createTeleportMenu(player)
    local window = ModalWindow {
        title = "Teleports",
        message = "Para onde voce quer ir?"
    }
    
    window:addChoice("Thais Temple", 1)
    window:addChoice("Carlin Depot", 2)
    window:addChoice("Venore Bank", 3)
    window:addChoice("Kazordoon", 4)
    
    window:addButton("Ir", function(player, button, choice)        
        local locations = {
            [1] = {x = 32369, y = 32241, z = 7, name = "Thais Temple"},
            [2] = {x = 32360, y = 31782, z = 7, name = "Carlin Depot"},
            [3] = {x = 32957, y = 32076, z = 7, name = "Venore Bank"},
            [4] = {x = 32649, y = 31925, z = 11, name = "Kazordoon"}
        }
        
        if choice and choice.id and locations[choice.id] then
            local pos = locations[choice.id]
            
            local success = player:teleportTo(Position(pos.x, pos.y, pos.z))
            if success then
                player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Teleportado para " .. pos.name)
            else
                player:sendTextMessage(MESSAGE_STATUS, "Erro no teleporte!")
            end
        else
            if player and player:isPlayer() then
                player:sendTextMessage(MESSAGE_STATUS, "Erro: Selecione um local primeiro!")
            end
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
        message = "O que voce gostaria de receber?"
    }
    
    window:addChoice("Health Potions (10x)", 1)
    window:addChoice("Gold Coins (1000x)", 2)
    window:addChoice("Crystal Coins (10x)", 3)
    window:addChoice("Food (20x)", 4)
    
    window:addButton("Receber", function(player, button, choice)        
        local items = {
            [1] = {id = 266, count = 10, name = "Health Potions"},
            [2] = {id = 3031, count = 1000, name = "Gold Coins"},
            [3] = {id = 3043, count = 10, name = "Crystal Coins"},
            [4] = {id = 3577, count = 20, name = "Food"}
        }
        
        if choice and choice.id and items[choice.id] then
            local item = items[choice.id]
            
            local success = player:addItem(item.id, item.count)
            if success then
                player:sendTextMessage(MESSAGE_LOOT, "Item recebido: " .. item.name)
            else
                player:sendTextMessage(MESSAGE_STATUS, "Erro ao adicionar item!")
            end
        else
            if player and player:isPlayer() then
                player:sendTextMessage(MESSAGE_STATUS, "Erro: Selecione um item primeiro!")
            end
        end
    end)
    
    window:addButton("Voltar", function(player, button, choice)
        createMainMenu(player)
    end)
    
    window:sendToPlayer(player)
end

-- function createConfigMenu(player)
--     local window = ModalWindow {
--         title = "Configuracoes",
--         message = "Configuracoes do personagem:"
--     }
    
--     window:addButton("Reset Skills.", function(player, button, choice)
--         for i = 0, 6 do
--             player:setSkillLevel(i, 10)
--         end
--         player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Skills resetados para level 10!")
--         player:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
--     end)
    
--     window:addButton("Full Bless", function(player, button, choice)
--         for i = 1, 8 do
--             player:addBlessing(i)
--         end
--         player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Todas as blessings recebidas!")
--         player:getPosition():sendMagicEffect(CONST_ME_HOLYAREA)
--     end)
    
--     window:addButton("Reset HP/MP", function(player, button, choice)
--         player:addHealth(player:getMaxHealth())
--         player:addMana(player:getMaxMana())
--         player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "HP e MP restaurados!")
--         player:getPosition():sendMagicEffect(CONST_ME_MAGIC_GREEN)
--     end)
    
--     window:addButton("Voltar", function(player, button, choice)
--         createMainMenu(player)
--     end)
    
--     window:sendToPlayer(player)
-- end

function createConfigMenu(player)
    local window = ModalWindow {
        title = "Configuracoes",
        message = "Configuracoes do personagem:"
    }

    local RESET_SKILLS = 1
    local FULL_BLESS = 2
    local RESET_HP_MP = 3

    window:addChoice("Reset Skills.", RESET_SKILLS)
    window:addChoice("Full Bless", FULL_BLESS)
    window:addChoice("Reset HP/MP", RESET_HP_MP)

    window:addButton("Executar", function(player, button, choice)
        if choice and choice.id then
            if choice.id == RESET_SKILLS then
                for i = 0, 6 do
                    player:setSkillLevel(i, 10)
                end
                player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Skills resetados para level 10!")
                player:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
            elseif choice.id == FULL_BLESS then
                for i = 1, 8 do
                    player:addBlessing(i)
                end
                player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Todas as blessings recebidas!")
                player:getPosition():sendMagicEffect(CONST_ME_HOLYAREA)
            elseif choice.id == RESET_HP_MP then
                player:addHealth(player:getMaxHealth())
                player:addMana(player:getMaxMana())
                player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "HP e MP restaurados!")
                player:getPosition():sendMagicEffect(CONST_ME_MAGIC_GREEN)
            end
        else
            if player and player:isPlayer() then
                player:sendTextMessage(MESSAGE_STATUS, "Erro: Selecione uma opcao primeiro!")
            end
        end
    end)

    window:addButton("Voltar", function(player, button, choice)
        createMainMenu(player)
    end)
    
    window:sendToPlayer(player)
end

function openMenu.onSay(player, words, param)
    -- Enviar extended opcode para o cliente (se ele suportar)
    -- Isso pode ser usado para adicionar botoes na interface
    player:sendExtendedOpcode(1, "open_custom_menu")
    
    -- Também abrir o menu diretamente
    createMainMenu(player)
    return false
end

openMenu:groupType("normal")
openMenu:register()