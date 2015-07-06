require "NecroList"

Events.OnGameStart.Add( function ()
    print ("Adding Lockpicking items to NecroForge");
    if NecroList then
        print ("Necroforge added");
        if NecroList.Items.LockPickingBobbyPin then
        else
            NecroList.Items.LockPickingBobbyPin = {"Misc.", nil, nil, "Bobby Pin", "Lockpicking.BobbyPin", "media/textures/Item_tz_BobbyPin.png", nil, nil, nil};
        end
        if NecroList.Items.LockPickingBobbyPin2 then
        else
            NecroList.Items.LockPickingBobbyPin2 = {"Misc.", nil, nil, "Bobby Pin", "Lockpicking.BobbyPin2", "media/textures/Item_nk_BobbyPin.png", nil, nil, nil};
        end
    else
        print ("Necroforge not found!");
    end
end)
