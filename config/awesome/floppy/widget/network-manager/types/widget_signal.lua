local signal = require("widget.shared.Signal")
local NetworkMangerSignal = signal("network-manager")
print(NetworkMangerSignal.tag)
return NetworkMangerSignal
