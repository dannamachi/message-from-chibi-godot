extends Node2D

signal done

var shown = false
var got_log = false
var finished = false
var got_reply = false
var reply_sent = false

var replies = ["reply 123456 a", "reply 123456 b"]

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_LineEdit_text_entered(new_text):
	$LineEdit.clear()
	if not finished:
		var log_text = new_text.strip_edges()
		if not shown:
			$Panel3/AnimationPlayer.play("PullUp")
			yield($Panel3/AnimationPlayer, "animation_finished")
			$NotifText.show()
			shown = true
		elif got_log:
			if log_text != "reply 123456" and not log_text in replies:
				log_text = log_text + "\nThat's not it, try again."
			elif log_text in replies and got_reply:
				log_text = log_text + "\nReply sent."
				finished = true
				$LineEdit.placeholder_text = "You're done, next!"
				$Button.disabled = false
				$Button.show()
			elif log_text in replies and not got_reply:
				log_text = log_text + "\nWait, how do you...? Anyway, you can't skip, at least not here!"
			else:
				log_text = log_text + "\n\t(enter 'reply 123456 a') Got it boss.\n\t(enter 'reply 123456 b') This is not that hard."
				got_reply = true
		else:
			log_text = log_text + "\nClick the notification!"
		$TextEdit2.text += "\n> " + log_text
		$TextEdit2.scroll_vertical = len($TextEdit2.text.split("\n")) - 1

func _on_Panel3_gui_input(event):
	if event is InputEventMouseButton and shown and not finished:
		if event.is_pressed() and event.button_index == BUTTON_LEFT:
			$TextEdit.text = "Log 123456:\n\nWao, congratz!! You entered something to the terminal!!!\n\nTry replying to this message by entering 'reply 123456'"
			$Panel3/AnimationPlayer.play_backwards("PullUp")
			yield($Panel3/AnimationPlayer, "animation_finished")
			$NotifText.hide()
			got_log = true


func _on_Button_pressed():
	emit_signal("done")
