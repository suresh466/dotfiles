local harpoon = require("harpoon")

-- REQUIRED
harpoon:setup()
-- REQUIRED

vim.keymap.set("n", "<leader>a", function()
	harpoon:list():add()
end, { desc = "Add File" })
vim.keymap.set("n", "<C-e>", function()
	harpoon.ui:toggle_quick_menu(harpoon:list())
end, { desc = "Toggle Quick Menu" })

vim.keymap.set("n", "<C-j>", function()
	harpoon:list():select(1)
end, { desc = "Select First" })
vim.keymap.set("n", "<C-k>", function()
	harpoon:list():select(2)
end, { desc = "Select Second" })
vim.keymap.set("n", "<C-l>", function()
	harpoon:list():select(3)
end, { desc = "Select Third" })
vim.keymap.set("n", "<C-;>", function()
	harpoon:list():select(4)
end, { desc = "Select Fourth" })

-- basic telescope configuration
local conf = require("telescope.config").values
local function toggle_telescope(harpoon_files)
	local file_paths = {}
	for _, item in ipairs(harpoon_files.items) do
		table.insert(file_paths, item.value)
	end

	require("telescope.pickers")
		.new({}, {
			prompt_title = "Harpoon",
			finder = require("telescope.finders").new_table({
				results = file_paths,
			}),
			previewer = conf.file_previewer({}),
			sorter = conf.generic_sorter({}),
		})
		:find()
end

vim.keymap.set("n", "<leader>fm", function()
	toggle_telescope(harpoon:list())
end, { desc = "Open harpoon window" })
