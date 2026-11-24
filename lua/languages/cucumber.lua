---@module 'lazylangs'
---@type ll.Language
return {
  lsp = {
    name = 'cucumber_language_server',
    server_configuration = {
      settings = {
        cucumber = {
          features = { '**/*.feature' },
          glue = {
            '**/features/**/*.js',
            '**/features/**/*.ts',
            '**/steps/**/*.js',
            '**/steps/**/*.ts',
            '**/*.steps.js',
            '**/*.steps.ts',
          },
        },
      },
    },
  },
  mason_packages = {
    'cucumber-language-server',
  },
}
