# IT Scripts - `scripts/`

Handy, portable **POSIX `sh`** utilities for day-to-day IT tasks.  
No external dependencies beyond a standard Unix-like environment.

> **TL;DR**
>
> - See usage/help: `<script> -h` or `<script> --help`  
> - Many tasks require root: prefix with `sudo`

---

## What’s here

| Path | What it’s for |
|-|-|
| `apache-instanciate/` | Tools to set up/manage **multiple Apache HTTP Server instances** on one host. |

> Tip: If a script name isn’t obvious, run it with `-h`/`--help` to see flags and examples.

---

## Prerequisites

- **Shell:** POSIX `sh` (works with `/bin/sh`; Bash/Zsh are fine too)
- **OS:** Any modern Linux/Unix.
- **Privileges:** Some scripts touch system services or `/etc` and need `sudo`.
