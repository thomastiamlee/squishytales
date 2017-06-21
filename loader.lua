function loadResources()
	-- Sheets
	gameSheetImage = love.graphics.newImage("assets/game.png")
	logoImage = love.graphics.newImage("assets/title.png")
	loveLogoImage = love.graphics.newImage("assets/love-bubble.png")
	excelsiorLogoImage = love.graphics.newImage("assets/excelsior-bubble.png")
	ohnoImage = love.graphics.newImage("assets/ohno.png")
	menuBgImage = love.graphics.newImage("assets/menuback.png")
	seafloorBackImage = love.graphics.newImage("assets/seafloor-back.png")
	seafloorMiddleImage = love.graphics.newImage("assets/seafloor-middle.png")
	seafloorFrontImage = love.graphics.newImage("assets/seafloor-front.png")
	-- Fonts
	quicksandFont = love.graphics.newFont("assets/quicksand.otf", 24)
	-- Music
	introBgm = love.audio.newSource("assets/bgm/sunshine.mp3", "stream")
	introBgm:setVolume(0.1)
	seafloorBgm = love.audio.newSource("assets/bgm/wallpaper.mp3", "stream")
	seafloorBgm:setVolume(0.1)
	-- SFX
	popSfx = love.audio.newSource("assets/sfx/pop.mp3", "static")
	popSfx:setVolume(1)
	splatSfx = love.audio.newSource("assets/sfx/splat.mp3", "static")
	splatSfx:setVolume(0.2)
	ouchSfx = love.audio.newSource("assets/sfx/ouch.wav", "static")
	ouchSfx:setVolume(0.2)
	-- Shaders
	underwatershader = love.graphics.newShader[[
		uniform vec2      iResolution;           // viewport resolution (in pixels)
		uniform float     iGlobalTime;           // shader playback time (in seconds)
		
		float rayStrength(vec2 raySource, vec2 rayRefDirection, vec2 coord, float seedA, float seedB, float speed) {
			vec2 sourceToCoord = coord - raySource;
			float cosAngle = dot(normalize(sourceToCoord), rayRefDirection);
			
			return clamp(
				(0.45 + 0.15 * sin(cosAngle * seedA + iGlobalTime * speed)) +
				(0.3 + 0.2 * cos(-cosAngle * seedB + iGlobalTime * speed)),
				0.0, 1.0) *
				clamp((iResolution.x - length(sourceToCoord)) / iResolution.x, 0.5, 1.0);
		}

		vec4 mainImage(in vec2 fragCoord ) {
			vec4 fragColor;
			vec2 uv = fragCoord.xy / iResolution.xy;
			uv.y = 1.0 - uv.y;
			vec2 coord = vec2(fragCoord.x, iResolution.y - fragCoord.y);
			
			
			// Set the parameters of the sun rays
			vec2 rayPos1 = vec2(iResolution.x * 0.7, iResolution.y * -0.4);
			vec2 rayRefDir1 = normalize(vec2(1.0, -0.116));
			float raySeedA1 = 36.2214;
			float raySeedB1 = 21.11349;
			float raySpeed1 = 1.5;
			
			vec2 rayPos2 = vec2(iResolution.x * 0.8, iResolution.y * -0.6);
			vec2 rayRefDir2 = normalize(vec2(1.0, 0.241));
			const float raySeedA2 = 22.39910;
			const float raySeedB2 = 18.0234;
			const float raySpeed2 = 1.1;
			
			// Calculate the colour of the sun rays on the current fragment
			vec4 rays1 =
				vec4(1.0, 1.0, 1.0, 1.0) *
				rayStrength(rayPos1, rayRefDir1, coord, raySeedA1, raySeedB1, raySpeed1);
			 
			vec4 rays2 =
				vec4(1.0, 1.0, 1.0, 1.0) *
				rayStrength(rayPos2, rayRefDir2, coord, raySeedA2, raySeedB2, raySpeed2);
			
			fragColor = rays1 * 0.2 + rays2 * 0.1;
			
			// Attenuate brightness towards the bottom, simulating light-loss due to depth.
			// Give the whole thing a blue-green tinge as well.
			float brightness = 1.0 - (coord.y / iResolution.y);
			fragColor.x *= 0.1 + (brightness * 0.8);
			fragColor.y *= 0.3 + (brightness * 0.6);
			fragColor.z *= 0.5 + (brightness * 0.5);
			return fragColor;
		}
		
		vec4 effect( vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords ) {
      vec4 pixel = Texel(texture, texture_coords );//This is the current pixel color
      vec4 x = mainImage( screen_coords );
			return x;
    }
	]]
end

function initGame()
	math.randomseed(os.time())
	-- Background settings
	love.window.setMode(800, 480)
	love.graphics.setBackgroundColor(255, 255, 255)
	screenWidth = love.graphics.getWidth()
	screenHeight = love.graphics.getHeight()
end

function normalize(value)
	return value / 800 * screenWidth
end

-- For these easing functions, 
-- t - current time
-- b - start value
-- c - change in value
-- d - duration
function easeOutCubicUtility(t, b, c, d)
	t = t / d
	t = t - 1
	return c * (t * t * t + 1) + b
end

function easeInOutSineUtility(t, b, c, d)
	return -c / 2 * (math.cos(math.pi * t / d) - 1) + b;
end