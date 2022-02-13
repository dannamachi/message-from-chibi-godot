extends Node

onready var schedule = get_node("CRSchedule")
onready var logs = get_node("CRLogs")
onready var logs_new = get_node("CRLogsNew")
onready var blocks = get_node("CRBlocks")
onready var remotestuff = get_node("CRRemote")
onready var decodes = get_node("CRDecodes")
onready var actions_help = get_node("CRActionsHelp")
onready var saving = get_node("CRSaving")
onready var secmail = get_node("CRSecureMail")

var end_result = 0

var flag_demtube_triggers = {
	34 : "Can Root Access",
	26 : "Remote Access",
	28 : "Pre-war?",
	22 : "Animals",
	12 : "Fast Decrypt",
	8  : "Decoder",
}

var flag_work_triggers = {
	20 : "Change Time",
	10 : "Secure Mail"
}

var day_check = {
	"Day 1"  : false,
	"Day 2"  : false,
	"Day 3"  : false,
}

var decrypt_track = {

}

var SECTION_DATA = {}

var flag_contact = 0

var contact_red = ["121111117", "109117115116", "115117114118105118101", "9910410598105"]

var in_hack = false

func set_restart_point(flags,current_time):
#    '''
#    Saves (auto) restart point to save file
#    Returns success
#    '''
	var save_success = saving.save_data_to_file(flags,current_time,flag_contact,
			day_check,decrypt_track,blocks.BLOCKS,blocks.BLOCKS_ROOT,blocks.BLOCKS_SPECIAL_TWO,blocks.BLOCKS_SPECIAL_THREE,blocks.BLOCKS_NEW,
			decodes.KEYFLAG,logs_new.LOGS_NEW,logs_new.LOG_NEED_REPLIES,logs_new.LOG_ATTACHMENT,"restart",{})
	return save_success

func run_hack(args):
	var flags = args[0]
	var current_time = args[1]
	return [""]

func run_haxx(args):
	var flags = args[0]
	var current_time = args[1]
	flags['WIPED'] = true
	return ["Running program...\n.....\n.........\n=====\n=====\nJokes on you, liar. Not that you will see this anyway, since this is obviously a virus that will alert the bots to come scan you... Just a prank, you didn't actually fall for it right?\n=====\n=====", current_time]

func secure_comm(args):
#	'''
#	get log message via secure comm (or options to select from)
#	'''
	var flags = args[0]
	var current_time = args[1]

	var encoded = args[2]
	var tips = "Secure chat running...\n"
	# no valid mail id
	if not (encoded in secmail.REPLY_STATUS.keys()):
		return ["Chat id not found.", current_time]
	# check flag for first stage
	if secmail.REPLY_STATUS[encoded] == 0:
		if not is_flag_triggered(flags, secmail.FLAG_START[encoded]):
			return ["No message topic available.\n", current_time]
	# no more topic
	elif secmail.REPLY_STATUS[encoded] >= len(secmail.REPLY_STAGES[encoded]):
		return ["No message topic available.\n", current_time]
	
	var toplist = secmail.REPLY_STAGES[secmail.REPLY_STATUS[encoded]]
	if len(args) == 3:
		# send back list of topics
		for i in secmail.ID_INDEX.keys():
			tips += "\t" + toplist[secmail.ID_INDEX[i]] + " - enter 'chat " + encoded + " " + i + "' to send\n"
		return [tips, current_time]
	else:
		# send topic
		var topicid = args[3]
		# check invalid topic id
		if not (topicid in secmail.ID_INDEX.keys()):
			return ["Invalid topic id.", current_time]
		var topicindex = secmail.ID_INDEX[topicid]
		if topicindex >= len(toplist):
			return ["Invalid topic id.", current_time]
		# send and reduce time
		current_time -= 1
		tips += "YOU -> " + encoded + "(" + secmail.CHAT_ALIAS[encoded] + "): " + secmail.REPLY_CONTENT[toplist[topicindex]] + "\n"
		tips += "Waiting for response...\n"
		# get reply if chat active
		if secmail.CHAT_STATUS[encoded]:
			var chatreply = secmail.REPLY_CODES[encoded][toplist[topicindex]]
			if not (chatreply in secmail.END_CODES):
				secmail.REPLY_STATUS += 1
			# end chat if terminated
			else:
				secmail.CHAT_STATUS[encoded] = false
			# reply if any
			tips += encoded + "(" + secmail.CHAT_ALIAS[encoded] + ") -> YOU: " + secmail.REPLY_CONTENT[chatreply] + "\n"
			# get flag for finishing convo
			if chatreply in secmail.FLAG_END:
				flags[secmail.FLAG_END[chatreply]] = true
		return [tips, current_time]

