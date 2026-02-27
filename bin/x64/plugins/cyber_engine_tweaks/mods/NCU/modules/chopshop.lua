-- chopshop.lua
-- ChopShop: jogador precisa estar em carro ou moto no raio do local.
-- Ao acionar o hotkey, recebe reward_eddies (1 edinho) e o veículo é removido.
-- Locais e valor em data/database.json -> chopshop.

local ChopShop = {}

function ChopShop:init(ncuCore)
    self.ncuCore = ncuCore
    self.lastHintAt = 0
    self.hintCooldownSeconds = 2

    if not ncuCore or not ncuCore.data or not ncuCore.data.chopshop then
        print("[NCU:ChopShop] Aviso: seção chopshop não encontrada em database.json.")
        return
    end

    self.rewardEddies = ncuCore.data.chopshop.reward_eddies or 1
    self.locations = ncuCore.data.chopshop.locations or {}
    if #self.locations == 0 then
        print("[NCU:ChopShop] Nenhum local de ChopShop definido.")
        return
    end

    registerHotkey("NCU_ChopShop", "Chop shop (1 edinho)", function()
        self:TryChopShop()
    end)

    print("[NCU:ChopShop] Módulo inicializado. " .. #self.locations .. " locais. Recompensa: " .. tostring(self.rewardEddies) .. " edinho(s). Hotkey: Chop shop.")
end

function ChopShop:GetPlayerPosition()
    local ok, pos = pcall(function()
        local player = Game.GetPlayer()
        if not player then return nil end
        local p = player:GetWorldPosition()
        if not p then return nil end
        return { x = p.x or p.X, y = p.y or p.Y, z = p.z or p.Z }
    end)
    if ok and pos and pos.x then return pos end
    return nil
end

function ChopShop:IsPlayerInVehicle()
    local ok, inV = pcall(function()
        local player = Game.GetPlayer()
        if not player then return false end
        local vehicle = player:GetMountedVehicle()
        if vehicle and vehicle.id then return true end
        local vs = Game.GetVehicleSystem()
        if vs then
            local pv = vs:GetPlayerVehicle(player)
            if pv and pv.id then return true end
        end
        return false
    end)
    return ok and inV == true
end

function ChopShop:DistanceSq(ax, ay, az, bx, by, bz)
    local dx = (ax or 0) - (bx or 0)
    local dy = (ay or 0) - (by or 0)
    local dz = (az or 0) - (bz or 0)
    return dx * dx + dy * dy + dz * dz
end

function ChopShop:GetCurrentLocation()
    local pos = self:GetPlayerPosition()
    if not pos then return nil end

    for _, loc in ipairs(self.locations) do
        local r = (loc.radius_meters or 20) * (loc.radius_meters or 20)
        if self:DistanceSq(pos.x, pos.y, pos.z, loc.x, loc.y, loc.z) <= r then
            return loc
        end
    end
    return nil
end

function ChopShop:GiveMoney(amount)
    local ok = pcall(function()
        Game.AddToInventory("Items.money", amount)
    end)
    return ok
end

function ChopShop:RemovePlayerVehicle()
    local ok = pcall(function()
        local player = Game.GetPlayer()
        if not player then return end
        local vs = Game.GetVehicleSystem()
        if not vs then return end
        local vehicle = vs:GetPlayerVehicle(player)
        if vehicle then
            vs:UnmountVehicle(player)
            vehicle:Delete()
        else
            local mounted = player:GetMountedVehicle()
            if mounted then
                player:UnmountVehicle()
                if mounted.Delete then mounted:Delete() end
            end
        end
    end)
    return ok
end

function ChopShop:TryChopShop()
    local ncuCore = self.ncuCore
    if not ncuCore or not ncuCore.data or not ncuCore.data.chopshop then return end

    local loc = self:GetCurrentLocation()
    if not loc then
        print("[NCU:ChopShop] Não estás num local de ChopShop. Aproxima-te de um ponto.")
        return
    end

    if not self:IsPlayerInVehicle() then
        print("[NCU:ChopShop] Entra num carro ou moto para usar o ChopShop.")
        return
    end

    local amount = ncuCore.data.chopshop.reward_eddies or 1
    if self:GiveMoney(amount) then
        self:RemovePlayerVehicle()
        print("[NCU:ChopShop] ChopShop feito em " .. (loc.name or loc.id) .. ". +" .. tostring(amount) .. " edinho(s).")
    else
        print("[NCU:ChopShop] Erro ao dar recompensa. ChopShop cancelado.")
    end
end

function ChopShop:update(ncuCore, deltaTime)
    if not self.locations or #self.locations == 0 then return end

    local loc = self:GetCurrentLocation()
    local inV = self:IsPlayerInVehicle()
    if loc and inV then
        self.lastHintAt = (self.lastHintAt or 0) + deltaTime
        if self.lastHintAt >= self.hintCooldownSeconds then
            self.lastHintAt = 0
            local ok = pcall(function()
                local bb = Game.GetBlackboardSystem()
                if bb then
                    local uiNotif = bb:Get(Game.GetAllBlackboardDefs().UI_Notifications)
                    if uiNotif then
                        local msg = "[NCU] " .. (loc.name or "ChopShop") .. ": usa o hotkey para chop shop (+" .. tostring(self.rewardEddies or 1) .. " edinho)."
                        uiNotif:SetVariant(Game.GetAllBlackboardDefs().UI_Notifications.WarningMessage, ToVariant(msg), true)
                    end
                end
            end)
        end
    end
end

return ChopShop
