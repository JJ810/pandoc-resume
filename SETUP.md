# Pandoc Resume — Setup and Workflow Guide

This guide explains how to set up the **pandoc-resume** toolchain on Windows and how to use it with a ChatGPT project to produce job-targeted resume PDFs.

---

## Overview

The workflow has three stages:

1. **Local setup** — Install Pandoc, MiKTeX, and the `build-resume` system command.
2. **ChatGPT project** — Paste a job description and receive a job summary (`.txt`), a tailored `resume.md`, and a suggested folder name.
3. **PDF generation** — Create that folder locally, place the generated files inside it, and run `build-resume` to produce the PDF.

---



## Part 1 — Local environment setup



### 1.1 Install Chocolatey (recommended)

Open **PowerShell as Administrator** and install Chocolatey if it is not already installed:

```powershell
Set-ExecutionPolicy Bypass -Scope Process -Force
[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072
iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
```

Close and reopen the terminal after installation.

### 1.2 Install Pandoc and MiKTeX

Using Chocolatey (recommended):

```powershell
choco install pandoc -y
choco install miktex -y
```

Alternative (winget):

```powershell
winget install --id JohnMacFarlane.Pandoc -e
winget install --id MiKTeX.MiKTeX -e
```

Close and reopen the terminal, then verify:

```powershell
pandoc --version
xelatex --version
```



### 1.3 Install the `build-resume` system command

From the `pandoc-resume` project directory:

```powershell
cd C:\Users\Administrator\Documents\pandoc-resume
powershell -ExecutionPolicy Bypass -File .\scripts\install-build-resume.ps1
```

This command:

- Installs `build-resume` to `%LOCALAPPDATA%\pandoc-resume\bin`
- Copies PDF style templates to `%LOCALAPPDATA%\pandoc-resume\templates`
- Adds the `bin` folder to your user PATH

Open a **new** terminal window after installation.

Confirm the command is available:

```powershell
build-resume
```

If you see a message about a missing `resume.md`, the command is installed correctly (it expects `resume.md` in the current folder).

For full command details and troubleshooting, see [system-command.md](system-command.md).

---



## Part 2 — ChatGPT project setup



### 2.1 Create a project

1. Open ChatGPT.
2. Create a new **Project**.
3. In the project **Sources** tab, upload the sample `readme.md` from this repository (or your preferred style/content reference file).



### 2.2 Configure project settings

Open the project settings popup and configure the following:


| Setting      | Value                                                                                                                 |
| ------------ | --------------------------------------------------------------------------------------------------------------------- |
| Memory       | **Project-only memory**                                                                                               |
| Instructions | Use the instruction to extract the job summary and company information. Reference this file for interview preparation |


Do **not** use account-wide memory for this project. Keep memory scoped to the project so job-specific context does not leak across unrelated chats.

### 2.4 Use the ChatGPT project

1. Paste the full job description into the project chat.
2. Download or copy the three outputs:
  - Job summary & Company information → save as a `job.txt` file
  - Resume Markdown → save as `resume.md`
  - Folder name → use when creating the local folder

---



## Part 3 — Generate the PDF locally



### 3.1 Create the application folder

Create a folder using the ChatGPT-suggested name. Example:

```powershell
mkdir C:\Users\Administrator\Documents\resumes\Microsoft-SeniorAIEngineer
cd C:\Users\Administrator\Documents\resumes\Microsoft-SeniorAIEngineer
```



### 3.2 Add the generated files

Place these files in the folder:


| File        | Description                                                             |
| ----------- | ----------------------------------------------------------------------- |
| `resume.md` | Tailored resume content from ChatGPT                                    |
| `job.txt`   | Job summary from ChatGPT (optional for PDF build, useful for reference) |


The PDF build requires only `resume.md`. The `job.txt` summary is for your records.

### 3.3 Build the PDF

In that folder, run:

```powershell
build-resume
```

This creates:

```text
resume.pdf
```



### 3.4 Customize the PDF file name (optional)

By default, the output is `jesse_pinzon_resume.pdf`.

To use a custom name:

```powershell
build-resume -OutPdf "Jesse_Pinzon_Senior_AI_Engineer.pdf"
```

To use a different Markdown source file:

```powershell
build-resume -Markdown resume.md -OutPdf "Jesse_Pinzon_Microsoft.pdf"
```

These options are defined in the `build-resume` command installed from this project. See [system-command.md](system-command.md).

---



## End-to-end checklist

1. Install Chocolatey (recommended).
2. Install Pandoc and MiKTeX (`choco install pandoc miktex -y`).
3. Run `scripts\install-build-resume.ps1` from the pandoc-resume project.
4. Open a new terminal and confirm `build-resume` is available.
5. Create a ChatGPT project, upload sample `resume.md` to Sources, set **Project-only memory**, and paste project instructions.
6. Paste a job description into the ChatGPT project.
7. Save the returned `job.txt`, `resume.md`, and folder name.
8. Create the local folder and copy the files into it.
9. Run `build-resume` (optionally with `-OutPdf` for a custom PDF name).
10. Open and review the generated PDF.

---



## Updating styles later

If you change styling files in the pandoc-resume project (`template.tex`, etc.), refresh the installed templates:

```powershell
cd C:\Users\Administrator\Documents\pandoc-resume
powershell -ExecutionPolicy Bypass -File .\scripts\install-build-resume.ps1
```

Then rebuild any resume folder with `build-resume`.

---



## Related documents

- [system-command.md](system-command.md) — `build-resume` install, usage, and troubleshooting
- [README.md](README.md) — project overview and Markdown structure