func reverse_encode(args):
#	'''
#	unicode decode
#	'''
	var flags = args[0]
	var current_time = args[1]
	var encoded = args[2]
	# check if in mem
	if not (encoded in decodes.CODE_KEYMAP.keys()):
		return ["Result: <gibberish>", current_time]
	return ["Result: " + decodes.CODE_KEYMAP[encoded], current_time]

func chibi(args):
#    '''
#    Returns string of result
#    '''
	var flags = args[0]
	var current_time = args[1]
	var tips
	if not is_flag_triggered(flags,"Another CHIBI"):
		tips =  "Running self replication sequence... Success. Scanning network for next target... Success\nInitializing persona code 'chibisuke'... Success. Initializing file transfer to target... Success\nMessage: mission not fulfilled, please run mission"
		flags["Another CHIBI"] = true
		current_time -= 2
	else:
		tips = "Code assembled. File transfer already in progress\nMessage: mission not fulfilled, please run mission"
	return [tips, current_time]

func notes(args):
#    '''
#    Returns string of helpful notes
#    '''
	var current_time = args[1]
	if len(args) == 2:
		return ["Enter:\n\n\tnotes general: general stuff\n\n\tnotes demtube: demtube schedule\n\n\tnotes work: work schedule", current_time]
#		return [actions_help.GENERAL_HELP + "\n\n" + actions_help.DEMTUBE_HELP + "\n\n" + actions_help.WORK_HELP, current_time]
	else:
		var key = args[2]
		if key in ["general","demtube","work"]:
			if key == "general":
				return [actions_help.GENERAL_HELP, current_time]
			elif key == "demtube":
				return [actions_help.DEMTUBE_HELP, current_time]
			else:
				return [actions_help.WORK_HELP, current_time]
		else:
			return ["Notes not found", current_time]


func save(args):
#    '''
#    Saves game
#    '''
	var flags = args[0]
	var current_time = args[1]
	if len(args) == 2:
		var tips = saving.read_save()
		if tips != 'Unable to load save file':
			tips += "\nEnter save [slot index] to save to/overwrite a save slot"
		return [tips, current_time]
	else:
		var slot_index = str(args[2])
#		if args[2].strip_edges() == "0":
#			slot_index = 0
#		else:
#			slot_index = int(args[2].strip_edges())
#			if slot_index != 0:
#				if not (slot_index in range(saving.TOTAL_SAVE_SLOT)):
#					return ['Invalid slot index', current_time]
#			else:
#				return ['Slot index must be a number', current_time]
		var save_success = saving.save_data_to_file(flags,current_time,flag_contact,
			day_check,decrypt_track,blocks.BLOCKS,blocks.BLOCKS_ROOT,blocks.BLOCKS_SPECIAL_TWO,blocks.BLOCKS_SPECIAL_THREE,blocks.BLOCKS_NEW,
			decodes.KEYFLAG,logs_new.LOGS_NEW,logs_new.LOG_NEED_REPLIES,logs_new.LOG_ATTACHMENT,slot_index, SECTION_DATA)
		if save_success:
			return ['Game saved', current_time]
		else:
			return ['Unable to save', current_time]
	return ["This function is not yet supported", current_time]

func load_dictionary(dict_from, dict_to):
#    '''
#    Copies dict_from into dict_to
#    Returns dict_to
#    '''
	# remove all flags not set in loaded data
	for item in dict_to.keys():
		if not item in dict_from.keys():
			dict_to.erase(item)
	# adjust/add flags set in loaded data
	for item in dict_from.keys():
		dict_to[item] = dict_from[item]
	return dict_to

func load_game(args):
#    '''
#    Loads game
#    '''
	var flags = args[0]
	var current_time = args[1]
	if len(args) == 2:
		var tips = saving.read_save()
		if not tips[0]:
			return ['Unable to open save files', current_time]
		else:
			return ['Opening load menu', current_time]
	else:
		var slot_index = str(args[2])
