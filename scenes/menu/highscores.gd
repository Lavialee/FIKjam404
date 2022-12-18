extends Control

const HIGHSCORE_PATH = "res://data/highscore.json"

var scores_count 
var current_scores := []
var rows := []
var blink := false
var blink_timer := Timer.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	scores_count = 10
	if Global.scores.empty():
		var data = parse_json_file(HIGHSCORE_PATH)
		print(data)
		if data.has("scores"):
			Global.scores = data.scores
		else:
			Global.scores = []
	#update scores
	_update_scores()
	_write_scores() 	#add scores to screen
	pass # Replace with function body.

func _update_scores():
	if Global.player_nick.empty():
		return
		
	var new_score = { "name": Global.player_nick, "score": Global.player_score }
	var success = false
	
	for i in Global.scores.size():
		if new_score.score > Global.scores[i].score:
			Global.scores.insert(i, new_score)
			success = true
			current_scores.append(i)
			break
	
	if !success:
		current_scores.append(Global.scores.size())
		Global.scores.append(new_score)

func _write_scores():
	for score_row in scores_count:
		if score_row >= Global.scores.size():
			break
		var row = $Row.duplicate()
		row.visible = true
		row.rect_position.y += score_row * 100
		add_child(row)# tady zjistuje co tam ma byt napsany

		row.get_node("Position").text = str(score_row + 1) + "."
		row.get_node("Name").text = Global.scores[score_row].name
		row.get_node("Score").text = str(Global.scores[score_row].score)
		rows.append(row) #prida do rows pole

	if Global.scores.size() > 100:
		Global.scores.resize(100)

	write_json_file(HIGHSCORE_PATH, { "scores": Global.scores })
	pass

func parse_json_file(path):
	var file = File.new()
	var data

	if file.file_exists(path):
		file.open(path, File.READ)
		data = parse_json(file.get_as_text())
	else:
		data = {}
	file.close()
	return data

func write_json_file(path, data):
	var file = File.new()
	file.open(path, File.WRITE)
	file.store_line(to_json(data))
	file.close()
