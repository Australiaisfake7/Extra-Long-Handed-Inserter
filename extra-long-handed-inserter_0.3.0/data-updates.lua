if data.raw.technology["automation-2"] then
	table.insert(data.raw.technology["automation-2"].effects,
		{
			type = "unlock-recipe",
			recipe = "extra-long-handed-inserter"
		}
	)
end