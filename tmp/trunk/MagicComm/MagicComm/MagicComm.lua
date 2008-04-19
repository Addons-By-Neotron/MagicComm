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

local MAJOR, MINOR = "MagicComm-1.0", string.match("$Revision$", "[0-9]+")

local MagicComm = LibStub:NewLibrary(MAJOR, MINOR)

if not MagicComm then return end

local C = LibStub("AceComm-3.0")
local S = LibStub("AceSerializer-3.0")
local MagicComm = MagicComm

C:Embed(MagicComm)
S:Embed(MagicComm)

local comm = {
   MM = { ALERT = "MagicMarkerRT", BULK = "MagicMarker" },
   MD = { ALERT = "MagicDKPRT", BULK = "MagicDKP" },
}

MagicComm.MAJOR_VERSION = MAJOR
MagicComm.MINOR_VERSION = MINOR

local playerName
local listening = { MM = false, MD = false }
local listeners = { MM = {}, MD = {}}

function MagicComm:RegisterListener(addon, prefix)
   if not listening[prefix] then
      self:RegisterComm(comm[prefix].ALERT, "UrgentReceive")
      self:RegisterComm(comm[prefix].BULK, "BulkReceive")
      listening[prefix] = true
   end
   if not playerName then
      playerName = UnitName("player")
   end
   listeners[prefix][addon] = true
end

function MagicComm:UnregisterListener(addon, prefix)
   if listening[prefix] then
      listeners[prefix][addon] = nil
      if not next(listeners[prefix]) then
	 listening[prefix] = false
	 self:UnregisterComm(comm[prefix].ALERT)
	 self:UnregisterComm(comm[prefix].BULK)
      end
   end
end

function MagicComm:UrgentReceive(prefix, encmsg, dist, sender)
   local _, message = self:Deserialize(encmsg)
   
   if not message then return end

   if message.cmd == "VCHECK" then
      self:Broadcast("VCHECK", message.prefix, sender)
      return;
   elseif message.cmd == "VRESP" and message.sender == sender then
      -- Only process version response messages if I was the sender
      self:Broadcast("OnVersionResponse", message.prefix, message.data, message.misc1, message.misc2, sender)
      return
   end
   MagicMarker:debug("Received messsage %s [data=%s, misc1=%s]", message.cmd, tostring(message.data), tostring(message.misc1))

   if sender == playerName then
      return -- don't want my own messages!
   end
   
   if message.prefix == "MM" then
      if message.cmd == "MARKV2" then
	 -- data = GUID, misc1 = mark, misc2 = type
	 self:Broadcast("OnCommMarkV2", message.prefix, message.misc1, message.data, message.misc2)
      elseif message.cmd == "UNMARKV2" then
	 -- data = GUID, misc1 = mark
	 self:Broadcast("OnCommUnmarkV2", message.prefix, message.data, message.misc1)
      elseif message.cmd == "CLEARV2" then
	 -- data = { mark = uid }
	 self:Broadcast("OnCommResetV2", message.prefix, message.data)
      elseif message.cmd == "MARK" then
	 -- data = UID, misc1 = mark, misc2 = value, misc3 = ccid, misc4 = guid
	 self:Broadcast("OnCommMark", message.prefix, message.misc1, message.data, message.misc2, message.misc3, message.misc4)
      elseif message.cmd == "UNMARK" then
	 -- data = UID, misc1 = mark
	 self:Broadcast("OnCommUnmark", message.prefix, message.misc1, message.data)
      elseif message.cmd == "CLEAR" then
	 -- data = { mark = uid }
	 self:Broadcast("OnCommReset", message.prefix, message.data)
      end
   elseif message.prefix == "MD" then
      if message.cmd == "STANDBYCHECK" then
	 -- data = event
	 self:Broadcast("OnStandbyCheck", message.prefix, message.data, sender)
      elseif message.cmd == "STANDBYRESPONSE" then
	 -- data = player
	 -- misc1 = event
	 self:Broadcast("OnStandbyResponse", message.prefix, message.data, message.misc1)
      elseif message.cmd == "DKP" then
      elseif message.cmd == "BID" then
      end
   end
end

function MagicComm:BulkReceive(prefix, encmsg, dist, sender)
   if sender == UnitName("player") then
      return -- don't want my own messages!
   end
   local _, message = self:Deserialize(encmsg)
   if not message then return end

   if message.prefix == "MM" then
      if message.cmd == "MOBDATA" then
	 self:Broadcast("OnMobdataReceive", message.prefix, message.misc1, message.data, message.dbversion, sender)
      elseif message.cmd == "TARGETS" then
	 self:Broadcast("OnTargetReceive", message.prefix, message.data, message.dbversion, sender)
      elseif message.cmd == "CCPRIO" then
	 self:Broadcast("OnCCPrioReceive", message.prefix, message.data, message.dbversion, sender)
      end
   end
end

function MagicComm:SendUrgentMessage(message, prefix, channel, recipient)
--   MagicMarker:debug("sending message %s for %s", message.cmd, prefix)
   message.prefix = prefix
   self:SendCommMessage(comm[prefix].ALERT, self:Serialize(message), channel or "RAID", recipient, "ALERT")
end

function MagicComm:SendBulkMessage(message, prefix, channel, recipient)
--   MagicMarker:debug("sending bulk message %s for %s", message.cmd, prefix)

   message.prefix = prefix
   self:SendCommMessage(comm[prefix].BULK, self:Serialize(message), channel or "RAID", recipient, "BULK")
end

local versionMsg = {
   cmd = "VRESP"
}

local verMsgFmt = "%s-r%s"

function MagicComm:Broadcast(command, prefix, ...)
--   MagicMarker:debug("command = %s, prefix = %s", command, prefix)
   for addon in pairs(listeners[prefix]) do 
      if command == "VCHECK" then
	 versionMsg.data = verMsgFmt:format(addon.MAJOR_VERSION or "Unknown", addon.MINOR_VERSION or "???")
	 versionMsg.misc1 = addon.MAJOR_VERSION
	 versionMsg.misc2 = addon.MINOR_VERSION
	 versionMsg.sender = ...
	 MagicComm:SendUrgentMessage(versionMsg, prefix)
      elseif addon[command] then
	 addon[command](addon, ...)
	 if command == "OnVersionResponse" then
	    return
	 end
      end
   end
end

