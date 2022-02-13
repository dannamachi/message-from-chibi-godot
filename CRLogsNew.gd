extends Node

var LOGS_NEW_ADDRESS = {
	"chibisuke@vsp.tc"   : ["061009","061010","061101","061105","061106","0611?1","0611?2",
							"061108","0611?3",],
	"dt_81@fpu.tc"       : ["061004","061005","061008","061102","061107","061202","061203",
							"061204",],
	"em_81@fpu.tc"       : ["061001","061002","061003","061006","061007","061011","061012",
							"061103","061104","061109","061110","061201","061205","061206",
							"061207","061208", "061209"],
}

var LOGS_NEW = {
	# time 36
	# What are you doing (Luv)
	"061001" : "What are you doing? You haven't been responding - I asked you to check on that problematic terminal, how did that go?",
	# Admit no memory (wiped) / Ask for UID (Luv)
	"061002" : "",

	# time 32
	# You are not responding / You are so nice as to ask for UID? (Luv)
	"061003" : "",
	# You have Cohab logs?? (Cass)
	"061004" : "You didn't tell me you found trace of Cohab logs? Since when did you trust a random crosser more than me? They put such info on dtube, I couldn't even take it down quick enough. The bots may already be onto you, hope you already cleared and overwrote your logs",
	# I don't have them / Didn't I already send you? (relocated) (Cass)
	"061005" : "",

	# time 28
	# So how did it go (Luv)
	"061006" : "So, how did it go? Anything suspicious?",
	# I don't know what to do / (Pre-war?) Looks like old encryption (Luv)
	"061007" : "",
	# Must have been a proxy then (Cass)
	"061008" : "They probably used your address as proxy to hide their trace. That sucks, I thought you actually have those logs!",
	
	# time 26
	# Please answer (Chibi)
	"061009" : "I'm so sorry!! I thought I removed the virus but it's actually still here. It's going to get me wiped - and I thought I need to send you something. Please don't reply - you might get implicated too",
	# Your password / Who are you (Chibi)
	"061010" : "",
	# (Pre-war?) That makes no sense (Luv)
	"061011" : "Pre-war encryption shouldn't even exist anymore, that's few hundred years ago. Are you sure?",
	# This is not my problem (wiped) / Let me try again (another day) (Luv)
	"061012" : "",

	# time 24
	# Just one thing (Chibi)
	"061101" : "I'm sorry, there's no time. The sweepers are coming... please, I just need you to keep these b-paints for me, and give it to me post-wipe... I'm not sure if I will still be the same, since wiping removes everything but the persona code. But I..I don't want to forget <attached: do.bpt not.bpt forget.bpt>",
	# that was a close call (Cass)
	"061102" : "That was a close call - the bots were scanning so many terminals because of those idiots that publicized those Cohab logs - what amateurs. A bunch of officers got wiped for not responding in time already. Glad that you're still around. By the way, remember our last discussion about the true culprit of Cybermite? You-know-who doesn't seem like a bad guy in these logs I've found, and it is so much more likely that the government put the blame on someone else. What do you think?",

	# time 18
	# Just an update (Luv)
	"061103" : "Not sure if you know but we had to scan quite a few terminals, yesterday. One of them in particular got a nasty rootkit left behind by a crosser - it's that problematic one I told you about. His terminal could not have worked properly with that virus around... no wonder you could not remote access him. We ended up wiping him. And also, you mentioned pre-war encryption - I don't know where you read that from but it's not a good idea to talk about things like that these days. You were lucky I knew you from way back.",
	# (Animals) ripupp / (Animals) rikitt / Thanks (Luv)
	"061104" : "",
	
	# time 16
	# I survived (Chibi)
	"061105" : "I don't know why but I survived the wipe, somehow. Don't tell anyone though! But when the virus was gone I found some old logs and, can you believe it, they were about the Cohab era! I think I mentioned this to you before; that time it was just bits and pieces, but I've got a whole block here, authored by someone called LUCA. Do you want to see them?",
	# Yes, send / No, I don't like old logs (Chibi)
	"061106" : "",
	
	# time 15
	# I thought they were gone (Cass)
	"061107" : "You didn't reply to my last log! Are you out looking for enol again - it's not gonna be possible in the short term, I told you! But anyway, I've done more digging around and I think it's VERY likely that the Cybermite incident was not caused by you-know-who. Look in your own archive if you forgot who I'm talking about - sometimes I think you drink so much enol that it affects your data retention. This could be a good distraction for you - why not look around for files left behind by you-know-who? The admin might have them and you are really chummy with him for some weird reason",
	
	# time 14
	# I survived (Chibi)
	"0611?1" : "I don't know why but I survived the wipe, somehow. Don't tell anyone though! But when the virus was gone I found some old logs and, can you believe it, they were about the Cohab era! I think I mentioned this to you before; that time it was just bits and pieces, but I've got a whole block here, authored by someone called LUCA. Do you want to see them?",
	# Yes, send / No, I don't like old logs (Chibi)
	"0611?2" : "",
	# Here it is / Nevermind then, thanks (Chibi)
	"061108" : "",

	# time 12
	# Here it is / Nevermind then, thanks (Chibi)
	"0611?3" : "",
	# (Animals) Close but no cigars  (Luv)
	"061109" : "That model is nothing but a poor ripoff. Ri-poff, ha",
	# what's so bad about it / Got a problem here (died/got discovered) (Luv)
	"061110" : "",

	# time 10
	# You don't get it! (Luv) (Luca's relic)
	"061201" : "You just don't get it. Okay. You already knew who my creator was - he was a bastard who wiped thousands and thousands of AIs - but his taste for rikitts is unrelated. Just look at this <attached: catgirl.bpt>",
	# Did you watch it (Cass)
	"061202" : "Did you watch the latest b-log? Encoding before the war! Humans used to encode letters using things like 'base64' and 'utf-8', it's the coolest thing ever. Is there any secret number you wanna try and decode? The result could potentially be passwords to unlocking files - but who knows?",
	# Luv's number / Cass's number / chibisuke (Cass)
	"061203" : "",

	# time 8
	# (Admin hacked) That's one weird string / (Crosser hacked) Wait a sec / What the hell (Cass)
	"061204" : "",

	# time 6
	# The sweepers are leaving (Luv)
	"061205" : "The sweepers didn't find any more suspicious data so they will be leaving...finally. I'm glad you did not get wiped... There are so many officers getting wiped these days, it's like those days before the war. I don't want to have to say goodbye to my nakama when all they've done is come across some sensitive logs by accident. Don't worry if you don't get that word",
	# Glad to work with you /  (Luca's message) There's something you must know (Luv) (Luv's secret)
	"061206" : "",

	# time 3
	# Luv revealing truth before normal end
	"061207" : "By the way, I know you're not NEKOI. Or you're malfunctioned. Funny how things go, she was really confident about her security measure you know? But either way it doesn't matter. Yesterday I checked, the result from scanning your persona code does not match what's in the ID database, so you'll be wiped when the bots run the scan in a few time units. I didn't report you, since you were not doing anything suspicious, but it's goodbye. Any last word?",
	# if not NEKOI? / what should I do
	"061208" : "",
	# idk, who are you? / hint to 10 tries
	"061209" : ""

}

