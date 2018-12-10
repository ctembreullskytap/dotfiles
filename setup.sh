# 1. Setup ZSH and make it the default
if ! [ $(test -e "/usr/bin/zsh")  ] ; then
    echo -e "\nSetting up ZShell (zsh) and making it the default login environment"
    sudo apt-get install -qy zsh
    chsh -s $(which zsh)
fi

# 2. Add oh-my-zsh for pure awesomeness
if ! [ $(test -f "${HOME}/.oh-my-zsh") ] ; then
    echo -e "\nAdding robbyrussell/oh-my-zsh toolkit"
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
fi

# 3. Adding dotfiles
echo -e "\nReplacing default dotfiles with customized versions:"
declare -a files=("hgrc", "zshrc", "zshenv")
for f in "${files[@]}"; do
    echo -e "\n\tChecking ${f}..."
    if test -e "${HOME}/.${f}"; then
        echo -e " found. Backing up..."
        mv "${HOME}/.${f}" "${HOME}/.backup_${f}"
        echo -e " done."
    fi
    echo -e " Replacing..."
    cp "$(dirname -- $0)/${f}" "${HOME}/.${f}"
    echo -e " done."
done
echo "\nAll tasks complete. Exiting."
