extends Control

const HIGHSCORE_PATH = "res://data/highscore.json"
const BLINK_TIME = 0.4
var scores_count 
var current_scores := []
var rows := []
var blink := false
var blink_timer := Timer.new()

signal back
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

	yield(get_tree().create_timer(1.0), "timeout") # aby se hned neodkliko
	pass # Replace with function body.

func _update_scores():
	$layer/book.play("default")
	if Global.player_nick == null:
		return
	var new_score = { "name": Global.player_nick, "score": Global.player_score }
	var success = false

	for i in Global.scores.size():
		if new_score.score > Global.scores[i].score:
			Global.scores.insert(i, new_score)
			success = true
			current_scores.append(i)
			
			Global.player_nick = null
			Global.player_score = null
			break

	if !success:
		current_scores.append(Global.scores.size())
		Global.scores.append(new_score)
		Global.player_nick = ""
		Global.player_score = ""

func _write_scores():
	for score_row in scores_count:
		if score_row >= Global.scores.size():
			break
		var row = $Row.duplicate()
		row.visible = true
		row.rect_position.y += score_row * 80
		add_child(row)# tady zjistuje co tam ma byt napsany
		row.get_node("Position").text = str(score_row + 1) + "."
		row.get_node("Name").text = Global.scores[score_row].name
		row.get_node("Score").text = str(Global.scores[score_row].score)
		rows.append(row) #prida do rows pole

	if Global.scores.size() > 100:
		Global.scores.resize(100)

	write_json_file(HIGHSCORE_PATH, { "scores": Global.scores })
	pass

func _input(event):
	if event.is_action_pressed("use"):  #use name
		emit_signal("back")

func _set_timers() -> void:
	blink_timer.connect("timeout", self, "_switch_blink")
	blink_timer.wait_time = BLINK_TIME
	add_child(blink_timer)
	blink_timer.start()

func _switch_blink() -> void:
	for s in current_scores:
		if s < rows.size():
			rows[s].visible = blink
	$Prompt.visible = blink
	blink = !blink

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
