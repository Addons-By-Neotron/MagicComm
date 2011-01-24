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
comm.spellIdToDuration = {
   [118] = 50, 
   [339] = 30, 
   [605] = 30, 
   [710] = 30, 
   [1098] = 300, 
   [1513] = 20, 
   [2094] = 10, 
   [2637] = 40, 
   [3355] = 60, 
   [5484] = 8, 
   [5782] = 20, 
   [6358] = 30, 
   [6770] = 60, 
   [6789] = 3, 
   [8122] = 8, 
   [9484] = 50, 
   [10326] = 20, 
   [19812] = 8, 
   [20066] = 60, 
   [28271] = 50, 
   [28272] = 50, 
   [33786] = 6, 
   [50577] = 8, 
   [51514] = 60, 
   [59634] = 10, 
   [61025] = 50, 
   [61305] = 50, 
   [61721] = 50, 
   [61780] = 50, 
   [76780] = 50, 
}
