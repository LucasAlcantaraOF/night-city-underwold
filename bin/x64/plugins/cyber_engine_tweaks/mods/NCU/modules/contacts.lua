-- contacts.lua
-- Gerencia os Dois Fixers principais do mod (Definições)

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
    print("[NCU:Contacts] Fixer Ativo: " .. self.car_fixer.name)
    print("[NCU:Contacts] Fixer Ativo: " .. self.gang_fixer.name)
end

return Contacts
