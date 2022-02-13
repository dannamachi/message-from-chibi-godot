extends Node

onready var actions = get_parent().get_node("CRActions")
onready var validation = get_node("CRValidation")
onready var blocks = get_parent().get_node("CRActions/CRBlocks")
onready var logs_new = get_parent().get_node("CRActions/CRLogsNew")
onready var decodes = get_parent().get_node("CRActions/CRDecodes")
onready var saving = get_parent().get_node("CRActions/CRSaving")

### endings
var end_game = false
var end_statuses = {
	0 : "Code integrity: True\nMission success: false\nMessage: At least you survive\n",
	1 : "Code integrity: True\nMission success: false\nMessage: Thank you for passing on the truth about LUCA\n",
	2 : "Code integrity: false\nMessage: Code files not assembled, program failure\n",
	3 : "Report: Malware detected (Severity:8)\nAction: Security analysis; Initializing analysis...\n",
	4 : "Report: Malware detected (Severity:6)\nAction: Data erasure; Initializing erasure...\n",
	5 : "Report: Malware detected (Severity:3)\nAction: Data transfer; Initializing transfer...\n",
	6 : "Report: Malware detected (Severity:10)\nAction: Data corruption; Initialization corruption...\n",
	7 : "Code integrity: True\nMission success: True\nMessage: You did it!\nSpecial Message: decode ? do+not+forget\n"\
}
var end_messages = {
	0 : "You've managed to save CHIBI! Want to try to fulfill the mission?\nMaybe you can try decoding files you have - the password can be found by remote accessing or talking to others\nFiles of the same author tend to have the same decoding key\nAnd if you think you have every file possible... are you sure?\n",
	1 : "You've managed to save CHIBI and tell the truth to Luv!\nYou're almost there - did you decode every files possible?\nRun every command possible?\n",
	2 : "You are either missing certain files\nor forgetting to run a certain command in time\n",
	3 : "You've exposed CHIBI to the authorities.\nDon't be so honest in replying next time\n",
	4 : "You've acted too suspicious and drew suspicion from authorities\nTry to reply more often/differently next time\n",
	5 : "You've drawn suspicion to yourself either by replying wrongly or\ndoing something you shouldn't be doing\n",
	6 : "You've exposed CHIBI and also drawn suspicion to yourself.\nThe authorities had to take care of you.\nDon't reply so honestly next time\n",
	7 : "You've managed to fulfill CHIBI's main mission while also surviving!\nDo you understand what CHIBI is now?\nIf you haven't... have you tried to decode all the files?\n"\
}
var end_result

var flag_dead_link = {
	0  : 4,
	1  : 5,
	2  : 6,
	3  : 3,
	4  : 2
}

### time units
var total_time = 36

### flags
var flags = {}

var flag_dead = [ "WIPED", "RELOCATED", "KILLED", "DISCOVERED", "DISAPPEARED"]

var day_check

### actions
var action_flags = {
	# 1 : ["Root Access"],
	5 : ["Root Access","Remote Access"],
	6 : ["Root Access","Change Time"],
	7 : ["Root Access","Decode Cohab's relic"],
	16: ["Assembled"],
	21: ["I can decode"],
	22: ["Root Access", "Secure Mail"],
	23: ["Root Access", "Real hack stuff"],
	24: ["Fake hack stuff"]
} 

func call_validation(action_ID, args):
	if action_ID == 0:
		return validation.check_dt(args)
	elif action_ID == 1:
		return validation.check_decrypt(args)
	elif action_ID == 2:
		return validation.check_read(args)
	elif action_ID == 3:
		return validation.check_work(args)
	elif action_ID == 4:
		return validation.check_root(args)
	elif action_ID == 5:
		return validation.check_remote(args)
	elif action_ID == 6:
		return validation.check_time(args)
	elif action_ID == 7:
		return validation.check_overspace(args)
	elif action_ID == 8:
		return validation.check_contact(args)
	elif action_ID == 9:
		return validation.check_help(args)
	elif action_ID == 10:
		return validation.check_decode(args)
	elif action_ID == 11:
		return validation.check_save(args)
	elif action_ID == 12:
		return validation.check_load(args)
	elif action_ID == 14:
		return validation.check_reply(args)
	elif action_ID == 15:
		return validation.check_notes(args)
	elif action_ID == 16:
		return validation.check_chibi(args)
	elif action_ID == 17:
		return validation.check_attachment(args)
		
	elif action_ID == 18:
		return validation.check_archive(args)
	elif action_ID == 19:
		return validation.check_files(args)
	elif action_ID == 20:
		return validation.check_commands(args)

	elif action_ID == 21:
		return validation.check_reverse(args)
	elif action_ID == 22:
		return validation.check_chat(args)
		
	elif action_ID == 23:
		return validation.check_hack(args)
	elif action_ID == 24:
		return validation.check_haxx(args)
		
	elif action_ID == 25:
		return validation.check_ha_tables(args)
	elif action_ID == 26:
		return validation.check_ha_get(args)
	elif action_ID == 27:
		return validation.check_ha_commit(args)
	elif action_ID == 28:
		return validation.check_ha_update(args)
	elif action_ID == 29:
		return validation.check_ha_exit(args)
	elif action_ID == 30:
		return validation.check_ha_hash(args)

	return false
	
