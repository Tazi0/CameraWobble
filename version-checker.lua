local label =
    [[ 
  //
  ||
  ||        ____                             __        __    _     _     _      
  ||       / ___|__ _ _ __ ___   ___ _ __ __ \ \      / /__ | |__ | |__ | | ___ 
  ||      | |   / _` | '_ ` _ \ / _ \ '__/ _` \ \ /\ / / _ \| '_ \| '_ \| |/ _ \
  ||      | |__| (_| | | | | | |  __/ | | (_| |\ V  V / (_) | |_) | |_) | |  __/
  ||       \____\__,_|_| |_| |_|\___|_|  \__,_| \_/\_/ \___/|_.__/|_.__/|_|\___|
  ||
  ||                       Made By Tazio.nl & Mystic#9999
  ||]]

Citizen.CreateThread(function()
    local CurrentVersion = GetResourceMetadata(GetCurrentResourceName(), 'version', 0)
    if not CurrentVersion then
        print('^1CameraWobble Version Check Failed!^7')
    end
    
    function VersionCheckHTTPRequest()
        PerformHttpRequest('https://raw.githubusercontent.com/Tazi0/CameraWobble/main/version.json', VersionCheck, 'GET')
    end
    
    function VersionCheck(err, response, headers)
        Citizen.Wait(3000)
        if err == 200 then
            local data = json.decode(response)
            if CurrentVersion ~= data.version then
                print(label)
                print('  ||    \n  ||    CameraWobble is outdated!')
                print('  ||    Current version: ^2' .. data.version .. '^7')
                print('  ||    Your version: ^1' .. CurrentVersion .. '^7')
                print('  ||    Please download the lastest version from ^5 https://github.com/Tazi0/CameraWobble ^7')
                if data.Changes ~= '' then
                    print('  ||    \n  ||    ^5Changes: ^7' .. data.changes .. "\n^0  \\\\\n")
                end
            else
                print(label)
                print('  ||    ^2CameraWobble is up to date!\n^0  ||\n  \\\\\n')
            end
        else
            print(label)
            print('  ||    ^1There was an error getting the latest version information, if the issue persists contact Tazio/Mystic#9999 on Discord.\n^0  ||\n  \\\\\n')
        end
        
        SetTimeout(60000000, VersionCheckHTTPRequest)
    end
    
    VersionCheckHTTPRequest()
end)
