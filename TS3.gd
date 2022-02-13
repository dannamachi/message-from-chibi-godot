extends Node2D

signal done

var finished = false

var shown = false
var got_file = false
var see_file = false

var final_msg = "And we are done! Go go go!\n\n\n...What? That can't be it? Can't you figure out the rest yourself? I'm just supposed to show you the ropes, not give you the answer to everything. What would be the fun in that? Now, off with you!!"

var replyDict = {
	"read 9999"     :  "Block 9999:\n\nLog 999901:\n\nOkay, last thing you need to know about is attachment.\n\nLog 999902:\n\nOnce in a while, a log will come to you with file(s) attached to it.\n\nLog 999903:\n\nYou can download them at your discretion, by entering the command 'download abcdef', with abcdef being the log number.\n\nLog 999904:\n\nTry it out. Enter 'download 999904' to get this file. <attached: dummy.clf>",
	"files"         :  "Files in memory:\n\tdummy.clf"
}


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
		if log_text in replyDict:
			if log_text == "files" and not got_file:
				log_text = log_text + "\nYou are skipping steps!"
			else:
				$TextEdit.text = replyDict[log_text]
				if log_text == "read 9999":
					see_file = true
				elif not shown:
					$Panel3/AnimationPlayer.play("PullUp")
					yield($Panel3/AnimationPlayer, "animation_finished")
					$NotifText.show()
					shown = true
		elif log_text == "download 999904":
			if see_file:
				log_text = log_text + "\nAttachment saved. Enter 'files' to check."
				got_file = true
			else:
				log_text = log_text + "\nYou are skipping steps!"
		else:
			log_text = log_text + "\nThat's not it, try again."

		$TextEdit2.text += "\n> " + log_text
		$TextEdit2.scroll_vertical = len($TextEdit2.text.split("\n")) - 1

func _on_Panel3_gui_input(event):
	if event is InputEventMouseButton and shown and not finished:
		if event.is_pressed() and event.button_index == BUTTON_LEFT:
			$TextEdit.text = final_msg
			$LineEdit.placeholder_text = "You're done!"
			$Button.disabled = false
			$Button.show()
			finished = true
			$Panel3/AnimationPlayer.play_backwards("PullUp")
			yield($Panel3/AnimationPlayer, "animation_finished")
			$NotifText.hide()


func _on_Button_pressed():
	emit_signal("done")
