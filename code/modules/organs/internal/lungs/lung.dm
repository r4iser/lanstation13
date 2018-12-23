
///////////////////////
// LUNG ORGAN
///////////////////////

/datum/organ/internal/lungs
	name = "lungs"
	parent_organ = LIMB_CHEST
	organ_type = "lungs"
	removed_type = /obj/item/organ/internal/lungs

	min_bruised_damage = 8
	min_broken_damage = 15

	// /vg/ now delegates breathing to the appropriate organ.

	// DEFAULTS FOR HUMAN LUNGS:
	var/list/datum/lung_gas/gasses = list(
		new /datum/lung_gas/metabolizable("oxygen",            min_pp=16, max_pp=140),
		new /datum/lung_gas/waste("carbon_dioxide",            max_pp=10),
		new /datum/lung_gas/toxic("toxins",                    max_pp=0.5, max_pp_mask=5, reagent_id=PLASMA, reagent_mult=0.1),
		new /datum/lung_gas/sleep_agent("/datum/gas/sleeping_agent", trace_gas=1, min_giggle_pp=0.15, min_para_pp=1, min_sleep_pp=5),
	)

	var/inhale_volume = BREATH_VOLUME
	var/exhale_moles = 0

/datum/organ/internal/lungs/proc/gasp()
	owner.emote("gasp")

/datum/organ/internal/lungs/proc/handle_breath(var/datum/gas_mixture/breath, var/mob/living/carbon/human/H)

	// NOW WITH MODULAR GAS HANDLING RATHER THAN A CLUSTERFUCK OF IF-TREES FOR EVERY SNOWFLAKE RACE
	//testing("Ticking lungs...")

	// First, we consume air.
	for(var/datum/lung_gas/G in gasses)
		G.set_context(src,breath,H)
		G.handle_inhale()

	// Next, we exhale. At the moment, only /datum/lung_gas/waste uses this.
	for(var/datum/lung_gas/G in gasses)
		G.set_context(src,breath,H)
		G.handle_exhale()

	if( (abs(310.15 - breath.temperature) > 50) && !(M_RESIST_HEAT in H.mutations)) // Hot air hurts :(
		if(H.status_flags & GODMODE)
			return 1	//godmode
		if(breath.temperature < H.species.cold_level_1)
			if(prob(20))
				H << "<span class='warning'>I feel my face freezing and an icicle forming in my lungs!</span>"
		else if(breath.temperature > H.species.heat_level_1)
			if(prob(20))
				if(isslimeperson(H))
					H << "<span class='warning'>I feel supercharged by the extreme heat!</span>"
				else
					H << "<span class='warning'>I feel my face burning and a searing heat in my lungs!</span>"

		if(isslimeperson(H))
			if(breath.temperature < H.species.cold_level_1)
				H.adjustToxLoss(round(H.species.cold_level_1 - breath.temperature))
				H.fire_alert = max(H.fire_alert, 1)
		else
			switch(breath.temperature)
				if(-INFINITY to H.species.cold_level_3)
					H.apply_damage(COLD_GAS_DAMAGE_LEVEL_3, BURN, LIMB_HEAD, used_weapon = "Excessive Cold")
					H.fire_alert = max(H.fire_alert, 1)

				if(H.species.cold_level_3 to H.species.cold_level_2)
					H.apply_damage(COLD_GAS_DAMAGE_LEVEL_2, BURN, LIMB_HEAD, used_weapon = "Excessive Cold")
					H.fire_alert = max(H.fire_alert, 1)

				if(H.species.cold_level_2 to H.species.cold_level_1)
					H.apply_damage(COLD_GAS_DAMAGE_LEVEL_1, BURN, LIMB_HEAD, used_weapon = "Excessive Cold")
					H.fire_alert = max(H.fire_alert, 1)

				if(H.species.heat_level_1 to H.species.heat_level_2)
					H.apply_damage(HEAT_GAS_DAMAGE_LEVEL_1, BURN, LIMB_HEAD, used_weapon = "Excessive Heat")
					H.fire_alert = max(H.fire_alert, 2)

				if(H.species.heat_level_2 to H.species.heat_level_3)
					H.apply_damage(HEAT_GAS_DAMAGE_LEVEL_2, BURN, LIMB_HEAD, used_weapon = "Excessive Heat")
					H.fire_alert = max(H.fire_alert, 2)

				if(H.species.heat_level_3 to INFINITY)
					H.apply_damage(HEAT_GAS_DAMAGE_LEVEL_3, BURN, LIMB_HEAD, used_weapon = "Excessive Heat")
					H.fire_alert = max(H.fire_alert, 2)

/datum/organ/internal/lungs/process()
	..()
	if (germ_level > INFECTION_LEVEL_ONE)
		if(prob(5))
			owner.audible_cough()		//respitory tract infection

	if(is_bruised())
		var/chance = min(50, (damage-min_bruised_damage)/min_broken_damage*50)
		if(prob(chance))
			spawn owner.emote("me", 1, "gasps for air!")
			if (owner.losebreath <= 30)
				owner.losebreath += 5
		else if(prob(chance))
			spawn owner.emote("me", 1, "coughs up blood!")
			owner.drip(10)


/datum/organ/internal/lungs/vox
	name = "\improper Vox lungs"
	removed_type = /obj/item/organ/internal/lungs/vox

	gasses = list(
		new /datum/lung_gas/metabolizable("nitrogen",          min_pp=16, max_pp=140),
		new /datum/lung_gas/waste("carbon_dioxide",            max_pp=10), // I guess? Ideally it'd be some sort of nitrogen compound.  Maybe N2O?
		new /datum/lung_gas/toxic(OXYGEN,                    max_pp=0.5, max_pp_mask=0, reagent_id=OXYGEN, reagent_mult=0.1),
		new /datum/lung_gas/sleep_agent("/datum/gas/sleeping_agent", trace_gas=1, min_giggle_pp=0.15, min_para_pp=1, min_sleep_pp=5),
	)


/datum/organ/internal/lungs/plasmaman
	name = "\improper Plasmaman lungs"
	removed_type = /obj/item/organ/internal/lungs/plasmaman

	gasses = list(
		new /datum/lung_gas/metabolizable("toxins", min_pp=16, max_pp=140),
		new /datum/lung_gas/waste("carbon_dioxide",         max_pp=10),
		new /datum/lung_gas/sleep_agent("/datum/gas/sleeping_agent", trace_gas=1, min_giggle_pp=0.15, min_para_pp=1, min_sleep_pp=5),
	)
