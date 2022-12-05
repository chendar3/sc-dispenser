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
_addon.commands = {'sc', '3step', '6step', 'cycle'}

require('tables')
res = require('resources')

function init()
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
end

function make_boom()
end

function check_job()
end

function commands(cmd, arg)
end

function translate(term)
	local cache = {}
	if not cache[term] then
		local entry = res.auto_translates:with('english', term)
		cache[term] = entry and 'CH>HC':pack(0xFD, 0x0202, entry.id, 0xFD) or term
    end
	return cache[term]
end

windower.register_event('addon command', commands(cmd, arg))

windower.register_event('load', init())
