--[[
**********************************************************************
This file is part of MagicComm, a World of Warcraft Addon

MagicComm is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

MagicComm is distributed in the hope that it will be useful, but
WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
General Public License for more details.

You should have received a copy of the GNU General Public License
along with MagicComm.  If not, see <http://www.gnu.org/licenses/>.
**********************************************************************
]]

-- This file handles logging of variable levels


local logPrefix = {
   "|cffff0000ERROR:|r ", 
   "|cffffff00WARN:|r ", 
   "", 
   "|cffd9d919DEBUG:|r ", 
   "|cffd9d5fFTRACE:|r ",
   "|cffff5050SPAM:|r ",
}
local lib = {}
lib.logLevels = { NONE = 0, ERROR = 1, WARN = 2, INFO = 3, DEBUG = 4, TRACE = 5, SPAM = 6 }

local logLevels = lib.logLevels

local function LogMessage(level,addon,...)
   if level <= addon.logLevel then
      addon:Print(logPrefix[level]..string.format(...))
   end
end

local function debug(...) LogMessage(logLevels.DEBUG, ...) end
local function error(...) LogMessage(logLevels.ERROR, ...) end
local function warn(...) LogMessage(logLevels.WARN,  ...) end
local function info(...) LogMessage(logLevels.INFO,  ...) end
local function trace(...) LogMessage(logLevels.TRACE, ...) end
local function spam(...) LogMessage(logLevels.SPAM, ...) end

function lib:SetLogLevel(level)
   local logLevel = tonumber(level)
   if logLevel >= logLevels.ERROR then self.error = error else self.error = nil end
   if logLevel >= logLevels.WARN  then self.warn = warn else self.warn = nil end
   if logLevel >= logLevels.INFO  then self.info = info else self.info = nil end
   if logLevel >= logLevels.DEBUG then self.debug = debug else self.debug = nil end
   if logLevel >= logLevels.TRACE then self.trace = trace else self.trace = nil end
   if logLevel >= logLevels.SPAM  then self.spam = spam else self.spam = nil end
   self.logLevel = logLevel
end

function lib:GetLogLevel() return self.logLevel end

local embeddables = { "GetLogLevel", "SetLogLevel", "logLevels" }

function MagicComm:EmbedLogger(addon)
   for _,key in ipairs(embeddables) do
      addon[key] = lib[key]
   end
   addon:SetLogLevel(logLevels.INFO)
end

