/mob/living/carbon/update_stat(reason = "none given")
	if(status_flags & GODMODE)
		return
	if(stat != DEAD)
//		if(health <= min_health)
		if(health <= HEALTH_THRESHOLD_DEAD && check_death_method())
			death()
			create_debug_log("died of damage, trigger reason: [reason]")
			return
//		if(paralysis || sleeping || getOxyLoss() > low_oxy_ko || (status_flags & FAKEDEATH) || health <= crit_health)
		if(paralysis || sleeping || (check_death_method() && getOxyLoss() > 50) || (status_flags & FAKEDEATH) || health <= HEALTH_THRESHOLD_FULLCRIT && check_death_method())
			if(stat == CONSCIOUS)
				KnockOut()
				create_debug_log("fell unconscious, trigger reason: [reason]")
		else
			if(health <= HEALTH_THRESHOLD_CRIT)
				stat = SOFT_CRIT
			else if(stat == UNCONSCIOUS)
				WakeUp()
				create_debug_log("woke up, trigger reason: [reason]")

/mob/living/carbon/update_stamina()
	..()
	if(staminaloss)
		var/total_health = (health - staminaloss)
		if(total_health <= HEALTH_THRESHOLD_CRIT && !stat)
			to_chat(src, "<span class='notice'>You're too exhausted to keep going...</span>")
			Weaken(5)
			setStaminaLoss(health - 2)
			handle_hud_icons_health()
			return

/mob/living/carbon/can_hear()
	. = FALSE
	var/obj/item/organ/internal/ears/ears = get_int_organ(/obj/item/organ/internal/ears)
	if(istype(ears) && !ears.deaf)
		. = TRUE