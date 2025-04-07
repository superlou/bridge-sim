extends Node

func _physics_process(delta: float) -> void:
	var conduits := get_tree().get_nodes_in_group("conduit")

	for conduit in conduits:
		if conduit is Conduit:
			_add_supplied_to_conduit(conduit, delta)

	# print("[Supply phase result]")
	# for conduit in conduits:
	# 	if conduit is Conduit:
	# 		print(conduit.name, " ", conduit.energy)

	for conduit in conduits:
		if conduit is Conduit:
			_diffuse_conduit_energy(conduit, delta)

	# print("[Diffuse phase result]")
	# for conduit in conduits:
	# 	if conduit is Conduit:
	# 		print(conduit.name, " ", conduit.energy)

	for conduit in conduits:
		if conduit is Conduit:
			_supply_conduit_energy_to_devices(conduit, delta)

	# print("[Device supply phase result]")
	# for conduit in conduits:
	# 	if conduit is Conduit:
	# 		print(conduit.name, " ", conduit.energy)
	# 		for link in conduit.links:
	# 			if link.has_node("ElectricalDevice"):
	# 				print(" - ", link.name, " ", link.get_node("ElectricalDevice").available, "/", link.get_node("ElectricalDevice").demand)


func _add_supplied_to_conduit(conduit: Conduit, _delta: float):
	# todo This will allow double-supplying from an ElectricalDevice connected
	# to two Conduits. Need to keep track of where supplying devices have their
	# energy used.

	# Set the conduit's energy to at least the total of connected devices that supply
	# energy.
	var linked_device_supply = conduit.links.filter(
		func(x): return x.has_node("ElectricalDevice")
	).reduce(
		func(accum, x): return accum + x.get_node("ElectricalDevice").supply,
		0.0
	)

	conduit.energy = maxf(conduit.energy, linked_device_supply)


func _diffuse_conduit_energy(conduit: Conduit, _delta: float):
	var linked_conduits := conduit.get_linked_conduits()
	linked_conduits.append(conduit)

	var total_energy = linked_conduits.reduce(func(accum, x): return accum + x.energy, 0.0)
	var num_linked_conduits := len(linked_conduits)

	for linked_conduit in linked_conduits:
		linked_conduit.energy = total_energy / num_linked_conduits


func _supply_conduit_energy_to_devices(conduit: Conduit, _delta: float):
	# Operate on devices that need energy
	var devices := conduit.get_linked_electrical_devices().filter(func(d): return d.needs() > 0.0)
	if len(devices) == 0:
		return

	var initial_provision := conduit.energy / len(devices)

	# For the first pass, devices split power fairly
	for device in devices:
		var device_needs:float = device.needs()

		if initial_provision >= device_needs:
			device.available += device_needs
			conduit.energy -= device_needs
		elif conduit.energy >= initial_provision:
			device.available += initial_provision
			conduit.energy -= initial_provision

	# For the next pass, device get as much as is available
	for device in devices:
		var device_needs:float = device.needs()

		if conduit.energy >= device_needs:
			device.available += device_needs
			conduit.energy -= device_needs
		elif conduit.energy > 0.0:
			device.available += conduit.energy
			conduit.energy = 0.0
			break
