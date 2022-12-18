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
	#add scores to screen
	_write_scores()
	pass # Replace with function body.

func _update_scores():
	pass
func _write_scores():
	for score_row in scores_count:
		if score_row >= Global.scores.size():
			break
		var row
		if score_row == 0: # override the first row ta je jenom TEST a veci, možná udělat invisible spis
			row = $Row
		else: # and then add duplicates na to se budou psát další scores
			row = $Row.duplicate()
			row.rect_position.y += 64 + (score_row * 100)
			add_child(row)
# tady zjistuje co tam ma byt napsany
		row.get_node("Position").text = str(score_row + 1) + "."
		row.get_node("Name").text = Global.scores[score_row].name
		row.get_node("Score").text = Global.scores[score_row].score
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
