local table_utils = {}
function table_utils.is_empty(t)
	local next = next
	if next(t) then
		return false
	else
		return true
	end
end
function table_utils.ssid_to_utf8(ap)
	local ssid = ap:get_ssid()
	if not ssid then
		return ""
	end
	return NM.utils_ssid_to_utf8(ssid:get_data())
end
return table_utils
