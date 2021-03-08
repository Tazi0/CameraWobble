----------------------------
--     Camera  Wobble     --
-- Made by Tazio & Mystic --
----------------------------

Config = {
    Walking = {
        Enabled = true,
        Intensity = 1.0
    },
    Running = {
        Enabled = true,
        Intensity = 1.3
    },
    Sprinting = {
        Enabled = true,
        Intensity = 2.0
    },
    FirstPerson = false
}


Citizen.CreateThread(function()
    local shake = 0.0
    while true do
        Wait(0)
        local ped = PlayerPedId()
        local type = "Walking"
        if (IsPedWalking(ped) or IsPedRunning(ped) or IsPedSprinting(ped)) and not IsPedStill(ped) then
            if IsPedRunning(ped) then type = "Running"
            elseif IsPedSprinting(ped) then type = "Sprinting"
            end
            if (not Config.FirstPerson and GetFollowPedCamViewMode() ~= 4) and shake ~= Config[type].Intensity then
                if Config[type].Enabled then
                    ShakeGameplayCam("HAND_SHAKE", Config[type].Intensity)
                    shake = Config[type].Intensity
                end
            elseif (not Config.FirstPerson and GetFollowPedCamViewMode() ~= 4) and shake ~= 0.0 then
                shake = 0.0
                ShakeGameplayCam("HAND_SHAKE", 0.0)
            end
        elseif shake ~= 0.0 then
            shake = 0.0
            ShakeGameplayCam("HAND_SHAKE", 0.0)
        end
    end
end)
