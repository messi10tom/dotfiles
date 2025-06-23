# config.nu
#
# Installed by:
# version = "0.104.0"
#
# This file is used to override default Nushell settings, define
# (or import) custom commands, or run any other startup tasks.
# See https://www.nushell.sh/book/configuration.html
#
# This file is loaded after env.nu and before login.nu
#
# You can open this file in your default editor using:
# config nu
#
# See `help config nu` for more options
#
# You can remove these comments if you want or leave
# them for future reference.


# ~/.config/nushell/config.nu


echo 'let-env HISTORY_FILE_PATH = if (sys | get host | get name) == "tmux" and (env | get -i TMUX_PANE) != null {
    $"($env.HOME)/.config/nushell/history/history_($env.TMUX_PANE | str replace "%" "_" | str replace "." "_").txt"
} else {
    $"($env.HOME)/.config/nushell/history/history.txt"
}

config set history.file_format "sqlite"
config set history.isolation true
config set history.path $env.HISTORY_FILE_PATH' >> ~/.config/nushell/config.nu


mkdir ($nu.data-dir | path join "vendor/autoload")
starship init nu | save -f ($nu.data-dir | path join "vendor/autoload/starship.nu")


# ~/.config/nushell/config.nu

# let-env PROMPT_COMMAND = { || starship prompt }
# let-env PROMPT_INDICATOR = ""
# let-env PROMPT_MULTILINE_INDICATOR = "::: "
 
# Optional: remove right prompt if it messes up powerline flow
# let-env RIGHT_PROMPT_COMMAND = { || "" }




# Enable vi keybindings
$env.config = {
  edit_mode: vi
  shell_integration: true
  # other config options...
}

# Custom keybindings for vi mode
$env.config.keybindings = [
  {
    name: history_search_backwards
    modifier: control
    keycode: char_k
    mode: [emacs, vi_insert, vi_normal]
    event: { send: upArrow }
  }
  {
    name: history_search_forwards
    modifier: control
    keycode: char_j
    mode: [emacs, vi_insert, vi_normal]
    event: { send: downArrow }
  }
]


# fzf integration
source ~/.config/nushell/fzf-config.nu # Create this file with your fzf customizations
alias ghd = ~/GitHub/gh-cli/dashboard.sh
source $"($nu.home-path)/.cargo/env.nu"
source ~/.zoxide.nu
# alias nvimf = { 
#   let file = (fd . | fzf --preview 'bat --style=numbers --color=always {}' --height=40%)
#   if $file != null { nvim $file }
# }


def --env cd_to_selected_folder [path: path] {
    cd $path
}
