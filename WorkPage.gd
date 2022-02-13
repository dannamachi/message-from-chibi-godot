extends WindowDialog


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func load_text(allText):
	# load text
	$Label2.text = allText + "\n\nYou can close this window."
	# load image
	$Image.play()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_WorkPage_popup_hide():
	$Image.stop()
