# Resume system commands

Two commands are installed together:

- `build-resume` — build a PDF from `resume.md` in the current folder
- `unzip-build-resume` — unzip every `.zip` in the current folder, then run `build-resume` in each extracted folder

---

# `build-resume`

Build a PDF resume from `resume.md` in the current folder.

## What it does

From any folder that contains `resume.md`:

```powershell
build-resume
```

Creates / overwrites:

- `resume.pdf`

It does **not** create HTML.

## Prerequisites

Install these once. **Chocolatey is recommended** on Windows:

```powershell
choco install pandoc -y
choco install miktex -y
```

Alternative (winget):

```powershell
winget install --id JohnMacFarlane.Pandoc -e
winget install --id MiKTeX.MiKTeX -e
```

Close and reopen your terminal after installing.

Verify:

```powershell
pandoc --version
xelatex --version
```

## Install the commands

Run this once from the `pandoc-resume` project folder:

```powershell
cd C:\Users\Administrator\Documents\pandoc-resume
powershell -ExecutionPolicy Bypass -File .\scripts\install-build-resume.ps1
```

This will:

1. Install `build-resume` and `unzip-build-resume` to `%LOCALAPPDATA%\pandoc-resume\bin`
2. Copy PDF style templates to `%LOCALAPPDATA%\pandoc-resume\templates`
3. Add the `bin` folder to your user PATH

Then open a **new** terminal window.

## Usage

1. Put your content in `resume.md`
2. Open a Command Prompt in that folder
3. Run:

```bat
build-resume
```

When the build finishes, the Command Prompt window closes automatically.

Example:

```bat
cd C:\Users\Administrator\Documents\my-resume
build-resume
```

Optional arguments:

```bat
build-resume -Markdown resume.md -OutPdf resume.pdf
```

Custom PDF file name example:

```bat
build-resume -OutPdf "Jesse_Pinzon_Senior_AI_Engineer.pdf"
```

> **Note:** Closing the window applies when you run `build-resume` from **Command Prompt** (`cmd.exe`). In PowerShell, only the command ends; your PowerShell session stays open.

---

# `unzip-build-resume`

Unzip every `.zip` in a folder, then run `build-resume` inside each extracted folder.

## What it does

From a folder that contains one or more zip files:

```powershell
unzip-build-resume
```

For each `Name.zip` it:

1. Creates / overwrites a folder named `Name` (same name as the zip, without `.zip`)
2. Extracts the zip into that folder
3. Runs `build-resume` in the folder that contains `resume.md`
4. Deletes `Name.zip` after a successful build

Failed zips are left in place so you can fix them and run the command again.

If a zip has a single top-level folder, that inner folder is flattened so `resume.md` lands in `Name\`, not `Name\Name\`.

## Usage

1. Put the zip files in a folder
2. Open a Command Prompt in that folder
3. Run:

```bat
unzip-build-resume
```

Example:

```bat
cd C:\Users\Administrator\Documents\resumes
unzip-build-resume
```

If that folder contains:

```text
Microsoft-SeniorAIEngineer.zip
Google-StaffEngineer.zip
```

You get:

```text
Microsoft-SeniorAIEngineer\resume.md
Microsoft-SeniorAIEngineer\resume.pdf
Google-StaffEngineer\resume.md
Google-StaffEngineer\resume.pdf
```

The original `.zip` files are deleted after they build successfully.

Optional: process a different folder or a single zip:

```bat
unzip-build-resume -Path C:\Users\Administrator\Documents\resumes
unzip-build-resume -Path C:\Users\Administrator\Documents\resumes\Microsoft-SeniorAIEngineer.zip
```

When the batch finishes, the Command Prompt window closes automatically.

> **Note:** Closing the window applies when you run `unzip-build-resume` from **Command Prompt** (`cmd.exe`). In PowerShell, only the command ends; your PowerShell session stays open.

Each zip is processed independently. If one zip fails (for example it has no `resume.md`), the others still run. A summary is printed at the end.

---

## Update styles

If you change the project style templates (`template.tex`, etc.), re-run the install script so the shared templates are refreshed:

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\install-build-resume.ps1
```

## Troubleshooting

### `build-resume` or `unzip-build-resume` is not recognized

- Open a new terminal (PATH updates apply to new sessions)
- Confirm install path exists: `%LOCALAPPDATA%\pandoc-resume\bin\build-resume.cmd`
- Confirm: `%LOCALAPPDATA%\pandoc-resume\bin\unzip-build-resume.cmd`
- Re-run `scripts\install-build-resume.ps1`

### `No 'resume.md' in current folder`

- Make sure your current directory contains `resume.md`
- Check with: `dir resume.md`

### `No .zip files`

- Run `unzip-build-resume` from the folder that contains the zip files
- Check with: `dir *.zip`

### `No resume.md inside ...zip`

- The zip must contain a `resume.md` file (at the top level or in a nested folder)
- Open the zip and confirm the file name is exactly `resume.md`

### PDF file is locked

- Close any PDF viewer that has the PDF open
- Run `build-resume` or `unzip-build-resume` again

### `pandoc` or `xelatex` not found

Install Pandoc and MiKTeX (see Prerequisites), then reopen the terminal.

## Uninstall

```powershell
Remove-Item -Recurse -Force "$env:LOCALAPPDATA\pandoc-resume"
```

Then remove this folder from your user PATH if it is still listed:

`%LOCALAPPDATA%\pandoc-resume\bin`

## Related document

For the full ChatGPT + local PDF workflow, see [SETUP.md](SETUP.md).
