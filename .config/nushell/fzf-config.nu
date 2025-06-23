def fzf-history [] {
  history | 
  get command | 
  uniq | 
  reverse | 
  str join (char -i 0) | 
  fzf --read0 --height 40% --layout=reverse | 
  str trim
}

# Bind to Ctrl+R
$env.config.keybindings = ($env.config.keybindings | append {
  name: fzf_history
  modifier: control
  keycode: char_r
  mode: [emacs, vi_insert, vi_normal]
  event: { eval: "(fzf-history)" }
})
