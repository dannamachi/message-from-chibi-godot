extends Node

export var max_cmd_length = 50
var is_editing = false
var is_paused = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_LineEdit_text_changed(new_text):
	pass
	# $LineEdit.text = new_text.substr(0,max_cmd_length)


func _on_LineEdit_focus_entered():
	if not is_paused:
		is_editing = true


func _on_LineEdit_focus_exited():
	if not is_paused:
		is_editing = false
