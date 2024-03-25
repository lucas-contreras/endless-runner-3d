extends CharacterBody3D

signal has_die;

const SPEED = 1.0
const JUMP_VELOCITY = 4.5

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var arrayPosition = [2.0, 0.0, -2.0];
var currentIndexPosition = 0;

func _physics_process(delta):
	if Input.is_action_just_pressed("ui_left"):
		currentIndexPosition -= 1;
		
	if Input.is_action_just_pressed("ui_right"):
		currentIndexPosition += 1;
	
	currentIndexPosition = clamp(currentIndexPosition, 0 , 2);
	position.x = lerp(position.x, arrayPosition[currentIndexPosition], .2);
	
	velocity.z += SPEED * delta;
	
	if (!is_on_floor()):
		velocity.y -= gravity;

	move_and_slide();


func _on_area_enemy_detection_body_entered(body):
	if (body.is_in_group("Enemy")):
		_die();
		get_tree().reload_current_scene();
	
func _die():
	emit_signal("has_die");
