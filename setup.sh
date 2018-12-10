# 1. Setup ZSH and make it the default
echo -e "\nSetting up ZShell (zsh) and making it the default login environment\n"
sudo apt-get install -qy zsh
chsh -s $(which zsh)

# 2. Add oh-my-zsh for pure awesomeness
echo -e "\nAdding robbyrussell/oh-my-zsh toolkit\n"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# 3. Adding dotfiles
echo -e "\nReplacing default dotfiles with customized versions\n"
declare -a files=("hgrc", "zshrc", "zshenv")
for f in "${files[@]}"; do
    echo -e "\nChecking ${f}..."
    if test -f "${HOME}/.${f}"; then
        echo -e " found. Backing up..."
        mv "${HOME}/.${f}" "${HOME}/.backup_${f}"
        echo -e " done."
    fi
    echo -e " Replacing..."
    mv "${f}" "${HOME}/.${f}"
    echo -e " done."
done
echo "\nAll tasks complete. Exiting."
