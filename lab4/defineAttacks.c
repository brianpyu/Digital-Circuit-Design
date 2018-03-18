#include "game_structs.h"
#include <stdio.h>
#include <string.h>
/* Import any additional necessary libraries. */

attack* defineAttacks() {
	static attack allAttacks[NUM_ATTACKS];

	// ***********************************************************
	// Attacks for Bulbasaur

	attack tackle;
	strcpy(tackle.name, "Tackle");
	tackle.power = 40;
	tackle.numValue = 0;
	allAttacks[tackle.numValue] = tackle;

	attack vineWhip;
	strcpy(vineWhip.name, "Vine Whip");
	vineWhip.power = 45;
	vineWhip.numValue = 1;
	allAttacks[vineWhip.numValue] = vineWhip;

	attack razorLeaf;
	strcpy(razorLeaf.name, "Razor Leaf");
	razorLeaf.power = 55;
	razorLeaf.numValue = 2;
	allAttacks[razorLeaf.numValue] = razorLeaf;

	attack doubleEdge;
	strcpy(doubleEdge.name, "Double-Edge");
	doubleEdge.power = 120;
	doubleEdge.numValue = 3;
	allAttacks[doubleEdge.numValue] = doubleEdge;

	// ***********************************************************
	// Attacks for Charmander

	attack scratch;
	strcpy(scratch.name, "SCRATCH");
	scratch.power = 5;
	scratch.numValue = 4;
	allAttacks[scratch.numValue] = scratch;

	attack fireFang;
	strcpy(fireFang.name, "Fire Fang");
	fireFang.power = 65;
	fireFang.numValue = 5;
	allAttacks[fireFang.numValue] = fireFang;

	attack flameBurst;
	strcpy(flameBurst.name, "Flame Burst");
	flameBurst.power = 70;
	flameBurst.numValue = 6;
	allAttacks[flameBurst.numValue] = flameBurst;

	attack fireSpin;
	strcpy(fireSpin.name, "Fire Spin");
	fireSpin.power = 35;
	fireSpin.numValue = 7;
	allAttacks[fireSpin.numValue] = fireSpin;

	// ***********************************************************
	// Attacks for Squirtle

	attack waterGun;
	strcpy(waterGun.name, "Water Gun");
	waterGun.power = 40;
	waterGun.numValue = 8;
	allAttacks[waterGun.numValue] = waterGun;

	attack bubble;
	strcpy(bubble.name, "Bubble");
	bubble.power = 40;
	bubble.numValue = 9;
	allAttacks[bubble.numValue] = bubble;

	attack bite;
	strcpy(bite.name, "Bite");
	bite.power = 60;
	bite.numValue = 10;
	allAttacks[bite.numValue] = bite;

	attack rapidSpin;
	strcpy(rapidSpin.name, "Rapid Spin");
	rapidSpin.power = 60;
	rapidSpin.numValue = 11;
	allAttacks[rapidSpin.numValue] = rapidSpin;

	// ***********************************************************
	// Attacks for Pikachu

	attack thunderShock;
	strcpy(thunderShock.name, "Thunder Attack");
	thunderShock.power = 40;
	thunderShock.numValue = 12;
	allAttacks[thunderShock.numValue] = thunderShock;

	attack thunderBolt;
	strcpy(thunderBolt.name, "Thunder Bolt");
	thunderBolt.power = 90;
	thunderBolt.numValue = 13;
	allAttacks[thunderBolt.numValue] = thunderBolt;

	attack spark;
	strcpy(spark.name, "Spark");
	spark.power = 65;
	spark.numValue = 14;
	allAttacks[spark.numValue] = spark;

	attack nuzzle;
	strcpy(nuzzle.name, "Nuzzle");
	nuzzle.power = 20;
	nuzzle.numValue = 15;
	allAttacks[nuzzle.numValue] = nuzzle;

	// ***********************************************************
	// Attacks for Eevee

	attack covet;
	strcpy(covet.name, "Covet");
	covet.power = 60;
	covet.numValue = 16;
	allAttacks[covet.numValue] = covet;

	attack lastResort;
	strcpy(lastResort.name, "Last Resort");
	lastResort.power = 140;
	lastResort.numValue = 17;
	allAttacks[lastResort.numValue] = lastResort;

	attack facade;
	strcpy(facade.name, "Facade");
	facade.power = 70;
	facade.numValue = 18;
	allAttacks[facade.numValue] = facade;

	attack shadowBall;
	strcpy(shadowBall.name, "Shadow Ball");
	shadowBall.power = 80;
	shadowBall.numValue = 19;
	allAttacks[shadowBall.numValue] = shadowBall;

	// ***********************************************************
	// Attacks for Chikorita

	attack hiddenPower;
	strcpy(hiddenPower.name, "Hidden Power");
	hiddenPower.power = 60;
	hiddenPower.numValue = 20;
	allAttacks[hiddenPower.numValue] = hiddenPower;

	attack magicalLeaf;
	strcpy(magicalLeaf.name, "Magical Leaf");
	magicalLeaf.power = 60;
	magicalLeaf.numValue = 21;
	allAttacks[magicalLeaf.numValue] = magicalLeaf;

	attack bodySlam;
	strcpy(bodySlam.name, "Body Slam");
	bodySlam.power = 85;
	bodySlam.numValue = 22;
	allAttacks[bodySlam.numValue] = bodySlam;

	attack solarBeam;
	strcpy(solarBeam.name, "Solar Beam");
	solarBeam.power = 120;
	solarBeam.numValue = 23;
	allAttacks[solarBeam.numValue] = solarBeam;

	// ***********************************************************
	// Attacks for Cyndaquil

	attack flameWheel;
	strcpy(flameWheel.name, "Flame Wheel");
	flameWheel.power = 60;
	flameWheel.numValue = 24;
	allAttacks[flameWheel.numValue] = flameWheel;

	attack flamethrower;
	strcpy(flamethrower.name, "Flamethrower");
	flamethrower.power = 90;
	flamethrower.numValue = 25;
	allAttacks[flamethrower.numValue] = flamethrower;

	attack inferno;
	strcpy(inferno.name, "Inferno");
	inferno.power = 100;
	inferno.numValue = 26;
	allAttacks[inferno.numValue] = inferno;

	attack eruption;
	strcpy(eruption.name, "Eruption");
	eruption.power = 150;
	eruption.numValue = 27;
	allAttacks[eruption.numValue] = eruption;

	// ***********************************************************
	// Attacks for Totodile

	attack rage;
	strcpy(rage.name, "Rage");
	rage.power = 20;
	rage.numValue = 28;
	allAttacks[rage.numValue] = rage;

	attack chipAway;
	strcpy(chipAway.name, "Chip Away");
	chipAway.power = 70;
	chipAway.numValue = 29;
	allAttacks[chipAway.numValue] = chipAway;

	attack slash;
	strcpy(slash.name, "Slash");
	slash.power = 70;
	slash.numValue = 30;
	allAttacks[slash.numValue] = slash;

	attack hydroPump;
	strcpy(hydroPump.name, "Hydro Pump");
	hydroPump.power = 110;
	hydroPump.numValue = 31;
	allAttacks[hydroPump.numValue] = hydroPump;

	return allAttacks;
}
