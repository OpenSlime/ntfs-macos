version=1.0-beta1
homebrew_install() {
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)";
    echo 'export PATH="/usr/local/sbin:$PATH"' >> ~/.bash_profile
};

ntfs_3g_enable() {
    if [[ $(brew doctor) != "Your system is ready to brew." ]];
    then
        homebrew_install;
            if [[ $(brew doctor) == "Your system is ready to brew." ]];
            then
                brew cask install osxfuse;
                brew install ntfs-3g;
            else
                echo "Errore 1: Homebrew non funzionante";
                echo "Controlla l'errore che ti dà e riavvia lo script";
                exit 1;
        fi;
    else
        brew cask install osxfuse;
        brew install ntfs-3g;
    fi;

    echo "Inserisci il nome completo del tuo disco.";
    echo "Per trovarlo, apri Utility Disco in Applicazioni > Utility dal Finder e vedi il nome della partizione (es. Macintosh HD)";
    read disk;
    sudo mv "/Volumes/${disk}/sbin/mount_ntfs" "/Volumes/${disk}/sbin/mount_ntfs.orig";
    sudo ln -s "/usr/local/sbin/mount_ntfs" "/Volumes/${disk}/sbin/mount_ntfs";
    echo "" && echo "";
    echo "Fatto! Ho abilitato la scrittura NTFS :)";

    echo "Vuoi riavviare ora? (y/n)";
    read reboot;

    if [[ $reboot == "y" || $reboot == "Y" ]];
    then
        sudo reboot;
    fi;
};

ntfs_3g_disable() {
    echo "Vuoi davvero disabilitare la scrittura NTFS? (y/n)"
    read okay;
    if [[ $okay == "y" || $okay == "Y" ]];
    then
        echo "";
        echo "Inserisci il nome completo del tuo disco.";
        echo "Per trovarlo, apri Utility Disco in Applicazioni > Utility dal Finder e vedi il nome della partizione (es. Macintosh HD)";
        read disk;
        sudo mv "/Volumes/${disk}/sbin/mount_ntfs.orig" "/Volumes/${disk}/sbin/mount_ntfs";
        brew uninstall ntfs-3g;
        brew cask uninstall osxfuse;

        echo "";
        echo "Vuoi anche rimuovere Homebrew? (y/n)";
        read uninstallbrew;
        if [[ $uninstallbrew == "y" || $uninstallbrew == "Y" ]];
        then
            ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/uninstall)";
        fi;
    else
        ntfs_3g_menu;
    fi;

    echo "";
    echo "Operazione completata.";

    echo "Vuoi riavviare ora? (y/n)";
    read reboot;
    if [[ $reboot == "y" || $reboot == "Y" ]];
    then
        sudo reboot;
    fi;
};

fstab_enable() {
    echo "Inserisci il nome completo del tuo disco (NON deve contenere spazi).";
    echo "Per trovarlo, apri Utility Disco in Applicazioni > Utility dal Finder e vedi il nome della partizione (es. Macintosh HD)";
    read disk;
    echo "LABEL=${disk}  none    ntfs    rw,auto,nobrowse" | sudo tee -a /etc/fstab;
    sudo ln -s /Volumes ~/Desktop/Volumes
    echo "";
    echo "Fatto! Ho abilitato la scrittura NTFS :)";

    echo "Vuoi riavviare ora? (y/n)";
    read reboot;
    if [[ $reboot == "y" || $reboot == "Y" ]];
    then
        sudo reboot;
    fi;
};

fstab_disable() {
    echo "Continuando eliminerai completamente il file /etc/fstab. Continuare? (y/n)"
    read delete;
    if [[ $delete == "y" || $delete == "Y" ]];
    then
        echo "";
        sudo rm /etc/fstab;
        rm ~/Desktop/Volumes;
        echo "";
        echo "Operazione completata.";

        echo "Vuoi riavviare ora? (y/n)";
        read reboot;
        if [[ $reboot == "y" || $reboot == "Y" ]];
        then
            sudo reboot;
        fi;
    else
        fstab_menu;
    fi;
};

