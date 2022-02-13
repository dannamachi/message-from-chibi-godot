extends Node

signal done

var transitioning = true
var clipName = "NA"

var is_muted = false

var musicDict = {
	'bad'  : 'res://sounds/bad.ogg',
	'base' : 'res://sounds/base.ogg',
	'good' : 'res://sounds/good.ogg',
	'final': 'res://sounds/final.ogg'
}

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func init(endText, endType, isMuted = false):
	is_muted = isMuted
	$Label.text = endText
	if endType == "base":
		$Label2.text = "NORMAL END"
	elif endType == "good":
		$Label2.text = "GOOD END"
	elif endType == "final":
		$Label2.text = "FINAL END"
	else:
		$Label2.text = "GAME OVER"
	$Music.stream = load(musicDict[endType])
	# animation
	if endType in $Clip_bad.name:
		clipName = $Clip_bad.name
	elif endType in $Clip_base_good.name:
		clipName = $Clip_base_good.name

	if clipName != "NA":
		get_node(clipName).show()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func play_animation():
	if clipName != "NA":
		if not is_muted:
			$Sound.play()
		get_node(clipName).play()
		yield(get_node(clipName), "finished")
		get_node(clipName).hide()
		$Fade/Animation.play("FadeIn")
		if not is_muted:
			$Music/AnimationPlayer.play("FadeIn")
			$Music.play()
		yield($Fade/Animation, "animation_finished")
		transitioning = false
	else:
		$Fade/Animation.play("FadeIn")
		if not is_muted:
			$Music/AnimationPlayer.play("FadeIn")
			$Music.play()
		yield($Fade/Animation, "animation_finished")
		transitioning = false


func _on_Button_pressed():
	if not transitioning:
		transitioning = true
		$Fade/Animation.play_backwards("FadeIn")
		if not is_muted:
			$Music/AnimationPlayer.play_backwards("FadeIn")
		yield($Fade/Animation, "animation_finished")
		emit_signal("done")
		if not is_muted:
			yield($Music/AnimationPlayer, "animation_finished")
			$Music.stop()

