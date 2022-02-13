extends Node

var CREDENTIALS = {
	"Cassilin"   : "6570",
	"Luvluv"     : "LUCA",
}

var RESULTS = {
	"Cassilin"   : "Unable to verify...\nAttempting to certify... Failed\nAttempting to use temporary key... Failed\nIntercepting security logs... Success\nTo: cass_677972656653515749@nfc.tc\n10 unrecognized log-in attempt(s)",
	"Luvluv"     : "Permission denied\nAttempting to bypass... Failed\nAttempting to escalate privilege. Failed\nIntercepting security logs... Success\n=> To: luvluv87696965667979@nfc.tc\n3 unrecognized log-in attempt(s)",
	"Chibi"      : "Attempting to establish connection... Failed\nMessage: This terminal is currently inactive"
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
