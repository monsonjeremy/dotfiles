local present, toggleterm = pcall(require, 'toggleterm')
if not present then return end

toggleterm.setup({ size = 25 })
