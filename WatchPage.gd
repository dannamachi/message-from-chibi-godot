extends WindowDialog


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var imageDict = {
	# 36 - 34 (0 - 2)
	34 : "image0.png",
	# 33 - 33 (3 - 3)
	33 : "image1.png",
	# 32 - 32 (4 - 4)
	32 : "image2.png",
	# 31 - 28 (5 - 8)
	28 : "image3.png",
	# 27 - 26 (9 - 10)
	26 : "image4.png",
	# 25 - 22 (11 - 14)
	22 : "image5.png",
	# 21 - 20 (15 - 16)
	20 : "image6.png",
	# 19 - 18 (17 - 18)
	15 : "image7.png",
	# 17 - 16 (19 - 20)
	14 : "image8.png",
	# 15 - 12 (21 - 24)
	12 : "image9.png",
	# 11 - 8 (25 - 28)
	8  : "image10.png",
	# 7 - 6 (29 - 30)
	6  : "image11.png",
	# 5 - 4 (31 - 32)
	4  : "image12.png",
	# 3 - 0 (33 - 36)
	0  : "image13.png",
}

func load_text(allText):
	# load text
	$Label2.text = allText[1]
	# load image
	$Image.texture = load("res://arts/demtube/" + imageDict[allText[0]])

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
