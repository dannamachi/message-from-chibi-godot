extends WindowDialog

var pageList = []
var pageInt = 0


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func load_text(allText):
	pageList = allText.split("\n\n")
	pageInt = 0
	$PageLabel.text = "0 / " + str(len(pageList))
	load_page()
	
func load_page():
	$Label2.text = pageList[pageInt]
	$PageLabel.text = str(pageInt + 1) + " / " + str(len(pageList))


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_BackButton_pressed():
	if pageInt > 0:
		pageInt -= 1
		load_page()


func _on_NextButton_pressed():
	if pageInt < len(pageList) - 1:
		pageInt += 1
		load_page()
