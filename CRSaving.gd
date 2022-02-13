extends Node

var TOTAL_SAVE_SLOT = 20

func initialize_save():
#    '''
#    Initializes save file with slots
#    Returns bool for success
#    '''
	var DATA_SAVES = {'Success' : 1}
	for index in range(TOTAL_SAVE_SLOT):
		DATA_SAVES[index] = {}
		DATA_SAVES[index]['Filled'] = 0
		
	var save_game = File.new()
	save_game.open("user://saves.dat", File.WRITE)
	
	save_game.store_line(to_json(DATA_SAVES))
	save_game.close()

	return true
	

func read_data_from_file():
#    '''
#    Returns dictionary of saves
#    '''
	var saveData = {'Success' : 0}
	# read from file
	var save_game = File.new()
	if not save_game.file_exists("user://saves.dat"):
		return saveData # Error! We don't have a save to load.

	# Load the file line by line and process that dictionary to restore
	# the object it represents.
	save_game.open("user://saves.dat", File.READ)
	var data_text = save_game.get_as_text()
	var data_parse = JSON.parse(data_text)
	if data_parse.error == OK:
		saveData = {'Success' : 1}
		saveData["data"] = data_parse.result
	save_game.close()
	
	return saveData

func format_time(isRoot,current_time):
#    '''
#    Returns string of formatted time
#    '''
	var day_int
	var time_offset
	var time
	if current_time > 24:
		day_int = 3
		time_offset = 24
	elif current_time > 12:
		day_int = 2
		time_offset = 12
	else:
		day_int = 1
		time_offset = 0
	if not isRoot:
		time = current_time - time_offset
	else:
		day_int = 4 - day_int
		time = 12 - (current_time - time_offset)
	return 'D' + str(day_int) + " T" + str(time)
	
func read_save():
	var DATA_SAVES = read_data_from_file()
	if DATA_SAVES['Success'] != 1:
		return [false,[]]
	DATA_SAVES = DATA_SAVES['data']
	var slotInfoList = []
	for index in range(TOTAL_SAVE_SLOT):
		var slotInfo = {}
		var slot = str(index)
		var isFilled = DATA_SAVES[slot]['Filled']
		if isFilled == 1:
			slotInfo['Filled'] = true
			var time = DATA_SAVES[slot]['TIME']
			var isRoot = 'Root Access' in DATA_SAVES[slot]['FLAGS']
			var time_string = format_time(isRoot,time)
			slotInfo['Info'] = "Slot " + str(slot) + ": " + time_string + " (Root: " + str(isRoot) +")"
			slotInfo["Time"] = DATA_SAVES[slot]["Timestamp"]
		else:
			slotInfo['Filled'] = false
			slotInfo['Info'] = "Slot " + str(slot)
			slotInfo["Time"] = ""
		slotInfoList.append(slotInfo)
	return [true,slotInfoList]

func save_data_to_file(\
	flags, current_time, flag_contact, day_check, decrypt_track,\
	blocks, blocks_root, blocks_two, blocks_three, blocks_new,\
	keyflag, logs_new, logs_need_replies, log_attachment,\
	slot_index, section_data={}):
#    '''
#    Writes data dictionaries to file
#    Returns bool whether succeeds
#    '''
	slot_index = str(slot_index)
	# read from file
	var DATA_SAVES = read_data_from_file()
	if DATA_SAVES['Success'] != 1:
		return false
	# save to file
	DATA_SAVES = DATA_SAVES["data"]
	DATA_SAVES[slot_index] = {}
	DATA_SAVES[slot_index]["FLAGS"] = flags
	DATA_SAVES[slot_index]["TIME"] = current_time
	DATA_SAVES[slot_index]["CONTACTCOUNT"] = flag_contact
	DATA_SAVES[slot_index]["DAYCHECK"] = day_check
	DATA_SAVES[slot_index]["DECRYPT"] = decrypt_track
	DATA_SAVES[slot_index]["BLOCKS"] = blocks
	DATA_SAVES[slot_index]["BLOCKSROOT"] = blocks_root
	DATA_SAVES[slot_index]["BLOCKSTWO"] = blocks_two
	DATA_SAVES[slot_index]["BLOCKSTHREE"] = blocks_three
	DATA_SAVES[slot_index]["BLOCKSNEW"] = blocks_new
	DATA_SAVES[slot_index]["DECODES"] = keyflag
	DATA_SAVES[slot_index]["LOGSNEW"] = logs_new
	DATA_SAVES[slot_index]["LOGSREPLY"] = logs_need_replies
	DATA_SAVES[slot_index]["LOGSATTACHMENT"] = log_attachment
	DATA_SAVES[slot_index]["SECTIONDATA"] = section_data
	DATA_SAVES[slot_index]['Filled'] = 1
	# timestamp
	var tstamp = "{year}/{month}/{day} {hour}:{minute}"
	var osTime = OS.get_datetime()
	tstamp = tstamp.format({
		"year"       : str(osTime["year"]), 
		"month"      : str(osTime["month"]), 
		"day"        : str(osTime["day"]), 
		"hour"       : str(osTime["hour"]), 
		"minute"     : str(osTime["minute"])
		})
	DATA_SAVES[slot_index]["Timestamp"] = tstamp
	
	var save_game = File.new()
	save_game.open("user://saves.dat", File.WRITE)
	
	save_game.store_line(to_json(DATA_SAVES))
	save_game.close()

	return true


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