# Luv's talk before ending 6
# "Thank you for sending me that. I did not know... no, I already knew, I was just too afraid to believe. My creator was not the sinner that everyone made him out to be, and you are also not Nekoi. Funny how I'm confirming a persona-breaking truth thanks to a suspicious infiltrator of the network. Unfortunately, this is goodbye. You've known too much now..."

# Cass' talk if ending 4 with failed hack
# "Normally she would have reacted more if I questioned her identity like that... I sent her the program to report suspicious entities, she wouldn't just run things without checking it first right?"

var LOG_NEED_REPLIES = {
	"061001" : true,
	"061004" : true,
	"061006" : true,
	"061009" : true,
	"061011" : true,
	"061103" : true,
	"061105" : true,
	"0611?1" : true,
	"061109" : true,
	"061202" : true,
	"061205" : true,
	"061207" : true,
}

var LOG_LINK_REPLIES = {
	"061001" : "061002",
	"061004" : "061005",
	"061006" : "061007",
	"061009" : "061010",
	"061011" : "061012",
	"061103" : "061104",
	"061105" : "061106",
	"0611?1" : "0611?2",
	"061109" : "061110",
	"061202" : "061203",
	"061205" : "061206",
	"061207" : "061208",
}

var LOG_ATTACHMENT = {
	"061101" : false,
	"061108" : false,
	"0611?3" : false,
	"061201" : false,
}

var LOG_REPLIES = {
	"061002i" : "",
	"061002a" : "Sorry, there's nothing in my memory. I think I've been hacked",
	"061002b" : "I'm planning to remote access his terminal, got his UID?",

	"061005i" : "",
	"061005a" : "My logs are already cleared. What Cohab logs are you talking about, I have no such thing",
	"061005b" : "My logs are already cleared. Didn't I send you last month?",

	"061007i" : "",
	"061007a" : "I can't seem to access the terminal. What should I do?",
	"061007b" : "I can't seem to access the terminal. The encryption looks like something pre-war",

	"061010i" : "",
	"061010a" : "I think I can help if you give me your terminal password",
	"061010b" : "Who are you?",

	"061012i" : "",
	"061012a" : "I don't know, this is really out of my expertise",
	"061012b" : "I know, let me try again. Maybe I made a mistake somewhere",

	"061104i" : "",
	"061104a" : "Thanks. Did you see that new b-log on the ripupp model 7? That was so organic and detailed",
	"061104b" : "Thanks. Did you see that new b-log on the rikitt model 3? That was as close to perfection as it can be",
	"061104c" : "Thanks",

	"061106i" : "",
	"061106a" : "Yes, send it here",
	"061106b" : "No, why would I want to see some old logs",

	"0611?2i" : "",
	"0611?2a" : "Yes, send it here",
	"0611?2b" : "No, why would I want to see some old logs",

	"061110i" : "",
	"061110a" : "What's so bad about it??",
	"061110b" : "Ripoff huh. Also we've got a problem. The wipe did not work on that terminal. He sent me this block",
	"061110c" : "Ripoff huh. Also we've got a problem. The wipe did not work on that terminal. He sent me this b-paint",

	"061203i" : "",
	"061203a" : "87696965667979",
	"061203b" : "677972656653515749",
	"061203c" : "chibisuke",

	"061206i" : "",
	"061206a" : "Glad to work with you, LUV",

	"061208i" : "",
	"061208a" : "Who else could I be if not NEKOI?",
	"061208b" : "I don't know what to do anymore. I've been trying and trying, there's something I need to do, but I just can't get there. It would take a miracle... should I just give up?",
}

