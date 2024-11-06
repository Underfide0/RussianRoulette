extends Control

@onready var _score : float = 0
@export var _currentScoreText : RichTextLabel = null

@onready var level: int = 1
@onready var cps : int = 1

func _ready():
	pass 

func _process(delta):
	_score += cps * delta  
	var display_score = int(_score)
	_currentScoreText.text = "[center]Current Level: [wave amp=50.0 freq=5.0 connected=1]" + str(display_score) + "[/wave][/center]"
	pass

func _mainClick():
	_score += level
	
