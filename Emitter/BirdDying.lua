--
-- For more information on emitter properties, see the EmitterObject documentation at:
-- https://docs.coronalabs.com/api/type/EmitterObject/index.html
--

local emitterParams = {

	-- General emitter properties
	textureFileName = "emitter/pena.png", 
	maxParticles = 150,
	angle = 0,
	angleVariance = 1000,
	emitterType = 1,  -- 1hange to 1 for radial emitter type (see below)
	duration = 0.2,

	-- Point/line/field emitter properties
	speed = 10,
	speedVariance = 0,
	sourcePositionVariancex = 0,
	sourcePositionVariancey = 0,
	gravityx = 0,
	gravityy = 0,
	radialAcceleration = 0,
	radialAccelVariance = 0,
	tangentialAcceleration = 0,
	tangentialAccelVariance = 0,

	-- Radial emitter properties
	maxRadius = 10,
	maxRadiusVariance = -10,
	minRadius = 35,
	minRadiusVariance = 10,
	rotatePerSecond = 0,
	rotatePerSecondVariance = 0,

	-- General particle properties
	particleLifespan = 0.7,
	particleLifespanVariance = 0,
	startParticleSize = 20,
	startParticleSizeVariance = 10, 
	finishParticleSize = 20,
	finishParticleSizeVariance = 10,
	rotationStart = 0,
	rotationStartVariance = 0,
	rotationEnd = 0,
	rotationEndVariance = 360,
	
	-- Color/alpha particle properties
	startColorRed = 1,
	startColorGreen = 1,
	startColorBlue = 1,
	startColorAlpha = 1,
	startColorVarianceRed = 0,
	startColorVarianceGreen = 0,
	startColorVarianceBlue = 0,
	startColorVarianceAlpha = 0,
	finishColorRed = 1,
	finishColorGreen = 1,
	finishColorBlue = 1,
	finishColorAlpha = 1,
	finishColorVarianceRed = 0,
	finishColorVarianceGreen = 0,
	finishColorVarianceBlue = 0,
	finishColorVarianceAlpha = 0,
	
	-- Blend mode properties
	blendFuncSource = 1,
	blendFuncDestination = 1
}

return emitterParams
