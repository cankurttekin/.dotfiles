require("avante").setup({
  provider = "gemini",
  providers = {
    gemini = {
      model = "gemini-2.0-flash-lite",
      -- If you want reasoning-enabled:
      -- generationConfig = {
      --   thinkingConfig = { thinkingBudget = 1024 }
      -- },
      timeout = 30000,
      -- add other Gemini-specific options if needed
    },
  },
  cursor_applying_provider = "gemini",
  auto_suggestions_provider = "gemini",
  memory_summary_provider = "gemini",
  behaviour = {
    enable_cursor_planning_mode = true,
    minimize_diff = true,
  },
  suggestion = {
    debounce = 300,
    throttle = 1000,
  },
  render_markdown = {
    file_types = { "markdown", "Avante" },
  },
})
