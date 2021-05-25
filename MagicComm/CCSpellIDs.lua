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
List of spell ID's for 2.4 for all crowd control spells.
Used for auto-learning which abilities can be used to CC a mob
**********************************************************************
]]
if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then return end

local comm = LibStub("MagicComm-1.0")

if comm.upgradeDone then
   -- A newer version was already loaded, so don't "upgrade"
   return
end

comm.upgradeDone = true

comm.spellIdToCCID = {
   -- Polymorph
   [118]   = 2, [28271] = 2, [28272] = 2, [61025] = 2, [61305] = 2, [61721] = 2, [61780] = 2,
   [277792] = 2, [277787] = 2, [161372] = 2, [161355] = 2, [161354] = 2, [161353] = 2, [126819] = 2, 

   -- Banish
   [710] = 3,

   -- Shackle
   [9484] = 4,

   -- Freezing Trap
   [3355] = 6, 

   -- 7 = KITE, not auto-learned
   
   -- Mind control
   [605] = 8,

   -- Fear
   [5782] = 9, [5484] = 9, [8122] = 9,

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

   -- Imprison Demon Hunter
   [217842] = 22,

   -- Control Undead, Death Knight
   [111673] = 23, 
   -- These aren't used for Magic Marker but are here for
   -- the duration auto scanning script. They are used by
   -- Magic Targets.
   -- Ring of Frost,
--    [82691] 
}

-- Spell durations in seconds
comm.spellIdToDuration = {
   [118] = 60,
   [339] = 30,
   [605] = 30,
   [710] = 30,
   [1098] = 300,
   [2094] = 60,
   [3355] = 60,
   [5484] = 20,
   [5782] = 20,
   [6358] = 30,
   [6770] = 60,
   [6789] = 3,
   [8122] = 8,
   [9484] = 50,
   [10326] = 40,
   [20066] = 60,
   [28271] = 60,
   [28272] = 60,
   [33786] = 6,
   [51514] = 60,
   [61025] = 60,
   [61305] = 60,
   [61721] = 60,
   [61780] = 60,
   [82691] = 10,
   [111673] = 300,
   [126819] = 60,
   [161353] = 60,
   [161354] = 60,
   [161355] = 60,
   [161372] = 60,
   [217842] = 120,
   [277787] = 60,
   [277792] = 60,
}
