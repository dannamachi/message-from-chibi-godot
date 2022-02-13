extends Node


# dimensions
var SCREEN_SIZE = [1280,720]
var RECT_MUSIC = [0,SCREEN_SIZE[1] - 50,50,50]

# page id
var PAGE_MAIN = 0
var PAGE_SAVE = 1
var PAGE_LOAD = 2
var PAGE_GAME = 3
var PAGE_END  = 4
var PAGE_CRED = 5


# section id
var SECT_CLI = 0
var SECT_MSG = 1
var SECT_END = 2
var SECT_READ = 4
var SECT_NOTE = 3
var SECT_HELP = 5
var SECT_MAIN = 6
var SECT_LOAD = 7
var SECT_SAVE = 8
var SECT_CRED = 9
var SECT_WATCH = 10
var SECT_WORK = 11

# actions
var ACTIONS = {
	0  : "demtube",
	1  : "decrypt",
	2  : "read",
	3  : "work",
	4  : "admin",
	5  : "remote",
	6  : "time",
	7  : "overspace",
	8  : "ping",
	9  : "help",
	10 : "unlock",
	11 : "save",
	12 : "load",
	13 : "quit",
	14 : "reply",
	15 : "notes",
	16 : "chibi",
	17 : "download",
	
	18 : "archive",
	19 : "files",
	20 : "commands",

	21 : "decode",
	22 : "chat",
	
	23 : "hack",
	24 : "haxx",
	
	25 : "tables",
	26 : "get",
	27 : "commit",
	28 : "update",
	29 : "exit",
	30 : "hash"
}

var ACTION_COMMANDS = range(31)

var CREDITS = ""


# Called when the node enters the scene tree for the first time.
func _ready():
	CREDITS += "Developed by Mochimochi95 with Godot"	
	CREDITS += "\nBeta-ed by Seairah, Bambosh, Yannu, Lovely."
	CREDITS += "\n-----"
	CREDITS += "\nMany thanks to my beloved friends who helped make this game more playable for others, and for sticking with it until the end"
	CREDITS += "\nThis is a remake of the original game in PyGame, with some additional features"
	CREDITS += "\nI hope you enjoy this and figure out CHIBI's identity by the end of the game"
	CREDITS += "\n-----"
	CREDITS += "\nCredits for music used:"
	CREDITS += "\nLicense: http://creativecommons.org/licenses/by/4.0/"
	CREDITS += "\n\nScreen Saver by Kevin MacLeod"
	CREDITS += "\nLink: https://incompetech.filmmusic.io/song/5715-screen-saver"
	CREDITS += "\n\nLimit 70 by Kevin MacLeod"
	CREDITS += "\nLink: https://incompetech.filmmusic.io/song/5710-limit-70"
	CREDITS += "\n\nFloating Cities by Kevin MacLeod"
	CREDITS += "\nLink: https://incompetech.filmmusic.io/song/3765-floating-cities"
	CREDITS += "\n\nLong note One by Kevin MacLeod"
	CREDITS += "\nLink: https://incompetech.filmmusic.io/song/3992-long-note-one"
	CREDITS += "\n\nComfortable Mystery 3 by Kevin MacLeod"
	CREDITS += "\nLink: https://incompetech.filmmusic.io/song/3529-comfortable-mystery-3"
	CREDITS += "\n\nBeauty Flow by Kevin MacLeod"
	CREDITS += "\nLink: https://incompetech.filmmusic.io/song/5025-beauty-flow"
	CREDITS += "\n\nInspired by Kevin MacLeod"
	CREDITS += "\nLink: https://incompetech.filmmusic.io/song/3918-inspired"
	CREDITS += "\n\nChill Wave by Kevin MacLeod"
	CREDITS += "\nLink: https://incompetech.filmmusic.io/song/3498-chill-wave"
	CREDITS += "\n-----"
	CREDITS += "\nCredits for clips used:"
	CREDITS += "\n\nAbstract lines green network background by bomman151"
	CREDITS += "\nFree Stock video at http://www.videezy.com"
	CREDITS += "\n\nThe System Failing to Display Information on Screen by diizlerza"
	CREDITS += "\nBroll provided at http://www.videezy.com"
	CREDITS += "\n\nA glitch in the system - graphics by diizlerza"
	CREDITS += "\nStock footage by http://www.videezy.com"


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
