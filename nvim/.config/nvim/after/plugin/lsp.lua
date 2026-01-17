local on_attach = function(client, bufnr)
  local map = function(mode, lhs, rhs, desc)
    vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, silent = true, noremap = true, desc = desc })
  end

  local builtin = require("telescope.builtin")

  -- Navigation
  map("n", "gd", builtin.lsp_definitions, "Go to definition")
  map("n", "gr", builtin.lsp_references, "References")
  map("n", "gi", builtin.lsp_implementations, "Go to implementation")
  map("n", "gt", builtin.lsp_type_definitions, "Go to type definition")
  map("n", "<leader>fs", builtin.lsp_document_symbols, "Document symbols")

  -- Info
  map("n", "K", vim.lsp.buf.hover, "Hover info")
  map("n", "<C-k>", vim.lsp.buf.signature_help, "Signature help")

  -- Refactor
  map("n", "<leader>rn", vim.lsp.buf.rename, "Rename symbol")
  map("n", "<leader>ca", vim.lsp.buf.code_action, "Code actions")

  -- Diagnostics
  map("n", "<leader>e", vim.diagnostic.open_float, "Show diagnostic float")
  map("n", "<leader>q", vim.diagnostic.setloclist, "Diagnostics list")

  -- Formatting (only if supported)
  if client.server_capabilities.documentFormattingProvider then
    map("n", "<leader>f", function()
      vim.lsp.buf.format({ async = true })
    end, "Format document")
  end
end

-- Capabilities (for nvim-cmp)
local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- Global diagnostics config
vim.diagnostic.config({
  virtual_text = { spacing = 4, prefix = "⦿" },
  float = {
      focusable = true,
      style = "minimal",
      border = "single",
      header = "",
      prefix = "",
  },
  severity_sort = true,
})

-- Setup servers
local servers = {
  "pyright",
  "ts_ls",
  "angularls",
--  "gopls",
}

for _, server in ipairs(servers) do
  vim.lsp.config(server, {
    capabilities = capabilities,
    on_attach = on_attach,
  })
end

-- Java (JDTLS)
local jdtls_ok, jdtls = pcall(require, "jdtls")
if not jdtls_ok then
  vim.notify("JDTLS not found, install with :MasonInstall jdtls", vim.log.levels.WARN)
  return
end

local function get_project_root()
  local root_markers = {
    "gradlew", "mvnw", ".git", "pom.xml", "build.gradle", "build.gradle.kts"
  }
  local root = vim.fs.dirname(vim.fs.find(root_markers, { upward = true })[1])
  return root or vim.fn.getcwd()
end

local function get_java_runtimes()
  local runtimes = {}

  -- Common Java installation paths (in order of preference)
  local java_paths = {
    -- OpenJDK
    "/usr/lib/jvm/java-21-openjdk",
    "/usr/lib/jvm/java-17-openjdk",
    "/usr/lib/jvm/java-11-openjdk",
    -- Oracle JDK
    "/usr/lib/jvm/jdk-21-oracle-x64",
    "/usr/lib/jvm/jdk-17-oracle-x64",
    "/usr/lib/jvm/jdk-11-oracle-x64",
    -- Alternative locations
    "/opt/jdk-21",
    "/opt/jdk-17",
    "/opt/jdk-11",

    "/usr/lib/jvm/java-8-temurin-jdk",
    "/usr/lib/jvm/java-11-temurin-jdk",
    "/usr/lib/jvm/java-17-temurin-jdk",
  }

  for i, path in ipairs(java_paths) do
    if vim.fn.isdirectory(path) == 1 then
      local version = path:match("java%-(%d+)") or path:match("jdk%-(%d+)")
      if version then
        table.insert(runtimes, {
          name = "JavaSE-" .. version,
          path = path,
        })
      end
    end
  end

  return runtimes
end

local jdtls_path = vim.fn.expand("~/.local/share/nvim/mason/packages/jdtls")
local launcher_jar = vim.fn.glob(jdtls_path .. "/plugins/org.eclipse.equinox.launcher_*.jar")
local config_dir = vim.fn.expand(jdtls_path .. "/config_" .. (vim.fn.has("linux") == 1 and "linux" or "mac"))

-- Lombok jar path (try multiple locations)
local lombok_jar = vim.fn.expand("~/.local/share/nvim/mason/packages/jdtls/lombok.jar")
if vim.fn.filereadable(lombok_jar) == 0 then
  lombok_jar = vim.fn.expand("~/.local/share/nvim/mason/share/jdtls/lombok.jar")
end

-- Build cmd table conditionally
local cmd_table = { "java" }

-- Only add lombok agent if the jar exists
if vim.fn.filereadable(lombok_jar) == 1 then
  table.insert(cmd_table, "-javaagent:" .. lombok_jar)
end

