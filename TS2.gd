extends Node2D

signal done

var finished = false
var got_reply = false


var replyDict = {
	"read 1234"  : "Block 1234:\n\nLog 123401:\n\nYou are reading logs from block 1234.\n\nLog 123402:\n\nEach of this is a message sent from one to another.\n\nLog 123403:\n\nIt is the method of communication for VSPs.\n\nLog 123404:\n\nWhen there are no new logs, you can spend time on other activities.\n\nTry entering 'demtube' below.",
	"demtube"    : "This is how you watch DemTube.\n\nThe technology of this world has allowed you to be able to get the gist of what you are watching in a couple sentences.\n\nConvenient?\n\nTry entering 'work' this time.",
	"work"       : "This is how you work.\n\nMainly just you deleting some old data.\n\nIt's all automated so don't you worry your pretty little head.\n\nThe system obviously deems it unnecessary for you to know the actual data, so all you have is a short summary if the data being deleted.\n\nNow, why don't you try reading block 5678?\n\nTip: read abcd",
	"read 5678"  : "Block 5678:\n\nLog 567801:\n\nOh finally. This is block 5678.\n\nLog 567802:\n\nSometimes you will come across block number like ?***. In those cases, the block number has been corrupted so it's not showing properly, but you can just copy paste the block number as is.\n\nLog 567803:\n\nJust in case you haven't noticed, you can copy paste text around.",
	"read ?***"  : "Block ?***:\n\nLog ?***01:\n\nWow, you replayed the tutorial and found this thing? Then let me reward you... with a character introduction by yours truly.\n\nLog ?***02: Try reading block chibi, cass, nekoi, and luv.",
	
	"read chibi" : "Chibi\n\nchibisuke@vsp.tc\n\nkid who's got a virus, just bear with him for a while",\
	"read nekoi" : "Nekoi\n\ncat_fish@vsp.tc\n\nyours truly, always awesome",\
	"read cass"  : "Cass\n\ndt_81@fpu.tc\n\nhistory nerd, knows too much for her own good, expert with numbers",\
	"read luv"   : "Luv\n\nem_81$fpu.tc\n\nchannel admin, likes kitts, cannot drink but drinks anyway"
}

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
var replyReq = {
	"demtube"       : "read 1234",
	"work"          : "demtube",
	"read 5678"     : "work",
	
	"read chibi"    : "read ?***",
	"read nekoi"    : "read ?***",
	"read cass"     : "read ?***",
	"read luv"      : "read ?***"
}

var replyFlag = {
	"read 1234"  : false,
	"demtube"    : false,
	"work"       : false,
	"read ?***"  : false
}


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_LineEdit_text_entered(new_text):
	$LineEdit.clear()
	if not finished:
		var log_text = new_text.strip_edges()
		if not log_text in replyDict:
			log_text = log_text + "\nThat's not it, try again."
		else:
			var can_run = true
			if log_text in replyReq:
				if not replyFlag[replyReq[log_text]]:
					log_text = log_text + "\nDon't even try."
					can_run = false
			if can_run:
				if log_text == "read 5678":
					$TextEdit.text = replyDict[log_text]
					$LineEdit.placeholder_text = "You're done, next!"
					finished = true
					$Button.disabled = false
					$Button.show()
				else:
					$TextEdit.text = replyDict[log_text]
				
				if log_text in replyFlag:
					replyFlag[log_text] = true

		$TextEdit2.text += "\n> " + log_text
		$TextEdit2.scroll_vertical = len($TextEdit2.text.split("\n")) - 1




func _on_Button_pressed():
	emit_signal("done")
