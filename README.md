# MASM on Linux

This repository contains 8086 MS-DOS assemblers/linkers (MASM/TASM and LINK) and tools you can run under Linux using **DOSBox**.
Files in `8086/` (already included):

* `MASM.EXE` — Microsoft Macro Assembler
* `TASM.EXE` — Borland Turbo Assembler
* `LINK.EXE` — Microsoft Linker
* `TD.EXE` — Turbo Debugger (or other DOS debugger)

Below are simple step-by-step instructions to install DOSBox on common Linux distributions, mount this folder inside DOSBox, assemble and link a sample program, plus troubleshooting tips.

---

# 1 Install DOSBox

Choose the command for your distribution.

Debian / Ubuntu / Linux Mint:

```bash
sudo apt update
sudo apt install dosbox -y
```

Fedora:

```bash
sudo dnf install dosbox -y
```

Arch / Manjaro:

```bash
sudo pacman -Syu dosbox
```

openSUSE:

```bash
sudo zypper install dosbox
```

Flatpak (if you prefer):

```bash
flatpak install flathub org.dosbox.DosBox
```

Snap (if available on your distro):

```bash
sudo snap install dosbox --classic
```

(If a command fails, use your distro’s package manager or software center to install the `dosbox` package.)

---

# 2 Prepare your project folder

Put your `.ASM` files alongside the `8086` folder or inside a subfolder. Example layout:

```
your-project/
  8086/
    MASM.EXE
    LINK.EXE
    TASM.EXE
    TD.EXE
    hello.asm
```

Make sure files are readable/executable by your user (Linux execute bit isn't required for DOS executables, but keep permissions sensible):

```bash
ls -l 8086
# If you want to ensure execute bit:
chmod +x 8086/*.EXE
```

---

# 3 Run DOSBox and mount the folder

You can launch an interactive DOSBox session and mount your project directory as drive `C:`:

```bash
dosbox
```

In the DOSBox window:

```
Z:\> mount c /full/path/to/your-project
Z:\> c:
C:\> masm your-project.asm      3xHit Enter
C:\> link your-project.obj      3xHit Enter
C:\> your-project.exe
```

Or mount and run commands directly from your Linux shell (non-interactive):

```bash
dosbox -c "mount c /full/path/to/your-project" -c "c:" -c "dir" -c "exit"
```

Replace `/full/path/to/your-project` with the absolute path (e.g. `/home/ruvais/projects/masm-test`).

---

# 4 Assemble & link with MASM (example)

Here’s a simple workflow using **MASM** + **LINK** for a source file `hello.asm`.

Example `hello.asm` (simple 16-bit DOS program — replace with your own):

```asm
.MODEL SMALL
.STACK 100h
.DATA
msg db 'Hello, DOSBox MASM!',13,10,'$'
.CODE
main proc
    mov ax,@data
    mov ds,ax

    mov ah,09h
    mov dx,offset msg
    int 21h

    mov ax,4C00h
    int 21h
main endp
end main
```

Commands inside DOSBox:

```
C:\> 8086\MASM.EXE hello.asm
C:\> 8086\LINK.EXE hello.obj
C:\> hello.exe
```

Or from Linux, in one `dosbox` invocation:

```bash
dosbox -c "mount c /full/path/to/your-project" \
       -c "c:" \
       -c "8086\\MASM.EXE hello.asm" \
       -c "8086\\LINK.EXE hello.obj" \
       -c "hello.exe" \
       -c "exit"
```

> Note: inside DOSBox, use backslashes for paths (`8086\MASM.EXE`). When calling from the shell, escape them or put the whole `-c` string in quotes as above.

---

# 5 Using TASM / TD (Turbo Assembler / Debugger)

To assemble with TASM:

```
C:\> 8086\TASM.EXE hello.asm
C:\> 8086\TASM.EXE hello.obj  ; or use TLINK if present
C:\> hello.exe
```

To debug with TD:

```
C:\> 8086\TD.EXE hello.exe
```

(Turbo tool usage may vary depending on the version; consult any included docs or help screens: `8086\TASM.EXE /?`)

---

# 6 Tips and recommended DOSBox settings

If assembly or linking is slow, increase CPU cycles and memory in DOSBox:

From within DOSBox:

```
Z:\> CPU cycles 8000
Z:\> mem 32  ; sets memory (if supported)
```

Or edit/create `dosbox.conf` and add under `[cpu]` / `[dosbox]` sections (interactive editors required). For most simple assembly tasks the default config is fine.

---

# 7 Automating builds (optional)

Create a small shell script to run MASM build under DOSBox:

`build.sh`

```bash
#!/usr/bin/env bash
PROJECT="$(realpath "$(dirname "$0")")"
dosbox -c "mount c $PROJECT" \
       -c "c:" \
       -c "8086\\MASM.EXE $1" \
       -c "8086\\LINK.EXE ${1%.asm}.obj" \
       -c "exit"
```

Usage:

```bash
chmod +x build.sh
./build.sh hello.asm
```

---

# 8 Troubleshooting

* **"Bad command or file name"**: Make sure you mounted the correct folder and switched to the `C:` drive.
* **Permissions issues**: DOS executables are run by DOSBox; Linux file permissions rarely block them, but ensure the files exist and paths are correct.
* **Help screens**: Run `8086\MASM.EXE /?` or `8086\LINK.EXE /?` inside DOSBox to see their options.
* **Linker errors about missing libraries**: MS linkers may expect default library names; ensure you’re using compatible object formats and link options. For Turbo tools, use `TLINK` if provided.
* **Programs fail due to 32-bit vs 16-bit**: These are DOS (16-bit) executables — DOSBox is the right environment. Running directly under Wine may not always work for these old tools.

---

# 9 Safety & licensing

These executables may be proprietary (MASM, TASM, LINK, TD). Ensure you have the legal right to use/distribute them. This README assumes you already own or are permitted to use these tools for development/testing. I am not providing the binaries — only usage instructions.

---

# 10 Example quick checklist

1. Install `dosbox`.
2. Place `8086/` and your `.asm` in a project folder.
3. `dosbox` → `mount c /path/to/project` → `c:`
4. `8086\MASM.EXE myprog.asm` → `8086\LINK.EXE myprog.obj` → `myprog.exe`

---
