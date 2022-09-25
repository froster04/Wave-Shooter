extends Sprite

var speed = 150
var velocity = Vector2()

var can_shoot = true
var is_dead = false

var bullet = preload("res://Bullet/Bullet.tscn")

func _ready():
	Global.player = self

func _exit_tree():
	Global.player = null

func _process(delta):
	velocity.x = int(Input.is_action_pressed("KEY_D")) - int(Input.is_action_pressed("KEY_A"))
	velocity.y = int(Input.is_action_pressed("KEY_S")) - int(Input.is_action_pressed("KEY_W"))
	
	velocity = velocity.normalized() #fixes higher speed when moving diagnol
	
	global_position.x = clamp(global_position.x, 24, 616)
	global_position.y = clamp(global_position.y, 24, 336)
	
	if is_dead == false:
		global_position += speed * velocity * delta
	
	if Input.is_action_pressed("LMB") and Global.node_creation_parent != null and can_shoot and is_dead == false:
		Global.instance_node(bullet, global_position, Global.node_creation_parent)
		$Reload_speed.start()
		can_shoot = false

func _on_Timer_timeout():
	can_shoot = true


func _on_Hitbox_area_entered(area):
	if area.is_in_group("Enemy"):
		is_dead =true
		visible = false
		yield(get_tree().create_timer(1), "timeout")
		get_tree().reload_current_scene()
