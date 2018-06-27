# Abilita la scrittura NTFS su macOS

Questo script **ti semplificherà la vita**, proponendo due modi per abilitare la scrittura NTFS.
Tutti i comandi necessari li farà **lui**. Tu dovrai solo confermare e, quando richiesto, inserire la tua password.

# Preparazione

**Requisiti**
* OS X 10.9 e superiori (consigliato: OS X 10.11 e superiori) | **NON funziona su macOS Mojave Beta!**
* SIP disattivato (vedi Disattivazione SIP)
* Buona connessione Internet
* Command Line Tools di Xcode

Per installare Command Line Tools di Xcode, apri il Terminale (Applicazioni > Utility) e invia questo comando:

```
xcode-select --install
```

Dopo averlo fatto, invia questi comandi per scaricare e avviare lo script:

```
git clone https://gitlab.com/OpenSlime/ntfs-macos.git
cd ntfs-macos
chmod 755 ntfs-macos.sh
./ntfs-macos.sh     # Avvia lo script
```

Se non stai usando bash ma un'altra shell (es. fish), per avviare lo script usa invece questo comando:

```
bash ntfs-macos.sh
```
## Disattivazione SIP

Prima di avviare lo script, è necessario **disattivare il SIP** se vuoi usare il metodo Homebrew e ntfs-3g. Per fstab è opzionale.

**Nota:** il SIP è stato introdotto da **OS X El Capitan (10.11) e successivi**. Se hai una versione di OS X **precedente** alla 10.11, disattivare/riattivare il SIP è **inutile** e puoi tranquillamente avviare lo script, saltando questa guida.

1. Spegni il Mac e riaccendilo, tenendo premuto cmd (⌘) + R per entrare in modalità recovery
2. Dopo qualche minuto, sarai nella modalità recovery. Sulla barra in alto clicca su Utility e apri il Terminale
3. Aperto il terminale, scrivi questo comando e premi Invio: `csrutil disable`
4. Se compare questo, complimenti! Hai disattivato il SIP :smiley:

```
Successfully disabled System Integrity Protection. Please restart the machine for the changes to take effect.
```

Non ti resta che riavviare il Mac e finalmente avviare il nostro script :grin:

### Riattivazione SIP

Dopo aver completato il metodo Homebrew e ntfs-3g, è **consigliato riabilitare SIP**, per rendere il tuo macOS meno vulnerabile.

**Nota:** il SIP è stato introdotto da **OS X El Capitan (10.11) e successivi**. Se hai una versione di OS X **precedente** alla 10.11, disattivare/riattivare il SIP è **inutile** e puoi tranquillamente avviare lo script, saltando questa guida.

1. Spegni il Mac e riavviarlo in modalità recovery
2. Apri il Terminale e invia questo: `csrutil enable`
3. Se compare questo, hai riattivato il SIP con successo:

```
Successfully enabled System Integrity Protection. Please restart the machine for the changes to take effect.
```

# Come usarlo
Muoviti nei menu inviando il numero/opzione desiderato. Scegli uno dei modi che più ti piace. Segui quello che dice lo script per completare l'operazione senza problemi.

# Caratteristiche
I due modi per abilitare la scrittura NTFS sono:
* **Homebrew e ntfs-3g** (consigliato): lo script installa Homebrew, osxfuse e ntfs-3g e sostituisce il mount tool di Apple con quello di ntfs-3g. L'installazione e la configurazione può durare qualche minuto, ma è più stabile e più comodo;
* **fstab:** lo script aggiunge una riga, con il nome del tuo device NTFS, nel file /etc/fstab per abilitare la scrittura NTFS in quel device. Non installa nessun programma e ci mette pochi secondi, ma è **sperimentale e instabile** e, se usato male, può portare alla **perdita di dati! FALLO A TUO RISCHIO E PERICOLO!**

Ovviamente dovrai scegliere **solo uno** di questi modi.

### Se vuoi usare fstab...
* Per aggiungere un altro device NTFS, **dovrai rifare l'operazione**
* Collegando il device NTFS, questo **non** comparirà nella scrivania. Sarà nella cartella Volumes, già presente nella scrivania dopo aver completato l'operazione "Abilita scrittura NTFS"
* L'opzione "Disabilita scrittura NTFS" rimuove **completamente** il file /etc/fstab
* Se hai sbagliato a scrivere il nome del device durante l'operazione oppure vuoi rimuovere solo un device e non l'intero file, lo script ti permette di modificare /etc/fstab tramite l'opzione **"Modifica manualmente /etc/fstab"**
* Nel caso stai modificando il file /etc/fstab per sistemare il nome del device, devi toccare **solamente** la parte "LABEL=". Modificare altro senza motivo può rendere impossibile il mount e quindi non poter usare il device nel Mac o peggio (anche se basta rimuovere il file /etc/fstab per risolvere il problema :new_moon_with_face:)

# Licenza
Lo script usa la licenza MIT.

Per leggerla, apri il file LICENSE oppure, avviato lo script, vai su 3) Informazioni > 1) Vedi ora la licenza.

# Crediti
* gstux per aver creato lo script
* OlioDiPalmas per averlo ottimizzato al meglio per farlo funzionare su macOS
* [Homebrew](https://github.com/Homebrew) per il suo incredibile package manager
* [osxfuse](https://github.com/osxfuse/osxfuse) per FUSE for macOS e per la wiki su [NTFS-3G](https://github.com/osxfuse/osxfuse/wiki/NTFS-3G)
* [Learn-a-holic Geek Notes](http://learnaholic.me/2013/11/11/enable-ntfs-write-on-mac-os-x-mavericks/) per l'articolo su fstab

Sono ben accetti aiuti e ulteriori test (soprattutto su OS X 10.9 e OS X 10.10) che possano migliorare questo script :smile:
