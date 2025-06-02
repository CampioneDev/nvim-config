return {
  init_options = {
    provideFormatter = false,
  },
  settings = {
    css = {
      lint = {
        -- for CSS modules, prevents `unknownProperties` error
        validProperties = { 'composes' },
      },
    },
  },
}
