return {
  {
    'ThePrimeagen/99',
    lazy = false,
    config = function()
      local _99 = require('99')

      _99.setup({
        model = 'amazon-bedrock/us.anthropic.claude-opus-4-6-v1',
        completion = {
          source = 'cmp',
        },
        md_files = {
          'AGENT.md',
        },
      })
    end,
    keys = {
      {
        '<leader>9f',
        function()
          require('99').fill_in_function()
        end,
        desc = '99: Fill in Function',
        mode = 'n',
      },
      {
        '<leader>9fp',
        function()
          require('99').fill_in_function_prompt()
        end,
        desc = '99: Fill in Function Prompt',
        mode = 'n',
      },
      {
        '<leader>99',
        function()
          require('99').visual()
        end,
        desc = '99: Visual',
        mode = 'v',
      },
      {
        '<leader>9p',
        function()
          require('99').visual_prompt()
        end,
        desc = '99: Visual Prompt',
        mode = 'v',
      },
      {
        '<leader>9s',
        function()
          require('99').stop_all_requests()
        end,
        desc = '99: Stop All Requests',
        mode = { 'n', 'v' },
      },
    },
  },
}
