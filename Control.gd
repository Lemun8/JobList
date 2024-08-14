extends Control

var temp = {}
var jobs = {}
@export var job_name_label : Label
@export var description_label : Label
@onready var skill_label = preload("res://label.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	import_resources_data()

func import_resources_data():
	var file = FileAccess.open("res://JobList.csv", FileAccess.READ)

	while !file.eof_reached():
		var data_set = Array(file.get_csv_line())
		temp[temp.size()] = data_set
 
	file.close()
	#print(temp)
	
	var title = temp[0]
	
	for i in range(1, temp.size()):
		jobs[temp[i][0]] = {}
		for j in range(title.size()):
			jobs[temp[i][0]][title[j]] = temp[i][j]
	#print(jobs)
	
	for i in jobs:
	# Split the SKILLS string and remove any empty strings
		var skills = jobs[i]["SKILLS"].split(";")
		var skill_temp = []
		for j in skills.size() - 1:
			skill_temp.append(skills[j])
		print(skill_temp)
		jobs[i]["SKILLS"] = skill_temp
	
	print(jobs)


func _on_option_button_item_selected(index):
	for n in $"../HBoxContainer".get_children():
		$"../HBoxContainer".remove_child(n)
		n.queue_free()
	match index:
		0: 
			job_name_label.text = jobs["1"]["JOBNAME"]
			description_label.text = jobs["1"]["DESCRIPTION"]
			for i in jobs["1"]["SKILLS"]:
				var test = skill_label.instantiate()
				test.text = i
				$"../HBoxContainer".add_child(test)
		1: 
			job_name_label.text = jobs["2"]["JOBNAME"]
			description_label.text = jobs["2"]["DESCRIPTION"]
			for i in jobs["2"]["SKILLS"]:
				var test = skill_label.instantiate()
				test.text = i
				$"../HBoxContainer".add_child(test)
		2: 
			job_name_label.text = jobs["3"]["JOBNAME"]
			description_label.text = jobs["3"]["DESCRIPTION"]
			for i in jobs["3"]["SKILLS"]:
				var test = skill_label.instantiate()
				test.text = i
				$"../HBoxContainer".add_child(test)

