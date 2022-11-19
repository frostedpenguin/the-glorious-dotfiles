local mocks = require("__tests__.mocks.bluetooth")
local scripts = require("widget.toggles.scripts")
local utils = require("__tests__.utils")
local bluetooth_scripts = scripts.bluetooth
local watch_script = bluetooth_scripts.watch_script[4]
local luaunit = require("luaunit")

TestLogger = {}
local command = _
function TestLogger:tearDown()
	command:close()
end
---@diagnostic disable-next-line: lowercase-global
function TestLogger:testOneBlockedOneUnblocked()
	local expected = "true"
	command = io.popen("cat " .. mocks.one_unblocked_one_blocked .. " | " .. watch_script)
	local actual = assert(command):read([[*all]])
	actual = utils.serialize(actual)
	luaunit.assertEquals(actual, expected)
end
function TestLogger:test_two_unblocked()
	local expected = "true"
	command = io.popen("cat " .. mocks.two_unblocked .. " | " .. watch_script)
	local actual = assert(command):read([[*all]])
	actual = utils.serialize(actual)
	luaunit.assertEquals(actual, expected)
end
function TestLogger:test_two_blocked()
	local expected = "false"
	command = io.popen("cat " .. mocks.two_blocked .. " | " .. watch_script)
	local actual = assert(command):read([[*all]])
	actual = utils.serialize(actual)
	luaunit.assertEquals(actual, expected)
end
function TestLogger:test_one_blocked_one_unblocked()
	local expected = "true"
	command = io.popen("cat " .. mocks.one_blocked_one_unblocked .. " | " .. watch_script)
	local actual = assert(command):read([[*all]])
	actual = utils.serialize(actual)
	luaunit.assertEquals(actual, expected)
end
function TestLogger:test_no_bluetooth_devices()
	local expected = "false"
	command = io.popen("cat " .. mocks.no_bluetooth_devices .. " | " .. watch_script)
	local actual = assert(command):read([[*all]])
	actual = utils.serialize(actual)
	luaunit.assertEquals(actual, expected)
end
function TestLogger:test_no_devices()
	local expected = "false"
	command = io.popen("cat " .. mocks.no_devices .. " | " .. watch_script)
	local actual = assert(command):read([[*all]])
	actual = utils.serialize(actual)
	luaunit.assertEquals(actual, expected)
end

os.exit(luaunit.LuaUnit.run())
