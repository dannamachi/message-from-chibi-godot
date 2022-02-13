extends Node

export var maxChar = 65
export var maxLine = 5

var saved_lines = []
var line_start = -1
var line_end = -1

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func get_text():
	var textget = ""
	for line in range(line_start,line_end):
		textget += saved_lines[line]
		if line < line_end:
			textget += "\n"
	return textget
	
func init(startLine="Session opened."):
	saved_lines = divide_into_lines(startLine, maxChar)
	line_start = 0
	line_end = len(saved_lines) - 1
	
func move_bottom():
	line_end = len(saved_lines)
	line_start = clamp(line_end - maxLine, 0, len(saved_lines) - 1)
	
func move_down():
	if line_end < len(saved_lines):
		line_start += 1
		line_end += 1
		
func move_up():
	if line_start > 0:
		line_start -= 1
		line_end -= 1

func append_line(new_line):
	var new_lines = divide_into_lines(new_line, maxChar)
	for line in new_lines:
		saved_lines.append(line)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func divide_into_lines(text_string, max_char):
#    Assumes text_string is sectioned by \n and word divided by space
#    Returns array of string
	# divide into sections by \n
	var sections = text_string.split('\n')
	var lines = []
	for section in sections:
		# get all words in section
		var words = section.split(' ')
		while true:
			var segment_string = ""
			# add word to segment string until reached max_char
			while true:
				# check still have word left
				if len(words) == 0:
					break
				if len(segment_string) + len(words[0]) > max_char:
					break
				segment_string += words[0] + " "
				words.remove(0)
			lines.append(segment_string)
			# check still have word left
			if len(words) == 0:
				break
			# TO DO: break up if there is a string > max_char
			if len(words[0]) > max_char:
				var breakword = words[0]
				words.remove(0)
				words.insert(0, breakword.substr(max_char))
				words.insert(0, breakword.substr(0,max_char))
	return lines

