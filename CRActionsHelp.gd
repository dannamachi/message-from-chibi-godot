extends Node

var GENERAL_HELP = """1 block = 1 day = 12 time units (from unit 0 to unit 12)\n
Log reply ticket expires in 2-4 units\n
Reply regularly (except for CASS, she's a chatterbox)\n
Info can be hidden anywhere so try unlocking everything"""

var DEMTUBE_HELP = """Demtube schedule:
	D1 0 - 2   : getting admin privilege
	D1 5 - 8   : encryption (note: good for bluffing)
	D1 9 - 10  : remote access tech (note: good for getting secret numbers)
	D2 0 - 2   : weird machines (note: LUV's favourite)
	D3 1 - 4   : decoding tech"""

# TO DO: dialogue to say that secure chat has always been there but disabled
var WORK_HELP = """Work schedule:
	D2 1 - 2   : something hidden by the govt
	D2 3 - 4   : prank to change the time (note: get them to send stuff twice)
	D2 9 - 10  : the truth of cybermite (note: does LUV need to know this?)
	D3 1 - 2   : idea for secret communication (note: upgrade secure chat?)
	D3 11 - 12 : suicide note from an aeternist"""

var ADDRESS_TO_NAME = {\
	"chibisuke@vsp.tc"   : "weird kid",\
	"cat_fish@vsp.tc"    : "me",\
	"dt_81@fpu.tc"       : "CASS",\
	"em_81@fpu.tc"       : "LUV",\
}

var CONTACT_COMMENTS = {\
	"chibisuke@vsp.tc"   : "kid who's got a virus, just bear with him for a while",\
	"cat_fish@vsp.tc"    : "always awesome",\
	"dt_81@fpu.tc"       : "history nerd, knows too much for her own good, expert with numbers",\
	"em_81@fpu.tc"       : "channel admin, likes kitts, cannot drink but drinks anyway",\
}

func is_flag_triggered(flags, flagname):
#    '''
#    Returns bool if flag is set
#    '''
	if flagname in flags.keys():
		return flags[flagname]
	return false

func get_contacts():
#    '''
#    Returns string with character info
#    '''
	var tips = "Address list: <Sorted: Recent>"
	for address in ADDRESS_TO_NAME.keys():
		tips += "\n" + address + " - " + ADDRESS_TO_NAME[address] + ": " + CONTACT_COMMENTS[address]
	return tips

func get_possible_commands(flags):
#    '''
#    Returns string with possible commands
#    '''
	var tips = ""
	tips += "----- BASIC -----\n\n"
	tips += "read: read logs of the day\n\n"
	tips += "read abcd: read logs in block abcd\n\n"
	tips += "reply abcdef: reply to log abcdef\n\n"
	tips += "download abcdef: save attachment from log abcdef\n\n"
	tips += "demtube: entertainment\n\n"
	tips += "work: self explanatory\n\n"
	
	tips += "----- HELP -----\n\n"
	tips += "help: what to do\n\n"
	tips += "commands: list of commands\n\n"
	
	tips += "----- ADVANCED -----\n\n"
	tips += "files: list of files\n\n"
	tips += "archive: old stuff\n\n"
	tips += "notes: notes on stuff\n\n"
	tips += "decrypt abcd: decrypt block abcd\n\n"
	tips += "unlock a.file password: unlock a.file with password"
	if is_flag_triggered(flags,"Decoder"):
		tips += " (quick)"
	tips += "\n\n"
	
	tips += "----- OTHER -----\n\n"
	if is_flag_triggered(flags,"Change Time"):
		tips += "time e@mail: change time of terminal with address e@mail\n\n"
	if is_flag_triggered(flags,"Remote Access"):
		tips += "remote someUID password: hack into another terminal of UID someUID with password\n\n"
	if is_flag_triggered(flags,"Assembled"):
		tips += "chibi: run special command\n\n"
	if is_flag_triggered(flags, "Real hack stuff"):
		tips += "hack: run program to access ID database\n\n"
	elif is_flag_triggered(flags, "Fake hack stuff"):
		tips += "haxx: run special command\n\n"
	if is_flag_triggered(flags,"Decode Cohab's relic"):
		tips += "overspace: connect to Overspace - make sure your connection is uninterrupted!\n\n"
	
	tips += "----- OTHER OTHER -----\n\n"
	tips += "save: save this session\n\n"
	tips += "load: load another session\n\n"
	tips += "quit: quit the session\n\n"
	return tips


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
