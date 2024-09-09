local testpos = vector3(-1127.1355, -3262.7573, 13.9444)
local testrad = vector3(0, 0, 0)
local offset = 2
local prop = GetHashKey("prop_cs_cardbox_01")
local objs = {}
local transitions = {
    "Linear",
    "EaseIn",
    "EaseOut",
    "EaseInOut",
    "EaseInCubic",
    "EaseOutCubic",
    "EaseInOutCubic",
    "ElasticIn",
    "ElasticOut",
    "ElasticInOut",
    "BounceIn",
    "BounceOut",
    "BounceInOut"
}
function Draw3DText(x, y, z, scl_factor, text)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    local p = GetGameplayCamCoords()
    local distance = GetDistanceBetweenCoords(p.x, p.y, p.z, x, y, z, 1)
    local scale = (1 / distance) * 2
    local fov = (1 / GetGameplayCamFov()) * 100
    local scale = scale * fov * scl_factor
    if onScreen then
        SetTextScale(0.0, scale)
        SetTextFont(0)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 215)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x, _y)
    end
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        for i, v in ipairs(transitions) do
            local of = offset * i
            Draw3DText(testpos.x + of, testpos.y, testpos.z, 1.0, v)
        end
    end
end)


Citizen.CreateThread(function()

    for i = 1, #transitions do
        local of = offset * i
        local pos = vector3(testpos.x + of, testpos.y, testpos.z)
        local obj = CreateObject(prop, pos.x, pos.y, pos.z, false, false, false)
        table.insert(objs, obj)
    end

    Citizen.Wait(250)


    for i, obj in ipairs(objs) do
        local transition = transitions[i] or "Linear"
        Citizen.CreateThread(function()
            local firstrun = true
            while true do
                local of = offset * i 
                local height = firstrun and 0 or 2
                local rad = firstrun and 0 or 180
                local pos = vector3(testpos.x + of, testpos.y, testpos.z + height)
                local rad = vector3(testrad.x , testrad.y , testrad.z+rad )

                TransitionEntity(transition, obj, rad, pos, 1)

                Citizen.Wait(2000)

                firstrun = not firstrun
                Citizen.Wait(1)
            end
        end)
    end
end)


AddEventHandler('onResourceStop', function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then
        return
    end
    for _, obj in ipairs(objs) do
        if DoesEntityExist(obj) then
            DeleteEntity(obj)
        end
    end
end)
