-- 3D Text Display Function

local function DrawText3D(coords, text)
    local onScreen, _x, _y = World3dToScreen2d(coords.x, coords.y, coords.z)

    if onScreen then
        SetTextScale(0.35, 0.35)
        SetTextFont(4)
        SetTextProportional(true)
        SetTextColour(255, 255, 255, 215)
        SetTextEntry("STRING")
        SetTextCentre(true)
        AddTextComponentString(text)
        DrawText(_x, _y)

        -- テキスト背景を描画
        local factor = (string.len(text)) / 370
        DrawRect(_x, _y + 0.0125, -0.15 + factor, 0.03, 41, 11, 41, 68)
    end
end

-- main loop with distance Opti
local targetCoords = vector3(215.0, -935.0, 24.0)

CreateThread(function()
    while true do
        local sleep = 1000
        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)
        local distance = #(playerCoords - targetCoords)

        --20ユニット以内に近づいた時のみ
        if distance < 20.0 then
            sleep = 0
            DrawMarker(
                1, --タイプ (1は円柱)
                targetCoords.x, targetCoords.y, targetCoords.z - 1.0, --位置
                0, 0, 0, -- 方向(dirx,y,z)
                0, 0, 0, -- 回転(rotx,y,z)
                1.5, 1.5, 1.0, -- スケール(x,y,z)
                255, 255, 0, 100, --色(R,G,B,Alpha)
                false, --　上下に動くか
                true, --プレイヤーの方を向くか
                2, --p19 (通常は2)
                false, -- 回転するか
                "", "", -- テクスチャ辞書/名前
                false -- エンティティの上に描画するか
            )

            if distance < 3 then
                DrawText3D(targetCoords + vector3(0.0, 0.0, 0.5), "Press ~y~[E]~w~ to Open Menu")
            end
    
            -- Interaction
            if distance < 1.5 then
                if IsControlJustReleased(0, 38) then
                    print("Action Triggered!")
                    TriggerEvent('chat:addMessage', { args = { '^1SYSTEM', 'Action Triggered!'} })
                end
            end
        end

        Citizen.Wait(sleep)
    end
end)