#		if args[2] != 'restart':
#			if args[2].strip_edges() == "0":
#				slot_index = 0
#			else:
#				slot_index = int(args[2].strip_edges())
#				if slot_index != 0:
#					if not (slot_index in range(saving.TOTAL_SAVE_SLOT)):
#						return ['Invalid slot index', current_time]
#				else:
#					return ['Slot index must be a number', current_time]
#		else:
#			slot_index = args[2]
		# check data can be loaded
		var DATA_SAVES = saving.read_data_from_file()
		if DATA_SAVES['Success'] != 1:
			return ['Unable to open save files', current_time]
		DATA_SAVES = DATA_SAVES['data']
		slot_index = str(slot_index)
		if DATA_SAVES[slot_index]['Filled'] != 1:
			return ['No data in that slot', current_time]

		# load data
		flags = load_dictionary(DATA_SAVES[slot_index]["FLAGS"],flags)
		current_time = int(DATA_SAVES[slot_index]["TIME"])
		flag_contact = int(DATA_SAVES[slot_index]["CONTACTCOUNT"])
		day_check = load_dictionary(DATA_SAVES[slot_index]["DAYCHECK"],day_check)
		decrypt_track = {}
		for i in DATA_SAVES[slot_index]["DECRYPT"]:
			decrypt_track[i] = int(DATA_SAVES[slot_index]["DECRYPT"][i])
		blocks.BLOCKS = load_dictionary(DATA_SAVES[slot_index]["BLOCKS"],blocks.BLOCKS)
		blocks.BLOCKS_ROOT = load_dictionary(DATA_SAVES[slot_index]["BLOCKSROOT"],blocks.BLOCKS_ROOT)
		blocks.BLOCKS_SPECIAL_TWO = load_dictionary(DATA_SAVES[slot_index]["BLOCKSTWO"],blocks.BLOCKS_SPECIAL_TWO)
		blocks.BLOCKS_SPECIAL_THREE = load_dictionary(DATA_SAVES[slot_index]["BLOCKSTHREE"],blocks.BLOCKS_SPECIAL_THREE)
		blocks.BLOCKS_NEW = load_dictionary(DATA_SAVES[slot_index]["BLOCKSNEW"],blocks.BLOCKS_NEW)
		decodes.KEYFLAG = load_dictionary(DATA_SAVES[slot_index]["DECODES"],decodes.KEYFLAG)
		logs_new.LOGS_NEW = load_dictionary(DATA_SAVES[slot_index]["LOGSNEW"],logs_new.LOGS_NEW)
		logs_new.LOG_NEED_REPLIES = load_dictionary(DATA_SAVES[slot_index]["LOGSREPLY"],logs_new.LOG_NEED_REPLIES)
		logs_new.LOG_ATTACHMENT = load_dictionary(DATA_SAVES[slot_index]["LOGSATTACHMENT"],logs_new.LOG_ATTACHMENT)
		SECTION_DATA = DATA_SAVES[slot_index]['SECTIONDATA']
		end_result = 0

		if slot_index == 'restart':
			return ['Game restarted', current_time]
		return ['Game loaded', current_time]
		
	return ["This function is not yet supported", current_time]

func overspace(args):
#    '''
#    Returns string of result
#    '''
	var flags = args[0]
	var current_time = args[1]
	current_time -= 2
	if is_flag_triggered(flags,"Admin radio ok"):
		flags["MISSION END"] = true
		return ["Attempting to connect. . . . . . . . . . . . . . . . . . . . . Success", current_time]
	else:
		return ["Attempting to connect. . . . . . . . . . . . . . . . . . . . . . . . .", current_time]

func time_change(args):
#    '''
#    Returns string of result, and new time
#    '''
	var flags = args[0]
	var current_time = args[1]
	var terminal_id = args[2]
	if terminal_id != "chibisuke@vsp.tc":
		return ["Error. Security warning", current_time]
	else:
		if is_flag_triggered(flags,"Hack Chibi"):
			return ["Already done", current_time]
		# raise linked flag
		flags["Hack Chibi"] = true
		# update time
		current_time -= 2
		return ["Success. Log replication may occur", current_time ]

func is_flag_triggered(flags, flagname):
#    '''
#    Returns bool if flag is set
#    '''
	if flagname in flags.keys():
		return flags[flagname]
	return false

func can_reply(flags,reply_id):
#    '''
#    Returns bool if reply can be used, based on flags
#    '''
	if reply_id in logs_new.LOG_NEED_FLAGS.keys():
		var flag_needed = logs_new.LOG_NEED_FLAGS[reply_id]
		return is_flag_triggered(flags,flag_needed)
	return true


