--[[
**********************************************************************
MagicMarker - your best friend for raid marking. See README.txt for
more details.
**********************************************************************
This file is part of MagicMarker, a World of Warcraft Addon

MagicMarker is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

MagicMarker is distributed in the hope that it will be useful, but
WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
General Public License for more details.

You should have received a copy of the GNU General Public License
along with MagicMarker.  If not, see <http://www.gnu.org/licenses/>.

**********************************************************************
List of spell ID's for Wrath for all crowd control spells.
Used for auto-learning which abilities can be used to CC a mob
**********************************************************************
]]

if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then return end

if WOW_PROJECT_ID ~= WOW_PROJECT_WRATH_CLASSIC or
        LE_EXPANSION_LEVEL_CURRENT ~= LE_EXPANSION_CATACLYSM then
    return
end

local comm = LibStub("MagicComm-1.0")
if comm.upgradeDone then
    -- A newer version was already loaded, so don't "upgrade"
    return
end

comm.upgradeDone = true

comm.spellIdToCCID = {
   -- Polymorph
   [118]   = 2, [28271] = 2, [28272] = 2, [59634] = 2,  
   [61025] = 2, [61305] = 2, [61721] = 2, [61780] = 2,
   
   -- Banish
   [710] = 3,

   -- Shackle
   [9484] = 4,

   -- Hibernate
   [2637] = 5,

   -- Freezing Trap
   [3355] = 6, 

   -- 7 = KITE, not auto-learned
   
   -- Mind control
   [605] = 8, [19812] = 8,

   -- Fear
   [5782] = 9, [5484] = 9, [8122] = 9,
   [50577] = 9, -- DemonForm howl of Terror

   -- Death Coil
   [6789] = 9,

   -- Sap
   [6770] = 10, 

   -- Enslave
   [1098] = 11,

   -- Root
   [339] = 12, 

   -- Cyclone
   [33786] = 13,

   -- Scare Beast
   [1513] = 15,

   -- Seduction
   [6358] = 16,

   -- Turn Evil
   [10326] = 17,

   -- Blind
   [2094] = 18,

   --  19 = "burn down", not auto-learned
   
   -- Hex
   [51514] = 20,

   -- Repentance
   [20066] = 21,

   -- Bind Elemental
   [76780] = 22, 
}

-- Spell durations in seconds



comm.spellIdToCCID = {
   -- Polymorph
   [118] = 2, [12824] = 2, [12825] = 2, [12826] = 2, [28271] = 2, [28272] = 2,
   [61025] = 2, [61305] = 2, [61721] = 2, [61780] = 2, [59634] = 2,

   -- Banish
   [710] = 3, [18647] = 3,

   -- Shackle
   [9484] = 4, [9485] = 4, [10955] = 4,

   -- Hibernate
   [2637] = 5, [18657] = 5, [18658] = 5,

   -- Freezing Trap
   [3355] = 6, [14308] = 6, [14309] = 6, [60210] = 6,

   -- 7 = KITE, not auto-learned

   -- Mind control
   [605] = 8,

   -- Fear
   [5782] = 9, [6213] = 9, [6215] = 9, [5484] = 9, [17928] = 9, [8122] = 9,
   [8124] = 9, [10888] = 9, [10890] = 9,
   [50577] = 9, -- DemonForm howl of Terror

   -- Death Coil
   [6798] = 9, [17926] = 9, [27223] = 9, [47859] = 9, [47860] = 9,

   -- Sap
   [6770] = 10, [2070] = 10, [11297] = 10, [51724] = 10,

   -- Enslave
   [1098] = 11, [11725] = 11, [11726] = 11,

   -- Root
   [339] = 12, [1062] = 12, [5195] = 12, [5196] = 12,
   [9852] = 12, [9853] = 12, [26989] = 12, [53308] = 12,

   -- Cyclone
   [33786] = 13,

   -- Turn Undead (=> sets Turn Evil too)
   [19725] = { 14, 17 },

   -- Scare Beast
   [1513] = 15, [14326] = 15, [14327] = 15,

   -- Seduction
   [6358] = 16,

   -- Turn Evil
   [10326] = 17,

   -- Blind
   [2094] = 18,

   --  19 = "burn down", not auto-learned

   -- Hex
   [51514] = 20,

   -- Repentance
   [20066] = 21,
}
