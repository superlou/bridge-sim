extends Node3D
class_name Ship

@onready var decks:Array = find_children("*", "Deck")

@export var ship_id := 0
@export var velocity := Vector3.ZERO
@export var acceleration := Vector3.ZERO


func _physics_process(delta:float) -> void:
	velocity += delta * acceleration
	position += delta * velocity