func save_attachment(args):
#    '''
#    Returns string of result
#    '''
	var flags = args[0]
	var current_time = args[1]
	var log_id = args[2]
	# narrow down wrong id
	if len(log_id) != 6:
		return ["Invalid log id", current_time]
	# narrow down log that can be downloaded from (flags)
	if not can_log_exist(flags, log_id):
		return ["That log does not exist", current_time]
	# narrow down log that can be replied to (using log time)
	var time_window = find_time_window(current_time)
	if not (log_id in logs_new.LOG_TIME[time_window]):
		return ["Cannot save attachment from that log at this time", current_time]
	# narrow down log with attachment
	if log_id in logs_new.LOG_ATTACHMENT.keys():
		logs_new.LOG_ATTACHMENT[log_id] = true
		if log_id == "061101":
			flags["p5-9"] = true
			decodes.KEYFLAG["do.bpt"] = true
			decodes.KEYFLAG["not.bpt"] = true
			decodes.KEYFLAG["forget.bpt"] = true
		elif log_id == "061201":
			decodes.KEYFLAG["catgirl.bpt"] = true
		else:
			if is_flag_triggered(flags,"Cohab") or is_flag_triggered(flags,"Cohab@"): 
				decodes.KEYFLAG["Cohab.clf"] = true
			if is_flag_triggered(flags,"Bpaint") or is_flag_triggered(flags,"Bpaint@"): 
				decodes.KEYFLAG["last_piece.bpt"] = true
			if is_flag_triggered(flags,"p5-9") and decodes.KEYFLAG["last_piece.bpt"]: 
				decodes.KEYFLAG["chibi.exe"] = true
		return ["Attachment saved. Enter help files to check", current_time]
	return ["No attachment found", current_time]
	
func find_time_window(curr_time):
	var time_list = []
	for item in logs_new.LOG_TIME:
		if curr_time - 4 <= item:
			time_list.append(item)
	var min_cp = [time_list[0], time_list[0] - curr_time]
	for item in time_list:
		if item - curr_time < min_cp[1]:
			min_cp[0] = item
			min_cp[1] = item - curr_time
	return min_cp[0]

func reply(args):
#    '''
#    Returns either string of result or possible replies to make
#    '''
	var flags = args[0]
	var current_time = args[1]
	var log_id = args[2]

	# narrow down wrong id
	if len(log_id) != 6:
		return ["Invalid log id", current_time]
	# narrow down log that can be replied to (using log time)
	var time_window = find_time_window(current_time)
	if not (log_id in logs_new.LOG_TIME[time_window]):
		return ["Cannot reply to that log at this time", current_time]
	# narrow down log that can be replied to
	if not (log_id in logs_new.LOG_NEED_REPLIES.keys()):
		return ["Cannot reply to that log", current_time]
	# narrow down log that hasn't been replied to
	if not logs_new.LOG_NEED_REPLIES[log_id]:
		return ["Log is already replied", current_time]
	# narrow down log that can be replied to (flags)
	if not can_log_exist(flags, log_id):
		return ["That log does not exist", current_time]
	
	var reply_id = logs_new.LOG_LINK_REPLIES[log_id]
	var reply_ids = []
	# filter replies by flags
	var possible_reply_codes = []
	for item in logs_new.LOG_REPLIES:
		if can_reply(flags,item):
			possible_reply_codes.append(item)
	# filter replies by log_id
	for repcode in possible_reply_codes:
		if repcode.substr(0,6) == reply_id and repcode[6] != "i":
			reply_ids.append(repcode)

	if len(args) == 3:
		var result = ">>> Enter reply " + log_id + " followed by reply code. For eg: reply " + log_id + " a "
		for code in reply_ids:
			result += "\n" + code[6] + ": " + logs_new.LOG_REPLIES[code]
		return [result, current_time]
	else:
		var reply_code = reply_id + args[3]
		if not (reply_code in reply_ids):
			return ["Invalid reply code", current_time]
		# update reply and flag
		logs_new.LOGS_NEW[reply_id] = "REPLY: " + logs_new.LOG_REPLIES[reply_code]
		logs_new.LOG_NEED_REPLIES[log_id] = false
		if reply_code in logs_new.LOG_GIVE_FLAGS.keys():
			flags[logs_new.LOG_GIVE_FLAGS[reply_code]] = true
		# update time
		current_time -= 1
		return ["Reply sent", current_time]

