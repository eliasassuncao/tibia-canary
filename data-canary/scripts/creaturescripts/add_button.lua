-- Adicionar botão virtual no login
local addCustomButton = CreatureEvent("AddCustomButton")
addCustomButton:type("login")

function addCustomButton.onLogin(player)
    -- Enviar informação para o cliente sobre o botão personalizado
    -- Isso pode ser usado por clientes modificados (OTClient)
    addEvent(function()
        if player then
            player:sendExtendedOpcode(100, json.encode({
                action = "addButton",
                text = "Menu Custom",
                icon = "menu.png",
                callback = "custom_menu"
            }))
            
            -- Mostrar mensagem sobre como usar
            player:sendTextMessage(MESSAGE_INFO_DESCR, "💡 Digite '!menu' para abrir o menu customizado!")
        end
    end, 2000) -- 2 segundos após login
    
    return true
end

addCustomButton:register()