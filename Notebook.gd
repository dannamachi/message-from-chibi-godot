extends WindowDialog

var pageList = []
var pageInt = 0

var initNotes = {
	"0":["Enter your notes here\nPress (+) to add empty pages (max 10)\nSaved notes are kept across save slots","Read the logs!!!"],
	"1":["Nothing to do? Just dt or work","You can copy paste text"],
	"2":["There's stuff in the archive if you want to know more","Right-click notification to close it"]
}


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	for i in initNotes:
		pageList.append(initNotes[i])
	var save_game = File.new()
	if not save_game.file_exists("user://notes.dat"):
		create_save_file()
	else:
		load_game_data()
	load_page()
	
func load_page():
	$Label2.text = pageList[pageInt][0]
	$Label22.text = pageList[pageInt][1]
	$PageLabel.text = str(pageInt + 1) + " / " + str(len(pageList))


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_BackButton_pressed():
	if pageInt > 0:
		pageInt -= 1
		load_page()


func _on_NextButton_pressed():
	if pageInt < len(pageList) - 1:
		pageInt += 1
		load_page()


func _on_AddButton_pressed():
	if len(pageList) < 10:
		pageList.append(["There is nothing here.", "There is nothing here."])
		$PageLabel.text = str(pageInt + 1) + " / " + str(len(pageList))
		window_title = "Notebook (unsaved)"


func _on_SaveButton_pressed():
	save_game_data()
	window_title = "Notebook (saved)"
		
func save_game_data():
	var save_notes = read_data_from_file()
	if save_notes['Success'] == 1:
		
		save_notes = save_notes["data"]
		for i in range(len(pageList)):
			save_notes[str(i)] = pageList[i]
		
		var save_game = File.new()
		save_game.open("user://notes.dat", File.WRITE)
		
		save_game.store_line(to_json(save_notes))
		save_game.close()
		
func load_game_data():
	var get_save = read_data_from_file()
	if get_save["Success"] == 1:
		pageList = []
		get_save = get_save["data"]
		for item in get_save:
			pageList.append(get_save[item])
		pageInt = 0
		
func create_save_file():
	var get_save = {}
	for i in range(len(pageList)):
		get_save[str(i)] = pageList[i]

	var save_game = File.new()
	save_game.open("user://notes.dat", File.WRITE)
	
	save_game.store_line(to_json(get_save))
	save_game.close()

func read_data_from_file():
	var saveData = {'Success' : 0}
	# read from file
	var save_game = File.new()
	if not save_game.file_exists("user://notes.dat"):
		return saveData # Error! We don't have a save to load.

	# Load the file line by line and process that dictionary to restore
	# the object it represents.
	save_game.open("user://notes.dat", File.READ)
	var data_text = save_game.get_as_text()
	var data_parse = JSON.parse(data_text)
	if data_parse.error == OK:
		saveData = {'Success' : 1}
		saveData["data"] = data_parse.result
	save_game.close()
	
	return saveData


func _on_Label2_text_changed():
	pageList[pageInt][0] = $Label2.text
	window_title = "Notebook (unsaved)"


func _on_Label22_text_changed():
	pageList[pageInt][1] = $Label22.text
	window_title = "Notebook (unsaved)"
