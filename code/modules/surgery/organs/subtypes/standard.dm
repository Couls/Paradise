/****************************************************
			   ORGAN DEFINES
****************************************************/

/obj/item/organ/external/chest
	name = "upper body"
	limb_name = "chest"
	icon_name = "torso"
	max_damage = 100
	min_broken_damage = 35
	w_class = WEIGHT_CLASS_HUGE
	body_part = UPPER_TORSO
	vital = TRUE
	amputation_point = "spine"
	gendered_icon = 1
	parent_organ = null
	max_stamina_damage = 100
	encased = "ribcage"
	var/fat = FALSE
	convertable_children = list(/obj/item/organ/external/groin)

/obj/item/organ/external/chest/proc/makeFat(update_body_icon = 1)
	fat = TRUE
	if(owner)
		owner.update_body(update_body_icon)
	else
		// get_icon updates the sprite icon, update_icon updates the injuries overlay.
		// Madness.
		get_icon()

/obj/item/organ/external/chest/proc/makeSlim(update_body_icon = 1)
	fat = FALSE
	if(owner)
		owner.update_body(update_body_icon)
	else
		// get_icon updates the sprite icon, update_icon updates the injuries overlay.
		// Madness.
		get_icon()

/obj/item/organ/external/groin
	name = "lower body"
	limb_name = "groin"
	icon_name = "groin"
	max_damage = 100
	max_stamina_damage = 100
	min_broken_damage = 35
	w_class = WEIGHT_CLASS_BULKY // if you know what I mean ;)
	body_part = LOWER_TORSO
	vital = TRUE
	parent_organ = "chest"
	amputation_point = "lumbar"
	gendered_icon = 1

/obj/item/organ/external/arm
	limb_name = "l_arm"
	name = "left arm"
	icon_name = "l_arm"
	max_damage = 50
	min_broken_damage = 30
	body_damage_coeff = 0.75
	w_class = WEIGHT_CLASS_NORMAL
	body_part = ARM_LEFT
	parent_organ = "chest"
	amputation_point = "left shoulder"
	can_grasp = 1
	convertable_children = list(/obj/item/organ/external/hand)
	stam_heal_tick = 2
	max_stamina_damage = 50

/obj/item/organ/external/arm/set_disabled(new_disabled = TRUE)
	. = ..()
	if(disabled)
		to_chat(owner, "<span class='userdanger'>Your [name] is too damaged to function!</span>")
		owner.emote("scream")
		if(body_part == ARM_LEFT)
			owner.drop_l_hand()
		else
			owner.drop_r_hand()

/obj/item/organ/external/arm/right
	limb_name = "r_arm"
	name = "right arm"
	icon_name = "r_arm"
	body_part = ARM_RIGHT
	amputation_point = "right shoulder"
	convertable_children = list(/obj/item/organ/external/hand/right)

/obj/item/organ/external/leg
	limb_name = "l_leg"
	name = "left leg"
	icon_name = "l_leg"
	max_damage = 50
	min_broken_damage = 30
	body_damage_coeff = 0.75
	w_class = WEIGHT_CLASS_NORMAL
	body_part = LEG_LEFT
	icon_position = LEFT
	parent_organ = "groin"
	amputation_point = "left hip"
	can_stand = 1
	convertable_children = list(/obj/item/organ/external/foot)
	stam_heal_tick = 2
	max_stamina_damage = 50

/obj/item/organ/external/leg/set_disabled(new_disabled = TRUE)
	. = ..()
	if(disabled)
		to_chat(owner, "<span class='userdanger'>Your [name] is too damaged to function!</span>")
		owner.emote("scream")

/obj/item/organ/external/leg/right
	limb_name = "r_leg"
	name = "right leg"
	icon_name = "r_leg"
	body_part = LEG_RIGHT
	icon_position = RIGHT
	amputation_point = "right hip"
	convertable_children = list(/obj/item/organ/external/foot/right)

/obj/item/organ/external/foot
	limb_name = "l_foot"
	name = "left foot"
	icon_name = "l_foot"
	max_damage = 30
	min_broken_damage = 15
	body_damage_coeff = 0.50
	w_class = WEIGHT_CLASS_SMALL
	body_part = FOOT_LEFT
	icon_position = LEFT
	parent_organ = "l_leg"
	amputation_point = "left ankle"
	can_stand = 1
	stam_heal_tick = 2
	max_stamina_damage = 30

/obj/item/organ/external/foot/set_disabled(new_disabled = TRUE)
	. = ..()
	if(disabled)
		to_chat(owner, "<span class='userdanger'>Your [name] is too damaged to function!</span>")
		owner.emote("scream")

/obj/item/organ/external/foot/remove()
	if(owner && owner.shoes) owner.unEquip(owner.shoes)
	. = ..()

