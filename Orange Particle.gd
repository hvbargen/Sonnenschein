extends Sprite


onready var audio = get_node("AudioPlayer") as AudioStreamPlayer2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_OrangeArea_body_entered(body):
	print(self.name, " on_OrangeArea_body_entered ", body.name)
	body.set_score(body.score + 10)
	audio.play(1.0)


func _on_AudioPlayer_finished():
	print("Audio finished")
	queue_free()