func demtube(args):
#    '''
#    Returns string of show watched
#    '''
	var flags = args[0]
	var current_time = args[1]
	var hour_list = schedule.DEMTUBE.keys()
	for i in range(len(hour_list)):
		var hour = hour_list[i]
		if current_time >= hour:
			# raise linked flag
			if hour in flag_demtube_triggers.keys():
				flags[flag_demtube_triggers[hour]] = true
			# update time
			current_time -= 1
			return [[hour, "Currently showing:\n" + schedule.DEMTUBE[hour]], current_time]

func update_block_status(block_id,group_id):
#    '''
#    Updates block status
#    '''
	if group_id == 0:
		blocks.BLOCKS[block_id] = true
	if group_id == 2:
		blocks.BLOCKS_SPECIAL_TWO[block_id] = true
	if group_id == 3:
		blocks.BLOCKS_ROOT[block_id] = true
	if group_id == 4:
		blocks.BLOCKS_SPECIAL_THREE[block_id] = true

func can_block_be_decrypted(flags, current_time, block_id):
#    '''
#    Returns bool whether block can be decrypted
#    '''
	if block_id in blocks.BLOCKS_ROOT and not is_flag_triggered(flags,'Root Access'):
		return false
	if block_id in blocks.BLOCKS_SPECIAL_TWO and current_time > 24:
		return false
	if block_id in blocks.BLOCKS_SPECIAL_THREE and current_time > 12:
		return false
	return true

func decrypt(args):
#    '''
#    Returns string of result
#    '''
	var flags = args[0]
	var current_time = args[1]
	var block_id = args[2]
	var block_group = is_in_which_block_group(block_id)
	if not (block_group in [0,1,2,3,4]): 
		return ["Block not found", current_time]
	if block_group == 1:
		return ["That block is not encrypted", current_time]
	if can_block_be_read(flags,block_id,block_group,current_time):
		return ["Block already decrypted", current_time]
	# check whether block can be decrypted
	if len(decrypt_track.keys()) == 6:
		return ["Decrypt capacity full", current_time]
	if not can_block_be_decrypted(flags,current_time,block_id):
		return ["Block is inaccessible", current_time]
	# check if alr decrypting
	if block_id in decrypt_track.keys():
		return ["Block is already being decrypted - " + str(decrypt_track[block_id]) + " units left", current_time]
	# set timer tracker
	decrypt_track[block_id] = 8
	return ["Block " + block_id + " has been added to the decryption queue - " + str(decrypt_track[block_id]) + " units left", current_time]

func get_log_content(log_id, is_old):
#    '''
#    Returns string in log
#    '''
	if is_old:
		return logs.LOGS[log_id]
	else:
		return logs_new.LOGS_NEW[log_id]

func address_to_name(address_string):
#    '''
#    Returns name corresponding to address
#    '''
	return address_string
	# if address_string in list(actions_help.ADDRESS_TO_NAME.keys()):
	#     return actions_help.ADDRESS_TO_NAME[address_string]
	# return "Unknown"

func get_log_info(log_id, is_old):
#    '''
#    Returns sender/recipient string of log
#    '''
	if is_old:
		var sender = 'Unknown'
		var receiver = "Unknown"
		for address in logs.LOGS_SENDER.keys():
			if log_id in logs.LOGS_SENDER[address]:
				sender = address
				break
		for address in logs.LOGS_RECIPIENT.keys():
			if log_id in logs.LOGS_RECIPIENT[address]:
				receiver = address
				break
		return "Log " + log_id + "\nFrom " + address_to_name(sender) + "\nTo " + address_to_name(receiver)
	else:
		for address in logs_new.LOGS_NEW_ADDRESS.keys():
			if log_id in logs_new.LOGS_NEW_ADDRESS[address]:
				return "Log " + log_id + "\n" + from_or_to(log_id) + address_to_name(address)
		return "Log " + log_id + "\nUnknown"
		
func from_or_to(log_id):
	for item in logs_new.LOG_LINK_REPLIES:
		var repID = logs_new.LOG_LINK_REPLIES[item]
		if log_id == repID:
			return "To "
	return "From "

func log_reply_status(log_id, current_time):
#    '''
#    Returns 0 is no reply needed, 1 is reply needed, 2 if reply expired, 3 if attachment expired
#    '''
	# narrow down log that can be replied to (using log time)
	var time_window = find_time_window(current_time)
	# check if its a reply or attachment needed
	if log_id in logs_new.LOG_ATTACHMENT.keys():
		if log_id in logs_new.LOG_TIME[time_window]:
			return 0
		else:
			return 3
	# narrow down log that can be replied to 
	if not (log_id in logs_new.LOG_NEED_REPLIES.keys()):
		return 0
	# narrow down log that is already replied
	if not logs_new.LOG_NEED_REPLIES[log_id]: 
		return 0

	if not (log_id in logs_new.LOG_TIME[time_window]):
		return 2
	return 1

