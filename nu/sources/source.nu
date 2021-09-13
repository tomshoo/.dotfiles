#!/usr/bin/nu

def clean [
        --pacman (-p): string #clean "cache" or remove "uneeded" packages
        --nu-history (-n) #clean nu shell history
    ] {
    if ($pacman|empty?) {
        if ($nu-history|empty?) {clean --help} {echo ''|save --raw /home/user/.local/share/nu/history.txt}
    } {
        if ($pacman == 'cache') {
            sudo pacman -Scc
        } {
            if ($pacman == 'uneeded') {
                let uneeded = (pacman -Qtdq)
                if ($uneeded|empty?) {echo "No uneeded packages"} {for $it in $uneeded {sudo pacman -Rsunc --noconfirm $it}}
            } {
                build-string 'Invalid option "' $pacman '"'
            }
        }
    }
}

def archupdate [
    --aur (-a): string #Update aur packages only(requires the aur helper name)
    --core (-c) #Update packages in core repositories
    --full (-f) #Update all packages
    ] {
    if ($aur|empty?) {} {
        if ($aur == 'aura') {
            sudo aura -Aux
        } {
            let cmd = $aur + " -Su"
            nu -c $cmd
        }
    }
    if ($core|empty?) {} {
        sudo pacman -Syu
    }
    if ($full|empty?) {} {
        if (which yay|empty?) {
            sudo aura -Aux
            sudo pacman -Syu
        } {yay -Syu}
    }
    if ($aur|empty?) { if ($core|empty?) { if ($full|empty?) {archupdate --help} {} } {} } {}
}
