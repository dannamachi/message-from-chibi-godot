extends Node

# additional hack commands (to edit in Actions):
# commands
# help

# check for any condition before commit is allowed

# for different details in ending roll
# name called based on name changed for player
var FLAGS = {
	"Inactivate me"       : false,
	"Inactivate others"   : false,
	"Change Cass name"    : false,
	"Change Luv name"     : false,
	"Email change me"     : false,
	"Email change others" : false
}

var OG_TABLES = {
	"terminals"     : [
		{
			"index"    : "-1",
			"uid"      : "Luvluv",
			"email"    : "em_81@fpu.tc",
			"status"   : "active",
			"name"     : "LUV"
		},
		{
			"index"    : "-1",
			"uid"      : "Cassilin",
			"email"    : "dt_81@fpu.tc",
			"status"   : "active",
			"name"     : "CASS"
		},
		{
			"index"    : "-1",
			"uid"      : "Ananth",
			"email"    : "just_an_ant_h@fpu.tc",
			"status"   : "inactive",
			"name"     : "ANTH"
		},
		{
			"index"    : "-1",
			"uid"      : "Nekoi",
			"email"    : "cat_fish@vsp.tc",
			"status"   : "active",
			"name"     : "NEKOI"
		}
	],
	"ids"           : [
		{
			"index"    : "-1",
			"uid"      : "Luvluv",
			"persona"  : "imissyouowner"
		},
		{
			"index"    : "-1",
			"uid"      : "Cassilin",
			"persona"  : "plotdeviceisme"
		},
		{
			"index"    : "-1",
			"uid"      : "Ananth",
			"persona"  : "killedbeforeaction"
		},
		{
			"index"    : "-1",
			"uid"      : "Nekoi",
			"persona"  : "iwillbeback"
		}
	],
	"hashes"        : [
		{
			"index"    : "-1",
			"uid"      : "Luvluv",
			"hash"     : "imissyouowner".md5_text()
		},
		{
			"index"    : "-1",
			"uid"      : "Cassilin",
			"hash"     : "plotdeviceisme".md5_text()
		},
		{
			"index"    : "-1",
			"uid"      : "Ananth",
			"hash"     : "killedbeforeaction".md5_text()
		},
		{
			"index"    : "-1",
			"uid"      : "Nekoi",
			"hash"     : "iwillbeback".md5_text()
		}
	]
}

var TABLES = {}

func _ready():
	copy_og_to_real()

func copy_og_to_real():
	TABLES = {}
	# copy og to tables
	for table in ["terminals", "ids", "hashes"]:
		TABLES[table] = []
		for row in OG_TABLES[table]:
			TABLES[table].append(row.duplicate())

# restart machine (randomize)
func restart():
	var index = 0
	for row in OG_TABLES["terminals"]:
		row["index"] = str(randi() % (50 + index * 10) + 100 + index * 100)
		index += 1
		
	for row in OG_TABLES["ids"]:
		row["index"] = str(randi() % (50 + index * 10) + 100 + index * 100)
		index += 1
		
	for row in OG_TABLES["hashes"]:
		row["index"] = str(randi() % (50 + index * 10) + 100 + index * 100)
		index += 1
		
	copy_og_to_real()

# reset machine (keep data, reset progress)
func reset():
	copy_og_to_real()
	
# get command
func ha_get(tableName):
	var returnText
	if tableName in TABLES:
		returnText = "Table found:\n=====\n====="
		for row in TABLES[tableName]:
			returnText += "\nIndex " + row["index"] + " UID " + row["uid"] + " Email " + row["email"] + " Status " + row["status"] + " Name " + row["name"]
			returnText += "\n====="
		returnText += "\n====="
	else:
		returnText = "No table found."
	return returnText

# update command
func ha_update(tableName, index, attribute, newvalue):
	pass
	

# commit command

# quit command

# tables command 

# hash command
