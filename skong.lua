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
	key = 'copium',
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

SMODS.Joker {
	key = 'hopium',
	loc_txt = {
		name = 'Skong',
		text = {
			"{C:attention}In the end, Hopium prevails.{}",
      "{X:mult,C:white}x10{} Mult",
			"{C:green}1 in 4{} chance this card is",
			"destroyed at end of round"
		}
	},
	config = { extra = { Xmult = 10, odds = 4 } },
	rarity = 4,
	atlas = 'skongatlas',
	pos = { x = 1, y = 0 },
  soul_pos = { x = 2, y = 0 },
	cost = 20,
	eternal_compat = false,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.Xmult, (G.GAME.probabilities.normal or 1), card.ability.extra.odds } }
	end,
	calculate = function(self, card, context)
		if context.joker_main then
			return {
				message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.Xmult } },
				Xmult_mod = card.ability.extra.Xmult
			}
		end
		if context.end_of_round and context.game_over == false and not context.repetition and not context.blueprint then
			if pseudorandom('hopium') < G.GAME.probabilities.normal / card.ability.extra.odds then
				G.E_MANAGER:add_event(Event({
					func = function()
						play_sound('tarot1')
						card.T.r = -0.2
						card:juice_up(0.3, 0.4)
						card.states.drag.is = true
						card.children.center.pinch.x = true
						G.E_MANAGER:add_event(Event({
							trigger = 'after',
							delay = 0.3,
							blockable = false,
							func = function()
								G.jokers:remove_card(card)
								card:remove()
								card = nil
								return true;
							end
						}))
						return true
					end
				}))
				return {
					message = 'Doubted...'
				}
			else
				return {
					message = 'Keeps Hoping!'
				}
			end
		end
	end
}
