extends Node

signal command_entered(cmd)

var is_paused = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func load_text(loadText):
	loadText = loadText.strip_edges()
	$Label2.text += loadText + "\n"
	var lines = $Label2.text.split("\n")
	$Label2.scroll_vertical = len(lines)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_LineEdit_text_entered(new_text):
	if not is_paused:
		new_text = new_text.strip_edges()
		if not new_text.empty():
			$Label2.text += "Nekoi> " +  new_text + "\n"
			var lines = $Label2.text.split("\n")
			$Label2.scroll_vertical = len(lines)
			emit_signal("command_entered", new_text)

