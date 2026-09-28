local teleportPoints = {
    {pos = Config.Entrance, target = Config.Exit},
    {pos = Config.Exit, target = Config.Entrance}
}

---@param text string
local function displayHelpText(text)
    BeginTextCommandDisplayHelp('STRING')
    AddTextComponentSubstringPlayerName(text)
    EndTextCommandDisplayHelp(0, false, true, -1)
end

CreateThread(function()
    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed)
    local lastUpdate = 0

    while true do
        local sleep = 500
        local gameTime = GetGameTimer()

        if gameTime - lastUpdate > 500 then
            playerPed = PlayerPedId()
            playerCoords = GetEntityCoords(playerPed)
            lastUpdate = gameTime
        end

        local nearPoint

        for _, point in ipairs(teleportPoints) do
            local dist = #(playerCoords - point.pos)

            if dist < 10.0 then
                sleep = 0
                playerCoords = GetEntityCoords(playerPed)

                DrawMarker(
                    Config.MarkerType,
                    point.pos.x, point.pos.y, point.pos.z,
                    0.0, 0.0, 0.0,
                    0.0, 0.0, 0.0,
                    Config.MarkerScale.x, Config.MarkerScale.y, Config.MarkerScale.z,
                    Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, Config.MarkerColor.a,
                    false, true, 2, false, nil, nil, false
                )

                if dist < Config.InteractDistance then
                    nearPoint = point
                    displayHelpText('Drücke ~INPUT_CONTEXT~ zum Teleportieren')
                end
            end
        end

        if nearPoint and IsControlJustPressed(0, 38) then
            DoScreenFadeOut(500)
            
            while not IsScreenFadedOut() do
                Wait(10)
            end
            
            SetEntityCoords(playerPed, nearPoint.target.x, nearPoint.target.y, nearPoint.target.z, false, false, false, false)
            
            Wait(300)
            
            DoScreenFadeIn(500)
        end

        Wait(sleep)
    end
end)