func can_block_be_read(flags, block_id, group_id, current_time):
#    '''
#    Return bool whether block can be read
#    '''
	if group_id == 0:
		return blocks.BLOCKS[block_id]
	if group_id == 2:
		return blocks.BLOCKS_SPECIAL_TWO[block_id] and current_time <= 24
	if group_id == 3:
		return blocks.BLOCKS_ROOT[block_id] and is_flag_triggered(flags, "Root Access")
	if group_id == 4:
		return blocks.BLOCKS_SPECIAL_THREE[block_id] and current_time <= 12
	return false

func is_in_which_block_group(block_id):
#    '''
#    Returns integer indicating which block group does block id belongs to
#    '''
	if block_id in blocks.BLOCKS.keys():
		return 0 # original blocks
	if block_id in blocks.BLOCKS_NEW.keys():
		return 1 # new blocks
	if block_id in blocks.BLOCKS_SPECIAL_TWO.keys():
		return 2 # day 2+ blocks
	if block_id in blocks.BLOCKS_ROOT.keys():
		return 3 # root blocks
	if block_id in blocks.BLOCKS_SPECIAL_THREE.keys():
		return 4 # day 3+ blocks
	return -1

func read(args):
#    '''
#    Returns string of result, whether it is read block or read log
#    '''
	var flags = args[0]
	var current_time = args[1]

	var block_id = args[2]
	# check whether new or old block
	var block_group = is_in_which_block_group(block_id)
	var is_old_block = not (block_group == 1)
	# return result if not found
	if block_group == -1:
		return ["Block not found", current_time]
	# return result of if locked
	if is_old_block:
		if not can_block_be_read(flags,block_id,block_group,current_time):
			return ["Block may be locked or inaccessible", current_time]
	else:
		if not blocks.BLOCKS_NEW[block_id]:
			return ["Block is unavailable at this time", current_time]
	var log_list = read_block(flags,current_time,block_id,is_old_block,block_group)
	var result = "Block " + block_id
	for i in range(len(log_list)):
		var log_id = log_list[i]
		result += "\n\n" + get_log_info(log_id,is_old_block)
		result += "\n\t" + get_log_content(log_id,is_old_block)
		# reply status
		var reply_status = log_reply_status(log_id,current_time)
		if reply_status == 2:
			result += "\n\tReply EXPIRED"
		elif reply_status == 1:
			result += show_possible_replies(flags,current_time,log_id)
		elif reply_status == 3:
			result += "\n\tATTACHMENT EXPIRED"
	return [result, current_time]

func show_possible_replies(flags, current_time, log_id):
#    '''
#    Returns string of possible replies to a log
#    '''
	return "\n>>> Enter reply " + log_id + " for replies"
	# reply_id = logs_new.LOG_LINK_REPLIES[log_id]
	# reply_ids = []
	# # filter replies by flags
	# possible_reply_codes = list(filter(lambda item: can_reply(flags,item), list(logs_new.LOG_REPLIES.keys())))
	# # filter replies by log_id
	# for repcode in possible_reply_codes:
	#     if repcode[:6] == reply_id and repcode[6] != "i":
	#         reply_ids.append(repcode)
	# result = "\n>>> Enter reply " + log_id + " followed by reply code. For eg: reply " + log_id + " a "
	# for code in reply_ids:
	#     result += "\n\t" + code[6] + ": " + logs_new.LOG_REPLIES[code] + "; "
	# return result


func read_log(flags,current_time):
#    '''
#    Returns log_id of latest log received
#    '''
	# get list of time
	var time_list = []
	for item in logs_new.LOG_TIME.keys():
		if current_time - 4 <= item:
			time_list.append(item)
	# sort log id by number (chronological)
	var id_list = logs_new.LOGS_NEW.keys()
	# filter log by time (logs that are visible by current time)
	var log_list = []
	for index in range(len(id_list)):
		var i = id_list[len(id_list) - 1 - index]
		for time in time_list:
			if i in logs_new.LOG_TIME[time]:
				log_list.append(i)
				break
	# remove empty log/log not written yet
	var log_list2 = []
	for item in log_list:
		if logs_new.LOGS_NEW[item] != "":
			log_list2.append(item)
	# remove log that should not exist based on flags
	var log_list3 = []
	for item in log_list2:
		if can_log_exist(flags,item):
			log_list3.append(item)
	return log_list3[0]

