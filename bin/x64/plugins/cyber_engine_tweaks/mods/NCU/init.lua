-- Night City Underworld (NCU) - Entry Point
-- Versão: 0.1 MVP Inicial

NCU = {
    modules = {},
    data = {}
}

-- Módulos principais do mod
local modulesToLoad = {
    "contacts",
    "chopshop"
}

-- Função para carregar o banco de dados local (.json)
function NCU:LoadDatabase()
    local file = io.open("data/database.json", "r")
    if file then
        local content = file:read("*all")
        file:close()
        -- CET tem suporte nativo global à biblioteca json
        NCU.data = json.decode(content)
        print("[NCU] Banco de dados de reputação e progressão carregado!")
        return true
    else
        print("[NCU] Erro: database.json não encontrado nas pastas do mod.")
        return false
    end
end

-- Função para salvar o banco de dados no disco (ex.: após discovered = true)
function NCU:SaveDatabase()
    if not NCU.data or type(NCU.data) ~= "table" then return false end
    local content = json.encode(NCU.data)
    if not content then return false end
    local file = io.open("data/database.json", "w")
    if file then
        file:write(content)
        file:close()
        print("[NCU] Banco de dados salvo (database.json).")
        return true
    else
        print("[NCU] Erro: não foi possível escrever database.json.")
        return false
    end
end

function NCU:Update(deltaTime)
    for _, module in pairs(self.modules) do
        if module.update then
            module:update(self, deltaTime)
        end
    end
end

-- Hook de Início do Cyber Engine Tweaks quando carrega os scripts
registerForEvent("onInit", function()
    print("[NCU] Inicializando Night City Underworld...")

    -- 1. Carrega os dados offline
    NCU:LoadDatabase()

    -- 2. Carrega e Inicia todos os submódulos da Fase 1, 2, 3 e 4
    for _, modName in ipairs(modulesToLoad) do
        local isLoaded, module = pcall(require, "modules/" .. modName)
        if isLoaded then
            NCU.modules[modName] = module
            if module.init then
                module:init(NCU) -- Passa a tabela principal inteira para o módulo ter acesso ao NCU.data
            end
            print("[NCU] Módulo carregado: " .. modName)
        else
            print("[NCU] Aviso: Módulo '" .. modName .. "' não encontrado ou vazio (ainda em desenvolvimento).")
        end
    end

    print("[NCU] Inicialização completa. O Submundo está ativo.")
end)

registerForEvent("onUpdate", function(deltaTime)
    NCU:Update(deltaTime)
end)

-- Hook para atualizações a cada frame da interface (usaremos mais pra frente)
registerForEvent("onDraw", function()
    -- Se tivermos UI persistente (Ex: barra de status da reputação local) entra aqui
end)
