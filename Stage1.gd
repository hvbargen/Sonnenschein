extends Node


func _on_Bunny_score_changed(score):
	$ScoreLabel.text = "%d" % score

func _on_Wurzel_ready():
	$Bunny.set_score(0)
