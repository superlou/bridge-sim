@tool
extends Node3D
class_name Conduit

@export var links:Array[Node3D] = []

var energy := 0.0

func _ready() -> void:
	add_to_group("conduit")


func _physics_process(_delta: float) -> void:
	for link in links:
		if link == null:
			return

		DebugDraw3D.draw_line(global_position, link.global_position)
		DebugDraw3D.draw_text(global_position, name, 128)


func get_linked_conduits() -> Array:
	return links.filter(func(x): return x is Conduit)


func get_linked_electrical_devices() -> Array:
	return links.filter(func(link):
		return link.has_node("ElectricalDevice")
	).map(func(link):
		return link.get_node("ElectricalDevice")
	)
