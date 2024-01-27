local ls = require "luasnip"
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local l = require("luasnip.extras").lambda
local rep = require("luasnip.extras").rep
local p = require("luasnip.extras").partial
local m = require("luasnip.extras").match
local n = require("luasnip.extras").nonempty
local dl = require("luasnip.extras").dynamic_lambda
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local types = require "luasnip.util.types"
local conds = require "luasnip.extras.conditions"
local conds_expand = require "luasnip.extras.conditions.expand"

ls.add_snippets("cpp", {
    s("flecsmod", {
        d(1, function(_, parent)
            local env = parent.snippet.env
            local name, filetype = env.TM_FILENAME:match "^(.+)%.(%w+)$"
            capitalised_name = name:gsub("^.", string.upper)
            if filetype == "hpp" then
                return sn(
                    nil,
                    t {
                        "#include <flecs.h>",
                        "",
                        "struct " .. capitalised_name .. "M",
                        "{",
                        "    " .. capitalised_name .. "M(flecs::world &world);",
                        "};",
                    }
                )
            else
                return sn(nil, {
                    t "#include <",
                    i(1),
                    t {
                        name .. ".hpp>",
                        "",
                        ("%sM::%sM(flecs::world &world)"):format(capitalised_name, capitalised_name),
                        "{",
                        "    ",
                    },
                    i(2),
                    t { "", "}" },
                })
            end
        end),
    }),
    s("test", { t "hello ", i(1), t " hi ", i(2) }),
}, { key = "cpp" })

require("luasnip.loaders.from_lua").lazy_load { include = { "cpp" } }
