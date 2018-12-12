# 1. download hg-prompt
hg clone http://bitbucket.org/sjl/hg-prompt/ "${HOME}/hg-prompt"

# 2. backup and copy dotfiles
echo -e "\nReplacing default dotfiles with customized versions:"
declare -a files=("hgrc" "zshrc" "zshenv" "screenrc"  "oh-my-zsh/themes/ctembreull.zsh-theme")
for f in "${files[@]}"; do
    echo -ne "\n\tChecking ${f}..."
    if test -e "${HOME}/.${f}"; then
        echo -ne " found. Backing up..."
        mv "${HOME}/.${f}" "${HOME}/.backup_${f}"
        echo -ne " done."
    fi
    echo -ne " Replacing..."
    cp "$(dirname -- $0)/${f}" "${HOME}/.${f}"
    echo -ne " done."
done

# 3. Setup zsh
if ! [ $(test -e "/usr/bin/zsh")  ] ; then
    echo -ne "\nSetting up ZShell (zsh) and making it the default login environment"
    sudo apt-get install -qy zsh
fi

# 4. Add oh-my-zsh for pure awesomeness
if ! [ $(test -f "${HOME}/.oh-my-zsh") ] ; then
    echo -ne "\nAdding robbyrussell/oh-my-zsh toolkit"
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
fi

echo -e "\nAll tasks complete. Exiting."
