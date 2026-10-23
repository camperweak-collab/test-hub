
if game.PlaceId == 72858262610964 then
    local CurrentVersion = "Test Hub - tap reborn"

    -- Library UI
    local Mercury = loadstring(game:HttpGet(
        "https://raw.githubusercontent.com/deeeity/mercury-lib/master/src.lua"
    ))()

    -- Main frame
    local GUI = Mercury:Create{
        Name = CurrentVersion,
        Size = UDim2.fromOffset(600, 400),
        Theme = Mercury.Themes.Dark,
        Link = "https://github.com/deeeity/mercury-lib"
    }

    -- Services
    local ReplicatedStorage = game:GetService("ReplicatedStorage")

    local TapRequested = ReplicatedStorage
        :WaitForChild("RemoteServices")
        :WaitForChild("TapService")
        :WaitForChild("RE")
        :WaitForChild("TapRequested")

    local EggHatchRequested = ReplicatedStorage
        :WaitForChild("RemoteServices")
        :WaitForChild("EggService")
        :WaitForChild("RE")
        :WaitForChild("EggHatchRequested")

    -- Variables
    local sequence = 0
    local isAutoClick = false
    local isAutoHatch = false
    local selectedEgg = nil
    local hatchSequence = 2
    local count = nil

    -- Egg list
    local EggsList = {
        "Basic",
        "Cactus",
        "Crystal",
        "Draconic",
        "Geode",
        "Mushroom",
        "Mycelium",
        "Nimbus",
        "Pumpkin",
        "Sky",
        "Spotted",
        "Spiked"
    }
    local HatchCount = {
        1,3,8
    }

    -- Farm tab
    local FarmTab = GUI:Tab{
        Name = "Farm Tab",
        Icon = "rbxassetid://14036361048"
    }

    -- Egg dropdown
    FarmTab:Dropdown{
        Name = "Select Egg",
        StartingText = "Select...",
        Description = "Should be near to the egg",
        Items = EggsList,

        Callback = function(item)
            selectedEgg = item
            print("Selected egg:", selectedEgg)
        end
    }
    FarmTab:Dropdown{
        Name = "Hatch Count",
        StartingText = "Select...",
        Description = "8 requires gps",
        Items = HatchCount,

        Callback = function(item)
            count = item
            print("Selected egg:", count)
        end
    }

    -- Auto Hatch toggle
    FarmTab:Toggle{
        Name = "Auto Hatch",
        StartingState = false,
        Description = "Auto Hatch",

        Callback = function(state)
            isAutoHatch = state

            if state then
                task.spawn(function()
                    while isAutoHatch do
                        if selectedEgg then
                            local args = {
                                Egg = selectedEgg,
                                Auto = false,
                                Count = count,
                                Seq = hatchSequence
                            }

                            EggHatchRequested:FireServer(args)
                            hatchSequence += 1
                        end

                        task.wait(0.5)
                    end
                end)
            end
        end
    }

    -- Auto Click toggle
    FarmTab:Toggle{
        Name = "Auto Click",
        StartingState = false,
        Description = "Auto clicks farm",

        Callback = function(state)
            isAutoClick = state

            if state then
                task.spawn(function()
                    while isAutoClick do
                        sequence += 1

                        local args = {
                            ClientSequence = sequence,
                            Auto = false,
                            Source = "screen"
                        }

                        TapRequested:FireServer(args)

                        task.wait(0.1)
                    end
                end)
            end
        end
    }
end
