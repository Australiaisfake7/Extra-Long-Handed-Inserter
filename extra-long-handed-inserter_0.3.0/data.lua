require("__core__.lualib.circuit-connector-generated-definitions")
local sounds = require("__base__.prototypes.entity.sounds")
local item_sounds = require("__base__.prototypes.item_sounds")

function make_rotated_animation_variations_from_sheet(variation_count, sheet) --makes remnants work with more than 1 variation
  local result = {}

  local function set_y_offset(variation, i)
    local frame_count = variation.frame_count or 1
    local line_length = variation.line_length or frame_count
    if (line_length < 1) then
      line_length = frame_count
    end

    local height_in_frames = math.floor((frame_count * variation.direction_count + line_length - 1) / line_length)
    -- if (height_in_frames ~= 1) then
    --   log("maybe broken sheet: h=" .. height_in_frames .. ", vc=" .. variation_count .. ", " .. variation.filename)
    -- end
    variation.y = variation.height * (i - 1) * height_in_frames
  end

  for i = 1,variation_count do
    local variation = util.table.deepcopy(sheet)

    if variation.layers then
      for _, layer in pairs(variation.layers) do
        set_y_offset(layer, i)
      end
    else
      set_y_offset(variation, i)
    end

    table.insert(result, variation)
  end
 return result
end

data:extend
{
	{
		type = "corpse",
		name = "extra-long-handed-inserter-remnants",
		icon = "__extra-long-handed-inserter__/graphics/icons/extra-long-handed-inserter.png",
		icon_size = 64,
		icon_mipmaps = 4,
		flags = {"placeable-neutral", "not-on-map"},
		subgroup = "inserter-remnants",
		order = "a-ca-a",
		selection_box = {{-0.5, -0.5}, {0.5, 0.5}},
		tile_width = 1,
		tile_height = 1,
		selectable_in_game = false,
		time_before_removed = 60 * 60 * 15, -- 15 minutes
		expires = false,
		final_render_layer = "remnants",
		animation = make_rotated_animation_variations_from_sheet (4,
		{
		  filename = "__base__/graphics/entity/long-handed-inserter/remnants/long-handed-inserter-remnants.png",
		  line_length = 1,
		  width = 134,
		  height = 94,
		  direction_count = 1,
		  shift = util.by_pixel(3.5, -2),
		  scale = 0.5
		})
	},
	{
		type = "inserter",
		name = "extra-long-handed-inserter",
		icon = "__base__/graphics/icons/long-handed-inserter.png",
		icon_size = 64,
		icon_mipmaps = 4,
		working_sound = sounds.inserter_long_handed,
		open_sound = sounds.inserter_open,
		close_sound = sounds.inserter_close,
		collision_box = {{-0.15, -0.15}, {0.15, 0.15}},
		selection_box = {{-0.4, -0.35}, {0.4, 0.45}},
		flags = {"placeable-player", "player-creation"},
		minable = {mining_time = 0.1, result = "extra-long-handed-inserter"},
		max_health = 160,
		dying_explosion = "long-handed-inserter-explosion",
		corpse = "extra-long-handed-inserter-remnants",
		resistances =
		{
			{
			type = "fire",
			percent = 90
			}
		},
		extension_speed = 0.06,
		rotation_speed = 0.03,
		starting_distance = 2.7,
		pickup_position = {0,-3},
		insert_position = {0,3.2},
		energy_per_movement = "6kJ",
		energy_per_rotation = "6kJ",
		energy_source = 
		{
			type = "electric",
			usage_priority = "secondary-input",
			drain = "0.4kW"
		},
		hand_base_picture =
		{
		  filename = "__extra-long-handed-inserter__/graphics/entities/extra-long-handed-inserter-hand-base.png",
		  priority = "extra-high",
		  width = 32,
		  height = 212,
		  scale = 0.25
		},
		hand_closed_picture =
		{
		  filename = "__extra-long-handed-inserter__/graphics/entities/extra-long-handed-inserter-hand-closed.png",
		  priority = "extra-high",
		  width = 72,
		  height = 164,
		  scale = 0.25
		},
		hand_open_picture =
		{
		  filename = "__extra-long-handed-inserter__/graphics/entities/extra-long-handed-inserter-hand-open.png",
		  priority = "extra-high",
		  width = 72,
		  height = 164,
		  scale = 0.25
		},
		hand_base_shadow =
		{
		  filename = "__base__/graphics/entity/burner-inserter/burner-inserter-hand-base-shadow.png",
		  priority = "extra-high",
		  width = 32,
		  height = 132,
		  scale = 0.25
		},
		hand_closed_shadow =
		{
		  filename = "__base__/graphics/entity/burner-inserter/burner-inserter-hand-closed-shadow.png",
		  priority = "extra-high",
		  width = 72,
		  height = 164,
		  scale = 0.25
		},
		hand_open_shadow =
		{
		  filename = "__base__/graphics/entity/burner-inserter/burner-inserter-hand-open-shadow.png",
		  priority = "extra-high",
		  width = 72,
		  height = 164,
		  scale = 0.25
		},
		platform_picture =
		{
		  sheet =
		  {
		    filename = "__extra-long-handed-inserter__/graphics/entities/extra-long-handed-inserter-platform.png",
		    priority = "extra-high",
		    width = 105,
		    height = 79,
		    shift = util.by_pixel(1.5, 7.5-1),
		    scale = 0.5
		  }
		},
		filter_count = 5,
		hand_size = 2,
		circuit_connector = circuit_connector_definitions["inserter"],
		circuit_wire_max_distance = inserter_circuit_wire_max_distance,
		default_stack_control_input_signal = inserter_default_stack_control_input_signal,
		icon_draw_specification = {scale = 0.5}
	},
	{
		type = "item",
		name = "extra-long-handed-inserter",
		subgroup = "inserter",
		order = "ca[extra-long-handed-inserter]",
		inventory_move_sound = item_sounds.inserter_inventory_move,
		pick_sound = item_sounds.inserter_inventory_pickup,
		drop_sound = item_sounds.inserter_inventory_move,
		stack_size = 20,
		icon = "__extra-long-handed-inserter__/graphics/icons/extra-long-handed-inserter.png",
		icon_size = 64,
		icon_mipmaps = 4,
		place_result = "extra-long-handed-inserter"
	},
	{
		type = "recipe",
		name = "extra-long-handed-inserter",
		category = "crafting",
		ingredients = {{type = "item", name = "long-handed-inserter", amount = 1},{type = "item", name = "electronic-circuit", amount = 2},{type = "item", name = "steel-plate", amount = 2}},
		results = {{type = "item", name = "extra-long-handed-inserter", amount = 1}},
		energy_required = 1.0,
		enabled = false
	}
}