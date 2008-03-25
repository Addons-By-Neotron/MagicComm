--[[
Name: MagicComm
Revision: $Revision$
Author: NeoTron (neotron@gmail.com)
Description:

  Helper addon to allow listening in on MagicMarker messages 
  Addons define the following callbacks (depending on data you want to receive):

    addon:OnCommMark(mark, uid, value, ccid, guid)
    addon:OnCommUnmark(mark, uid)
    addon:OnCommReset( { mark1 = uid, mark2 = uid, [...] } )

License: 

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.

]]

local MAJOR, MINOR = "MagicComm-1.0", "$Revision$"

MagicComm = LibStub("AceAddon-3.0"):NewAddon("MagicComm", "AceComm-3.0", "AceSerializer-3.0")

local MagicComm = MagicComm

MagicComm.commPrefix = "MagicMarkerRT"

local playerName
local listening = false
local listeners = {}

function MagicComm:RegisterListener(addon)
   if not listening then
      self:RegisterComm(self.commPrefix, "UrgentReceive")
      listening = true
      playerName = UnitName("player")
   end
   listeners[addon] = true
end

function MagicComm:UnregisterListener(addon)
   if listening then
      listeners[addon] = nil
      if not next(listeners) then
	 listening = false
	 self:UnregisterComm(self.commPrefix)
      end
   end
end

function MagicComm:UrgentReceive(prefix, encmsg, dist, sender)
   if sender == playerName then
      return -- don't want my own messages!
   end
   local _, message = self:Deserialize(encmsg)
   
   if not message then return end

   if message.cmd == "MARK" then
      -- data = UID
      -- misc1 = mark
      -- misc2 = value
      -- misc3 = ccid
      -- misc4 = guid
      self:Broadcast("OnCommMark", message.misc1, message.data, message.misc2, message.misc3, message.misc4)
   elseif message.cmd == "UNMARK" then
      -- data = UID
      -- misc1 = mark
      self:Broadcast("OnCommUnmark", message.misc1, message.data)
   elseif message.cmd == "CLEAR" then
      -- data = { mark = uid }
      self:Broadcast("OnCommReset", message.data)
   end
end

function MagicComm:SendMessage(message)
   self:SendCommMessage(self.commPrefix, self:Serialize(message), "RAID", nil, "ALERT")
end

function MagicComm:Broadcast(command, ...)
   for addon,_ in pairs(listeners) do
      if addon[command] then
	 addon[command](addon, ...)
      end
   end
end
