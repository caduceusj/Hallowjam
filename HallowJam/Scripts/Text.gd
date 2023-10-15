extends CanvasLayer

@onready var textboxContainer = $Control/MarginContainer
@onready var startSymbol = $Control/MarginContainer/Panel/HBoxContainer/Start
@onready var endSymbol = $Control/MarginContainer/Panel/HBoxContainer/End
@onready var label = $Control/MarginContainer/Panel/HBoxContainer/Text
# Called when the node enters the scene tree for the first time.
func HideTextbox() : 
	startSymbol.text = ""
	endSymbol.text = ""
	label.text = ""
	textboxContainer.hide()
	
func ShowTextbox() :
	startSymbol.text = "*" 
	textboxContainer.show()
	
func AddText(nextText) :
	label.text = nextText
	ShowTextbox()
	

func _ready():
	HideTextbox()		


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
