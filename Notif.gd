extends Node


var notif_queue = []
var is_open = false
var is_showing = "NA"

### New log notification (check time window and eligible logs)
### New command notification (check for flag, make sure trigger once)
### Decryption complete (used what was written for helpful notes)
### Special command notificiation (optional)
### Hidden blocks after root (flag)
### Hidden blocks due to day (time)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func reset():
	if is_open:
		close()
	notif_queue = []
	is_showing = "NA"
	
func push_notif(typekey):
	notif_queue.append(typekey)
	
func run_notif(typekey):
	var text = "NA"
	if typekey == "LOG":
		text = "New log arrived - click here"
	elif typekey == "CMD":
		text = "Changes to command list - click here"
	elif typekey == "DEC":
		text = "1 or more blocks decrypted - click here"
	elif typekey == "HID":
		text = "New archive detected - click here"
	$Label.text = text
	is_showing = typekey
	open()
	
func open():
	if $Label.text != "NA":
		is_open = true
		$Panel/AnimationPlayer.play("Pop")
		yield($Panel/AnimationPlayer, "animation_finished")
		$Label.show()
	
func close():
	if $Label.text != "NA":
		$Label.hide()
		$Panel/AnimationPlayer.play_backwards("Pop")
		yield($Panel/AnimationPlayer, "animation_finished")
		is_open = false
		is_showing = "NA"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not is_open and len(notif_queue) > 0:
		var notif = notif_queue[0]
		run_notif(notif)
		notif_queue.remove(notif)
