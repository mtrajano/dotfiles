local u = require('mt.utils')

vim.g.github_enterprise_urls = {
  "https://git.corp.adobe.com"
}

u.cnoreabbrev('Gds', 'Gdiffsplit')
u.cnoreabbrev('Gvs', 'Gvsplit')
u.cnoreabbrev('Gvsm', 'Gvsplit master:%')
u.cnoreabbrev('Gco', 'GBranches --locals')
u.cnoreabbrev('Gcor', 'GBranches --remotes')
u.cnoreabbrev('Gre', 'Gread master:%')
u.cnoreabbrev('Glo', 'G log -n 500')
u.cnoreabbrev('Glink', 'GBrowse')
