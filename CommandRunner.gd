extends Node

onready var constants = get_node("CRapi/CRconstants")
onready var api = get_node("CRapi")

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	

func run_command_game(cmd, update=false):
	# process cmd text
	var command_list = cmd.strip_edges().split(' ')
	var command = -1
	if len(command_list) > 0:
		# check that command is valid for this section
		for num in constants.ACTIONS:
			var key = constants.ACTIONS[num]
			if command_list[0] == key:
				command = num
				break
	# if it is, set the corresponding arguments
	if command != -1:	
		var argument_list = []
		if len(command_list) > 1:
			for i in range(1,len(command_list)):
				argument_list.append(command_list[i])
		# run it!
		var results =  api.run_game_command(command,argument_list,update)
		return [command, results[0], results[1]]
		
	return [command, "Command not found", constants.SECT_MSG]
		
func run_load_command(slotID):
	return api.run_command(12, [slotID])
	
func run_save_command(slotID):
	return api.run_command(11, [slotID])
	
func run_restart_command():
	return api.run_command(12, ['restart'])

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
