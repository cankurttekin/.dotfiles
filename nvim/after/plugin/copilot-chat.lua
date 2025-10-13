local copilot_chat = require("CopilotChat")

copilot_chat.setup({
  model = "gpt-4.1",
  temperature = 0.1,
  auto_insert_mode = true,

  window = {
    layout = "vertical",
    width = 0.3,
  },

  headers = {
    user = "👤 You",
    assistant = "🤖 Copilot",
    tool = "🔧 Tool",
  },

  separator = "━━",
  auto_fold = true,

  prompts = {
    Explain = {
      prompt = "Explain this code step by step.",
      system_prompt = "You are a helpful tutor who explains concepts clearly.",
      mapping = "<leader>cce",
      description = "Explain current code",
    },
    Review = {
      prompt = "Review this code for potential improvements.",
      mapping = "<leader>ccr",
      description = "Code review",
    },
    TransTr = {
        prompt = "Translate all comments in this code to Turkish.",
        system_prompt = "You are a bilingual programming assistant.",
        mapping = "<leader>cctt",
        description = "Translate comments",
    },
    TransEn = {
        prompt = "Translate all comments in this code to English.",
        system_prompt = "You are a bilingual programming assistant.",
        mapping = "<leader>ccte",
        description = "Translate comments",
    },
  },
})

-- Buffer behavior for copilot chat buffers
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "copilot-*",
  callback = function()
    vim.opt_local.relativenumber = false
    vim.opt_local.number = false
    vim.opt_local.conceallevel = 0
  end,
})

-- Highlights
vim.api.nvim_set_hl(0, "CopilotChatHeader", { fg = "#7C3AED", bold = true })
vim.api.nvim_set_hl(0, "CopilotChatSeparator", { fg = "#374151" })
vim.api.nvim_set_hl(0, "CopilotChatPrompt", { fg = "#10B981", italic = true })
vim.api.nvim_set_hl(0, "CopilotChatModel", { fg = "#F59E0B", bold = true })
