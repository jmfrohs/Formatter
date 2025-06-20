# Batch-Code-Formatter

**Batch-Code-Formatter** ist ein umfangreiches Windows-Batch-Tool zum automatischen Formatieren und Lizenzieren von Quellcode-Dateien verschiedenster Programmiersprachen. Es unterstützt die Installation und Verwaltung von Formattern, das Hinzufügen von Lizenz-Headern, sowie die Analyse und Aufbereitung ganzer Projekte.

---

## Features

- **Automatische Formatierung** für viele Sprachen: JavaScript, Python, Java, C/C++, PHP, Rust, Go, HTML, CSS, uvm.
- **Lizenzverwaltung**: Lizenz-Header automatisch zu Dateien hinzufügen (MIT, Apache, GPL, BSD, ISC, Custom).
- **Batch- und Einzeldatei-Bearbeitung**.
- **Spracherkennung für TXT-Dateien** mit manueller Auswahlmöglichkeit.
- **Tool-Installation** direkt aus dem Menü (Prettier, Black, clang-format, usw.).
- **Konfigurierbare Standardwerte** (Lizenz, Autor, Jahr, etc.).
- **Projektweite Aufbereitung** mit Statistik-Report.
- **Farbiges Konsolenmenü** und ASCII-Logo.
- **Backup-Funktion** vor Lizenzierung.
- **Cache- und Konfigurationsmanagement**.

---

## Voraussetzungen

- **Windows** (getestet ab Windows 10)
- **cmd.exe** (Batch-Dateien)
- Für bestimmte Formatter:  
  - [Node.js](https://nodejs.org/) (für Prettier, ESLint, JS-Beautify)
  - [Python](https://www.python.org/) (für Black, autopep8, YAPF, isort)
  - [Java](https://adoptium.net/) (für google-java-format)
  - [PHP](https://www.php.net/) (für PHP-CS-Fixer)
  - [Rust](https://www.rust-lang.org/tools/install) (für rustfmt)
  - [Go](https://go.dev/dl/) (für gofmt)
  - [LLVM/Clang](https://llvm.org/) (für clang-format)

---

## Installation

1. **Repository herunterladen**  
   Lade das Repository als ZIP herunter oder klone es:

   ```sh
   git clone https://github.com/dein-benutzername/Batch-Code-Formatter.git
   ```

2. **Batch-Datei starten**  
   Öffne die `Batch-Code-Formatter.bat` per Doppelklick oder im Terminal:

   ```sh
   cd Pfad\zum\Ordner
   Batch-Code-Formatter.bat
   ```

3. **Formatter installieren**  
   Über das Menü können alle benötigten Tools automatisch installiert werden.

---

## Bedienung

### Hauptmenü

- **Formatierung**: Einzelne Datei oder ganzes Verzeichnis formatieren und lizenzieren.
- **Lizenzierung**: Lizenz zu einzelnen oder mehreren Dateien hinzufügen/entfernen.
- **Tool-Installation**: Formatter für verschiedene Sprachen installieren.
- **Konfiguration**: Standard-Lizenz, Autor, Jahr, Templates verwalten.
- **TXT-Datei-Formatierung**: Sprache wählen, formatieren und Lizenz hinzufügen.
- **Projekt-Aufbereitung**: Komplettes Projekt formatieren und lizenzieren.

### Beispiel: TXT-Datei formatieren

1. Wähle im Menü `[25] TXT-Datei mit Sprach-Erkennung formatieren`.
2. Gib den Pfad zur TXT-Datei ein.
3. Wähle die Programmiersprache aus.
4. Die Datei wird temporär umbenannt, formatiert und zurückkopiert.
5. Optional: Lizenz-Header hinzufügen.

---

## Konfiguration

Die Einstellungen werden in `config\settings.ini` gespeichert.  
Hier kannst du Standard-Lizenz, Autor, Jahr, unterstützte Dateitypen und weitere Optionen anpassen.

---

## Unterstützte Lizenzen

- MIT
- Apache-2.0
- GPL-3.0
- BSD-3-Clause
- ISC
- Custom (frei editierbar)
- None (nur Copyright)

---

## Hinweise

- Das Script erstellt Backups vor Lizenzänderungen, sofern aktiviert.
- Für einige Formatter ist eine vorherige Installation von Node.js, Python, Java, PHP, Rust oder Go erforderlich.
- Die Formatierung von TXT-Dateien erfolgt nach manueller Sprachauswahl.
- Das Tool ist modular aufgebaut und kann leicht erweitert werden.

---

## Fehlerbehebung

- **Formatter nicht gefunden:** Stelle sicher, dass die benötigten Tools installiert und im PATH sind.
- **Lizenz wird nicht hinzugefügt:** Prüfe, ob bereits ein Copyright-Hinweis in der Datei existiert.
- **Menü zeigt keine Farben:** Die Farbausgabe ist auf Konsolenebene (`color`-Befehl) beschränkt.

---

## Lizenz

Dieses Projekt steht unter der MIT-Lizenz.  
Siehe [LICENSE](LICENSE) für Details.

---

## Autor

**jmfrohs**  
2025