extends Node

signal return_menu(reasonKey)

# music section
var musicDict = {
	1  : "res://sounds/one.ogg",
	2  : "res://sounds/two.ogg",
	3  : "res://sounds/three.ogg"
}

func switch_track():
	if not is_muted:
		if $Music.playing:
			$Music/AnimationPlayer.play_backwards("FadeIn")
			yield($Music/AnimationPlayer, "animation_finished")
			$Music.stop()
		$Music.stream = load(musicDict[currDay])
		$Music.play()
		$Music/AnimationPlayer.play("FadeIn")
	
func stop_track():
	if not is_muted:
		$Music/AnimationPlayer.play_backwards("FadeIn")
		yield($Music/AnimationPlayer, "animation_finished")
		$Music.stop()
	
var is_restart = true
var saved_cmds = []
var cmd_pointer = -1

var command_runner
var is_muted = false

var section_mappings = {
	1  : "Log",
	3  : "Internal",
	4  : "External",
	10 : "WatchPage",
	11 : "WorkPage"
}

var section_showing = {
	3 : 9,
	4 : 2
}

var updateDict = {
	2  : "read",
	9  : "help",
	15 : "notes",
	18 : "archive",
	19 : "files",
	20 : "commands"
}

var currDay = 1
var is_paused = false
var currMilestone = -1

var notifCmdDict = {
	"Remote Access"          : false,
	"Change Time"            : false,
	"Decoder"                : false,
	"Assembled"              : false,
	"Decode Cohab's relic"   : false
}
var notifBlockDict = {
	"Root"       : false,
	"Day2"       : false,
	"Day3"       : false
}

func get_section_data():
	var saveData = {}
	# variables
	saveData['Milestone'] = currMilestone
	saveData['Curr day'] = currDay
	saveData['Saved cmds'] = saved_cmds
	saveData['Section showing'] = section_showing
	saveData['Update dict'] = updateDict
	saveData['Notif cmd dict'] = notifCmdDict
	saveData['Notif block dict'] = notifBlockDict
	
	# section text
	saveData['Log text'] = $Log/Label2.text
	saveData['Internal text'] = $Internal/Label2.text
	saveData['External text'] = $External/Label2.text
	saveData['Internal notif'] = [$Internal/Notif.notif_queue, $Internal/Notif.is_open, $Internal/Notif.is_showing]
	saveData['External notif'] = [$External/Notif.notif_queue, $External/Notif.is_open, $External/Notif.is_showing]

	# side info
	saveData['Reminder'] = $Notification/Label2.text
	
	return saveData

# Called when the node enters the scene tree for the first time.
func _ready():
	$BGEffect.play()
	if is_restart:
		$StartPage.restart()
	
func from_start_done():
	$Daybook.set_text(currDay)
	$Daybook.popup()
	
func init(cmdrunner, isRestart = true, isMuted = false):
	is_restart = isRestart
	is_muted = isMuted
	command_runner = cmdrunner
	$LoadPage.cmd_runner = cmdrunner
	if not $LoadPage.connected:
		$LoadPage.connect("quit", self, "_on_QuitButton_pressed")
		$LoadPage.connect("loaded", self, "from_game_loaded")
		$LoadPage.connected = true
	# load saved sect data
	load_section_data(command_runner.api.get_section_data())
	run_command("help")
	post_load()
	
func post_load():
	updateDict[2] = "read " + command_runner.api.get_day_block()
	for sect in section_showing:
		if section_showing[sect] in updateDict:
			run_update_command(updateDict[section_showing[sect]])
	# update time
	var daytime = command_runner.api.get_day_time()
	$Side/Label.text = "D " + str(daytime[0]) + "\nT " + str(daytime[1])
	cmd_pointer = len(saved_cmds)
	var lines = $Log/Label2.text.split("\n")
	$Log/Label2.scroll_vertical = len(lines)
	$Notification.set_text(command_runner.api.old.print_helpful_note(command_runner.api.TOTAL_TIME,command_runner.api.is_root()))
	switch_track()
	# milestone
	var milestones = command_runner.api.logs_new.LOG_TIME.keys()
	var mileCount = 0
	for i in range(len(milestones)):
		if command_runner.api.TOTAL_TIME - 4 > milestones[i]:
			mileCount = i
			if milestones[i] == 8:
				if not command_runner.api.is_flag_triggered("Rikitts") and not command_runner.api.is_flag_triggered("Cohab@") and not command_runner.api.is_flag_triggered("Bpaint@"):
					mileCount = 9
			elif milestones[i] == 10:
				if not command_runner.api.is_flag_triggered("Cohab") and not command_runner.api.is_flag_triggered("Bpaint") and not command_runner.api.is_flag_triggered("Hack Chibi"):
					mileCount = 8
			break
	if command_runner.api.TOTAL_TIME - 4 <= 0:
		if not command_runner.api.is_flag_triggered("Luca's secret"):
			mileCount = 13
		else:
			mileCount = 14
	currMilestone = mileCount
	