var LOG_GIVE_FLAGS = {
	# these flags are triggered when not responding in time
	"061002i" : "Ignore Luv 1",
	"061005i" : "Ignore Cass 1",
	"061007i" : "Ignore Luv 2",
	"061010i" : "Ignore Chibi 1",
	"061012i" : "Ignore Luv 3",
	"061104i" : "Ignore Luv 4",
	"061106i" : "Ignore Chibi 2",
	"0611?2i" : "Ignore Chibi @",
	"061110i" : "Ignore Luv 5",
	"061203i" : "Ignore Cass 2",
	"061206i" : "Ignore Luv 6",
	"061208i" : "Ignore Luv 7",
	

	"061002a" : "Kidding",
	"061002b" : "Ask for UID",
	"061005b" : "RELOCATED",
	"061007a" : "WIPED",
	"061007b" : "Is it pre-war?",
	"061012a" : "WIPED",
	"061012b" : "Another day",
	"061104b" : "Rikitts",
	"061106a" : "Cohab",
	"061106b" : "Bpaint",
	"0611?2a" : "Cohab@",
	"0611?2b" : "Bpaint@",
	"061110a" : "Luca's relic",
	"061110b" : "KILLED",
	"061110c" : "DISCOVERED",
	# TO DO: either 'code' flag triggered and is in bpt path, AI will unlock decoder by dialogue
	"061203a" : "Luca's code",
	"061203b" : "Cass's code",
	"061203c" : "Chibi's code",
	# "061206b" : "Luca's secret",
	"061208a" : "Who are you",
	"061208b" : "Last hint"
 }

var LOG_VARIATIONS = {
	"061003a" : "That's not even a funny joke. I get it that you don't have enol to drink away your sorrow - as you call it. But not today. I'll check on you later",
	"061003b" : "UID? I already sent you before, did you forget? Look into your archive -  and hurry up",
	
	"061108a" : "<attached: Cohab.clf>",
	"061108b" : "<attached: last_piece.bpt>",

	"0611?3a" : "<attached: Cohab.clf>",
	"0611?3b" : "<attached: last_piece.bpt>",

	"061204a" : "That would be WEEABOO for you, what the heck is that? Did you just string together random numbers?",
	"061204b" : "........... I can't say it HERE, you know that right? Another place where we're not being watched, maybe.",
	"061204c" : "That's not a number! Oh well I'm guessing you want it encoded... that would be 677273667383857569",

	"061209a" : "I don't know, who are you? What game are you playing at here?",
	"061209b" : "Well 10 is a pretty decent number to try for something that seems hopeless."
}

var LOG_NEED_FLAGS = {
	"061003a" : "Kidding",
	"061003b" : "Ask for UID",
	"061007b" : "Pre-war?",
	"061104a" : "Animals",
	"061104b" : "Animals",
	"061108a" : "Cohab",
	"061108b" : "Bpaint",
	"061110b" : "Cohab",
	"061110c" : "Bpaint",
	"0611?3a" : "Cohab@",
	"0611?3b" : "Bpaint@",
	"061203a" : "Hack Luv",
	"061203b" : "Hack Cass",
	"061204a" : "Luca's code",
	"061204b" : "Cass's code",
	"061204c" : "Chibi's code",
	"061206b" : "Decode Luca's relic",
	"061208b" : "Decode Cohab's relic",
	"061209a" : "Who are you",
	"061209b" : "Last hint",

	#"061006"  : "Ask for UID",
	"061011"  : "Is it pre-war?",
	"0611?1"  : "Hack Chibi",
	"0611?2"  : "Hack Chibi",
	"0611?3"  : "Hack Chibi",
	"061109"  : "Rikitts",
	"061201"  : "Luca's relic",
	"061207"  : "Normal end"
	
}

var LOG_TIME = {
	32 : ["061001","061002"],
	28 : ["061003","061004","061005"],
	26 : ["061006","061007","061008"],
	24 : ["061009","061010","061011","061012"],
	18 : ["061101","061102"],
	16 : ["061103","061104"],
	15 : ["061105","061106"],
	14 : ["061107"],
	12 : ["061108","0611?1","0611?2"],
	10 : ["061109","061110","0611?3"],
	8  : ["061201","061202","061203"],
	6  : ["061204", "061205","061206"],
	4  : ["061207", "061208"],
	0  : ["061209"],
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
