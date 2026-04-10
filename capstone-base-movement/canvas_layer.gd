extends CanvasLayer
@onready var pain_bar: ProgressBar = $PainBar
@onready var blood_bar: ProgressBar = $BloodBar
func update() :
	pain_bar.update()
	blood_bar.update()