func run_command(command):
	var results = command_runner.run_command_game(command)
	var command_run = results[0]
	var text = results[1]
	var sectionID = results[2]
	# update cmds
	updateDict[2] = "read " + command_runner.api.get_day_block()
	if command_run in updateDict:
		updateDict[command_run] = command
	# print info
	get_node(section_mappings[sectionID]).load_text(text)
	# popup if dialog section
	if sectionID in [10, 11]:
		get_node(section_mappings[sectionID]).popup()
	if sectionID in section_showing:
		section_showing[sectionID] = command_run
	# check switch section
	if command_runner.api.IS_MENU:
		command_runner.api.IS_MENU = false
		_on_QuitButton_pressed()
	elif command_runner.api.IS_SAVING:
		command_runner.api.IS_SAVING = false
		_on_SaveButton_pressed()
	elif command_runner.api.IS_LOADING:
		command_runner.api.IS_LOADING = false
		_on_LoadButton_pressed()
	elif command_runner.api.END_GAME:
		from_end()
	else:
		# update notification
		command_runner.api.update_helpful_note($Notification)
		# update stale sections
		for sect in section_showing:
			if sectionID != sect and section_showing[sect] in updateDict:
				run_update_command(updateDict[section_showing[sect]])
		# update time
		var daytime = command_runner.api.get_day_time()
		$Side/Label.text = "D " + str(daytime[0]) + "\nT " + str(daytime[1])
		var newDay = command_runner.api.get_pers_day()
		if newDay != currDay:
			$Daybook.set_text(newDay)
			$Daybook.popup()
			switch_track()
		currDay = newDay
		check_notification()

func check_log_time():
	# check for time lost
	if command_runner.api.TIME_SPENT == 2:
		var milestones = command_runner.api.logs_new.LOG_TIME.keys()
		var mileCount = 0
		for i in range(len(milestones)):
			if command_runner.api.TOTAL_TIME + 1 - 4 > milestones[i]:
				mileCount = i
				if milestones[i] == 8:
					if not command_runner.api.is_flag_triggered("Rikitts") and not command_runner.api.is_flag_triggered("Cohab@") and not command_runner.api.is_flag_triggered("Bpaint@"):
						mileCount = currMilestone
				elif milestones[i] == 10:
					if not command_runner.api.is_flag_triggered("Cohab") and not command_runner.api.is_flag_triggered("Bpaint") and not command_runner.api.is_flag_triggered("Hack Chibi"):
						mileCount = currMilestone
				break
		if command_runner.api.TOTAL_TIME + 1 - 4 <= 0:
			if not command_runner.api.is_flag_triggered("Luca's secret"):
				mileCount = currMilestone
			else:
				mileCount = 14
		if mileCount != currMilestone:
			$External/Notif.push_notif("LOG")
			currMilestone = mileCount
	# check for end
	var milestones = command_runner.api.logs_new.LOG_TIME.keys()
	var mileCount = 0
	for i in range(len(milestones)):
		if command_runner.api.TOTAL_TIME - 4 > milestones[i]:
			mileCount = i
			if milestones[i] == 8:
				if not command_runner.api.is_flag_triggered("Rikitts") and not command_runner.api.is_flag_triggered("Cohab@") and not command_runner.api.is_flag_triggered("Bpaint@"):
					mileCount = currMilestone
			elif milestones[i] == 10:
				if not command_runner.api.is_flag_triggered("Cohab") and not command_runner.api.is_flag_triggered("Bpaint") and not command_runner.api.is_flag_triggered("Hack Chibi"):
					mileCount = currMilestone
			break
	if command_runner.api.TOTAL_TIME - 4 <= 0:
		if not command_runner.api.is_flag_triggered("Luca's secret"):
			mileCount = currMilestone
		else:
			mileCount = 14
	if mileCount != currMilestone:
		$External/Notif.push_notif("LOG")
		currMilestone = mileCount

