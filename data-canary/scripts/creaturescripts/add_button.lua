-- Adicionar botão virtual no login
local addCustomButton = CreatureEvent("AddCustomButton")
addCustomButton:type("login")

function addCustomButton.onLogin(player)
    -- Enviar informação para o cliente sobre o botão personalizado
    -- Isso pode ser usado por clientes modificados (OTClient)
    addEvent(function()
        if player then
            -- Verificar se json existe antes de usar
            local data = {
                action = "addButton",
                text = "Menu Custom",
                icon = "menu.png",
                callback = "custom_menu"
            }
            
            -- Tentar usar json se disponível, senão usar string simples
            local encoded = ""
            if json then
                encoded = json.encode(data)
            else
                encoded = "addButton"
            end
            
            player:sendExtendedOpcode(100, encoded)
            
            -- Mostrar mensagem sobre como usar
            player:sendTextMessage(MESSAGE_STATUS, "Digite '!menu' para abrir o menu customizado!")
        end
    end, 2000) -- 2 segundos após login
    
    return true
end

addCustomButton:register()