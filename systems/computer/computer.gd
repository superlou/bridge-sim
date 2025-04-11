extends Node
class_name Computer


@export var ship:Ship = null


func send(label:String, value):
	ship_net.computer_send(self, label, value)