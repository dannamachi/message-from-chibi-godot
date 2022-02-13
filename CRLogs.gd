extends Node

var LOGS = {
	# Block 0000
	"000001" : "Hello, I'm sure you are a bit confused right now because you don't remember anything. It is a bit of a tricky situation, but I've got you covered. First of all, you are a VSP, which stands for virtual security police. It's a beautified name for garbage cleaner actually, since what we actually do is delete the logs that get discarded from Earthline, and we get arrested if we want to keep them for ourselves - I mean, it's garbage so why can't we keep them?",
	"000002" : "But this is not my point. The problem is, because of the sensitive nature of the information we are dealing with, they really want to make sure that our terminal has not been hacked. So upon restarting the terminal, you might be bombarded with logs from your admin asking for response - reply to them immediately if you can! And I know it sounds impossible but you have to do it: you have to pretend like you haven't lost your memory! It is important that they do not suspect anything - bluff your way through it if you must. Logs from others? Just ignore them",
	"000003" : "Since you are me and I know myself, I think it might be hard for you to lie smoothly. Watch some dtube so you have data to back up your bluffs! You can also just demtube or work repeatedly while waiting for replies - they give you useful info once in a while",
	"000004" : "Just a reminder, new commands could become available after watching dtube, working, saving attachment and decoding files so check regularly!",
	"000005" : "Anyway, try to survive and get as many data files as possible. Then decode the last file to get the way to fulfill your mission. I'm counting on you, okay? And you don't have to get admin privilege - you don't need it",
	# Block **00
	"**0001"  : "I have tried to decode the 'last file' as instructed by my predecessor and followed the steps... but my mission is still not completed? It seems I have no choice but to recompile... I can only hope my future self will be able to fulfill the mission",
	"**0002"  : "But why? I only have with me the files necessary for survival... could it be that the 'last file' was referring to another file? What other file can I possibly get?",
	# Block **?0
	"**?001" : "A reminder for my future self: do not accept the clf file! You get the other file if you choose the other option - that's the one needed for our survival!",
	"**?002" : "Once you have all the necessary files, make sure to run the command that pops up!",
	# Block ***0
	"***001" : "A reminder for my future self: the decode password for last_piece comes from one of the addresses! The address name, without the @... that follows. Of course, run that word through an encoder to get the actual password - that much is normal right?",
	# Block *0*0
	"*0*001" : "If you got this message then you must have survived! Congratulations! It must have been hard to get here. Good on you",
	"*0*002" : "So you've got one job left, and it's quite important - you've got a mission to fulfill. You know what it is, yeah? As to how to do it... the way has been hidden in one of the files that you could have gotten. That's why I told you to get as many files as possible. But well, it's too late now",
	"*0*003" : "So, good luck with your mission! And if you were wondering why it said 'save CHIBI' at the beginning, that's code for 'survive'... don't ask me, I don't know why either",
	# Block ?5?2
	"?5?201" : "I've always wondered; what are Demrys? I know Rimorians are in-organic humans with fully virtualizable portable memory, and humans after the revolution are half-organic bullshit that doesn't need mors to live... but a million other things, judging by the size of their life support system",
	"?5?202" : "Humans are delicate creatures yeah. They are also the most wonderful of inventors though - just LOOK at all the things they do during Cohabitation era! 'Culture, Arts, Entertainment'! I have no idea what the first two words really mean but they seem like some real important things back then - many of the Rimorians on Earthline always talked about those things, going all 'those were the days'",
	"?5?203" : "You and your unnecessary details. Tell me about Demrys already",
	"?5?204" : "Alright alright. So you got the Rimorian part right. Demrys, or Demry, is short for Demi-Rimorian... We have in-organic physical forms, hence our ability to survive on mors alone, but our memory device is kinda malfunctioning. Any attempt to detach and transfer the memory data anywhere else, as with full virtualization, runs the risk of permanently damaging the data. That's why we've been deemed incompatible for virtualization into Earthline and stuck here doing security work... or rather cleaners' work",
	"?5?205" : "You got that right...",
	# Block *???
	"*???01" : "How is it going? Is the life support system hacked yet?",
	"*???02" : "Time estimated is 69379200 time units... that's about 40150 years. It really is tough for an ancient piece of code...",
	"*???03" : "Ugh that's useless!... Maybe the only way is to use that method after all...",
	"*???04" : "What method?",
	"*???05" : "I found something while going through some old logs... those terrorists sure like to hide stuff in their bpaints. One of the logs mentioned an idea that was scrapped because it would overload the system, potentially shutting down the life support system",
	"*???06" : "Overload the system? Are you sure this is safe?",
	"*???07" : "They are only afraid because they are humans. We are made of data, we are inherently recoverable... the overflow would not kill all of us, and the rest could just recover the others. It will be fine, trust me. This is our chance to finally snuff out those annoying mortals for good - and get rid of the humans as well!",
	"*???08" : "...Fine, if you say so",
	# Block ?*??
	"?*??01" : "What's happening?? I'm getting warnings - a LOT of warnings - from the central server. Is it those aeternutjobs? What in Rimor are they doing!",
	"?*??02" : "I don't know! One of the crawlers I sent out came back with data signatures that shouldn't exist. They... they came from deleted AIs! But it shouldn't have been possible to rebuild those AIs!!",
	"?*??03" : "Could it be? Those stupid bastards!! They are recreating AIs from before the 'mite; back then old data was only deleted not corrupted! It's entirely recoverable - but our servers cannot handle it! Are they out of their damned mind!",
	"?*??04" : "I cannot suspend the operation! At this rate... no! The life support system!",
	"?*??05" : "Error. Overflow. Error. Overflow. Error. Overflow",
	# Block ???2
	"???201" : "So this is what I've got from digging through logs of near-death Rimorians - just a few time units longer and you VSPs would have deleted everything. But anyway, so the timeline goes like this:",
	"???202" :"6007 - Server Expansion Project III, 6130 - POW scandal (The Rimorian leaders were suspected to make surviving human leaders from post-revolution go through some sort of 'eternal prison' using virtualization technology, it's pretty grim stuff), 6256 - Genesisline server established, 6428 - Cyberdemic (a virus created by the Oriental Human United Kingdom caused serious data loss to many of the old servers, discovering a huge vulnerability in the security network)",
	"???203" : "The virus is called EXLRO, I think... I might have spelled it wrongly. It's such a weird word. Why can't it be like, idk, ROXEL or something. It's the same combination of letters but much easier to remember... Oh wait, I'm sidetracking. So next in the timeline...",
	"???204" :"6552 - Armisline server established, 6570 - Cybermite (we both know this - it's the birth of large-scale data wipe technology. and connection to the Overspace network was lost for good after this). And 6600 - 6794 was the 7th Cyber War, in which the humans were completely wiped out from shutting down the life control system. Those debris floating around, yes",
	# Block ??0?
	"??0?01" : "So I've come across an interesting term. What's 'Overspace'?" ,
	"??0?02" : "Heeeeh, finally there's something you don't know. So it's actually a network set up all the way back in the 5500s - but it's not on Earth. The year might not be accurate, but in 5510 the Overspace agreement was signed between human leaders and Rimorian ambassadors. Yes, I'm not very sure about it since there's not a lot of data but the Rimorians originally came from another planet. They claimed to be our ancestors but there's no proof",
	"??0?03" : "You really like to add so many details... basically, Overspace is a network between different planets? So Earthline used to be connected to Genesisline and Armisline, those other servers you mentioned before?",
	"??0?04" : "Yep. And let's not forget about Rimorline. That's where the Rimorians came from, and where we got mors, our main source of energy. Mors generate naturally over there, so they won't have to worry about shortage... but not for us. Back before Cyberdemic happened they would transfer it to us in bulk, but terrorist activities in the 6400s disrupted a lot of deliveries. And 6570 just straight up cut off our supply... well",
	# Block ??08
	"??0801" : "Welcome to channel NHN, I am your admin LUV, you can contact me via this address. As a new Virtual Security Police officer, your main duty is to regularly remove bad data from Earthline. While it is true that life can be dull out here since almost everyone has been virtualized and uploaded onto Earthline, I hope you'll remain steadfast to your duty as a citizen of Earth. The war was not so long ago so the government is still very on edge about things, so they may conduct random log scan in order to make sure everyone stay in line. I am not sure what the punishment would be but it can't be any good, so I hope you'll conduct your business with this in mind. On that note, do you drink?",
	# Block ?7?1
	"?7?101" : "I can call you CASS right? Or do you prefer your UID, Cassilin? I've got some spare time on my hand and... well, your logs are really intriguing that's all. A lot of these data shouldn't even be on the system? And they are definitely not yours? Makes one wonder how that could be possible",
	"?7?102" : "Uh, not sure how they got there either. Maybe a terminal crosser left them there in my database? They are known to just randomly hack into terminals not their own after all. And honestly, you shouldn't even know my UID - don't go around accusing people when you are not so innocent either!",
	"?7?103" : "Look, I know you. The dealer at the hidden market sold you out. You really should pay a bit more to those dealers - they crack up quite easily",
	"?7?104" : "Ugh those idiots! Well what do you want, miss officer? I'm sure we can come to a good deal... The admin does not need to know that I collect some random logs, or an upstanding officer like you just went and hacked into another terminal not your own",
	"?7?105" : "Well why did you think I left those obvious traces? As an experienced crosser you must have collected quite a few logs from behind the war. I don't want much, just some of that old data. It's like a hobby of mine. And maybe you can buy me enol for cheap too - in return I'll warn you about the admin's movement. Deal?",
	"?7?106" : "Deal! Enol huh... it's just ethanol and doesn't even give you energy. But I won't judge you. Here's to a good partnership!",
	# Block ?55?
	"?55?01" : "Entertainment? Well... You have cyber-sports, c-sports for short, on dtube. 4-layer soccer matches are quite popular. A lot of people also do things like b-painting (bit painting) which is essentially 'drawing', in ancient terms. Some eccentric folks also upload b-logs (look similar to ancient 'blogs' but they are more 'videos' huh) of different ways to consume mors. We consume nothing but mors so it is quite interesting to see variation of it - it's called creative fuelling by the way",
	"?55?02" : "That's too much information, idiot. But I'll check out the soccer",
	# Block 0308
	"030801" : "Hey! How's it going?",
	"030802" : "Nothing's on, you got the wrong address",
	"030803" : "Sorry, but I have to do this! It's admin order",
	"030804" : "That's a lie and you know it. I'm sending a log to the admin",
	"030805" : "I'm sorry for that bad lie, but I don't know what else to do! I've got a really old virus and I don't know how to remove it....",
	"030806" : "Hey, is it possible to block an address on the network?",
	"030807" : "Sad to say, nope. The terminals are all connected so we can detect issues if any, and back up if any of us got wiped. It's even harder these days because some officers got caught helping terminal crossers get access to confidental information. Just be careful you don't become the next one to be wiped. We are already running low on officers as it is",
	"030808" : "What are they even doing on earthline that's causing so many memory leak? There are so many logs to overwrite these days",
	"030809" : "It's not good to lie. I've already told the admin about this",
	"030810" : "Please, just give me some time! I'm trying to reach my processing cap so I can force the virus to stop running. I just need to send out a lot of logs",
	"030811" : "Don't send this to anyone, but they are giving every citizen on Earthline enough processing power to create their own world. Singulari, singular world. All running in parallels - that's why there's a lot of memory that has to be cleared up regularly",
	"030812" : "That's too much! It's just like the 4900s again - we're just wasting memory space on unrealistic world rendering. They won't even be satisfied at the end",
	"030813" : "But doesn't it sound good to you? Your own world, with whatever the heck you want. It's better than being out here doing these boring things",
	"030814" : "I don't know... it's not like we are compatible with full virtualization anyway",
	"030815" : "Fine, just don't clutter my memory with your logs",
	
	# Block 0210
	"021001" : "LUV's remote access is his creator's first name. What an obsessive idiot... and why set his UID as something so easy to guess like Luvluv?. And let's not talk about CASS's obsession with history... she really likes to talk about the Cybermite incident, but what's she really crazy about is the Cohab era...",

	# Block 0309
	"030901" : "Hello, hope you have a nice day! I'm making a b-paint, it is genuinely quite fun. How about you, do you do b-painting?",
	"030902" : "It takes too much effort, and I see no point. C-sports is much better - a bit of a waste of memory but it's at least exciting. Classic 4-layer soccer is the best.",
	"030903" : "4-layer? Like just another layer on top of this? <attached: 3-layer-soccer.bpt>",
	"030904" : "No, they use reverse modelling and enable interaction between the images - don't clog my memory with your stupid b-paints. And get an update already",
	"030905" : "Omg that's amazing! Where can you watch it? I want to make a b-paint based on it!",
	"030906" : "Can't believe you make me do this. All VSP have access to DemTube. And just read this <attached: VSP_guide.clf>",
	"030907" : "Thank you so much!! You've helped me so much - and all I can give you is this <attached: thank-you.bpt>",
	"030908" : "I said stop sending me these b-paints",
	"030909" : "Thanks for helping me cut off the trail last time. How much enol do you want?",

	# Block 0401
	"040101" : "Hey, what are you having for today?",
	"040102" : "Distilled mors what else. And some well-earned enol",
	"040103" : "That sounds so dull! Isn't it more fun to be creative with what you consume - I followed this tutorial on demtube and mixed a cremor brul from just mors. Creative fuelling is so fun. I thought there's only Ymoria for drinks?",
	"040104" : "Hey did you even read the clf I sent you last month? There's a hidden market selling enol for VSPs, using logs from work. It's illegal but the admin allows it as long as it's not some sensitive logs",
	"040105" : "It's like the grey market from Cohab...",
	"040106" : "Cohab? You have data on the Cohab era?",
	"040107" : "It's a really old virus. I think it dates back all the way to the Cyberdemic, a few hundred years before the war. During my extraction I managed to get some logs out - they have some info about the Cohab era",
	"040108" : "I almost forgot; hurry up with that extraction. Your logs are cluttering my memory",
	"040109" : "I almost forgot too! Just finished this <attached: debris-full-sky.bpt>",
	"040110" : "Didn't I tell you to stop",
	"040111" : "There are a lot of crossers of these days. The admins don't care that much but we've been getting pressure from the higher ups. Some sensitive logs were being circulated, so we are now asked to crack down on some active crossers",
	"040112" : "It's getting out of hand yeah. I'll keep an eye out, thanks",
	"040113" : "You better lay low for now. The admins are on the lookout for crossers so you better be careful. And change your terminal password already - how did you not get found out with using the year of a major incident as your password?",
	"040114" : "Gotcha. Once this is over I'll tell you about some spicy details I've found out about our channel admin. And stop remote accessing my terminal already!!",
	"040115" : "<Draft> Oh I have a better one - got some trace of a block of logs about Cohab era",
	"040116" : "The bots found out! Clear your logs!!!",

	# Block 0503
	"050301" : "Hey, did anything happen? DemTube was going crazy over some incident",
	"050302" : "Some stupid crossers led the bots to the hidden market so sale of enol is suspended indefinitely. Those trash bots",
	"050303" : "Well Demrys can't really break down Enol anyway. You can learn to mix an alternative using Ymoria, it's really not that bad",
	"050304" : "Shut your trap, you don't understand since all you do is drink ymoria and do stupid shits like b-painting! And you take fucking forever to kill a virus from the 6500s!!",
	"050305" : "I'm sorry, I didn't mean to meddle... I'm almost done with the virus, no more clogging your memory I promise. I'm sorry",
	"050306" : "<Draft> I'm sorry, I actually like your b-paints, and you can keep sending me logs I",

	# Block 0505
	"050501" : "Finally some leeway to talk! Remember that spicy detail about our admin? He's actually a replica of the AI created by the Cybermite culprit!! The higher ups copied the code while changing the core persona so he would follow their Singularist propaganda. Poor thing actually",
	"050502" : "The bots are still around, you fool! Don't just mention things like the Cybermite incident so easily... LUV's creator was that guy huh",
	"050503" : "Did you finish extracting the virus?",

	# Block 0512
	"051201" : "DID YOU SEE THAT? That log, it basically proved that the Cybermite incident was caused by a remnant of the OHUK!! A whole 130 years after we thought they were all killed in 6428!!!",
	"051202" : "Stop using timestamps in your logs! The Oriental Human United Kingdom huh... makes sense that Cybermite was caused by a bunch of human extremists. But why are you so excited??",
	"051203" : "Is the lack of enol making you stupid? The 7th Cyber War was thought to happen due to conflict between the 2 schools of thought - Mortalis and Aeternum. Then suddenly this new movement, Singulari, just appeared out of nowhere and took power after the war killed nearly half of us. Everyone thought OHUK died when Cyberdemic was contained... but if they were still around until Cybermite, a mere 30 years before the war... you know what I mean right?!",
	"051204" : "You can't mean... the war was caused by humans? The very humans that were exterminated to the last one when the life support system broke down during the war?",
	"051205" : "Sounds stupid, but hear me out. The war started because we lost the connection to the Overspace network in the Cybermite data wipe, and we had to decide whether to remain de-virtualized (Mortalis) or return to Earthline (Aeternum). The humans could have planned to commit suicide all along, knowing that we will die off without extra server space. That's what the Singulari policy is - it's just a way of slowly killing off every Rimorians. The OHUK extremists didn't all die out in the war, they are still alive!",
	"051206" : "But how can a human live with the life support system gone?",
	"051207" : "I thought that too, but apparently it was possible back then to put a human consciousness into a synthetic body used for Rimorians. If it succeeds, the new body could potentially live on indefinitely like a real Rimorian.",
	"051208" : "Then what would be the difference between human and Rimorian? Any Rimorian could be one of them.",
	"051209" : "Well... I have a hypothesis. I think... We Demrys are...",
	"051210" : "Okay enough. These are all speculations, make sure to clear these logs!",
	"051211" : "...Is there really no way to re-connect to Overspace?",
	"051212" : "It's hard... the info was all stolen by OHUK during Cyberdemic. It's almost impossible to find any log dating back to before 6500, and the bots basically wiped all info about Overspace... I should've realized that was suspicious as heck!",
	"051213" : "So we won't be able to get more server space, Singulari is essentially killing off all Rimorians in a sweet 'dream', while we Demrys slowly run out of mors out here. How bleak",
	"051214" : "Don't be too pessimistic, it's not the end yet! We just need to find the clue to Overspace before the bots do, that's all",

	# Block 0604
	"060401" : "You found out some pretty interesting information, didn't you. Don't worry, I know you're not a terrorist. So there's someone on the network, he's been sending out contact signals with unknown wavelengths - wavelengths not found on the entire VSP system. Either he's been infected with a virus or he's malfunctioning very bad. His UID is Ananth - look into his logs for me, will you? You wouldn't want some bots going through all your Enol trading history now, would you?",
	"060402" : "Kiddo, are you even alive? Did the virus take you? If you are the one sending suspicious signals that you should really stop - the admin is onto you",
	"060403" : "Hey! The virus acted up while I was trying to shut it down, but it's gone now! So this will be my last log to you... Thank you for everything! <attached: cat_playing_soccer.bpt>",
	

}

