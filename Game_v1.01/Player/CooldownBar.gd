extends TextureProgress

func _ready():
	$BlinkTimer.start()

func _on_BlinkTimer_timeout():
	if $CDProgressBar.value < 100:
		$CDProgressBar.value += 1
	else:
		$RightBR_1.visible = true
