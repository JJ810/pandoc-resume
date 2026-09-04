# Pandoc Resume — Setup and Workflow Guide

This guide explains how to set up the **pandoc-resume** toolchain on Windows and how to use it with a ChatGPT project to produce job-targeted resume PDFs.

---

## Overview

The workflow has three stages:

1. **Local setup** — Install Pandoc, MiKTeX, and the resume system commands (`build-resume` and `unzip-build-resume`).
2. **ChatGPT project** — Paste a job description and download a zip that contains `resume.md` and `job.txt`.
3. **PDF generation** — Put one or more of those zips in a folder and run `unzip-build-resume` to extract them and build every PDF at once.

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



### 1.3 Install the resume system commands

From the `pandoc-resume` project directory:

```powershell
cd C:\Users\Administrator\Documents\pandoc-resume
powershell -ExecutionPolicy Bypass -File .\scripts\install-build-resume.ps1
```

This command:

- Installs `build-resume` and `unzip-build-resume` to `%LOCALAPPDATA%\pandoc-resume\bin`
- Copies PDF style templates to `%LOCALAPPDATA%\pandoc-resume\templates`
- Adds the `bin` folder to your user PATH

Open a **new** terminal window after installation.

Confirm `build-resume` is available:

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
2. Download the zip ChatGPT produces. Each zip includes:
   - `resume.md` — tailored resume content
   - `job.txt` — job summary and company information
3. Repeat for additional jobs. You can collect several zips and build them all in one step (Part 3).

---



## Part 3 — Generate the PDF locally



### 3.1 Save the ChatGPT zip files

Put the downloaded zip files in one folder. Example:

```powershell
mkdir C:\Users\Administrator\Documents\resumes
```

Copy or move the zips there. You can add one zip or many.

Each zip includes:

| File        | Description                                                             |
| ----------- | ----------------------------------------------------------------------- |
| `resume.md` | Tailored resume content from ChatGPT (required to build the PDF)        |
| `job.txt`   | Job summary from ChatGPT (kept for your records)                        |


### 3.2 Unzip and build all resumes at once

In that folder, run:

```bat
cd C:\Users\Administrator\Documents\resumes
unzip-build-resume
```

For each `Name.zip`, this command:

1. Extracts the zip into a folder named `Name`
2. Runs `build-resume` inside that folder
3. Deletes `Name.zip` after a successful build

Example: if the folder contains

```text
Microsoft-SeniorAIEngineer.zip
Google-StaffEngineer.zip
```

you get

```text
Microsoft-SeniorAIEngineer\resume.md
Microsoft-SeniorAIEngineer\job.txt
Microsoft-SeniorAIEngineer\resume.pdf
Google-StaffEngineer\resume.md
Google-StaffEngineer\job.txt
Google-StaffEngineer\resume.pdf
```

Successful zip files are deleted after the PDF is built. Failed zips are left in place. When run from **Command Prompt**, the window closes automatically after the batch finishes.

See [system-command.md](system-command.md) for `unzip-build-resume` details.


### 3.3 Build a single already-unzipped folder

If you already have a folder that contains `resume.md`, you do not need the zip command. Open that folder and run:

```bat
build-resume
```

This creates / overwrites the PDF in that folder.


### 3.4 Customize the PDF file name (optional)

By default, the output is `jesse_pinzon_resume.pdf`.

To use a custom name (single folder):

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
4. Open a new terminal and confirm `build-resume` (and `unzip-build-resume`) are available.
5. Create a ChatGPT project, upload sample `resume.md` to Sources, set **Project-only memory**, and paste project instructions.
6. Paste a job description into the ChatGPT project.
7. Download the zip ChatGPT produces (`resume.md` and `job.txt` inside). Repeat for each job.
8. Put the zip files in one local folder.
9. Run `unzip-build-resume` in that folder to unzip every archive and build every PDF.
10. Open and review the generated PDFs. Use `build-resume` later if you edit a single unzipped folder.

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

- [system-command.md](system-command.md) — `build-resume` and `unzip-build-resume` install, usage, and troubleshooting
- [README.md](README.md) — project overview and Markdown structure
