# Abilita la scrittura NTFS su macOS

Questo script **ti semplificherà la vita**, proponendo due modi per abilitare la scrittura NTFS.
Tutti i comandi necessari li farà **lui**. Tu dovrai solo confermare e, quando richiesto, inserire la tua password.

# Preparazione

**Requisiti**
* OS X 10.9 e superiori (consigliato: macOS 10.11 e superiori)
* SIP disattivato **(!!!)**
* Buona connessione Internet
* Command Line Tools di Xcode

Per installare Command Line Tools di Xcode, apri il Terminale (Applicazioni > Utility) e invia questo comando:
```
xcode-select --install
```
Dopo averlo fatto, invia questi comandi per scaricare e avviare lo script:
```
git clone https://github.com/OpenSlime/ntfs-macos.git
cd ntfs-macos
chmod 755 ntfs-macos.sh
./ntfs-macos.sh           # Avvia lo script
```
# Come usarlo
Muoviti nei menu inviando il numero/opzione desiderato. Scegli uno dei modi che più ti piace. Segui quello che dice lo script per completare l'operazione senza problemi.

# Caratteristiche
I due modi per abilitare la scrittura NTFS sono:
* **Homebrew e ntfs-3g** (consigliato): lo script installa Homebrew, osxfuse e ntfs-3g e sostituisce il mount tool di Apple con quello di ntfs-3g. L'installazione e la configurazione può durare qualche minuto, ma è più stabile e più comodo;
* **fstab:** lo script aggiunge una riga, con il nome del tuo device NTFS, nel file /etc/fstab per abilitare la scrittura NTFS in quel device. Non installa nessun programma e ci mette pochi secondi, ma è **sperimentale e instabile** e, se usato male, può portare alla **perdita di dati! FALLO A TUO RISCHIO E PERICOLO!**

Ovviamente dovrai scegliere **solo uno** di questi modi.

## Se vuoi usare fstab...
* Per aggiungere un altro device NTFS, **dovrai rifare l'operazione**
* Collegando il device NTFS, questo **non** comparirà nella scrivania. Sarà nella cartella Volumes, già presente nella scrivania dopo aver completato l'operazione "Abilita scrittura NTFS"
* L'opzione "Disabilita scrittura NTFS" rimuove **completamente** il file /etc/fstab

# Licenza
Lo script usa la licenza MIT. Per leggerla, apri il file LICENSE oppure, avviato lo script, vai su 3) Informazioni > 1) Vedi ora la licenza.

# Crediti
* gstux per aver creato lo script
* OlioDiPalmas per averlo ottimizzato al meglio per farlo funzionare su macOS
* [Homebrew](https://github.com/Homebrew) per il suo incredibile package manager
* [osxfuse](https://github.com/osxfuse/osxfuse) per FUSE for macOS e per la wiki su [NTFS-3G](https://github.com/osxfuse/osxfuse/wiki/NTFS-3G)
* [Learn-a-holic Geek Notes](http://learnaholic.me/2013/11/11/enable-ntfs-write-on-mac-os-x-mavericks/) per l'articolo su fstab

(readme in sviluppo...)
