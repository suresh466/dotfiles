require('neotest').setup({
    adapters = {
        require('neotest-python')({
            dap = {
                console = 'integratedTerminal',
            },
        }),
    },
})
