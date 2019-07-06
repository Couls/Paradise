/*
//////////////////////////////////////

Spontaneous Combustion

	Slightly hidden.
	Lowers resistance tremendously.
	Decreases stage tremendously.
	Decreases transmittablity tremendously.
	Fatal Level.

Bonus
	Ignites infected mob.

//////////////////////////////////////
*/

/datum/symptom/fire

	name = "Spontaneous Combustion"
	desc = "The virus turns fat into an extremely flammable compound, and raises the body's temperature, making the host burst into flames spontaneously."
	stealth = 1
	resistance = -4
	stage_speed = -4
	transmittable = -4
	level = 6
	severity = 5
	base_message_chance = 20
	symptom_delay_min = 20
	symptom_delay_max = 75
	var/infective = FALSE
	threshold_desc = "<b>Stage Speed 4:</b> Increases the intensity of the flames.<br>\
					  <b>Stage Speed 8:</b> Further increases flame intensity.<br>\
					  <b>Transmission 8:</b> Host will spread the virus through skin flakes when bursting into flame.<br>\
					  <b>Stealth 4:</b> The symptom remains hidden until active."

/datum/symptom/fire/Start(datum/disease/advance/A)
	if(!..())
		return
	if(A.properties["stage_rate"] >= 4)
		power = 1.5
	if(A.properties["stage_rate"] >= 8)
		power = 2
	if(A.properties["stealth"] >= 4)
		suppress_warning = TRUE
	if(A.properties["transmittable"] >= 8) //burning skin spreads the virus through smoke
		infective = TRUE

/datum/symptom/fire/Activate(datum/disease/advance/A)
	if(!..())
		return
	var/mob/living/M = A.affected_mob
	switch(A.stage)
		if(3)
			if(prob(base_message_chance) && !suppress_warning)
				to_chat(M, "<span class='warning'>[pick("You feel hot.", "You hear a crackling noise.", "You smell smoke.")]</span>")
		if(4)
			Firestacks_stage_4(M, A)
			M.IgniteMob()
			to_chat(M, "<span class='userdanger'>Your skin bursts into flames!</span>")
			M.emote("scream")
		if(5)
			Firestacks_stage_5(M, A)
			M.IgniteMob()
			to_chat(M, "<span class='userdanger'>Your skin erupts into an inferno!</span>")
			M.emote("scream")

/datum/symptom/fire/proc/Firestacks_stage_4(mob/living/M, datum/disease/advance/A)
	M.adjust_fire_stacks(1 * power)
	M.take_overall_damage(burn = 3 * power)
	if(infective)
		A.spread(2)
	return 1

/datum/symptom/fire/proc/Firestacks_stage_5(mob/living/M, datum/disease/advance/A)
	M.adjust_fire_stacks(3 * power)
	M.take_overall_damage(0,burn = 5 * power)
	if(infective)
		A.spread(4)
	return 1
