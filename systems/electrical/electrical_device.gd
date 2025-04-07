extends Node
class_name ElectricalDevice

@export var supply := 0.0
@export var demand := 0.0
@export var available := 0.0


func needs() -> float:
	return demand - available
