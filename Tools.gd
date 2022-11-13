extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var countVoda = 0
var countBible = 0
var countSul = 0
var countKriz = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	$HBoxContainer/Voda.grab_focus()
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
func _on_Voda_pressed():
	countVoda += 1 
	if countBible + countSul + countKriz == 0:
		if countVoda == 1:
			$RichTextLabel.set_text("Drzis vodu")
		if countVoda == 2: 
			$RichTextLabel.set_text("Pouzivas vodu")
		if countVoda == 3:
			$RichTextLabel.set_text("Pokladas vodu")
		elif countVoda == 4:
			countVoda = 0
			$RichTextLabel.set_text("Nic nedrzis")
	else:
		 $RichTextLabel.set_text("Nemozny move")
		
func _on_Bible_pressed():
	countBible += 1 
	if countVoda + countSul + countKriz == 0:
		if countBible == 1:
			$RichTextLabel.set_text("Drzis Bibli")
		if countBible == 2: 
			$RichTextLabel.set_text("Pouzivas Bibli")
		if countBible == 3:
			$RichTextLabel.set_text("Pokladas Bibli")
		elif countBible == 4:
			countBible = 0
			$RichTextLabel.set_text("Nic nedrzis")
	else:
		 $RichTextLabel.set_text("Nemozny move")
	
func _on_Sul_pressed():
	countSul += 1 
	if countVoda + countBible + countKriz == 0:
		if countSul == 1:
			$RichTextLabel.set_text("Drzis sul")
		if countSul == 2: 
			$RichTextLabel.set_text("Pouzivas sul")
		if countSul == 3:
			$RichTextLabel.set_text("Pokladas sul")
		elif countSul == 4:
			countSul = 0
			$RichTextLabel.set_text("Nic nedrzis")
	else:
		 $RichTextLabel.set_text("Nemozny move")


func _on_Kriz_pressed():
	countKriz += 1 
	if countVoda + countBible + countSul == 0:
		if countKriz == 1:
			$RichTextLabel.set_text("Drzis kriz")
		if countKriz == 2: 
			$RichTextLabel.set_text("Pouzivas kriz")
		if countKriz == 3:
			$RichTextLabel.set_text("Pokladas kriz")
		elif countKriz == 4:
			countKriz = 0
			$RichTextLabel.set_text("Nic nedrzis")
	else:
		 $RichTextLabel.set_text("Nemozny move")
