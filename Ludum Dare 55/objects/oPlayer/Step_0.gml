/// @description Main Gameplay
input();
//Animation
pAnimation();
//Check if grounded
checkGrounded();
//ALIVE
if (hp > 0) {
	//Movement
	pMovement();
	//Talisman Action
	pTalisman();

	//Get damage by spikes
	if (place_meeting(x, y, oSpikes)) {
		pDamage();
		
		
	}
	//Skip Level
		if (nextlevel) room_goto_next();

}
//DED
else if (hp <= 0) {
	movement.hspd = 0;
	movement.vspd = 0;
	visible = false;
	
	//Get taken apart
	if (!instance_exists(oPlayerPart)) {
		for (var i = 0; i < sprite_get_number(sPlayerParts); i++) {
			var _part = instance_create_depth(x, y - 20, depth, oPlayerPart);
			_part.image_index = i;
			var _dir = irandom_range(15, 180 - 15);
			var _len = 14;
			_part.hspd = lengthdir_x(_len, _dir);
			_part.vspd = lengthdir_y(_len, _dir);
			_part.rotationSpd = irandom_range(5, 20);
		}
	}
	
	//Retry
	if (restart) {
		with (oPlayerPart) instance_destroy();
		visible = true;
		room_restart();
	}
}

//Move Player
movement.vspd = collisionsY(movement.vspd);