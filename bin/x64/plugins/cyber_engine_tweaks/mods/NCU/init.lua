-- Night City Underworld (NCU) - Entry Point
-- Versão: 0.1 MVP Inicial

NCU = {
    modules = {},
    data = {}
}

-- Módulos principais do mod
local modulesToLoad = {
    "contacts",
    "missions",
    "races",
    "chop_shops",
    "reputation"
}

-- Função para carregar o banco de dados local (.json)
function NCU:LoadDatabase()
    local file = io.open("data/database.json", "r")
    if file then
        local content = file:read("*all")
        file:close()
        -- Supondo uso nativo de decode simples, na prática usaremos jansson/lua-cjson
        -- Para o protótipo: Carregando a string e exibindo num console
        print("[NCU] Banco de dados de reputação e progressão carregado!")
        return true
    else
        print("[NCU] Erro: database.json não encontrado nas pastas do mod.")
        return false
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
                module:init() -- Inicializa a lógica de cada módulo
            end
            print("[NCU] Módulo carregado: " .. modName)
        else
            print("[NCU] Aviso: Módulo '" .. modName .. "' não encontrado ou vazio (ainda em desenvolvimento).")
        end
    end

    print("[NCU] Inicialização completa. O Submundo está ativo.")
end)

-- Hook para atualizações a cada frame da interface (usaremos mais pra frente)
registerForEvent("onDraw", function()
    -- Se tivermos UI persistente (Ex: barra de status da reputação local) entra aqui
end)
