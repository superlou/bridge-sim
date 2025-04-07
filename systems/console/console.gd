extends Node
class_name Console


@export var ship_id := 0


func find_label_by_text(text:String) -> Label:
	var children = find_children("*", "Label")
	var text_pattern = "{{%s}}" % text
	var matches = children.filter(func(label): return label.text == text_pattern)
	return matches[0]


func send(label:String, value=true):
	ship_net.console_send(self, label, value)