/obj/item/organ/external/foot/right
	limb_name = "r_foot"
	name = "right foot"
	icon_name = "r_foot"
	body_part = FOOT_RIGHT
	icon_position = RIGHT
	parent_organ = "r_leg"
	amputation_point = "right ankle"

/obj/item/organ/external/hand
	limb_name = "l_hand"
	name = "left hand"
	icon_name = "l_hand"
	max_damage = 30
	min_broken_damage = 15
	body_damage_coeff = 0.50
	w_class = WEIGHT_CLASS_SMALL
	body_part = HAND_LEFT
	parent_organ = "l_arm"
	amputation_point = "left wrist"
	can_grasp = 1
	stam_heal_tick = 2
	max_stamina_damage = 30

/obj/item/organ/external/hand/set_disabled(new_disabled = TRUE)
	. = ..()
	if(disabled)
		to_chat(owner, "<span class='userdanger'>Your [name] is too damaged to function!</span>")
		owner.emote("scream")
		if(body_part == HAND_LEFT)
			owner.drop_l_hand()
		else
			owner.drop_r_hand()
		if(owner.hud_used)
			var/obj/screen/inventory/hand/L = owner.hud_used.inv_slots[slot_l_hand]
			var/obj/screen/inventory/hand/R = owner.hud_used.inv_slots[slot_r_hand]
			if(L && R)
				L.update_icon()
				R.update_icon()

/obj/item/organ/external/hand/remove()
	if(owner)
		if(owner.gloves)
			owner.unEquip(owner.gloves)
		if(owner.l_hand)
			owner.unEquip(owner.l_hand, TRUE)
		if(owner.r_hand)
			owner.unEquip(owner.r_hand, TRUE)

	. = ..()

/obj/item/organ/external/hand/right
	limb_name = "r_hand"
	name = "right hand"
	icon_name = "r_hand"
	body_part = HAND_RIGHT
	parent_organ = "r_arm"
	amputation_point = "right wrist"

/obj/item/organ/external/head
	limb_name = "head"
	icon_name = "head"
	name = "head"
	max_damage = 75
	max_stamina_damage = 100 // so you can put people in stamina crit by aiming for the head
	min_broken_damage = 35
	w_class = WEIGHT_CLASS_NORMAL
	body_part = HEAD
	parent_organ = "chest"
	amputation_point = "neck"
	gendered_icon = 1
	encased = "skull"
	var/can_intake_reagents = 1
	var/alt_head = "None"

	//Hair colour and style
	var/hair_colour = "#000000"
	var/sec_hair_colour = "#000000"
	var/h_style = "Bald"

	//Head accessory colour and style
	var/headacc_colour = "#000000"
	var/ha_style = "None"

	//Facial hair colour and style
	var/facial_colour = "#000000"
	var/sec_facial_colour = "#000000"
	var/f_style = "Shaved"

/obj/item/organ/external/head/remove()
	if(owner)
		if(!istype(dna))
			dna = owner.dna.Clone()
		name = "[dna.real_name]'s head"
		if(owner.glasses)
			owner.unEquip(owner.glasses)
		if(owner.head)
			owner.unEquip(owner.head)
		if(owner.l_ear)
			owner.unEquip(owner.l_ear)
		if(owner.r_ear)
			owner.unEquip(owner.r_ear)
		if(owner.wear_mask)
			owner.unEquip(owner.wear_mask)
		owner.update_hair()
		owner.update_fhair()
		owner.update_head_accessory()
		owner.update_markings()
	. = ..()

/obj/item/organ/external/head/replaced()
	name = limb_name
	..()

/obj/item/organ/external/head/receive_damage(brute, burn, stamina, sharp, used_weapon = null, list/forbidden_limbs = list(), ignore_resists = FALSE)
	..()
	if(!disfigured)
		if(total_damage() > 50)
			disfigure()

/obj/item/organ/external/head/proc/handle_alt_icon()
	if(alt_head && GLOB.alt_heads_list[alt_head])
		var/datum/sprite_accessory/alt_heads/alternate_head = GLOB.alt_heads_list[alt_head]
		if(alternate_head.icon_state)
			icon_name = alternate_head.icon_state
		else //If alternate_head.icon_state doesn't exist, that means alternate_head is "None", so default icon_name back to "head".
			icon_name = initial(icon_name)
	else //If alt_head is null, set it to "None" and default icon_name for sanity.
		alt_head = initial(alt_head)
		icon_name = initial(icon_name)

/obj/item/organ/external/head/robotize(company, make_tough = 0, convert_all = 1) //Undoes alt_head business to avoid getting in the way of robotization. Make sure we pass all args down the line...
	alt_head = initial(alt_head)
	icon_name = initial(icon_name)
	..()

/obj/item/organ/external/head/set_dna(datum/dna/new_dna)
	..()
	new_dna.write_head_attributes(src)
