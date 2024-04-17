-- CONFIG --

-- Allow passengers to shoot
local passengerDriveBy = true

-- CODE --

Citizen.CreateThread(function()
    while true do
        Wait(1)

        local playerPed = GetPlayerPed(-1)
        local car = GetVehiclePedIsIn(playerPed, false)
        
        if car then
            local seat = GetPedInVehicleSeat(car, -1)
            
            if seat == playerPed then
                local currentWeapon = GetSelectedPedWeapon(playerPed)
                
                -- Check if the current weapon is a throwable
                local isThrowable = IsWeaponThrowable(currentWeapon)
                
                if isThrowable then
                    SetPlayerCanDoDriveBy(PlayerId(), true)
                else
                    SetPlayerCanDoDriveBy(PlayerId(), false)
                end
            else
                SetPlayerCanDoDriveBy(PlayerId(), false)
            end
        end
    end
end)

-- Function to check if the weapon is a throwable
function IsWeaponThrowable(weaponHash)
    -- List of throwable weapon hashes
    local throwableWeapons = {
        "WEAPON_ACIDPACKAGE",
        -- Add more throwable weapons as needed
    }
    
    for _, throwableWeapon in ipairs(throwableWeapons) do
        if GetHashKey(throwableWeapon) == weaponHash then
            return true
        end
    end
    
    return false
end
