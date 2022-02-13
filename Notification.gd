extends WindowDialog


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func set_text(setText):
	var textList = setText.split("\n")
	var textFin = ""
	for i in range(len(textList)):
		var line = textList[i]
		textFin += line
		if i < len(textList) - 1:
			textFin += "\n\n"
	$Label2.text = textFin;

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
