# Pandoc Resume

Create a professional ATS-friendly résumé from a single Markdown file (`resume.md`).

The layout follows a clean, single-page style: centered header with name, title, and contact line; uppercase section headings with underline rules; compact Arial typography; and pipe-separated experience entries.

## Usage

1. Edit `resume.md` with your information.
2. Build the resume (see [Windows](#windows) below).
3. Outputs:
   - `index.html` — web preview
   - `resume.pdf` — print-ready PDF

### Windows

**Install Pandoc first** (required):

```powershell
winget install --id JohnMacFarlane.Pandoc -e
```

For PDF output, also install [MiKTeX](https://miktex.org/):

```powershell
winget install --id MiKTeX.MiKTeX -e
```

#### System command: `build-resume` (recommended)

Install once from this project:

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\install-build-resume.ps1
```

Then, from **any folder** that contains `resume.md`:

```powershell
cd C:\path\to\folder
build-resume
```

That writes `resume.pdf` in the current folder (PDF only).

See [system-command.md](system-command.md) for full setup and troubleshooting.

Open a **new** terminal after install if the command is not found.

#### Project-local build

```powershell
.\compile.ps1
# or: make compile
```

If `make compile` fails with *"The system cannot find the file specified"*, Pandoc is not installed or not on your PATH — install it and restart the terminal.

### Linux / macOS

```bash
make compile
```

## Structure

```markdown
---
title: Your Name
subtitle: Your Title
contact: City, ST | phone | email | website
---

## Professional Summary
...

## Technical Skills
**Category:** skill, list

## Professional Experience
**COMPANY** | Location | Date Range
**Role** | *Date Range*
- Bullet points

## Education
```

## Dependencies

- [pandoc](https://pandoc.org/)
- [XeLaTeX](https://www.tug.org/texlive/) (for PDF output; Arial font)
- `make` (optional)

## Links

- [Original Public Archive](https://github.com/LukeSmithxyz/md-website-cv)
