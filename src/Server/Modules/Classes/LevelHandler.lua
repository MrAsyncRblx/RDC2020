-- Level Handler
-- MrAsync
-- July 18, 2020



local LevelHandler = {}
LevelHandler.__aeroPreventStart = true
LevelHandler.__index = LevelHandler

--//Api

--//Services
local PlayerService

--//Classes

--//Controllers

--//Locals
local HappyHome
local Airport
local Hyatt


function LevelHandler.new(playerProfile)
    local self = setmetatable({
        Player = playerProfile.Player,

        Levels = {
            HappyHome.new(playerProfile),
            Airport.new(playerProfile),
            Hyatt.new(playerProfile)
        },

        _CurrentLevel = 0,
        CompletedLevels = {},
    }, LevelHandler)

    --Set current level, should be happy home
    self:ForwardLevel(true)

    return self
end

--//Called when the player clicks play
function LevelHandler:Start(gender)
    self.CurrentLevel:Initialize(gender)
end


--//Updates currentLevel
function LevelHandler:ForwardLevel(isInitial)
    self._CurrentLevel = self._CurrentLevel + 1
    self.CurrentLevel = self.Levels[self._CurrentLevel]

    if (not self.CurrentLevel) then
        return PlayerService:FireClient("GameCompleted", self.Player)
    end

    if (not isInitial) then
        self.CurrentLevel:Initialize()
    end
end


function LevelHandler:Init()
    --//Api

    --//Services
    PlayerService = self.Services.PlayerService

    --//Classes

    --//Controllers

    --//Locals
    HappyHome = self.Modules.Levels.HappyHome
    Airport = self.Modules.Levels.Airport
    Hyatt = self.Modules.Levels.Hyatt

end


return LevelHandler