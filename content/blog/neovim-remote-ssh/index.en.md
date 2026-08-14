---
title: "Remote SSH in Neovim, Just Like VS Code"
summary: "Use remote-nvim.nvim to edit files on SSH hosts and inside containers directly from Neovim."
date: 2024-10-16
lastmod: 2024-10-16
tags: ["SSH", "Docker", "neovim", "devcontainer", "RemoteSSH"]
draft: false
showSummary: true
---

## Prologue
Even though I love vim, there were times when I had to use VScode.
This is when you want to directly edit files on the server or container locally.
I've been looking around for about half a year to see if it could be done with vim, but I couldn't find it.
But I found it.
Its name is [remote-nvim.nvim](https://github.com/amitds1997/remote-nvim.nvim)

## About remote-nvim
This is seriously divine👼
The OS supports Linux, mac, and FreeBSD,
It supports ssh, docker-container/image, and dev-container.

As for what I'm doing
- Automatically install neovim on remote destination using sh
- Push local oreo nvim config to remote
- Start remote nvim and connect with local nvim
- You can use nvim to operate files on remote destinations from the local area. Of course, you can use most of the various plugins, and you can automatically install any other dependent tools you want to install (I've installed lazygit etc.)
- Moreover, clean up properly after use to avoid polluting the server environment.

## Installation
When using lazy.nvim to separate files for each plugin
```lua
return {
   "amitds1997/remote-nvim.nvim",
   version = "*", -- Pin to GitHub releases
   dependencies = {
       "nvim-lua/plenary.nvim", -- For standard functions
       "MunifTanjim/nui.nvim", -- To build the plugin UI
       "nvim-telescope/telescope.nvim", -- For picking b/w different remote methods
   },
   config = true,
}
```
After that, you can use it by looking at github and setting the config parameters for each.
I did not set Enter passphrase for key in ssh_prompts, so I was unable to enter the password when connecting via ssh.

```lua
local ssh_config = {
			ssh_binary = "ssh",
			scp_binary = "scp",
			ssh_config_file_paths = { "$HOME/.ssh/config" },
			ssh_prompts = {
				{
					match = "Enter passphrase for key",
					type = "secret", -- パスフレーズはシークレットとして扱う
					value_type = "static", -- 毎回新しいパスフレーズを入力するか
					value = "", -- 初期値
				},
				{
					match = "password:",
					type = "secret",
					value_type = "static",
					value = "",
				},
				{
					match = "continue connecting (yes/no/[fingerprint])?",
					type = "plain",
					value_type = "static",
					value = "",
				},
			},
		}
```

## How to use
A demo video is available on github.
You can easily start it by typing the RemoteStart command and selecting the necessary items for ssh connection on Telescope.

`:RemoteStart`
Connect to a remote instance. User can start local client if remote neovim server is already running

`:RemoteStop`
Stop Neovim server execution and close session

`:RemoteInfo`
Get information about sessions created during the current Neovim run and open the progress viewer.

`:RemoteCleanup`
Remove the workspace and the entire remote neovim setup from the remote instance. Also clean up the configuration of remote resources.

`:RemoteConfigDel`
Delete records of remote instances that no longer exist from the saved session records.

`:RemoteLog`
Open the plugin's log file. If an error occurs, you can see it here.

`:RemoteInfo`
Information about the connection etc. will be displayed.

---

[Read the original article on Qiita](https://qiita.com/daigo-suhara/items/463ddd15efd8bd993c99)
