local _G = _G
local format = format
local tonumber = tonumber
local math = math
local shortPrefixValues = shortPrefixValues
local CreateFrame = CreateFrame

local EventFrame = CreateFrame("Frame")

local shortPrefixValues = {{1e8,'亿', '%.1f亿'}, {1e4,'万', '%.1f万'}}

local function ShortValue(value, dec)
	local abs_value = value<0 and -value or value
	local decimal = dec and format('%%.%df', tonumber(dec) or 0)

	for i=1, #shortPrefixValues do
		if abs_value >= shortPrefixValues[i][1] then
			if decimal then
				return format(decimal..shortPrefixValues[i][2], value / shortPrefixValues[i][1])
			else
				return format(shortPrefixValues[i][3], value / shortPrefixValues[i][1])
			end
		end
	end

	return format('%.0f', value)
end

local function AddonLoaded(self, event, addonName)
    if addonName == 'Skada' then
        local Skada = _G.Skada
        function Skada:FormatNumber(number)
            return number and ShortValue(math.floor(number))
        end
    end
    if addonName == 'ShadowedUnitFrames' then
        local ShadowUF = _G.ShadowUF
        function ShadowUF:FormatLargeNumber(number)
            return ShortValue(number)
        end
        function ShadowUF:SmartFormatNumber(number)
            return ShortValue(number)
        end
    end
end

EventFrame:RegisterEvent('ADDON_LOADED')
EventFrame:SetScript("OnEvent", AddonLoaded)