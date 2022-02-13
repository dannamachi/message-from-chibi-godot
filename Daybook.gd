extends WindowDialog


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func set_text(dayInt):
	var dayNum = "0610"
	if dayInt == 1:
		dayNum = "0610"
	elif dayInt == 2:
		dayNum = "0611"
	elif dayInt == 3:
		dayNum = "0612"
	$Label.text = dayNum + "/7204 (Day " + str(dayInt) + ") is starting"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
