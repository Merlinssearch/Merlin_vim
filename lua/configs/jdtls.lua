local jdtls = require("jdtls")

-- Find root of project
local root_markers = { "gradlew", "mvnw", ".git", "pom.xml", "build.gradle" }
local root_dir = require("jdtls.setup").find_root(root_markers)
if root_dir == "" then
  return
end

-- Get Java home path
local java_home = vim.fn.getenv("JAVA_HOME")
if java_home == vim.NIL or java_home == "" then
  -- Fallback to common Java installation paths
  local possible_paths = {
    "/usr/lib/jvm/java-25-openjdk",
    "/usr/lib/jvm/java-21-openjdk",
    "/usr/lib/jvm/default-java",
  }
  for _, path in ipairs(possible_paths) do
    if vim.fn.isdirectory(path) == 1 then
      java_home = path
      break
    end
  end
end

if not java_home or java_home == vim.NIL or java_home == "" then
  vim.notify(
    "JAVA_HOME not set and no Java installation found",
    vim.log.levels.ERROR
  )
  return
end

local java_cmd = java_home .. "/bin/java"

-- Get Mason's jdtls installation path
local mason_registry = require("mason-registry")
local jdtls_pkg = mason_registry.get_package("jdtls")
local jdtls_path = jdtls_pkg:get_install_path()

-- Find the equinox launcher jar
local function find_equinox_launcher()
  local launcher_path = jdtls_path .. "/plugins/"
  local handle = io.popen(
    "ls -1 "
      .. launcher_path
      .. "org.eclipse.equinox.launcher_*.jar 2>/dev/null"
  )
  if handle then
    local result = handle:read("*a")
    handle:close()
    local jar = result:match("([^\n]+)")
    if jar then
      return launcher_path .. jar
    end
  end
  return nil
end

local equinox_launcher = find_equinox_launcher()
if not equinox_launcher then
  vim.notify("Could not find Eclipse launcher jar", vim.log.levels.ERROR)
  return
end

-- Determine system config directory
local system = "linux"
if vim.fn.has("mac") == 1 then
  system = "mac"
elseif vim.fn.has("win32") == 1 then
  system = "win"
end

local config_path = jdtls_path .. "/config_" .. system

-- Data directory for this workspace
local workspace_dir = vim.fn.stdpath("data")
  .. "/jdtls-workspace/"
  .. vim.fn.fnamemodify(root_dir, ":p:h:t")

-- Get capabilities from nvchad
local on_attach = require("nvchad.configs.lspconfig").on_attach
local on_init = require("nvchad.configs.lspconfig").on_init
local capabilities = require("nvchad.configs.lspconfig").capabilities

-- jdtls configuration
local config = {
  cmd = {
    java_cmd,
    "-Declipse.application=org.eclipse.jdt.ls.core.id1",
    "-Dosgi.bundles.defaultStartLevel=4",
    "-Declipse.product=org.eclipse.jdt.ls.core.product",
    "-Dlog.protocol=true",
    "-Dlog.level=ALL",
    "-Xmx1g",
    "--add-modules=ALL-SYSTEM",
    "--add-opens",
    "java.base/java.util=ALL-UNNAMED",
    "--add-opens",
    "java.base/java.lang=ALL-UNNAMED",
    "-jar",
    equinox_launcher,
    "-configuration",
    config_path,
    "-data",
    workspace_dir,
  },

  root_dir = root_dir,

  settings = {
    java = {
      eclipse = {
        downloadSources = true,
      },
      configuration = {
        updateBuildConfiguration = "interactive",
      },
      maven = {
        downloadSources = true,
      },
      implementationsCodeLens = {
        enabled = true,
      },
      referencesCodeLens = {
        enabled = true,
      },
      references = {
        includeDecompiledSources = true,
      },
      format = {
        enabled = true,
      },
    },
    signatureHelp = { enabled = true },
    completion = {
      favoriteStaticMembers = {
        "org.hamcrest.MatcherAssert.assertThat",
        "org.hamcrest.Matchers.*",
        "org.hamcrest.CoreMatchers.*",
        "org.junit.jupiter.api.Assertions.*",
        "java.util.Objects.requireNonNull",
        "java.util.Objects.requireNonNullElse",
        "org.mockito.Mockito.*",
      },
    },
    contentProvider = { preferred = "fernflower" },
    extendedClientCapabilities = jdtls.extendedClientCapabilities,
    sources = {
      organizeImports = {
        starThreshold = 9999,
        staticStarThreshold = 9999,
      },
    },
    codeGeneration = {
      toString = {
        template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
      },
      useBlocks = true,
    },
  },

  flags = {
    allow_incremental_sync = true,
  },

  on_attach = on_attach,
  on_init = on_init,
  capabilities = capabilities,
}

-- Start jdtls
jdtls.start_or_attach(config)
