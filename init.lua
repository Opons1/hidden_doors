local function register_door_from_node(node)
	local def = core.registered_nodes[node]
	if not def or not def.tiles then return end
	local tile = type(def.tiles) == "string" and def.tiles or (def.tiles[5] or def.tiles[3] or def.tiles[1])
	local tex = type(tile) == "table" and tile.name or tile
	local suffix = node:match(":(.+)$") or node
	local raw_desc = def.description or ""
	local desc = "Hidden " .. raw_desc:gsub("%s*Door%s*", ""):gsub("%s*Block%s*", "") .. " Door"
	local inv_image  = "[combine:32x32:8,0=" .. tex .. ":8,16=" .. tex
	local door_tiles = "[combine:38x32:0,0=" .. tex .. ":16,0=" .. tex .. ":32,0=" .. tex .. ":0,16=" .. tex .. ":16,16=" .. tex .. ":32,16=" .. tex
	doors.register_door("hidden_doors:" .. suffix, {
		description = desc,
		groups = {choppy=2, oddly_breakable_by_hand = 2, door=1},
		inventory_image = inv_image,
		tiles = { door_tiles }
	})	
	minetest.register_craft({
		output = "hidden_doors:" .. suffix,
        type = "shapeless",
		recipe = {
		"doors:door_wood", node
		}
	})
end

table.insert(core.registered_on_mods_loaded, 1, function()
	local nodes_to_register = {
		"darkage:chalk",
		"default:pine_tree",
		"default:silver_sand",
        "default:dirt",
        "default:sand",
        "default:gravel",
        "default:cobble",
        "default:wood",
        "you see nothing trust"
	}
	for _, node in ipairs(nodes_to_register) do
		register_door_from_node(node)
	end
end)