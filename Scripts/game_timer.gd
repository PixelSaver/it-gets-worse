extends Timer
class_name GameTimer
signal timer_update(new_timer_value:float)
var counting : bool = false
var total_time : float = 0


func _ready() -> void:
	Global.game_timer = self
	self.game_time_start()

func _process(delta: float) -> void:
	if counting == false: return
	total_time += delta
	timer_update.emit(total_time)

func game_time_start():
	counting = true
