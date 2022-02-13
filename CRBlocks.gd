extends Node

var BLOCKS = {
	"0000" : true,
	"0308" : false,
	"0210" : false,
	"0309" : false,
	"0401" : false,
	"0503" : false,
	"0505" : false,
	"0512" : false,
	"0604" : false,
}

var BLOCKS_ROOT = {
	"??08" : false,
	"?7?1" : false,
	"?55?" : false,
	"???2" : false,
	"??0?" : false,
	"?*??" : false,
	"*???" : false,
	"?5?2" : false,
}

var BLOCKS_SPECIAL_TWO = {
	"**00" : true,
	"**?0" : true,
	"***0" : false,
}

var BLOCKS_SPECIAL_THREE = {
	"*0*0" : false,
}

var BLOCKS_NEW = {
	"0610" : true,
	"0611" : false,
	"0612" : false,
}


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