ntfs_3g_menu() {
    clear
    echo "╔═══════════════════════╡ OpenSlime ╞═══════════════════════╗";
    echo "║ Hai scelto: Homebrew e ntfs-3g                            ║";
    echo "║ Scegli un'opzione                                         ║";
    echo "╠═══╦═══════════════════════════════════════════════════════╣";
    echo "║ 1 ║ Abilita scrittua NTFS                                 ║";
    echo "║ 2 ║ Disabilita scrittura NTFS                             ║";
    echo "║ 3 ║ Torna indietro                                        ║";
    echo "║ 4 ║ Esci                                                  ║";
    echo "╚═══╩═══════════════════════════════════════════════════════╝";

    read input;
    case ${input} in
        "1")
            clear;
            ntfs_3g_enable;;
        "2")
            clear;
            ntfs_3g_disable;;
        "3")
            main_menu;;
        "4")
            clear;;
        *)
            ntfs_3g_menu;;
    esac;
};

fstab_menu() {
    clear;
    echo "╔═══════════════════════╡ OpenSlime ╞═══════════════════════╗";
    echo "║ Hai scelto: fstab                                         ║";
    echo "║                                                           ║";
    echo "║ ATTENZIONE: leggi gli avvisi nel README prima di          ║";
    echo "║ continuare! USALO A TUO RISCHIO E PERICOLO!               ║";
    echo "║                                                           ║";
    echo "║ Scegli un'opzione                                         ║";
    echo "╠═══╦═══════════════════════════════════════════════════════╣";
    echo "║ 1 ║ Abilita scrittua NTFS                                 ║";
    echo "║ 2 ║ Disabilita scrittura NTFS                             ║";
    echo "║ 3 ║ Torna indietro                                        ║";
    echo "║ 4 ║ Esci                                                  ║";
    echo "╚═══╩═══════════════════════════════════════════════════════╝";
    read input;
    case ${input} in
        "1")
            clear;
            fstab_enable;;
        "2")
            clear;
            fstab_disable;;
        "3")
            main_menu;;
        "4")
            clear;;
        *)
            fstab_menu;;
    esac;
};

about() {
    clear;
    echo "╔═══════════════════════╡ OpenSlime ╞═══════════════════════╗";
    echo "║ Script creato da gstux e OlioDiPalmas per OpenSlime.it    ║";
    echo "║                                                           ║";
    echo "║ Versione script: ${version}                                ║";
    echo "║                                                           ║";
    echo "║ Questo script è distribuito sotto licenza MIT             ║";
    echo "║ Puoi guardarla dal file LICENSE oppure inviando 1         ║";
    echo "║                                                           ║";
    echo "║ https://github.com/gstux                                  ║";
    echo "║ https://github.com/OlioDiPalmas                           ║";
    echo "║ https://github.com/OpenSlime                              ║";
    echo "╠═══╦═══════════════════════════════════════════════════════╣";
    echo "║ 1 ║ Vedi ora la licenza                                   ║";
    echo "║ 2 ║ Torna indietro                                        ║";
    echo "╚═══╩═══════════════════════════════════════════════════════╝";

    read input;
    case ${input} in
        "1")
            license;;
        "2")
            main_menu;;
        *)
            about;;
    esac;
};

license() {
    clear;
    cat LICENSE
    echo "";
    echo "╔═══╦══════════════════╗";
    echo "║ 1 ║ Torna indietro   ║";
    echo "╚═══╩══════════════════╝";

    read input;
    case ${input} in
        "1")
            about;;
        *)
            license;;
    esac;
};

main_menu() {
    clear;
    echo "╔═══════════════════════╡ OpenSlime ╞═══════════════════════╗";
    echo "║ Benvenuto/a :)                                            ║";
    echo "║ Scegli il metodo che vuoi utilizzare per abilitare        ║";
    echo "║ la scrittura NTFS nel tuo macOS                           ║";
    echo "╠═══╦════════════════════════════════╦══════════════════════╣";
    echo "║ 1 ║ Homebrew e ntfs-3g             ║ lungo, ma stabile    ║";
    echo "║ 2 ║ fstab                          ║ veloce, ma instabile ║";
    echo "║ 3 ║ Informazioni                   ╚══════════════════════╣";
    echo "║ 4 ║ Esci                                                  ║";
    echo "╚═══╩═══════════════════════════════════════════════════════╝";

    read input;
    case ${input} in
        "1")
            ntfs_3g_menu;;
        "2")
            fstab_menu;;
        "3")
            about;;
        "4")
            clear;;
        *)
            main_menu;;
    esac;
};

main_menu;