func check_notification():
	# notification (log)
	check_log_time()
	# notification cmd
	var flagList = []
	for flag in notifCmdDict:
		if not notifCmdDict[flag]:
			flagList.append(flag)
	for item in flagList:
		if command_runner.api.is_flag_triggered(item):
			$Internal/Notif.push_notif("CMD")
			notifCmdDict[item] = true
	# notification decrypt
	if command_runner.api.finished_decrypt:
		$Internal/Notif.push_notif("DEC")
	# notification archive
	var dayGet = command_runner.api.get_pers_day()
	if dayGet == 2 and not notifBlockDict["Day2"]:
		$Internal/Notif.push_notif("HID")
		notifBlockDict["Day2"] = true
	if dayGet == 3 and not notifBlockDict["Day3"]:
		$Internal/Notif.push_notif("HID")
		notifBlockDict["Day3"] = true
	if command_runner.api.is_root() and not notifBlockDict["Root"]:
		$Internal/Notif.push_notif("HID")
		notifBlockDict["Root"] = true
	
		
func run_update_command(command):
	var results = command_runner.run_command_game(command,true)
	var command_run = results[0]
	var text = results[1]
	var sectionID = results[2]
	get_node(section_mappings[sectionID]).load_text(text,true)
	# update cmds
	updateDict[2] = "read " + command_runner.api.get_day_block()
	if command_run in updateDict:
		updateDict[command_run] = command
	if sectionID in section_showing:
		section_showing[sectionID] = command_run

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if $Editing.is_editing and Input.is_action_just_pressed("ui_up"):
		if len(saved_cmds) > 0:
			cmd_pointer = clamp(cmd_pointer - 1, 0, len(saved_cmds) - 1)
			$Editing/LineEdit.text = saved_cmds[cmd_pointer]
		$Editing/LineEdit.caret_position = len($Editing/LineEdit.text)
	elif $Editing.is_editing and Input.is_action_just_pressed("ui_down"):
		if len(saved_cmds) > 0:
			cmd_pointer = clamp(cmd_pointer + 1, 0, len(saved_cmds) - 1)
			$Editing/LineEdit.text = saved_cmds[cmd_pointer]
		$Editing/LineEdit.caret_position = len($Editing/LineEdit.text)
		
	# mouse hovering
	var mouse_pos = get_viewport().get_mouse_position()
	for child in $Side.get_children():
		if "ButtonHover" in child.name:
			if panel_has_point(child, mouse_pos):
				child.show()
			else:
				child.hide()

func panel_has_point(control_node, mouse_pos):
	var true_pos = control_node.rect_position
	var true_size = Vector2(control_node.rect_size.x * control_node.rect_scale.x, control_node.rect_size.y * control_node.rect_scale.y)
	return mouse_pos.x > true_pos.x and mouse_pos.y > true_pos.y and mouse_pos.x < true_pos.x + true_size.x and mouse_pos.y < true_pos.y + true_size.y

func pause_screen():
	$Log.is_paused = true
	$Editing.is_paused = true
	$Editing.is_editing = false
	is_paused = true
	
func unpause_screen():
	$Log.is_paused = false
	$Editing.is_paused = false
	$Editing.is_editing = true
	is_paused = false

func _on_Log_command_entered(cmd):
	$Editing/LineEdit.clear()
	saved_cmds.append(cmd)
	cmd_pointer = len(saved_cmds)
	run_command(cmd)


func _on_NotificationButton_pressed():
	$Notification.popup()


func _on_ViewButton1_pressed():
	$Viewbook.load_text($Internal/Label2.text)
	$Viewbook.popup()


func _on_ViewButton2_pressed():
	$Viewbook.load_text($External/Label2.text)
	$Viewbook.popup()


func _on_NoteButton_pressed():
	$Notebook.popup()


func _on_SystemButton_pressed():
	$Settings.popup()


func _on_SaveButton_pressed():
	var sectData = get_section_data()
	$SavePage.init(command_runner, sectData)
	$SavePage.popup()
	$Settings.hide()


func _on_LoadButton_pressed():
	$Settings.hide()
	$LoadPage.init(command_runner)
	if not $LoadPage.connected:
		$LoadPage.connect("quit", self, "_on_QuitButton_pressed")
		$LoadPage.connect("loaded", self, "from_game_loaded")
		$LoadPage.connected = true
	$LoadPage.popup()


func _on_RestartButton_pressed():
	$Restart.popup()
	$Settings.hide()


func _on_QuitButton_pressed():
	var sectData = get_section_data()
	command_runner.api.set_section_data(sectData)
	stop_track()
	emit_signal("return_menu", "resume")


func from_game_loaded(new_sect_data):
	stop_track()
	if not load_section_data(new_sect_data):
		$Loaded.popup()
	else:
		check_notification()
		pass
	post_load()
	
