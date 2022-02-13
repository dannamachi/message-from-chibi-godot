extends WindowDialog

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var save_node
var cmd_runner

var saveInfo = []
var pageInt = 0
var pageCount = 0

var pop_up = false
var current_selected = -1

var unfilledList = []

var section_data = {}

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
func init(cmdRunner, sectionData):
	pop_up = false
	save_node = cmdRunner.api.saving
	cmd_runner = cmdRunner
	# input section data
	cmd_runner.api.set_section_data(sectionData)
	# read saved data
	var getInfo = save_node.read_save()
	if getInfo[0]:
		saveInfo = getInfo[1]
		# set up info and pagination
		if len(saveInfo) % 5 == 0:
			pageCount = len(saveInfo) / 5
		else:
			pageCount = len(saveInfo) / 5 + 1
		pageInt = 0
		load_page()
	else:
		# notif saying saving is ded
		# disable everything
		save_error()
		pass

func reload():
	var getInfo = save_node.read_save()
	if getInfo[0]:
		saveInfo = getInfo[1]
		load_page()
	else:
		# pop notif that saving is ded
		# disable
		save_error()
		pass
		
func save_error():
	pop_up = true
	$CannotSave.show()
	$CannotSave/QuitButton.set_mouse_filter(Control.MOUSE_FILTER_STOP)
	for item in $Slots.get_children():
		item.disabled = true
	$BackButton.disabled = true
	$NextButton.disabled = true
		
func load_page():
	if pageInt * 5 < len(saveInfo):
		var startIndex = pageInt * 5
		for i in range(5):
			if startIndex + i < len(saveInfo):
				var info = saveInfo[startIndex + i]
				$Slots.get_node("Button" + str(i + 1)).text = info["Info"]
				$Timestamps.get_node("Time" + str(i + 1)).text = info["Time"]
				$Slots.get_node("Button" + str(i + 1)).disabled = false
			else:
				unfilledList.append(startIndex + i)
				$Slots.get_node("Button" + str(i + 1)).text = ""
				$Timestamps.get_node("Time" + str(i + 1)).text = ""
				$Slots.get_node("Button" + str(i + 1)).disabled = true
		$PageLabel.text = str(pageInt + 1) + " / " + str(pageCount)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_NextButton_pressed():
	if pageInt < pageCount - 1 and not pop_up:
		pageInt += 1
		load_page()


func _on_BackButton_pressed():
	if pageInt > 0 and not pop_up:
		pageInt -= 1
		load_page()



func _on_Button1_pressed():
	slot_button_pressed(1)

func _on_Button2_pressed():
	slot_button_pressed(2)

func _on_Button3_pressed():
	slot_button_pressed(3)

func _on_Button4_pressed():
	slot_button_pressed(4)

func _on_Button5_pressed():
	slot_button_pressed(5)


func slot_button_pressed(slotNum):
	if not pop_up:
		current_selected = pageInt * 5 + slotNum - 1
		if saveInfo[current_selected]['Filled']:
			# open notif
			pop_up = true
			for item in $Slots.get_children():
				item.disabled = true
			$BackButton.disabled = true
			$NextButton.disabled = true
			$Overwrite.show()
			$Overwrite/YesButton.set_mouse_filter(Control.MOUSE_FILTER_STOP)
			$Overwrite/NoButton.set_mouse_filter(Control.MOUSE_FILTER_STOP)
		else:
			save_to_slot()
			
func save_to_slot():
	if current_selected != -1:
		var results = cmd_runner.run_save_command(current_selected)
		if results[0]:
			reload()
			current_selected = -1
		else:
			save_error()


func _on_YesButton_pressed():
	save_to_slot()
	close_overwrite()
	current_selected = -1


func _on_NoButton_pressed():
	current_selected = -1
	close_overwrite()


func _on_Close1_gui_input(event):
	if event is InputEventMouseButton:
		if event.is_pressed() and event.button_index == BUTTON_LEFT:
			close_overwrite()
			
		

func close_overwrite():
	$Overwrite.hide()
	$Overwrite/YesButton.set_mouse_filter(Control.MOUSE_FILTER_IGNORE)
	$Overwrite/NoButton.set_mouse_filter(Control.MOUSE_FILTER_IGNORE)
	for item in $Slots.get_children():
		item.disabled = false
	for i in range(5):
		if (pageInt * 5 + i) in unfilledList:
			$Slots.get_node("Button" + str(i + 1)).disabled = true
	$BackButton.disabled = false
	$NextButton.disabled = false
	pop_up = false


func close_error():
	$CannotSave.hide()
	for item in $Slots.get_children():
		item.disabled = false
	for i in range(5):
		if (pageInt * 5 + i) in unfilledList:
			$Slots.get_node("Button" + str(i + 1)).disabled = true
	$BackButton.disabled = false
	$NextButton.disabled = false
	$CannotSave/QuitButton.set_mouse_filter(Control.MOUSE_FILTER_IGNORE)
	pop_up = false

func _on_SavePage_popup_hide():
	close_overwrite()
	close_error()


func _on_QuitButton_pressed():
	hide()
