extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func load_text(loadText,resetLine=false):
	var prev_line = $Label2.scroll_vertical
	loadText = loadText.strip_edges()
	$Label2.text = loadText + "\n"
#	var lines = $Label2.text.split("\n")
#	$Label2.scroll_vertical = len(lines) - 1
	if resetLine:
		$Label2.scroll_vertical = prev_line
	else:
		$Label2.scroll_vertical = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
