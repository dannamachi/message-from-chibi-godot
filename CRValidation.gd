extends Node

func check_ha_tables(args):
	return len(args) == 3
	
func check_ha_get(args):
	return len(args) == 4
	
func check_ha_commit(args):
	return len(args) == 3
	
func check_ha_update(args):

func check_ha_exit(args):
	
func check_ha_hash(args):
	
func check_hack(args):
#	'''
#	Returns bool if argument list is valid for run_hack(flags, current_time)
#	'''
	return len(args) == 3
	
func check_haxx(args):
#	'''
#	Returns bool if argument list is valid for run_haxx(flags, current_time)
#	'''
	return len(args) == 3

func check_chat(args):
	#    '''
	#    Returns bool if argument list is valid for secure_comm(flags,current_time,chat_id) or secure_comm(flags, current_time, chat_id, topic_id)
	#    '''
	return len(args) == 3 or len(args) == 4

func check_reverse(args):
	#    '''
	#    Returns bool if argument list is valid for reverse_encode(flags,current_time,log_id)
	#    '''
		return len(args) == 3

func check_attachment(args):
#    '''
#    Returns bool if argument list is valid for save_attachment(flags,current_time,log_id)
#    '''
	return len(args) == 3

func check_notes(args):
#    '''
#    Returns bool if argument list is valid for notes(flags,current_time) or notes(flags,current_time,key)
#    '''
	return len(args) == 2 or len(args) == 3

func check_dt(args):
#    '''
#    Returns bool if argument list is valid for demtube(flags,current_time)
#    '''
	return len(args) == 2

func check_decrypt(args):
#    '''
#    Returns bool if argument list is valid for decrypt(flags,current_time,block_id)
#    '''
	return len(args) == 3

func check_read(args):
#    '''
#    Returns bool if argument list is valid for read_block(flags,current_time,current_id)
#    '''
	return len(args) == 3

func check_work(args):
#    '''
#    Returns bool if argument list is valid for work(flags,current_time)
#    '''
	return len(args) == 2

func check_remote(args):
#    '''
#    Returns bool if argument list is valid for remote_access(flags,current_time,username,password)
#    '''
	return len(args) == 4

func check_contact(args):
#    '''
#    Returns bool if argument list is valid for contact(flags,current_time,wavelength)
#    '''
	return len(args) == 3

func check_help(args):
#    '''
#    Returns bool if argument list is valid for help(flags,current_time)
#    '''
	return len(args) == 2

func check_decode(args):
#    '''
#    Returns bool if argument list is valid for decode(flags,current_time,filename,key)
#    '''
	return len(args) == 4

func check_root(args):
#    '''
#    Returns bool if argument list is valid for root(flags,current_time)
#    '''
	return len(args) == 2

func check_reply(args):
#    '''
#    Returns bool if argument list is valid for reply(flags,current_time,log_id) or reply(flags,current_time,log_id,choice)
#    '''
	return len(args) == 3 or len(args) == 4

func check_time(args):
#    '''
#    Returns bool if argument list is valid for time_change(flags,current_time,terminal_id)
#    '''
	return len(args) == 3

func check_overspace(args):
#    '''
#    Returns bool if argument list is valid for overspace(flags,current_time)
#    '''
	return len(args) == 2

func check_save(args):
#    '''
#    Returns bool if argument list is valid for save(flags,current_time) or save(flags,current_time,index)
#    '''
	return len(args) == 2 or len(args) == 3

func check_load(args):
#    '''
#    Returns bool if argument list is valid for load(flags,current_time) or load(flags,current_time,index)
#    '''
	return len(args) == 2 or len(args) == 3

func check_chibi(args):
#    '''
#    Returns bool is argument list is valid for chibi(flags,current_time)
#    '''
	return len(args) == 2

func check_archive(args):
#    '''
#    Returns bool if argument list is valid for archive(flags,current_time)
#    '''
	return len(args) == 2
	
func check_files(args):
#    '''
#    Returns bool if argument list is valid for files(flags,current_time)
#    '''
	return len(args) == 2
	
func check_commands(args):
#    '''
#    Returns bool if argument list is valid for commands(flags,current_time)
#    '''
	return len(args) == 2


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
