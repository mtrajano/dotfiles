local u = require('utils')

vim.g.github_enterprise_urls = {
  "https://git.corp.adobe.com"
}

u.cnoreabbrev('Gds', 'Gdiffsplit')
u.cnoreabbrev('Gco', 'GBranches')
u.cnoreabbrev('Gre', 'Gread master:%')
