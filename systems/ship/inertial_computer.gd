extends Computer
class_name InertialComputer


func _process(_delta: float) -> void:
	send("position", ship.position)
	send("velocity", ship.velocity)
	send("acceleration", ship.acceleration)
