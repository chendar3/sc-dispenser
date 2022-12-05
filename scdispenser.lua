--[[
Copyright © 2022, Chendar
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:

* Redistributions of source code must retain the above copyright
notice, this list of conditions and the following disclaimer.
* Redistributions in binary form must reproduce the above copyright
notice, this list of conditions and the following disclaimer in the
documentation and/or other materials provided with the distribution.
* Neither the name of EasyNuke nor the
names of its contributors may be used to endorse or promote products
derived from this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL Nyarlko, or it's members, BE LIABLE FOR ANY
DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
]]

_addon.name = 'Skillchain Dispenser'
_addon.author = 'Chendar'
_addon.version = '1.0'
_addon.command = 'scd'
_addon.commands = {'sc', 'element', 'burst', 'ebullience'}

require('tables')
texts = require('texts')
res = require('resources')

function init()
	check_job()
	Elements= T{'Fire','Water','Thunder','Stone','Aero','Blizzard','Light','Dark'}
	Ele_index = 1
	Skillchain = {}
		Skillchain.Fire = {
			skillchain="Fusion",
			element="Fire/Light",
			opener="Fire",
			closer="Ionohelix",
			delay=4,
			}	
		Skillchain.Water = {
			skillchain="Distortion",
			element="Water/Ice",
			opener="Luminohelix",
			closer="Geohelix",
			delay=6,
			}
		Skillchain.Thunder = {
			skillchain="Fragmentation",
			element="Lightning/Wind",
			opener="Blizzard",
			closer="Hydrohelix",
			delay=4,
			}
		Skillchain.Stone = {
			skillchain="Gravitation",
			element="Earth/Dark",
			opener="Aero",
			closer="Noctohelix",
			delay=4,
			}
		Skillchain.Aero = {
			skillchain="Fragmentation",
			element="Lightning/Wind",
			opener="Blizzard",
			closer="Hydrohelix",
			delay=4,
			}
		Skillchain.Blizzard = {
			skillchain="Distortion",
			element="Water/Ice",
			opener="Luminohelix",
			closer="Geohelix",
			delay=6,
			}
		Skillchain.Light = {
			skillchain="Fusion",
			element="Fire/Light",
			opener="Fire",
			closer="Ionohelix",
			delay=4,
			}
		Skillchain.Dark = {
			skillchain="Gravitation",
			element="Earth/Dark",
			opener="Aero",
			closer="Noctohelix",
			delay=4,
			}
	
	Colors = T{}
		Colors.Fire = {204, 0, 0} 
		Colors.Water = {0, 102, 204}
		Colors.Aero = {51, 102, 0}
		Colors.Light = {255, 255, 255}
		Colors.Stone = {139, 139, 19}
		Colors.Blizzard = {0, 204, 204}
		Colors.Thunder = {102, 0, 204}
		Colors.Dark = {0, 0, 0}
					
	Burst = T{'off', 'on', 'helix'}
	Burst_index = 1
	Ebullience = false	

	BurstMode = Burst[Burst_index]
	CurrentElement = Elements[Ele_index]	
	Color = Colors[CurrentElement]
			
	HUD = texts.new()
	HUD:text('Element: '..CurrentElement..'\n'..'Burst: '..BurstMode..'\n'..'Ebullience: '..tostring(Ebullience))
	HUD:font('Impact')
	HUD:size(12)
	HUD:bg_alpha(200)	
	HUD:bg_color(40, 40, 55)
	HUD:pos(15,90)
	HUD:color(Color[1], Color[2], Color[3])
	HUD:show()
end

function make_boom(arg)
end

function check_job()
end

function update_element()
	CurrentElement = Elements[Ele_index]
	Color = Colors[CurrentElement]
end

function update_hud()
	HUD:text('Element: '..CurrentElement..'\n'..'Burst: '..BurstMode..'\n'..'Ebullience: '..tostring(Ebullience))
	HUD:color(Color[1], Color[2], Color[3])
end

handle_commands = function(...)
	local args = T{...}		
    if args ~= nil then
        local cmd = table.remove(args,1):lower()
		if cmd == 'sc' then
			make_boom(args)
		elseif cmd == 'element' then
			if args[1] ~= nil and Elements:contains(args[1]) then
				Ele_index = table.find(Elements, args[1])
				update_element()				
				--CurrentElement = args[1]
				--Color = Colors[CurrentElement]
				update_hud()
			else
				Ele_index = Ele_index + 1 
				if Ele_index > #Elements then Ele_index = 1 end
				update_element()
				update_hud()
			end
		elseif cmd == 'burst' then
			if args[1] ~= nil and Burst:contains(args[1]) then
				Burst = args[1]
				update_hud()
			else
				Burst_index = Burst_index + 1
				if Burst_index > #Burst then Burst_index = 1 end
				BurstMode = Burst[Burst_index]
				update_hud()
			end
		elseif cmd == 'ebullience' then
			if Ebullience then
				Ebullience = false
			else
				Ebullience = true
			end
			update_hud()
		end
	end
end

function translate(term)
	local cache = {}
	if not cache[term] then
		local entry = res.auto_translates:with('english', term)
		cache[term] = entry and 'CH>HC':pack(0xFD, 0x0202, entry.id, 0xFD) or term
    end
	return cache[term]
end

windower.register_event('addon command', handle_commands)

windower.register_event('load', init())
