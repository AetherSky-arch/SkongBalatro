SMODS.Atlas {
	-- Key for code to find it with
	key = "skong",
	-- The name of the file, for the code to pull the atlas from
	path = "skong.png",
	-- Width of each sprite in 1x size
	px = 70,
	-- Height of each sprite in 1x size
	py = 95
}

SMODS.Joker {
	key = 'hornet',
	loc_txt = {
		name = 'Silksong',
		text = {
			"Gains {X:mult}x1{} Mult for each year",
            "Hollow Knight: Silksong hasn't",
            "released yet",
            "{C:inactive}(Currently {X:mult}x6{} {C:inactive}Mult)",
		}
	},
	rarity = 3,
	atlas = 'skong',
	pos = { x = 0, y = 0 },
	cost = 10,
	calculate = function(self, card, context)
		if context.joker_main then
			return {
				Xmult_mod = 6,
			}
		end
	end
}