local jdtls_config = {
  cmd = vim.list_extend(cmd_table, {
    "-Declipse.application=org.eclipse.jdt.ls.core.id1",
    "-Dosgi.bundles.defaultStartLevel=4",
    "-Declipse.product=org.eclipse.jdt.ls.core.product",
    "-Dlog.protocol=true",
    "-Dlog.level=ALL",
    "-Xmx2g", -- Increased memory for better performance
    "--add-modules=ALL-SYSTEM",
    "--add-opens", "java.base/java.util=ALL-UNNAMED",
    "--add-opens", "java.base/java.lang=ALL-UNNAMED",
    -- Performance optimizations
    "-XX:+UseParallelGC",
    "-XX:GCTimeRatio=4",
    "-XX:AdaptiveSizePolicyWeight=90",
    -- Debugging
    "-agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=5005",
    "-jar", launcher_jar,
    "-configuration", config_dir,
    "-data", vim.fn.stdpath("data") .. "/jdtls-workspace/" .. vim.fn.fnamemodify(get_project_root(), ":p:h:t"),
  }),

  root_dir = get_project_root(),
  capabilities = capabilities,
  on_attach = function(client, bufnr)
    on_attach(client, bufnr)
    -- Additional Java-specific keymaps
    local map = function(mode, lhs, rhs, desc)
      vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, silent = true, noremap = true, desc = desc })
    end

    -- Java-specific mappings
    map("n", "<leader>jo", function() jdtls.organize_imports() end, "Organize Imports")
    map("n", "<leader>jv", function() jdtls.extract_variable() end, "Extract Variable")
    map("n", "<leader>jc", function() jdtls.extract_constant() end, "Extract Constant")
    map("n", "<leader>jm", function() jdtls.extract_method() end, "Extract Method")
    map("n", "<leader>jt", function() require("jdtls.tests").goto_subjects() end, "Go to Test Subject")
    map("n", "<leader>tr", function() require("jdtls.tests").run_current_method() end, "Run Current Method")
  end,

  settings = {
    java = {
      configuration = {
        runtimes = get_java_runtimes(),
      },

      format = {
        enabled = true,
        settings = {
          url = "https://raw.githubusercontent.com/google/styleguide/gh-pages/eclipse-java-google-style.xml",
          profile = "GoogleStyle",
        },
        comments = {
          enabled = true,
        },
        onType = {
          enabled = true,
        },
      },

      completion = {
        favoriteStaticMembers = {
          "org.junit.Assert.*",
          "org.junit.Assume.*",
          "org.junit.jupiter.api.Assertions.*",
          "org.junit.jupiter.api.Assumptions.*",
          "org.mockito.Mockito.*",
          "org.mockito.ArgumentMatchers.*",
          "org.mockito.BDDMockito.*",
        },
        filteredTypes = {
          "com.sun.*",
          "io.micrometer.shaded.*",
          "java.awt.*",
          "jdk.*",
          "sun.*",
        },
        importOrder = {
          "java",
          "javax",
          "com",
          "org",
        },
      },

      contentProvider = {
        preferred = "fernflower",
      },

      signatureHelp = {
        enabled = true,
        description = {
          enabled = true,
        },
      },

      implementationsCodeLens = {
        enabled = true,
      },
      referencesCodeLens = {
        enabled = true,
        includesDecompiledSources = true,
      },

      codeGeneration = {
        generateComments = true,
        hashCodeEquals = {
          useJava7Objects = true,
        },
        useBlocks = true,
        toString = {
          template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
          codeStyle = "STRING_CONCATENATION",
        },
      },

      eclipse = {
        downloadSources = true,
      },
      maven = {
        downloadSources = true,
        updateSnapshots = true,
      },

      inlayHints = {
        parameterNames = {
          enabled = "all",
        },
      },

      saveActions = {
        organizeImports = true,
      },

    },
  },

  handlers = {
    ["language/status"] = function(_, result)
      -- Show language server status in status line
    end,
    ["$/progress"] = function(_, result, ctx)
      -- Handle progress notifications
    end,
  },

  -- Initialization options
  init_options = {
    bundles = {
      -- Add debugging support if available
      vim.fn.glob(vim.fn.expand("~/.local/share/nvim/mason/packages/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar"), 1) or nil,
    },
  },
}

-- Start jdtls when opening Java files (enhanced)
vim.api.nvim_create_autocmd("FileType", {
  pattern = "java",
  callback = function()
    -- Check if we're in a Java project
    local root = get_project_root()
    if vim.fn.isdirectory(root .. "/src/main/java") == 1 or
       vim.fn.filereadable(root .. "/pom.xml") == 1 or
       vim.fn.filereadable(root .. "/build.gradle") == 1 or
       vim.fn.filereadable(root .. "/build.gradle.kts") == 1 then
      jdtls.start_or_attach(jdtls_config)
    else
      vim.notify("Not a Java project, skipping JDTLS", vim.log.levels.INFO)
    end
  end,
})

-- Java-specific file type settings
vim.api.nvim_create_autocmd("FileType", {
  pattern = "java",
  callback = function()
    -- Enhanced Java formatting and style settings
    vim.opt_local.tabstop = 4
    vim.opt_local.shiftwidth = 4
    vim.opt_local.expandtab = true
    vim.opt_local.softtabstop = 4

    -- Enhanced editor features for Java
    vim.opt_local.number = true
    vim.opt_local.relativenumber = true
    vim.opt_local.colorcolumn = "100,120"
    vim.opt_local.textwidth = 100

    -- Enhanced search and navigation
    vim.opt_local.ignorecase = true
    vim.opt_local.smartcase = true
    vim.opt_local.hlsearch = true

    -- Enhanced completion
    vim.opt_local.completeopt = "menu,menuone,noselect"
    vim.opt_local.pumheight = 15

    -- Enhanced diagnostics
    vim.diagnostic.config({
      virtual_text = {
        prefix = "●",
        spacing = 4,
      },
      float = {
        border = "rounded",
        focusable = false,
        style = "minimal",
        source = "always",
        header = "",
        prefix = "",
      },
      signs = true,
      underline = true,
      update_in_insert = false,
      severity_sort = true,
    }, bufnr)
  end,
})

-- Lua
vim.lsp.config("lua_ls", {
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {
    Lua = {
      diagnostics = { globals = { "vim" } },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
        checkThirdParty = false,
      },
      telemetry = { enable = false },
    },
  },
})

-- Go
vim.lsp.config("gopls", {
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {
    gopls = {
      analyses = {
        unusedparams = true,
        shadow = true,
      },
      staticcheck = true,
    },
  },
})

