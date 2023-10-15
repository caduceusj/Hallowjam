extends CanvasLayer

@onready var State = get_node("/root/PlayerState")
@onready var textboxContainer = $Control/MarginContainer
@onready var startSymbol = $Control/MarginContainer/Panel/HBoxContainer/Start
@onready var endSymbol = $Control/MarginContainer/Panel/HBoxContainer/End
@onready var label = $Control/MarginContainer/Panel/HBoxContainer/Text
var currentOldValue
# Called when the node enters the scene tree for the first time.
func _ready():
	HideTextbox()
	AddText("")
	currentOldValue = State.currentHealth
	$TextureProgressBar.max_value = State.maxHealth
	$TextureProgressBar.min_value = State.minHealth
	$TextureProgressBar.value = State.currentHealth
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(currentOldValue != State.currentHealth):
		$TextureProgressBar.value = lerp(currentOldValue, State.currentHealth, 0.5)
		currentOldValue = State.currentHealth
	if(State.currentItems.size() == 0):
		$TextureRect/Sprite2D.hide()
	else:
		$TextureRect/Sprite2D.show()

	if(State.currentSkill == "Axe"):
		$TextureRect/Sprite2D.frame = 0
	elif(State.currentSkill == "Flame"):
		$TextureRect/Sprite2D.frame = 1
	elif(State.currentSkill == "Hammer"):
		$TextureRect/Sprite2D.frame = 2
	elif(State.currentSkill == "Web"):
		$TextureRect/Sprite2D.frame = 3
	
	
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
