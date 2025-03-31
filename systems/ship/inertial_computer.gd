extends Node
class_name InertialComputer


@export var ship:Ship = null


func _process(_delta: float) -> void:
	ship_net.send(0, "InertialComputer", "position", ship.position)
	ship_net.send(0, "InertialComputer", "velocity", ship.velocity)
	ship_net.send(0, "InertialComputer", "acceleration", ship.acceleration)
