extends Node

# only show with correct flags (provided by dialogue/goal)
var REPLY_STAGES = {
	"677972656653515749" : [
		["How to access ID database"],
		["5391", "6570"],
		["I need to access it"],
		["I haven't forgotten our deal", "Who else would I be" ]
	],
	"87696965667979" : [
		["About the cat pic"],
		["About your creator"],
		["I do Enol", "I do Ymoria"],
		["I like 4-layer soccer", "I like doing bpainting"],
		["You don't like drinking", "You love drinking"],
		["What do you mean"],
		["Let me send radiowaves"]
	]
}

# TO DO: add this to save/load
# negative if not responding, otherwise index of stages, if out of range no more
var REPLY_STATUS = {
	"677972656653515749"  : 0,
	"87696965667979"      : 0
}

var ID_INDEX = {
	"a" : 0,
	"b" : 1,
	"c" : 2,
	"d" : 3
}

var FLAG_START = {
	"677972656653515749"  : "How to ID",
	"87696965667979"      : "How to radio"
}

var FLAG_END = {
	"Here you go"             : "Real hack stuff",
	"Take this"               : "Fake hack stuff",
	"You got 2 units"         : "Admin radio ok"
}

var CHAT_ALIAS = {
	"677972656653515749"  : "CASS",
	"87696965667979"      : "LUV"
}

# TO DO: add this to save/load
var CHAT_STATUS = {
	"677972656653515749"  : true,
	"87696965667979"      : true
}

var END_CODES = [
	"Get back to you later",
	"Enol, right", # might be slow in answering
	"Soccer, yes", # might be slow in answering
	"Indeed I do" # might be slow in answering
]

# EXTRA: maybe do a flag system just within this, for more otome-like ish
var REPLY_CODES = {
	"677972656653515749" : {
		# stage 1
		"How to access ID database"     : "Tell me my favourite number",
		# stage 2
		"5391"                          : "It's dangerous, why",
		"6570"                          : "Get back to you later",
		# stage 3
		"I need to access it"           : "Are you really NEKOI",
		# stage 4
		"I haven't forgotten our deal"  : "Here you go", # stuff to hack
		"Who else would I be"           : "Take this" # unable to hack
	},
	"87696965667979" : {
		# stage 1
		"About the cat pic"             : "It's not from my creator",
		# stage 2
		"About your creator"            : "Nothing much, and you",
		# stage 3
		"I do Enol"                     : "Enol, right",
		"I do Ymoria"                   : "Ymoria, really",
		# stage 4
		"I like 4-layer soccer"         : "Soccer, yes",
		"I like doing bpainting"        : "Painting, oh",
		# stage 5
		"You don't like drinking"       : "Is this a prank", # you're the worst impostor ever, I can't even, LMCO
		"You love drinking"             : "Indeed I do",
		# stage 6
		"What do you mean"              : "What are you trying to do", # laughing my code off... just tell me what you want, you got me
		# stage 7
		"Let me send radiowaves"        : "You got 2 units" # can overspace, countdown
	}
}

var REPLY_CONTENT = {
	"How to access ID database"         : "Hey CASS, tell me how to access the ID database.",
	"Tell me my favourite number"       : "What's my favourite number?",

	"5391"                              : "Cohab, 5391?",
	"It's dangerous, why"               : "The ID database? Why are you trying to mess with that? It's pretty secure, won't be pretty if you're caught.",
	"6570"                              : "Cybermite, 6570?",
	"Get back to you later"             : "I don't know, let me check.",
	
	"I need to access it"               : "I just really need to see it, it's important. Please?",
	"Are you really NEKOI"              : "I do have something, but you saying please... are you really NEKOI?",

	"I haven't forgotten our deal"      : "Who else would help you snitch against the admin just for some enol?",
	"Here you go"                       : "For those pre-war logs too! Ugh, fine, I sent you the stuff. Just run it.",
	"Who else would I be"               : "Of course, who else could I be?",
	"Take this"                         : "Well okay. I sent you what I have, give it a try.",
	
	"About the cat pic"                 : "The bpt you sent me, that was really nice. Did your creator paint it?",
	"It's not from my creator"          : "I don't know. His friend gave it to me, saying it was a momento.",
	
	"About your creator"                : "What was your creator like?",
	"Nothing much, and you"             : "My memory got wiped so I only know bits and pieces, like his taste in rikitts. Are you drunk?",

	"I do Enol"                         : "Just had some Enol, not that much. Why?",
	"Enol, right"                       : "You always like your Enol, don't you. What are you doing now? I have a report, so might be slow to reply.",
	"I do Ymoria"                       : "Haven't had Ymoria for a while, so no?",
	"Ymoria, really"                    : "Ymoria. You love that. Don't you. What are you doing now?",

	"I like 4-layer soccer"             : "Watching some 4-layer soccer. What about you?",
	"Soccer, yes"                       : "Ah soccer, your favourite. I'm drinking while writing a report, might reply late.",
	"I like doing bpainting"            : "Just doing some bpainting, it's nice to kill time. What about you?",
	"Painting, oh"                      : "Bpainting. Nice. That's.... nice. I'm drinking.",

	"You love drinking"                 : "It's not like you're good at it, so why do you like it so much? Running away from something?",
	"Indeed I do"                       : "What do I have to run away from... drinking is just fun. Gotta do this report too, will reply later.",
	"You don't like drinking"           : "What a bad lie, you don't even like drinking.",
	"Is this a prank"                   : "LMCO what do you mean it's a lie, I am literally... YOU are the worst liar ever. I already know you're not NEKOI.",

	"What do you mean"                  : "What are you saying? LMCO?",
	"What are you trying to do"         : "Laughing my code... no, you stop it. Flipping... you are just messing with me now. What do you WANT from me!!",
	
	"Let me send radiowaves"            : "Let me send some packages via radio, pretty please?",
	"You got 2 units"                   : "Flipping... just do whatever, you got until I finish this bottle."
}


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