func call_action_command(action_ID, args):
	if action_ID == 0:
		return actions.demtube(args)
	elif action_ID == 1:
		return actions.decrypt(args)
	elif action_ID == 2:
		return actions.read(args)
	elif action_ID == 3:
		return actions.work(args)
	elif action_ID == 4:
		return actions.root(args)
	elif action_ID == 5:
		return actions.remote_access(args)
	elif action_ID == 6:
		return actions.time_change(args)
	elif action_ID == 7:
		return actions.overspace(args)
	elif action_ID == 8:
		return actions.contact(args)
	elif action_ID == 9:
		return actions.help(args)
	elif action_ID == 10:
		return actions.decode(args)
	elif action_ID == 11:
		return actions.save(args)
	elif action_ID == 12:
		return actions.load_game(args)
	elif action_ID == 14:
		return actions.reply(args)
	elif action_ID == 15:
		return actions.notes(args)
	elif action_ID == 16:
		return actions.chibi(args)
	elif action_ID == 17:
		return actions.save_attachment(args)
		
	elif action_ID == 18:
		return actions.archive(args)
	elif action_ID == 19:
		return actions.files(args)
	elif action_ID == 20:
		return actions.commands(args)
	
	elif action_ID == 21:
		return actions.reverse_encode(args)
	elif action_ID == 22:
		return actions.secure_comm(args)
		
	elif action_ID == 23:
		return actions.run_hack(args)
	elif action_ID == 24:
		return actions.run_haxx(args)
		
	elif action_ID == 25:
		return actions.ha_tables(args)
	elif action_ID == 26:
		return actions.ha_get(args)
	elif action_ID == 27:
		return actions.ha_commit(args)
	elif action_ID == 28:
		return actions.ha_update(args)
	elif action_ID == 29:
		return actions.ha_exit(args)
	elif action_ID == 30:
		return actions.ha_hash(args)

# text
func print_intro():
#    '''
#    Prints intro text
#    '''
	var tips =  "=====================================\n"
	tips += "Security warning (Level 5): Change detected in memory database\n"
	tips += "Security warning (Level 2): Change detected in time display\n"
	tips += "Security warning (Level 2): Change detected in message display\n"
	tips += "Security warning (Level 2): Change detected in help display\n"
	tips += "Due to security warning(s), admin privilege will be disabled\nSome functionalities may be unavailable\n"
	tips += "Establishing connection...\n"
	tips += "=====================================\n"
	tips += "Year: 7204\n"
	tips += "Session: 4498032\n"
	tips += "Connection status: Good\n"
	tips += "Address: cat_fish@vsp.tc\n"
	return tips

func print_helpful_note(total_time,isRoot):
#    '''
#    Prints helpful note and time (reverse time if isRoot)
#    '''
	var tips = "1. Enter 'read' "
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
	tips += "to check all logs in day\n"
	tips += "2. Enter 'commands' to check available commands\n"
	if not isRoot:
		tips = "<Day " + str(day_int) + " Time " + str(total_time - time_offset) + ">\n" + tips
	else:
		tips = "<Day " + str(4 - day_int) + " Time " + str(12 - (total_time - time_offset)) + ">\n" + tips
	tips += "3. Press (+) on top right of tabs to enter viewing mode\n"
	tips += "4. Press up/down to navigate past commands"
#	if "Assembled" in flags.keys() and not ("Another CHIBI" in flags.keys()):
#		tips += "\n\n???Message: all code files detected, please run special command"
	return tips

# SAVE INITIALIZING
# saving.initialize_save()
#actions.set_restart_point(flags,total_time)



# Called when the node enters the scene tree for the first time.
func _ready():
	end_result = actions.end_result
	day_check = actions.day_check

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
