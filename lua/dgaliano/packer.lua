-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  use {
	  'nvim-telescope/telescope.nvim', tag = '0.1.4',
	  -- or                            , branch = '0.1.x',
	  requires = { {'nvim-lua/plenary.nvim'} }
  }
  use("kyazdani42/nvim-web-devicons")

  use({
	  'rose-pine/neovim',
	  as = 'rose-pine',
          config = function()
	          vim.cmd('colorscheme rose-pine')
	  end
  })

  -- LSP
  use("neovim/nvim-lspconfig")
  use("williamboman/mason.nvim")
  use("williamboman/mason-lspconfig.nvim")

  -- LSP utilities
  use("onsails/lspkind-nvim") -- VSCode-like pictograms
  use("L3MON4D3/LuaSnip") -- Snippet engine
  use("hrsh7th/cmp-nvim-lsp") -- nvim-cmp source for neovim's built-in LSP
  use("hrsh7th/cmp-buffer") -- nvim-cmp source for buffer words
  use("hrsh7th/nvim-cmp") -- A completion engine plugin for neovim
  use("jose-elias-alvarez/nvim-lsp-ts-utils")
  use("jose-elias-alvarez/typescript.nvim")

  -- Formatting
  use("jose-elias-alvarez/null-ls.nvim")

  use('nvim-treesitter/nvim-treesitter', {run = ':TSUpdate'})
  use('nvim-treesitter/playground')
  use('theprimeagen/harpoon')
  use('mbbill/undotree')
  use('tpope/vim-fugitive')
  use('tpope/vim-surround')
  use('tpope/vim-commentary')
  use("folke/neodev.nvim")
  use("ThePrimeagen/vim-be-good")
  use("wellle/targets.vim")
  use("folke/trouble.nvim")
  use("nvim-lualine/lualine.nvim")
  use("windwp/nvim-ts-autotag")
  use("windwp/nvim-autopairs")
  use("lewis6991/gitsigns.nvim")

  use ({
    'nvimdev/lspsaga.nvim',
    after = 'nvim-lspconfig',
  
  use({'JoosepAlviste/nvim-ts-context-commentstring'})
})

  use({
    "iamcco/markdown-preview.nvim",
    run = function() vim.fn["mkdp#util#install"]() end,
  })

  use('github/copilot.vim')

  use('NvChad/nvim-colorizer.lua')

  -- documentation tool
  use {
  'kkoomen/vim-doge',
  run = ':call doge#install()'
}
end)


