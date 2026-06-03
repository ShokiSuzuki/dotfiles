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

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        -- 💡 キーマップ（補完ウィンドウが出ているときの操作）
        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(), -- 強制的に補完ウィンドウを開く
          ["<C-e>"] = cmp.mapping.abort(),        -- 補完を閉じる
          ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Enterで確定
          
          -- Tabキーで次の候補、Shift+Tabで前の候補を選択する
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
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
        -- 💡 どこから補完候補を集めてくるかの設定（優先度順）
        sources = cmp.config.sources({
          { name = "nvim_lsp" }, -- 将来LSPを入れた時用
	  { name = "copilot", group_index = 2 },
          { name = "luasnip" },  -- スニペット
          { name = "path" },     -- ファイルパス
        }, {
          { name = "buffer" },   -- 現在のファイル内の単語（少し優先度を下げる）
        }),
      })

      -- 💡 先ほど入れた nvim-autopairs との連携設定
      -- 関数を補完したあとに自動で `()` が挿入されるようになります
      local cmp_autopairs = require("nvim-autopairs.completion.cmp")
      cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())


      local has_words_before = function()
        if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then return false end
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_text(0, line-1, 0, line-1, col, {})[1]:match("^%s*$") == nil
      end
      cmp.setup({
        mapping = {
          ["<Tab>"] = vim.schedule_wrap(function(fallback)
            if cmp.visible() and has_words_before() then
              cmp.confirm({select = true})
            else
              fallback()
            end
          end),
       },
     })
    end,
  },
}