func load_section_data(new_sect_data):
	var saveData = new_sect_data
	for notif in [$Internal/Notif, $External/Notif]:
		notif.reset()
	$Editing/LineEdit.text = ""
	if len(saveData.keys()) > 0:
		# variables
		currMilestone = int(saveData['Milestone'])
		currDay = int(saveData['Curr day'])
		saved_cmds = saveData['Saved cmds']
		cmd_pointer = -1
		section_showing = {}
		for i in saveData['Section showing']:
			section_showing[int(i)] = int(saveData['Section showing'][i])
		updateDict = {}
		for i in saveData['Update dict']:
			updateDict[int(i)] = saveData['Update dict'][i]
		notifCmdDict = saveData['Notif cmd dict']
		notifBlockDict = saveData['Notif block dict']
		# section text
		$Log/Label2.text = saveData['Log text']
		$Internal/Label2.text = saveData['Internal text']
		$External/Label2.text = saveData['External text']
		$Internal/Notif.notif_queue = saveData['Internal notif'][0]
		$Internal/Notif.is_open = saveData['Internal notif'][1]
		$Internal/Notif.is_showing = saveData['Internal notif'][2]
		$External/Notif.notif_queue = saveData['External notif'][0]
		$External/Notif.is_open = saveData['External notif'][1]
		$External/Notif.is_showing = saveData['External notif'][2]
		
		#notification
		for notif in [$External/Notif, $Internal/Notif]:
			if notif.is_open:
				notif.run_notif(notif.is_showing)
	
		# side info
		$Notification/Label2.text = saveData['Reminder']
		return false
	else:
		# variables
		saved_cmds = []
		cmd_pointer = -1
		section_showing = {
			3 : 9,
			4 : 2
		}
		updateDict = {
			2  : "read",
			9  : "help",
			15 : "notes",
			18 : "archive",
			19 : "files",
			20 : "commands"
		}
		currDay = 1
		currMilestone = -1
		notifCmdDict = {
			"Remote Access"          : false,
			"Change Time"            : false,
			"Decoder"                : false,
			"Assembled"              : false,
			"Decode Cohab's relic"   : false
		}
		notifBlockDict = {
			"Root"       : false,
			"Day2"       : false,
			"Day3"       : false
		}
		
		# section text
		$Log/Label2.text = ""
		$Internal/Label2.text = ""
		$External/Label2.text = ""
		$Internal/Notif.notif_queue = []
		$Internal/Notif.is_open = false
		$Internal/Notif.is_showing = "NA"
		$External/Notif.notif_queue = []
		$External/Notif.is_open = false
		$External/Notif.is_showing = "NA"
	
		# side info
		$Notification/Label2.text = ""
		return true


func from_end():
	stop_track()
	var text = command_runner.api.END_STATUS + "\n\n\n" + command_runner.api.END_MESSAGE
	var endType = command_runner.api.what_ending_is_it()
	$EndPage.init(text, endType, is_muted)
	$EndPage.set_mouse_filter(Control.MOUSE_FILTER_STOP)
	$EndPage/Button.set_mouse_filter(Control.MOUSE_FILTER_STOP)
	$EndPage.connect("done", self, "from_end_done")
	$EndPage.show()
	$EndPage.play_animation()
	
func from_end_done():
	emit_signal("return_menu", "end")

func _on_Panel1_gui_input(event):
	if event is InputEventMouseButton:
		if event.is_pressed():
			$Internal/Notif.close()
			if event.button_index == BUTTON_LEFT:
				var cmd = get_notif_cmd($Internal/Notif.is_showing)
				if cmd != "NA":
					run_update_command(cmd)

func _on_Panel2_gui_input(event):
	if event is InputEventMouseButton:
		if event.is_pressed():
			$External/Notif.close()
			if event.button_index == BUTTON_LEFT:
				var cmd = get_notif_cmd($External/Notif.is_showing)
				if cmd != "NA":
					run_update_command(cmd)
		
			
func get_notif_cmd(typekey):
	var cmd = "NA"
	if typekey == "LOG":
		cmd = "read " + command_runner.api.get_day_block()
	elif typekey == "CMD":
		cmd = "commands"
	elif typekey == "DEC":
		cmd = "archive"
	elif typekey == "HID":
		cmd = "archive"
	return cmd


func _on_YesButton_pressed():
	$StartPage.restart()
	$Restart.hide()
	$LoadPage.run_restart()


func _on_NoButton_pressed():
	$Restart.hide()


func _on_BGEffect_finished():
	$BGEffect.play()
