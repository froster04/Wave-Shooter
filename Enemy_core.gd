extends Sprite

export(int) var speed = 75
var velocity = Vector2()

var stun = false
export(int) var hp = 3
export(int) var knockback = 600
export(int) var screen_shake = 60

onready var current_colour = modulate

var blood_particels = preload("res://BloodParticle/Blood_particles.tscn")

func _process(_delta):
	if hp <=0:
		if Global.camera != null:
			Global.camera.screen_shake(screen_shake, 0.2)
		
		Global.points += 10
		if Global.node_creation_parent != null:
			var blood_particle_instance = Global.instance_node(blood_particels, global_position, Global.node_creation_parent)
			blood_particle_instance.rotation = velocity.angle()
		queue_free()


func basic_movement_towards_player(delta):
	if Global.player != null and stun == false:
		velocity = global_position.direction_to(Global.player.global_position)
		global_position += speed * velocity * delta
	elif stun:
		velocity = lerp(velocity, Vector2(0, 0), 0.3)
		global_position += velocity * delta

func _on_Hitbox_area_entered(area):
	if area.is_in_group("Enemy_damage") and stun == false:
		modulate = Color.white
		velocity = -velocity * knockback
		hp -= 1
		stun = true
		$Stun_timer.start()
		area.get_parent().queue_free()

func _on_Timer_timeout():
	modulate = current_colour
	stun = false