func can_log_exist(flags,log_id):
#    '''
#    Returns bool whether log can exist based on flags
#    '''
	if not (log_id in logs_new.LOG_NEED_FLAGS.keys()): 
		return true
	var flag_needed = logs_new.LOG_NEED_FLAGS[log_id]
	return flag_needed in flags

func read_block(flags,current_time,block_id,is_old,group_id):
#    '''
#    Returns list of log IDs
#    '''
	var block_list = []
	
	if is_old:
		# get all matching log IDs
		var id_list = logs.LOGS.keys()
		for i in range(len(id_list)):
			if id_list[i].substr(0,4) == block_id:
				block_list.append(id_list[i])
	else:
		var match_list = []
		# get all matching log IDs
		var id_list = logs_new.LOGS_NEW.keys()
		for i in range(len(id_list)):
			if id_list[i].substr(0,4) == block_id:
				match_list.append(id_list[i])
		# filter logs by time
		var time_list = []
		for item in logs_new.LOG_TIME.keys():
			if item >= current_time - 4:
				time_list.append(item)
		for i in match_list:
			for time in time_list:
				if i in logs_new.LOG_TIME[time]:
					block_list.append(i)
					break
		# remove empty log/log not written yet
		var log_list2 = []
		for item in block_list:
			if logs_new.LOGS_NEW[item] != "":
				log_list2.append(item)
		# remove log that should not exist based on flags
		var log_list3 = []
		for item in log_list2:
			if can_log_exist(flags,item):
				log_list3.append(item)
				
		block_list = log_list3

	return block_list

func work(args):
#    '''
#    Returns string of data cleaned up
#    '''
	var flags = args[0]
	var current_time = args[1]
	var hour_list = schedule.WORK.keys()
	for i in range(len(hour_list)):
		var hour = hour_list[i]
		if current_time >= hour:
			# raise linked flag
			if hour in flag_work_triggers.keys():
				flags[flag_work_triggers[hour]] = true
			# update time
			current_time -= 1
			return ["Work in progress...\n\nData summary: " + schedule.WORK[hour], current_time]

func remote_access(args):
#    '''
#    Returns string of result
#    '''
	var flags = args[0]
	var current_time = args[1]
	var username = args[2]
	var password = args[3]
	if username == "Ananth":
		return [remotestuff.RESULTS["Chibi"], current_time]
	if username in remotestuff.CREDENTIALS.keys():
		if password == remotestuff.CREDENTIALS[username]:
			# raise linked flag
			if username == "Cassilin":
				flags["Hack Cass"] = true
			elif username == "Luvluv":
				flags["Hack Luv"] = true
			# update time
			current_time -= 2
			return [remotestuff.RESULTS[username], current_time]
		else:
			return ["Wrong password", current_time]
	else:
		return ["Username not found", current_time]

func contact(args):
#    '''
#    Returns network not found message
#    '''
	var flags = args[0]
	var current_time = args[1]
	var wavelength = args[2]
	# update flag count
	if wavelength in contact_red:
		flag_contact += 1
	if flag_contact == 4:
		flags["WIPED"] = true
	# update time
	current_time -= 1
	return ["Network not found", current_time]

func backup(args):
	# instant death
	var flags = args[0]
	var current_time = args[1]
	flags["REVENGE"] = true
	return ["Gotcha, bastard.", current_time]
	
func archive(args):
#	'''
#	Returns list of archive
#	'''
	var flags = args[0]
	var current_time = args[1]
	
	var tips = "Archive status:"
	# basic blocks
	tips += "\n\n----- COMMON -----\n"
	for item in blocks.BLOCKS.keys():
		tips += "\n" + str(item)
		if blocks.BLOCKS[item]: tips += " - Decrypted"
		elif item in decrypt_track.keys(): tips += " - Decrypting (" + str(decrypt_track[item]) + " units left)"
		else: tips += " - Decrypt to read"
	# day 2 blocks
	if current_time <= 24:
		for item in blocks.BLOCKS_SPECIAL_TWO.keys():
			tips += "\n" + str(item)
			if blocks.BLOCKS_SPECIAL_TWO[item]: tips += " - Unlocked"
			elif item in decrypt_track.keys(): tips += " - Decrypting (" + str(decrypt_track[item]) + " units left)"
			else: tips += " - Locked"
	if current_time <= 12:
		for item in blocks.BLOCKS_SPECIAL_THREE.keys():
			tips += "\n" + str(item)
			if blocks.BLOCKS_SPECIAL_THREE[item]: tips += " - Unlocked"
			elif item in decrypt_track.keys(): tips += " - Decrypting (" + str(decrypt_track[item]) + " units left)"
			else: tips += " - Locked"
	# day 3 blocks
	# root blocks
	if is_flag_triggered(flags,"Root Access"):
		tips += "\n\n----- HIDDEN -----\n"
		for item in blocks.BLOCKS_ROOT.keys():
			tips += "\n" + str(item)
			if blocks.BLOCKS_ROOT[item]: tips += " - Decrypted"
			elif item in decrypt_track.keys(): tips += " - Decrypting (" + str(decrypt_track[item]) + " units left)"
			else: tips += " - Decrypt to read"
	else:
		tips += "\n\n(some blocks may not be accessible unless you have admin privilage)"
	return [tips, current_time]
	
