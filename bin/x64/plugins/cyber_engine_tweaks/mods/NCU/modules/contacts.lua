-- contacts.lua
-- Gerencia os Dois Fixers principais do mod, ligações e liberação de missões

local Contacts = {
    car_fixer = {
        id = "car_fixer",
        name = "Yelena",
        domain = "Veículos, Corridas Clandestinas e Desmanches",
        greeting = "Aí, pé de chumbo. Tenho umas chaves que precisam trocar de dono."
    },
    gang_fixer = {
        id = "gang_fixer",
        name = "Ian",
        domain = "Reputação, Acerto de Contas e Controle de Território",
        greeting = "V... as ruas estão pedindo sangue. Tenho um trabalho de limpeza pra você."
    }
}

function Contacts:init()
    print("[NCU:Contacts] Módulo de Contatos inicializado.")
    print("[NCU:Contacts] Fixer Ativo: " .. self.car_fixer.name .. " (" .. self.car_fixer.domain .. ")")
    print("[NCU:Contacts] Fixer Ativo: " .. self.gang_fixer.name .. " (" .. self.gang_fixer.domain .. ")")
    
    -- Futuramente: Aqui escutaremos os eventos pra saber quando disparar as dublagens
end

-- Simula verificação de missões do contato de Carros (Yelena)
function Contacts:CheckCarContracts(trustLevel)
    if trustLevel > 10 then
        print("[NCU:" .. self.car_fixer.name .. "] Enviando contrato High-End: Hipercarro Corporativo.")
    else
        print("[NCU:" .. self.car_fixer.name .. "] Enviando contrato Inicial: Roube um sedã abandonado em Watson.")
    end
end

-- Simula verificação de missões do contato de Gangues (Ian)
function Contacts:CheckGangContracts(trustLevel, territoryReputation)
    if trustLevel > 10 and territoryReputation < -20 then
        print("[NCU:" .. self.gang_fixer.name .. "] Maelstrom tá full pistola com você. Tenho um contrato pra limpar a barra, ou ir pra guerra.")
    else
        print("[NCU:" .. self.gang_fixer.name .. "] O básico. Vá em Heywood e dê um susto nuns devedores.")
    end
end

-- Essa função será responsável por acionar o áudio/interface no jogo depois
function Contacts:TriggerHoloCall(contactId)
    local fixer = self[contactId]
    if fixer then
        print(">> TOCA O TELEFONE <<")
        print("[" .. fixer.name .. " (Holo)]: " .. fixer.greeting)
        -- Aqui dentro vamos plugar o arquivo de som pt-br (.wem/.wav) via sistema do Cyberpunk
    end
end

return Contacts
