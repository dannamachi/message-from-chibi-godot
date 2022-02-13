extends Node

var TS1 = preload("res://TS1.tscn")
var TS2 = preload("res://TS2.tscn")
var TS3 = preload("res://TS3.tscn")

signal done
signal quit

var stageDict = {
	"TS1"  :  TS1.instance(),
	"TS2"  :  TS2.instance(),
	"TS3"  :  TS3.instance()
}

var stageList = ["TS1", "TS2", "TS3"]
var stageInt = 0

var is_muted = false

# Called when the node enters the scene tree for the first time.
func _ready():
	if not is_muted:
		$Music/AnimationPlayer.play("FadeIn")
		$Music.play()
	# connect stages
	for i in stageList:
		stageDict[i].connect("done", self, "from_stage_done")	
	run_stage()



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func init(isMuted = false):
	is_muted = isMuted

func run_stage():
	$Scenes.add_child(stageDict[stageList[stageInt]])
	$Transition/AnimationPlayer.play("FadeIn")


func from_stage_done():
	$Transition/AnimationPlayer.play_backwards("FadeIn")
	yield($Transition/AnimationPlayer, "animation_finished")
	$Scenes.remove_child(stageDict[stageList[stageInt]])
	stageInt += 1
	if stageInt >= len(stageList):
		if not is_muted:
			$Music/AnimationPlayer.play_backwards("FadeIn")
		emit_signal("done")
		if not is_muted:
			yield($Music/AnimationPlayer, "animation_finished")
			$Music.stop()
	else:
		run_stage()


func _on_Button_pressed():
	if not is_muted:
		$Music/AnimationPlayer.play_backwards("FadeIn")
	emit_signal("quit")
	if not is_muted:
		yield($Music/AnimationPlayer, "animation_finished")
		$Music.stop()
