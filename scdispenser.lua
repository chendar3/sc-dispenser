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
	Elements= T{'Fire','Water','Thunder','Stone','Aero','Blizzard','Light','Dark'}
	Ele_index = 1
	Skillchain = {}
		Skillchain.Fire = {
			skillchain='Fusion',
			opener='Fire',
			closer='Ionohelix',
			mbhelix='Pyrohelix II',
			delay=4,
			}	
		Skillchain.Water = {
			skillchain='Distortion',
			opener='Luminohelix',
			closer='Geohelix',
			mbhelix='Hydrohelix II',
			delay=6,
			}
		Skillchain.Thunder = {
			skillchain='Fragmentation',
			opener='Blizzard',
			closer='Hydrohelix',
			mbhelix='Ionohelix II',
			delay=4,
			}
		Skillchain.Stone = {
			skillchain='Gravitation',
			opener='Aero',
			closer='Noctohelix',
			mbhelix='Geohelix II',
			delay=4,
			}
		Skillchain.Aero = {
			skillchain='Fragmentation',
			opener='Blizzard',
			closer='Hydrohelix',
			mbhelix='Anemohelix II',
			delay=4,
			}
		Skillchain.Blizzard = {
			skillchain='Distortion',
			opener='Luminohelix',
			closer='Geohelix',
			mbhelix='Cryohelix II',
			delay=6,
			}
		Skillchain.Light = {
			skillchain='Fusion',
			opener='Fire',
			closer='Ionohelix',
			mbhelix='Luminohelix II',
			delay=4,
			}
		Skillchain.Dark = {
			skillchain='Gravitation',
			opener='Aero',
			closer='Noctohelix',
			mbhelix='Noctohelix II',
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
	
	if check_job() then
		HUD:show()
	else
		HUD:hide()
	end
end

function make_boom(arg)
		--359 = dark arts
		--402 = add: black
		--470 = immanence
		--365 = ebullience		
		--377 = tabula rasa
	if not buff_check(359) then
		windower.add_to_chat(122, 'Dark Arts not active. Aborting skillchain')
		return
	elseif BurstMode == 'on' and not buff_check(402) then
		windower.add_to_chat(122, 'Addendum: Black not active. Turning Burst mode off')
		BurstMode = 'off'
		update_hud()
	end
	
	Targeted = windower.ffxi.get_mob_by_index(windower.ffxi.get_player().target_index)
	
	if not Targeted.is_npc then
		windower.add_to_chat(122, 'Invalid target. Aborting skillchain')
		return
	end
	
	if arg[1] ~= nil then 
		if arg[1] == 'liquifusion' then
			liquefusion()
			return
		elseif arg[1] == 'sixstep' then
			sixstep()
			return
		end
	end
	
	local SCtarget = Targeted.id
	local SCname = Skillchain[CurrentElement].skillchain
	local SCelement = CurrentElement
	local SCopener = Skillchain[CurrentElement].opener
	local SCcloser = Skillchain[CurrentElement].closer
	local SCdelay = Skillchain[CurrentElement].delay
	local SChelix = Skillchain[CurrentElement].mbhelix
	local SCnuke = CurrentElement..' V'
				
	windower.chat.input('/p Opening SC: '..SCname..' - MB: '..SCelement..'.')
	windower.chat.input('/ja Immanence <me>')
	windower.chat.input:schedule(1.5, '/ma '..SCopener..' '..SCtarget)
	windower.chat.input:schedule(1.5 + SCdelay, '/ja Immanence <me>')
	windower.chat.input:schedule(3 + SCdelay, '/p Closing SC: '..SCname..' - MB: '..SCelement..' now!')
	windower.chat.input:schedule(3 + SCdelay, '/ma '..SCcloser..' '..SCtarget)
	
	if BurstMode == 'on' and (Ebullience or buff_check(377)) then
		windower.chat.input:schedule(10 + SCdelay,'/ja Ebullience <me>')
		windower.chat.input:schedule(11 + SCdelay,'/ma '..SCnuke..' '..SCtarget)
	elseif BurstMode == 'on' then
		windower.chat.input:schedule(10 + SCdelay,'/ma '..SCnuke..' '..SCtarget)
	else if BurstMode == 'helix' then
		windower.chat.input:schedule(10 + SCdelay,'/ma '..SChelix..' '..SCtarget)
	end
end

function liquefusion()
	local SCtarget = Targeted.id
	windower.chat.input('/p Opening SC: Liquefaction > Fusion - MB: Fire.')
	windower.chat.input('/ja Immanence <me>')
	windower.chat.input:schedule(1.5, '/ma Stone '..SCtarget)
	windower.chat.input:schedule(5.5, '/ja Immanence <me>')
	windower.chat.input:schedule(7, '/p Closing SC: Liquefaction - MB: Fire now!')
	windower.chat.input:schedule(7, '/ma Fire '..SCtarget)
	windower.chat.input:schedule(13,'/ja Immanence <me>' )
	windower.chat.input:schedule(14.5, '/p Closing SC: Fusion - MB: Fire now!')
	windower.chat.input:schedule(14.5, '/ma Ionohelix '..SCtarget)
	if BurstMode == 'on' and (Ebullience or buff_check(377)) then
		windower.chat.input:schedule(21.5,'/ja Ebullience <me>')
		windower.chat.input:schedule(22.5,'/ma "Fire V" '..SCtarget)
	elseif BurstMode == 'on' then
		windower.chat.input:schedule(21.5,'/ma "Fire V" '..SCtarget)
	else if BurstMode == 'helix' then
		windower.chat.input:schedule(21.5,'/ma "Pyrohelix II" '..SCtarget)
	end
end

function sixstep()
	windower.add_to_chat(122, '6step')
	local SCtarget = Targeted.id
	if buff_check(365) then
	else
	end
end

function check_job()
	local Player = windower.ffxi.get_player()
    if Player.main_job == "SCH" then
        return true
	end
end

function buff_check(check)	
	Buffs = T(windower.ffxi.get_player().buffs)
	if Buffs:contains(check) then
		return true
	end
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
				update_hud()
			else
				Ele_index = Ele_index % 8 + 1 
				update_element()
				update_hud()
			end
		elseif cmd == 'burst' then
			if args[1] ~= nil and Burst:contains(args[1]) then
				BurstMode = args[1]
				update_hud()
			else
				Burst_index = Burst_index % 3 + 1
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

do
    local cache = {}
    translate = function(term)
        if not cache[term] then
            local entry = res.auto_translates:with('english', term)
            cache[term] = entry and 'CH>HC':pack(0xFD, 0x0202, entry.id, 0xFD) or term
        end

        return cache[term]
    end
end

windower.register_event('addon command', handle_commands)

windower.register_event('load', init())

windower.register_event('job change', init())
 
