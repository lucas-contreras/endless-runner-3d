extends CanvasLayer

var timer := 0.0: 
	set (value):
		timer = value;
		$Label.text = str(value);

func _on_timer_timeout():
	timer += $Timer.wait_time;
