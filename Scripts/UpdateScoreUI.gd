extends Label

func _ready():
	Signals.connect("updatescore",self,"updatescore")
	
func updatescore(score):
	self.text = String(score)
