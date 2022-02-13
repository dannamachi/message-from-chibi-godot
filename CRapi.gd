extends Node

onready var old = get_parent().get_node("CROld")
onready var actions = get_parent().get_node("CRActions")
onready var constants = get_node("CRconstants")
onready var blocks = get_parent().get_node("CRActions/CRBlocks")
onready var logs_new = get_parent().get_node("CRActions/CRLogsNew")
onready var decodes = get_parent().get_node("CRActions/CRDecodes")
onready var saving = get_parent().get_node("CRActions/CRSaving")

# constants
var IS_QUIT = false
var IS_SAVING = false
var IS_LOADING = false
var IS_MENU = false
var END_GAME
var END_RESULT
var END_STATUS = ""
var END_MESSAGE = ""
var TOTAL_TIME
var TIME_SPENT = 0
var DECRYPT_ENQUEUD = false
var FLAGS

var finished_decrypt = false


### TO DO
# play music
# button to toggle music
# button to reset all saves

# section mapping
var SECTION_MAPPING

func set_section_data(sectData):
	actions.SECTION_DATA = sectData

func get_section_data():
	return actions.SECTION_DATA
	
func get_intro():
	return old.print_intro()

func is_flag_triggered(flagName):
	return flagName in FLAGS.keys()

func get_day_block():
	var day = what_day_is_it()
	if day == 1:
		return "0610"
	elif day == 2:
		return "0611"
	elif day == 3:
		return "0612"

func what_day_is_it():
	if TOTAL_TIME > 24:
		return 1
	elif TOTAL_TIME > 12:
		return 2
	else:
		return 3

func what_ending_is_it():
	if END_RESULT == 0:
		return 'base'
	if END_RESULT == 1:
		return 'good'
	if END_RESULT == 7:
		return 'final'
	return "bad"

func run_command(comm_id, args):
#    '''
#    Reserve for save/load
#    '''
	if not (comm_id in [11,12]):
		return [false, "Not valid"]
	var argument_list = [FLAGS, TOTAL_TIME]
	for item in args:
		argument_list.append(item)
	var results = old.call_action_command(comm_id, argument_list)
	var text = results[0]
	TOTAL_TIME = results[1]
	# reset variables if load
	if comm_id == 12:
		IS_SAVING = false
		IS_LOADING = false
		END_GAME = false
		TIME_SPENT = 0
		END_RESULT = 0
	if comm_id == 11:
		if text == 'Game saved':
			return [true, text]
	else:
		if text == 'Game loaded' or text == 'Game restarted':
			return [true, text]
	return [false, text]

func check_end():
	var end_result = 0
	if "Luca's secret" in FLAGS.keys():
		end_result = 1
	if "MISSION END" in FLAGS.keys():
		end_result = 7
	var end_mes = old.end_messages[end_result]
	var end_stat = old.end_statuses[end_result]
	return [end_result, end_stat, end_mes]

func run_game_command(comm_id, args, update=false):
#	'''
#	Returns text, section id
#	'''
	var argument_list = [FLAGS,TOTAL_TIME]
	for item in args:
		argument_list.append(item)
	# check quit
	var error_code = is_special(comm_id)
	if error_code != 4:
		if error_code == 0:
			IS_MENU = true
			return ['Quitting the session...', constants.SECT_MSG]
		if error_code == 5:
			IS_SAVING = true
			return ['Switching to saving...', constants.SECT_MSG]
		if error_code == 6:
			IS_LOADING = true
			return ['Switching to loading...', constants.SECT_MSG]    
	# check doable by flag
	error_code = can_be_done(comm_id, FLAGS)
	if error_code != 4:
		if error_code == 1:
			return ["Admin privilege needed", constants.SECT_MSG]
		else:
			return ["Command not recognized. Are you missing any file/script?", constants.SECT_MSG]
	# convert 'read' to 'read [day block]'
	if comm_id == 2 and len(argument_list) == 2:
		argument_list.append(get_day_block())
	# check correct syntac
	error_code = is_valid(comm_id, argument_list)
	if error_code != 4:
		return ["Invalid syntax", constants.SECT_MSG]
	# run command
	var previous_time = TOTAL_TIME
	var results = old.call_action_command(comm_id, argument_list)
	var text = results[0]
	TOTAL_TIME = results[1]
	if not update:
		TIME_SPENT = previous_time - TOTAL_TIME
		# post command
		DECRYPT_ENQUEUD = (comm_id == 1)
		# update block variation
		for key in logs_new.LOG_VARIATIONS.keys():
			if logs_new.LOG_NEED_FLAGS[key] in FLAGS.keys():
				logs_new.LOGS_NEW[key.substr(0,6)] = logs_new.LOG_VARIATIONS[key]
		# update new block status
		# update new day
		if TOTAL_TIME <= 24 and not old.day_check["Day 1"]:
			blocks.BLOCKS_NEW["0611"] = true 
			if not ("Another day" in FLAGS.keys()):
				FLAGS["WIPED"] = true
			old.day_check["Day 1"] = true
		if TOTAL_TIME <= 12 and not old.day_check["Day 2"]:
			blocks.BLOCKS_NEW["0612"] = true
			if not ("Another CHIBI" in FLAGS.keys()):
				FLAGS["DISAPPEARED"] = true
			old.day_check["Day 2"] = true
		if TOTAL_TIME <= 0 and not old.day_check["Day 3"]:
			END_GAME = true
			var end_check = check_end()
			END_RESULT = end_check[0]
			END_STATUS = end_check[1]
			END_MESSAGE = end_check[2]
			return ["Time's up", constants.SECT_MSG]
		# update special command
		if "p5-9" in FLAGS.keys() and decodes.KEYFLAG["last_piece.bpt"] and not ("Assembled" in FLAGS.keys()):
			FLAGS["Assembled"] = true
		# check final end
		if "MISSION END" in FLAGS.keys():
			END_RESULT = 7
			END_GAME = true
			END_MESSAGE = old.end_messages[END_RESULT]
			END_STATUS = old.end_statuses[END_RESULT]
			return ["Code running...", constants.SECT_MSG]
		# check dead
		for i in range(len(old.flag_dead)):
			if old.flag_dead[i] in FLAGS:
				# print("Disconnected - " + flag_dead[i])
				END_RESULT = old.flag_dead_link[i]
				END_GAME = true
				END_MESSAGE = old.end_messages[END_RESULT]
				END_STATUS = old.end_statuses[END_RESULT]
				return ["Disconnected", constants.SECT_MSG]
	else:
		TIME_SPENT = 0
	# check which section do info text go to
	return [text, get_section_mapping(comm_id)]