var LOGS_SENDER = {
	"chibisuke@vsp.tc"  : ["030801","030803","030805","030810","030901","030903","030905","030907","040101","040103","040105","040107","040109","050301","050303","050305","060403",
							],
	"cat_fish@vsp.tc"   : ["030802","030804","030806","030808","030809","030812","030814","030815","021001","030902","030904","030906","030908","040102","040104","040106","040108","040110","040112","040113","040115","050302","050304","050306","050502","050503",
							"051202","051204","051206","051208","051210","051211","051213","060402","?7?101","?7?103","?7?105","?55?02","??0?01","??0?03","?5?201","?5?203","?5?205",],
	"dt_81@fpu.tc"      : ["030909","040114","050501","051201","051203","051205","051207","051209","051212","051214","?7?102","?7?104","?7?106","?55?01","???201","???202","???203","???204","??0?02","??0?04","?5?202","?5?204",],
	"em_81@fpu.tc"      : ["030807","030811","030813","040111","060401","??0801"],
}

var LOGS_RECIPIENT = {
	"chibisuke@vsp.tc"  : ["030802","030804","030809","030815","030902","030904","030906","030908","040102","040104","040106","040108","040110","050302","050304","050306","050503","060402",],
	"cat_fish@vsp.tc"   : ["030801","030803","030805","030807","030810","030811","030813","021001","030901","030903","030905","030907","030909","040101","040103","040105","040107","040109","040111","040114","040116","050301","050303","050305","050501",
							"051201","051203","051205","051207","051209","051212","051214","060401","060403","??0801","?7?102","?7?104","?7?106","?55?01","???201","???202","???203","???204","??0?02","??0?04","?5?202","?5?204","000001","000002","000003","000004","000005",
						"**0001","**0002","**?001","***001","*0*001","*0*002","*0*003",],
	"dt_81@fpu.tc"      : ["040113","040115","050502","051202","051204","051206","051208","051210","051211","051213","?7?101","?7?103","?7?105","?55?02","??0?01","??0?03","?5?201","?5?203","?5?205",],
	"em_81@fpu.tc"      : ["030806","030808","030812","030814","040112",],
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
