# Batch-Code-Formatter

**Batch-Code-Formatter** is a comprehensive Windows batch tool for automatically formatting and licensing source code files in various programming languages. It supports formatter installation, license management, project-wide processing, TXT file language detection, and even experimental batch file formatting.

---

## Features

- **Automatic formatting** for many languages: JavaScript, Python, Java, C/C++, PHP, Rust, Go, HTML, CSS, and more
- **Batch and single file processing**
- **License management**: Add or remove license headers (MIT, Apache, GPL, BSD, ISC, Custom, None)
- **TXT file formatting** with language detection and manual selection
- **Experimental batch file formatting** (`.bat`, `.cmd`)
- **Tool installation** directly from the menu (Prettier, Black, clang-format, etc.)
- **Configurable defaults** (license, author, year, etc.)
- **Project-wide processing** with statistics report
- **Colored console menu** and ASCII logo
- **Backup function** before licensing (optional)
- **Cache and configuration management**

---

## Requirements

- **Windows** (tested on Windows 10 and above)
- **cmd.exe** (batch files)
- For certain formatters:  
  - [Node.js](https://nodejs.org/) (for Prettier, ESLint, JS-Beautify)
  - [Python](https://www.python.org/) (for Black, autopep8, YAPF, isort)
  - [Java](https://adoptium.net/) (for google-java-format)
  - [PHP](https://www.php.net/) (for PHP-CS-Fixer)
  - [Rust](https://www.rust-lang.org/tools/install) (for rustfmt)
  - [Go](https://go.dev/dl/) (for gofmt)
  - [LLVM/Clang](https://llvm.org/) (for clang-format)
  - **PowerShell** (for batch file formatting)

---

## Installation

1. **Download the repository**  
   Download as ZIP or clone:

   ```sh
   git clone https://github.com/your-username/Batch-Code-Formatter.git
   ```

2. **Start the batch file**  
   Open `Batch-Code-Formatter.bat` by double-clicking or in the terminal:

   ```sh
   cd path\to\Batch-Code-Formatter
   Batch-Code-Formatter.bat
   ```

3. **Install formatters**  
   All required tools can be installed automatically via the menu.

---

## Usage

### Main Menu Options

- **Formatting**: Format and license a single file or an entire directory
- **Licensing**: Add or remove licenses to/from single or multiple files
- **Tool installation**: Install formatters for various languages
- **Configuration**: Manage default license, author, year, templates
- **TXT file formatting**: Select language, format, and add license
- **Batch file formatting**: Format `.bat`/`.cmd` files (experimental)
- **Project preparation**: Format and license an entire project

### Example: Format a TXT file

1. Select `[25] Format TXT file with language detection` in the menu.
2. Enter the path to the TXT file.
3. Choose the programming language.
4. The file will be temporarily renamed, formatted, and copied back.
5. Optionally: Add a license header.

### Example: Format a Batch file

1. Select `[28] Batch-Datei formatieren (experimentell)` in the menu.
2. Enter the path to your `.bat` or `.cmd` file.
3. The file will be cleaned up (trailing spaces removed, line endings unified).
4. Optionally: Add a license header.

---

## Configuration

Settings are stored in `config/settings.ini`.  
You can adjust default license, author, year, supported file types, and more.

---

## Supported Licenses

- MIT
- Apache-2.0
- GPL-3.0
- BSD-3-Clause
- ISC
- Custom (editable)
- None (copyright only)

---

## Notes

- The script creates backups before license changes if enabled.
- Some formatters require prior installation of Node.js, Python, Java, PHP, Rust, or Go.
- TXT file formatting is performed after manual language selection.
- Batch file formatting is experimental and only unifies line endings and trims trailing spaces.
- The tool is modular and easily extendable.

---

## Troubleshooting

- **Formatter not found:** Make sure the required tools are installed and in your PATH.
- **License not added:** Check if a copyright notice already exists in the file.
- **Menu shows no colors:** Color output is limited to the console (`color` command).

---

## License

This project is licensed under the MIT License.  
See [LICENSE](LICENSE) for details.

---

## Author

**jmfrohs**  
2025