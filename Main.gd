extends Node

var MenuScene = preload("res://MenuPage.tscn")
var GameScene = preload("res://GamePage.tscn")
var TuteScene = preload("res://TutorialPage.tscn")

var can_resume = false

var is_muted = false


# Called when the node enters the scene tree for the first time.
func _ready():
	open_menu(false)
	
func toggle_mute(newIsMuted):
	is_muted = newIsMuted

func open_menu(canResume = false):
	var new_menu = MenuScene.instance()
	new_menu.init(canResume, $CommandRunner, is_muted)
	new_menu.connect("error_restart", self, "from_menu_error")
	new_menu.connect("load_game", self, "from_menu_loaded")
	new_menu.connect("start_game", self, "from_menu_start")
	new_menu.connect("resume_game", self, "from_menu_resume")
	new_menu.connect("tutorial", self, "from_menu_tute")
	new_menu.connect("mute_music", self, "toggle_mute")
	$Pages.add_child(new_menu)
	$Transition/AnimationPlayer.play("FadeIn")
	
func open_game(isRestart):
	var new_game = GameScene.instance()
	new_game.init($CommandRunner, isRestart, is_muted)
	new_game.connect("return_menu", self, "from_game_return")
	$Pages.add_child(new_game)
	$Transition/AnimationPlayer.play("FadeIn")
	
func open_tute():
	var new_tute = TuteScene.instance()
	new_tute.init(is_muted)
	new_tute.connect("done", self, "from_tute_done")
	new_tute.connect("quit", self, "from_tute_quit")
	$Pages.add_child(new_tute)
	$Transition/AnimationPlayer.play("FadeIn")
	
func from_tute_done():
	$Transition/AnimationPlayer.play_backwards("FadeIn")
	yield($Transition/AnimationPlayer, "animation_finished")
	for i in $Pages.get_children():
		if "TutorialPage" in i.name:
			i.queue_free()
	$CommandRunner.run_restart_command()
	open_game(true)
	
func from_tute_quit():
	$Transition/AnimationPlayer.play_backwards("FadeIn")
	yield($Transition/AnimationPlayer, "animation_finished")
	for i in $Pages.get_children():
		if "TutorialPage" in i.name:
			i.queue_free()
	open_menu(can_resume)
	
func from_game_return(reasonKey):
	$Transition/AnimationPlayer.play_backwards("FadeIn")
	yield($Transition/AnimationPlayer, "animation_finished")
	for i in $Pages.get_children():
		if "GamePage" in i.name:
			i.queue_free()
	if reasonKey == "resume":
		can_resume = true
	else:
		can_resume = false
	open_menu(can_resume)
	
func from_menu_error():
	$Transition/AnimationPlayer.play_backwards("FadeIn")
	yield($Transition/AnimationPlayer, "animation_finished")
	$CommandRunner.run_restart_command()
	for i in $Pages.get_children():
		if "MenuPage" in i.name:
			i.queue_free()
	can_resume = false
	open_menu()
	
func from_menu_loaded():
	$Transition/AnimationPlayer.play_backwards("FadeIn")
	yield($Transition/AnimationPlayer, "animation_finished")
	for i in $Pages.get_children():
		if "MenuPage" in i.name:
			i.queue_free()
	open_game(false)

func from_menu_start():
	$Transition/AnimationPlayer.play_backwards("FadeIn")
	yield($Transition/AnimationPlayer, "animation_finished")
	$CommandRunner.run_restart_command()
	for i in $Pages.get_children():
		if "MenuPage" in i.name:
			i.queue_free()
	open_game(true)
	
func from_menu_resume():
	$Transition/AnimationPlayer.play_backwards("FadeIn")
	yield($Transition/AnimationPlayer, "animation_finished")
	for i in $Pages.get_children():
		if "MenuPage" in i.name:
			i.queue_free()
	open_game(false)

func from_menu_tute():
	$Transition/AnimationPlayer.play_backwards("FadeIn")
	yield($Transition/AnimationPlayer, "animation_finished")
	for i in $Pages.get_children():
		if "MenuPage" in i.name:
			i.queue_free()
	open_tute()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