func get_section_mapping(comm_id):
	if comm_id in SECTION_MAPPING:
		return SECTION_MAPPING[comm_id]
	else:
		return constants.SECT_MSG

func update_helpful_note(helpful_section):
#	'''
#	Updates helpful section, also does decrypting update
#	Returns helpful section
#	'''
	var isRoot = "Root Access" in old.flags.keys()
	var remove_list = []
	for item in actions.decrypt_track.keys():
		actions.decrypt_track[item] -= TIME_SPENT
		if actions.decrypt_track[item] <= 0:
			actions.update_block_status(item,actions.is_in_which_block_group(item))
			remove_list.append(item)
	for item in remove_list:
		actions.decrypt_track.erase(item)
	var tips = old.print_helpful_note(TOTAL_TIME,isRoot)
	finished_decrypt = len(remove_list) > 0
	helpful_section.set_text(tips)
	
func get_day_time():
	var total_time = TOTAL_TIME
	var isRoot = "Root Access" in old.flags.keys()
	var day_int
	var time_offset
	if total_time > 24:
		day_int = 3
		time_offset = 24
	elif total_time > 12:
		day_int = 2
		time_offset = 12
	else:
		day_int = 1
		time_offset = 0
	if not isRoot:
		return [day_int, total_time - time_offset]
	else:
		return [4 - day_int, 12 - (total_time - time_offset)]

func is_root():
	return "Root Access" in old.flags.keys()

func is_hack():
	return actions.in_hack

func get_pers_day():
	if TOTAL_TIME > 24:
		return 1
	elif TOTAL_TIME > 12:
		return 2
	else:
		return 3

func is_special(comm_id):
	if comm_id == 11:
		return 5
	if comm_id == 12:
		return 6
	if comm_id == 13:
		return 0
	return 4

func can_be_done(comm_id, flags):
	if comm_id in old.action_flags.keys():
		if not ("Root Access" in flags.keys()) and "Root Access" in old.action_flags[comm_id]:
			# command_status = "Root access needed"
			return 1
		else:
			for flag in old.action_flags[comm_id]:
				if not (flag in flags.keys()):
					# command_status = "Command not recognized. Are you missing any package/script? Watch dtube or find files via logs"
					return 2
	return 4

func is_valid(comm_id, args):
	if not old.call_validation(comm_id, args):
		# command_status = "Invalid syntax"
		return 3
	return 4


# Called when the node enters the scene tree for the first time.
func _ready():
	END_GAME = old.end_game
	END_RESULT = old.end_result
	TOTAL_TIME = old.total_time
	FLAGS = old.flags
	# set up saving
	var save_game = File.new()
	if not save_game.file_exists("user://saves.dat"):
		saving.initialize_save()
	actions.set_restart_point(FLAGS,TOTAL_TIME)
	
	SECTION_MAPPING = {
	0  : constants.SECT_WATCH,
	1  : constants.SECT_MSG,
	2  : constants.SECT_READ,
	3  : constants.SECT_WORK,
	4  : constants.SECT_MSG,
	5  : constants.SECT_MSG,
	6  : constants.SECT_MSG,
	7  : constants.SECT_MSG,
	8  : constants.SECT_MSG,
	9  : constants.SECT_NOTE,
	10 : constants.SECT_READ,
	14 : constants.SECT_MSG,
	15 : constants.SECT_NOTE,
	16 : constants.SECT_MSG,
	17 : constants.SECT_MSG,
	
	18 : constants.SECT_NOTE,
	19 : constants.SECT_NOTE,
	20 : constants.SECT_NOTE,

	21 : constants.SECT_MSG,
	22 : constants.SECT_MSG,
	
	23 : constants.SECT_MSG,
	24 : constants.SECT_MSG
}


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
