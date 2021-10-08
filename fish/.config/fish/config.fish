fish_vi_key_bindings
set fish_greeting ""
alias lll "ls -la"
abbr -a -g nv nvim
abbr -a -g sps "sudo pacman -S"
abbr -a -g cd.. "cd .."
set -g -x shell fish
set -g -x FZF_DEFAULT_COMMAND "fd -H --exclude={.local,.cache,.steam,.wine,.mozilla,.npm,.rustup,.cargo,.dropbox*,.git,.idea,.vscode,.sass-cache,node_modules,build,tmp,__pycache__,*venv*} -d 10 --type f"

if set -q SSH_CONNECTION
  set -g -x EDITOR vim
else
  set -g -x EDITOR nvim
end
set PATH $PATH $HOME/.cargo/bin

starship init fish | source
