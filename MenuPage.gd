extends Node

export (PackedScene) var Runner

signal tutorial
signal start_game
signal load_game
signal error_restart
signal resume_game
signal mute_music(newIsMuted)

var is_muted = false

var can_resume = false
var command_runner

# Called when the node enters the scene tree for the first time.
func _ready():
	$Music/AnimationPlayer.play("FadeIn")
	if not is_muted:
		$Music.play()
	$MuteButton.pressed = is_muted

func init(canResume, cmdrunner, isMuted = false):
	command_runner = cmdrunner
	is_muted = isMuted
	
	$Credits/Label.text = cmdrunner.api.constants.CREDITS
	
	$LoadPage.init(command_runner)
	$LoadPage.connect("quit", self, "from_load_quit")
	$LoadPage.connect("loaded", self, "from_load_done")
	can_resume = canResume
	if canResume:
		$Buttons/ResumeButton.show()
		$Buttons/ResumeButton.disabled = false
	else:
		$Buttons/ResumeButton.hide()
		$Buttons/ResumeButton.disabled = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
	# mouse hovering
func _process(delta):
	var mouse_pos = get_viewport().get_mouse_position()
	for child in $Hover.get_children():
		if panel_has_point(child, mouse_pos):
			if "Resume" in child.name and can_resume:
				child.show()
			elif not "Resume" in child.name:
				child.show()
		else:
			child.hide()

func panel_has_point(control_node, mouse_pos):
	var true_pos = control_node.rect_position
	var true_size = Vector2(control_node.rect_size.x * control_node.rect_scale.x, control_node.rect_size.y * control_node.rect_scale.y)
	return mouse_pos.x > true_pos.x and mouse_pos.y > true_pos.y and mouse_pos.x < true_pos.x + true_size.x and mouse_pos.y < true_pos.y + true_size.y

func pause_scene():
	for item in $Buttons.get_children():
		item.disabled = true
		
func unpause_scene():
	for item in $Buttons.get_children():
		item.disabled = false
	if not can_resume:
		$Buttons/ResumeButton.disabled = true

func from_load_quit():
	$LoadPage.hide()
	$Music/AnimationPlayer.play_backwards("FadeIn")
	emit_signal("error_restart")
	if not is_muted:
		yield($Music/AnimationPlayer, "animation_finished")
		$Music.stop()
	
func from_load_done(sectionData):
	$Music/AnimationPlayer.play_backwards("FadeIn")
	emit_signal("load_game")
	if not is_muted:
		yield($Music/AnimationPlayer, "animation_finished")
		$Music.stop()


func _on_StartButton_pressed():
	$Tutorial.popup()


func _on_YesButton_pressed():
	$Music/AnimationPlayer.play_backwards("FadeIn")
	emit_signal("tutorial")
	if not is_muted:
		yield($Music/AnimationPlayer, "animation_finished")
		$Music.stop()
	

func _on_NoButton_pressed():
	$Music/AnimationPlayer.play_backwards("FadeIn")
	emit_signal("start_game")
	if not is_muted:
		yield($Music/AnimationPlayer, "animation_finished")
		$Music.stop()


func _on_LoadButton_pressed():
	$LoadPage.popup()


func _on_CreditsButton_pressed():
	$Credits.popup()


func _on_QuitButton_pressed():
	get_tree().quit()


func _on_ResumeButton_pressed():
	$Music/AnimationPlayer.play_backwards("FadeIn")
	emit_signal("resume_game")
	if not is_muted:
		yield($Music/AnimationPlayer, "animation_finished")
		$Music.stop()


func _on_Button_pressed():
	is_muted = not is_muted
	emit_signal("mute_music", is_muted)
	if is_muted:
		$Music.stop()
	else:
		$Music.play()
