extends MarginContainer

const startScene = preload("res://Cenas/Map.tscn")

@onready var selectorOne = $CenterContainer/VBoxContainer/CenterContainer2/VBoxContainer/CenterContainer/HBoxContainer/Selector
@onready var selectorTwo = $CenterContainer/VBoxContainer/CenterContainer2/VBoxContainer/CenterContainer2/HBoxContainer/Selector
@onready var selectorThree = $CenterContainer/VBoxContainer/CenterContainer2/VBoxContainer/CenterContainer3/HBoxContainer/Selector

var currentSelection = 0

func setCurrentSelection(currentSelection) :
	selectorOne.text = ""
	selectorTwo.text = ""
	selectorThree.text = ""
	if currentSelection == 0 :
		selectorOne.text = ">"
	elif currentSelection == 1 :
		selectorTwo.text = ">"
	else :
		selectorThree.text = ">"	

func handleSelection(currentSelection) :
	if(currentSelection == 0) :
		get_tree().get_root().add_child(startScene.instance())	
		queue_free()	
	elif(currentSelection == 2) :
		get_tree().quit()
		
# Called when the node enters the scene tree for the first time.
func _ready():
	setCurrentSelection(0)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(Input.is_action_just_pressed("ui_down")) :
		if(currentSelection < 2) :
			currentSelection += 1		
		else :
			currentSelection = 0
	elif(Input.is_action_just_pressed("ui_up")) :
		if(currentSelection > 0) :
			currentSelection -= 1
		else :
			currentSelection = 2
	setCurrentSelection(currentSelection)
	if(Input.is_action_just_pressed("ui_accept")) :
		handleSelection(currentSelection)
