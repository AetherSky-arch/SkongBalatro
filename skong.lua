SMODS.Atlas {
	-- Key for code to find it with
	key = "skongatlas",
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
			"United we hope.",
            "{C:inactive}( {X:mult,C:white}x2025{} {C:inactive}Mult )",
		}
	},
	config = { extra = { Xmult = 2025 } },
	rarity = 3,
	atlas = 'skongatlas',
	pos = { x = 0, y = 0 },
	cost = 10,
    loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.Xmult } }
	end,

	calculate = function(self, card, context)
		if context.joker_main then
			return {
				message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.Xmult } },
				Xmult_mod = card.ability.extra.Xmult
			}
		end
	end
}
