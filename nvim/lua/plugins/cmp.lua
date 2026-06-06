return {
    {
        "hrsh7th/nvim-cmp",
        -- 挿入モードに入ったとき（文字を入力しようとしたとき）に読み込む
        event = "InsertEnter",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp", -- LSPからの補完（今後LSPを入れた時に機能します）
            "hrsh7th/cmp-buffer",   -- 開いているファイル内の単語から補完
            "hrsh7th/cmp-path",     -- ファイルパス（../ や ./ など）の補完
            "L3MON4D3/LuaSnip",     -- スニペットエンジン（必須）
            "saadparwaiz1/cmp_luasnip", -- スニペットをcmpと紐付ける
        },
        config = function()
            local cmp = require("cmp")
            local luasnip = require("luasnip")
            -- 新しい判定関数
            local has_words_before = function()
                unpack = unpack or table.unpack
                local line, col = unpack(vim.api.nvim_win_get_cursor(0))
                if col == 0 then return false end
                local current_line = vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]
                local left_of_cursor = current_line:sub(1, col)
                return left_of_cursor:match("%S") ~= nil
            end
            cmp.setup({
                snippet = {
                  expand = function(args) luasnip.lsp_expand(args.body) end,
                },
                mapping = cmp.mapping.preset.insert({
                    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-f>"] = cmp.mapping.scroll_docs(4),
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<C-e>"] = cmp.mapping.abort(),
                    ["<CR>"] = cmp.mapping.confirm({ select = true }),
                    
                    -- 新しいTab設定
                    ["<Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() and has_words_before() then
                            cmp.confirm({ select = true })
                        elseif luasnip.expand_or_jumpable() then
                            luasnip.expand_or_jump()
                        else
                            vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Tab>", true, false, true), "n", false)
                        end
                    end, { "i", "s" }),
                    ["<S-Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        elseif luasnip.jumpable(-1) then
                            luasnip.jump(-1)
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                }),
                sources = cmp.config.sources({
                    { name = "nvim_lsp" },
                    { name = "copilot", group_index = 2 },
                    { name = "luasnip" },
                    { name = "path" },
                }, {
                    { name = "buffer" },
                }),
            })
            local cmp_autopairs = require("nvim-autopairs.completion.cmp")
            cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
    end,
    },
}

