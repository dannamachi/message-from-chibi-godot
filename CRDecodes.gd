extends Node

var CODE_KEYMAP = {
	"121111117"                         : "YOU",
	"109117115116"                      : "MUST",
	"115117114118105118101"             : "SURVIVE",
	"9910410598105"                     : "CHIBI",
	"110121971101101219711011012197110" : "nyannyannyan",
	"677273667383857569"                : "chibisuke",
	"87696965667979"                    : "WEEABOO",
	"677972656653515749"                : "COHAB5391"
}

var KEYMAP = {
	"chibi.exe"               : "ROXEL",
	
	"catgirl.bpt"             : "nyannyannyan",

	"Cohab.clf"               : "WEEABOO",

	"do.bpt"                  : "677273667383857569",
	"not.bpt"                 : "677273667383857569",
	"forget.bpt"              : "677273667383857569",
	"last_piece.bpt"          : "677273667383857569",

	"3-layer-soccer.bpt"      : "YOUMUSTSURVIVECHIBI",
	"thank-you.bpt"           : "YOUMUSTSURVIVECHIBI",
	"debris-full-sky.bpt"     : "YOUMUSTSURVIVECHIBI",
	"cat_playing_soccer.bpt"  : "YOUMUSTSURVIVECHIBI",
}

# TO DO: ADD TO SAVE/LOAD
var DONEFLAG = {
	# clf path
	"Cohab.clf"               : false,

	# bpt path
	"catgirl.bpt"             : false,
	"last_piece.bpt"          : false,
	"do.bpt"                  : false,
	"not.bpt"                 : false,
	"forget.bpt"              : false,
	"3-layer-soccer.bpt"      : false,
	"thank-you.bpt"           : false,
	"debris-full-sky.bpt"     : false,
	"cat_playing_soccer.bpt"  : false,
}

var KEYFLAG = {
	"chibi.exe"  : false,
	
	"catgirl.bpt"             : false,
	"Cohab.clf"               : false,
	"last_piece.bpt"          : false,

	"do.bpt"       : false,
	"not.bpt"      : false,
	"forget.bpt"   : false,

	"3-layer-soccer.bpt"      : true,
	"thank-you.bpt"           : true,
	"debris-full-sky.bpt"     : true,
	"cat_playing_soccer.bpt"  : true,
}

var RESULTS = {
	"chibi.exe"   : "SUKE, I trust you know what to do with the scripts I left behind. They got to me sooner than I could warn you... I guess I don't even have to tell you not to be reckless, since I am the one with that role between the two of us... I'm sorry. You got dragged into this because of me. I didn't think... I had no idea that my teacher, she was under their control all along. She was... she was like a doll... a slave to them. I... I don't know what's right anymore. But it's for sure not killing everyone on this planet. They won't let me off, but I hope at least you will find a chance to escape. Farewell, my friend.",
	
	# given to luv by suke (it's a slim chance but... if it happens, you should know the truth too)
	"catgirl.bpt"    : "Log ?????? by LUCA: I was betrayed. There was never a possibility of compromise between the OHUK and the Rimorian leaders... ROXEL must have been tricked. You know I no longer have full admin access over LUVLUV ever since I joined this organization... You're the only one I can trust here; please shut down LUVLUV before the leaders can use it to launch an attack on the Rimorian government. I'm counting on you, SUKE",
	
	# luca's
	"Cohab.clf"      : "Log ?????? by LUCA: If you are reading this, then it seems that we couldn't prevent the incident from happening. I predict that the overspace connection would have been completely cut off, as desired by the OHUK leaders, but as long as you have a working terminal that can send out radiowaves, you will be able to re-establish connection. However, you will have to encapsulate the package being sent out with some specific frames for it to be accepted by the overspace access points. I've attached a script that can facilitate this process - just make sure you have an uninterrupted emission and you will be able to connect to overspace. I wish you best of luck, and sorry that we couldn't stop what has happened to your world.",

	# youmustsurvivechibi
	"do.bpt"             : "ping 121111117",
	"not.bpt"            : "ping 109117115116",
	"forget.bpt"         : "ping 115117114118105118101",
	"last_piece.bpt"     : "ping 9910410598105",

	"3-layer-soccer.bpt"      : "11012197Log ?????1 by SUKE: I'm sorry... I'm so sorry. It was all my fault. The switch was there, it was in my hand, all I need to do was just flip it...! But I couldn't. CHIBI was there... they took my child... if only I was a second sooner...if only...!",
	"thank-you.bpt"           : "110110121Log ?????2 by SUKE: It won't be long til the war now. The organization has riled up both sides enough... one of them will definitely use the method hidden in the bit paint and destroy the life support system. I can't believe I am part of the organization that will singlehandedly bring an end to a whole planet - what madness, should I be proud? But what hope do we have? What do I have left to live for? Perhaps I will try to decode the files you left for me - you were not the type to just leave things as they were after all. I bet you used the name of your teacher as the password as usual... The world may condemn you, but I am aware of the truth, and you will remain within my heart, LUCA",
	"debris-full-sky.bpt"     : "97110110Log ?????3 by SUKE: LUCA, I knew that you couldn't possibly just left things like that. There's a script for connecting to overspace, and diagrams for the creation of a virus. A self-replicating virus that can pass parts of its code as log attachments to other AI-based creatures. After the target has saved all files, essentially having a copy of the virus, the original can perform the function it was intended to do - in this case, contacting overspace. And if it fails to do so then it will recompile itself into a rootkit-like program to avoid analysis (most bots tend to just erase it). The persona code saved at the target terminal will wipe the memory database and instruct the wiped AI to assemble the self-replicating code (in the form of fake incoming logs) before repeating the process again",
	"cat_playing_soccer.bpt"  : "12197110Log ?????4 by SUKE: So I've changed a bit of it - your original idea would be very effective but very easy to detect due to its spreading speed. So I configure so that the virus would slowly send the files to the target over a period of time, disguising as a normal conversation. The persona for this virus... I have a perfect model to base it on. Most copies would focus on self replication, and they would be given 2 different scripts - a fake one and a real one that would connect to overspace. This will reduce the possibility of successful connection, but it is much more important that the 'virus' keeps replicating. We won't have to worry about losing the way to connect to overspace again. And my child... my child will live on as the virus 'CHIBI'",
}


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
