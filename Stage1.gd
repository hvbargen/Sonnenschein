extends Node

var time : float

func _on_Bunny_score_changed(score):
	$ScoreLabel.text = "%d" % score

func _on_Wurzel_ready():
	$Bunny.set_score(0)
	time = 0.0
	
func _process(delta):
	time += delta
	var textlist = ("%6.1f" % time).split(".")
	var secs:String = textlist[0]
	var fracs:String = textlist[1]
	#print(secs,".",fracs)
	$TimeHBox/TimeLabelSec.text = secs.strip_edges() + "."
	$TimeHBox/TimeLabelFrac.text = fracs
