NetworkRepository = {}
function NetworkRepository:new()
	o = o or {}
	setmetatable(o, self)
	self.__index = self
	return o
end
function NetworkRepository:get_networks()
	return self.networks
end
function NetworkRepository:add_network(network)
	self.networks[#self.networks + 1] = network
end
return NetworkRepository
