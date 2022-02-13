extends ColorRect

signal done

var textString = "=||=||=||=||=||" + \
"\nSecurity warning (Level 5): Change detected in memory database||" + \
"\nSecurity warning (Level 2): Change detected in time display||" + \
"\nSecurity warning (Level 2): Change detected in message display||" + \
"\nSecurity warning (Level 2): Change detected in help display||" + \
"\n=||=||=||" + \
"\nDue to security warning(s), root privilege will be disabled" + \
"\nSome functionalities may be unavailable" + \
"\nEstablishing connection...||" + \
"\n=||=||=||=||=||=||=||" + \
"\nYear: 7204" + \
"\nSession: 4498032" + \
"\nConnection status: Good" + \
"\nAddress: cat_fish@vsp.tc\n" + \
"\n???Save CHIBI! Time is running out!"

var textList = textString.split("||")

var lineInt = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func restart():
	set_mouse_filter(Control.MOUSE_FILTER_STOP)
	$StartButton.set_mouse_filter(Control.MOUSE_FILTER_STOP)
	$StartButton.show()
	$VideoPlayer.show()
	lineInt = 0
	$StartPanel/Label.text = ""
	$StartPanel/OpenButton.hide()
	$StartPanel/OpenButton.set_mouse_filter(Control.MOUSE_FILTER_IGNORE)
	show()

func _on_StartButton_pressed():
	$StartButton.set_mouse_filter(Control.MOUSE_FILTER_IGNORE)
	$StartButton.hide()
	$VideoPlayer.play()


func _on_VideoPlayer_finished():
	$VideoPlayer.hide()
	$StartPanel/Timer.start()

func _on_Timer_timeout():
	$StartPanel/Label.text += textList[lineInt]
	lineInt += 1
	if lineInt < len(textList):
		$StartPanel/Timer.start()
	else:
		$StartPanel/Timer.stop()
		$StartPanel/OpenButton.set_mouse_filter(Control.MOUSE_FILTER_STOP)
		$StartPanel/OpenButton.show()


func _on_OpenButton_pressed():
	$StartPanel/OpenButton.set_mouse_filter(Control.MOUSE_FILTER_IGNORE)
	set_mouse_filter(Control.MOUSE_FILTER_IGNORE)
	hide()
	emit_signal("done")
