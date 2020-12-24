local lspconfig = require'lspconfig'
local configs = require'lspconfig/configs'
if not lspconfig.sumneko_lua then
    configs.sumneko_lua = {
        default_config = {
            cmd = {'/home/kli/.local/bin/lua-language-server -'};
            filetypes = {'lua'};
            root_dir = function(fname)
                return lspconfig.util.find_git_ancestor(fname) or vim.loop.os_homedir()
            end;
            settings = {};
        };
    }
end
lspconfig.sumneko_lua.setup{}
