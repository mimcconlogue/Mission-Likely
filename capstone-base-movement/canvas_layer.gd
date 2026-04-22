extends CanvasLayer
@onready var pain_bar: ProgressBar = $PainBar
@onready var blood_bar: ProgressBar = $BloodBar
@onready var stamina_bar: ProgressBar = $StaminaBar
func update() :
	pain_bar.update()
	blood_bar.update()
	stamina_bar.update()

func _process(_delta: float) -> void:
	update()
