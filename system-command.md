# `build-resume` system command

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

Install these once:

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

## Install the `build-resume` command

Run this once from the `pandoc-resume` project folder:

```powershell
cd C:\Users\Administrator\Documents\pandoc-resume
powershell -ExecutionPolicy Bypass -File .\scripts\install-build-resume.ps1
```

This will:

1. Install `build-resume` to `%LOCALAPPDATA%\pandoc-resume\bin`
2. Copy PDF style templates to `%LOCALAPPDATA%\pandoc-resume\templates`
3. Add the `bin` folder to your user PATH

Then open a **new** terminal window.

## Usage

1. Put your content in `resume.md`
2. Open a terminal in that folder
3. Run:

```powershell
build-resume
```

Example:

```powershell
cd C:\Users\Administrator\Documents\my-resume
build-resume
```

Optional arguments:

```powershell
build-resume -Markdown resume.md -OutPdf resume.pdf
```

## Update styles

If you change the project style templates (`template.tex`, etc.), re-run the install script so the shared templates are refreshed:

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\install-build-resume.ps1
```

## Troubleshooting

### `build-resume` is not recognized

- Open a new terminal (PATH updates apply to new sessions)
- Confirm install path exists: `%LOCALAPPDATA%\pandoc-resume\bin\build-resume.cmd`

### `No 'resume.md' in current folder`

- Make sure your current directory contains `resume.md`
- Check with: `dir resume.md`

### PDF file is locked

- Close any PDF viewer that has `resume.pdf` open
- Run `build-resume` again

### `pandoc` or `xelatex` not found

Install Pandoc and MiKTeX (see Prerequisites), then reopen the terminal.

## Uninstall

```powershell
Remove-Item -Recurse -Force "$env:LOCALAPPDATA\pandoc-resume"
```

Then remove this folder from your user PATH if it is still listed:

`%LOCALAPPDATA%\pandoc-resume\bin`
