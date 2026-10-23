if game.PlaceId == 72858262610964 then
  local CurrentVersion "Test Hub - tap reborn"

  -- library ui
  local Rayfield = loadstring(game:HttpGet("https://sirius.menu/gen2"))()

  -- main frame
  local window = Rayfield:CreateWindow({
    name = "Farm Tab",
    subtitle = "nun",
    slidebarLayout = true
  })

  -- services
  local ReplicatedStorage = game:GetService("ReplicatedStorage")
  local TapRequested = ReplicatedStorage
    :WaitForChild(RemoteServices)
    :WaitForChild(TapService)
    :WaitForChild("RE")
    :WaitForChild("TapRequested")
  local EggHatchRequested = ReplicatedStorage
  :WaitForChild("RemoteServices")
  :WaitForChild("EggService")
  :WaitForChild("RE")
  :WaitForChild("EggHatchRequested")

  --Variables
  local sequence = 0
  local isAutoClick = false
  local isAutoHatch = false 
  local selectedEgg = nil
  local hatchSequence = 2
  local counthatch = nil 

  --Egg Lists
  local EggList = {
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

  -- Farm Tab
  local Farmtab = window:CreateTab({
    name = "Home",
    icon = 93364949241311
  })

  Farmtab:CreateDropdown({
    name = "Select Type of Eggs",
    multiSelect = false,
    options = EggList,
    Callback = function(item)
      selectedEgg = item
    end
  })
  Farmtab:CreateDropdown({
    name = "Hatch Count",
    multiSelect = false,
    options = HatchCount,
    Callback = function(item)
      count = item
    end
  })

  -- Auto Hatch Toggle
  Farmtab:CreateToggle({
    name = "Auto Hatch",
    flag = "Auto hatch eggs",
    value = true,
    Callback = function(state)
      isAutoHatch = state
      if state then 
        task.spawn(function()
          if isAutoHatch do
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
  })

  -- Auto Click Toggle
  Farmtab:CreateToggle({
    name = "Auto Click",
    flag = "auto clicks farm",
    value = true,

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
  })
end