func files(args):
#	'''
#	Returns list of files
#	'''
	
	var flags = args[0]
	var current_time = args[1]
	
	var tips = "Files in memory:\n\t"
	for item in decodes.KEYFLAG.keys():
		if decodes.KEYFLAG[item]:
			tips += item + " "
	if is_flag_triggered(flags,"Remote Access"):
		tips += "remote.exe "
	if is_flag_triggered(flags,"Change Time"):
		tips += "time.exe "
	if is_flag_triggered(flags,"Decoder"):
		tips += "decode.exe "
	if is_flag_triggered(flags,"Assembled"):
		tips += "chibi.exe "
	if is_flag_triggered(flags,"Decode Cohab's relic"):
		tips += "overspace.exe "
	if is_flag_triggered(flags, "Real hack stuff"):
		tips += "hack.exe "
	elif is_flag_triggered(flags, "Fake hack stuff"):
		tips += "haxx.exe "
	return [tips, current_time]

func commands(args):
#	'''
#	Returns list of game commands
#	'''
	var flags = args[0]
	var current_time = args[1]
	
	var tips = actions_help.get_possible_commands(flags)
	return [tips, current_time]

func help(args):
#    '''
#    Returns game tips
#    '''
	var flags = args[0]
	var current_time = args[1]
	
	var tips  = "Terminal: Nekoi\nAddress: cat_fish@vsp.tc"
	tips += "\n\nRead logs and reply on time, or get sacked."
	tips += "\n\nTo work or not to work -> notes work"
	tips += "\n\nIf bored -> demtube"
	tips += "\n\nIf amnesiac -> commands"
	
	# TO DO: make this first default message
	tips += "\n\n???Message: enterread0000"
	tips += "\n???Mission: contactoverspace\n???Need: donotforgetlastpiece"
	return [tips, current_time]
	
func decode(args):
#    '''
#    Return string of result
#    '''
	var flags = args[0]
	var current_time = args[1]
	var file_name = args[2]
	var key = args[3]
	if not (file_name in decodes.KEYMAP.keys()):
		return ["Unable to decode", current_time]
	if not decodes.KEYFLAG[file_name]:
		return ["Cannot find file", current_time]
	if key != decodes.KEYMAP[file_name]:
		return ["Invalid key", current_time]
	# raise linked flag
	if file_name == "catgirl.bpt":
		flags["Decode Luca's relic"] = true
	elif file_name == "Cohab.clf":
		flags["Decode Cohab's relic"] = true
	elif file_name == "chibi.exe":
		flags["Another story"] = true
	if file_name in decodes.DONEFLAG.keys():
		decodes.DONEFLAG[file_name] = true
	var bptpath = true
	for item in decodes.DONEFLAG.keys():
		if (item != "Cohab.clf") and not (decodes.DONEFLAG[item]):
			bptpath = false
			break
	if bptpath:
		flags["Decode all bitpaints"] = true

	# update time
	if is_flag_triggered(flags,'Decoder'):
		current_time -= 1
	else:
		current_time -= 2
	return [decodes.RESULTS[file_name], current_time]

func root(args):
#    '''
#    Returns string of result
#    '''
	var flags = args[0]
	var current_time = args[1]
	if is_flag_triggered(flags,"Root Access"):
		return ["Already enabled admin privilege", current_time]
	else:
		# raise linked flag
		flags["Root Access"] = true
		# update time
		current_time -= 2
		return ["Attempting to gain admin privilege. Success\nSyncing time settings. Success\nWelcome back, Nekoi", current_time]


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
