/obj/structure/closet/crate/secure/loot/bay_01
	New()
		..()
		new/obj/item/weapon/reagent_containers/food/drinks/bottle/rum(src)
		new/obj/item/weapon/reagent_containers/food/snacks/grown/ambrosiavulgaris/deus(src)
		new/obj/item/weapon/reagent_containers/food/drinks/bottle/whiskey(src)
		new/obj/item/weapon/lighter/zippo(src)

/obj/structure/closet/crate/secure/loot/bay_02
	New()
		..()
		new/obj/item/weapon/pickaxe/drill(src)
		new/obj/item/device/taperecorder(src)
		new/obj/item/clothing/suit/space(src)
		new/obj/item/clothing/head/helmet/space(src)

/obj/structure/closet/crate/secure/loot/bay_03
	New()
		..()
		new/obj/item/weapon/reagent_containers/glass/beaker/bluespace/large(src)

/obj/structure/closet/crate/secure/loot/bay_04
	New()
		..()
		drop_stack(/obj/item/stack/ore/diamond, src, rand(10,20))

/obj/structure/closet/crate/secure/loot/bay_05
	New()
		..()
		for(var/i = 0, i < 3, i++)
			var/obj/machinery/portable_atmospherics/hydroponics/tray = new(src)
			tray.anchored = FALSE

/obj/structure/closet/crate/secure/loot/bay_06
	New()
		..()
		for(var/i = 0, i < 3, i++)
			new/obj/item/weapon/reagent_containers/glass/beaker/noreact/large(src)

/obj/structure/closet/crate/secure/loot/bay_07
	New()
		..()
		for(var/i = 0, i < 9, i++)
			new/obj/item/bluespace_crystal(src)

/obj/structure/closet/crate/secure/loot/bay_08
	New()
		..()
		new/obj/item/weapon/melee/classic_baton(src)

/obj/structure/closet/crate/secure/loot/bay_09
	New()
		..()
		new/obj/item/clothing/under/chameleon(src)
		for(var/i = 0, i < 7, i++)
			new/obj/item/clothing/accessory/tie/horrible(src)

/obj/structure/closet/crate/secure/loot/bay_10
	New()
		..()
		new/obj/item/clothing/under/shorts/red(src)
		new/obj/item/clothing/under/shorts/blue(src)

/obj/structure/closet/crate/secure/loot/bay_11
	New()
		..()
		new/obj/item/weapon/melee/baton/loaded(src)
