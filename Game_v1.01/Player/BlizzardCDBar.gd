extends TextureProgress


func _ready():
	$Skill1Timer.start()

func _on_Skill1Timer_timeout():
	if $CDProgressBar.value < 100:
		$CDProgressBar.value += 1
	else:
		$RightBR_1.visible = true
