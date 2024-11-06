extends Control

@export var points: Array[RichTextLabel]
@export var revolver : Sprite2D = null
@export var statsText : RichTextLabel = null

@onready var _anim = $AnimPlayer
@onready var _gunAnim = $gunAnim
@onready var sfx_shoot = $SFX_SHOOT
@onready var sfx_noShoot = $SFX_noSHOOT

@onready var x_menus = $X
@export var _x : PackedScene
var currentSlotBullet : int
var currentPlayerSlot : int
var currentPlayer : int
var maxPlayers : int

var _isBullet: bool

var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	currentSlotBullet = rng.randi_range(0,5)
	currentPlayer = 0
	_anim.play("startGame")
	maxPlayers = points.size()
	revolver.look_at(points[currentPlayer].get_global_rect().position)
	stats_update()
	pass 

func getRandomBullet():
	if !_isBullet:
		currentSlotBullet = rng.randi_range(0,5)
		stats_update()
	else:
		print("Ya hay bala")

func shoot():
	currentPlayer += 1
	if currentPlayer >= maxPlayers:
		currentPlayer = 0
	var currentPlayerPos = Vector2(points[currentPlayer].get_global_rect().position)
	revolver.look_at(currentPlayerPos)
	if currentSlotBullet == currentPlayerSlot:
		_gunAnim.play("gunShoot")
		_anim.play("statsRefresh")
	else:
		_gunAnim.play("gunNoShoot")
		_anim.play("statsRefresh")
		
func shootYourself():
	if currentPlayer >= maxPlayers:
		currentPlayer = 0
	var currentPlayerPos = Vector2(points[currentPlayer].get_global_rect().position)
	revolver.look_at(currentPlayerPos)
	if currentSlotBullet == currentPlayerSlot:
		_gunAnim.play("gunShoot")
		_anim.play("statsRefresh")
	else:
		_gunAnim.play("gunNoShoot")
		_anim.play("statsRefresh")

		

func stats_update():
	if maxPlayers == 1:
		win()
	elif maxPlayers > 1 and currentPlayer >= 0 and points[currentPlayer] != null:
		statsText.text = "CurrentPlayer: " + str(points[currentPlayer].text)
	else:
		statsText.text = "No more players remaining."

func winAnim():
	_anim.play("newGame")

func win():
	statsText.text = "The Winner is " + "[wave]"+str(points[0].text)+"[wave]"
	$Botones.hide()
	$WinSFX.play()
	$BotonesJugar.show()
	rotate_revolver_to_zero()

func rotate_revolver_to_zero() -> void:
	while abs(revolver.rotation) > 0.01:  
		revolver.rotation = lerp_angle(revolver.rotation, 0.0, 5 * get_process_delta_time())
		await get_tree().create_timer(0.01).timeout  
	revolver.rotation = 0.0  


func _playAgain():
	var current_scene = get_tree().current_scene 
	get_tree().reload_current_scene()

func kill():
	var _newX = _x.instantiate()
	_newX.global_position = Vector2(points[currentPlayer].position.x - 30, points[currentPlayer].position.y -32)
	x_menus.add_child(_newX)
	points.remove_at(currentPlayer)
	maxPlayers = points.size()
	stats_update()
	if maxPlayers > 0:
		currentPlayer %= maxPlayers  
	else:
		currentPlayer = -1  
	getRandomBullet()
	currentPlayerSlot = 0
	sfx_shoot.play()
	stats_update()

func noKill():
	currentPlayerSlot += 1
	sfx_noShoot.play()
	stats_update()

func closeButton():
	get_tree().quit()
