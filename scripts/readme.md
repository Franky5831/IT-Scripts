# IT Scripts - `scripts/`

Handy, portable **POSIX `sh`** utilities for day-to-day IT tasks.  
No external dependencies beyond a standard Unix-like environment.

> **TL;DR**
>
> - See usage/help: `<script> -h` or `<script> --help`  
> - Many tasks require root: prefix with `sudo`

---

## What’s here

## Scripts catalog
<table>
	<tbody>
		<tr>
			<td>Title</td>
			<td>Read More</td>
			<td>Short description</td>
		</tr>
		<tr>
			<td valign="top"><strong>apache&#8209;instantiate</strong></td>
			<td valign="top"><a href="./scripts/apache-instantiate/">/scripts/&#8288;apache&#8209;instantiate</a></td>
			<td valign="top">Quickly creates and enables an Apache vhost on the next free port, scaffolds a docroot and index page, and reloads Apache.</td>
		</tr>
		<tr>
			<td valign="top"><strong>MacOS&#8209;SMB&#8209;AutoMount</strong></td>
			<td valign="top"><a href="./scripts/mac-smb-automount/">/scripts/&#8288;mac&#8209;smb&#8209;automount</a></td>
			<td valign="top">Automatically mounts your SMB drives on your Mac.</td>
		</tr>
	</tbody>
</table>

> Tip: If a script name isn’t obvious, run it with `-h`/`--help` to see flags and examples.

---

## Prerequisites

- **Shell:** POSIX `sh` (works with `/bin/sh`; Bash/Zsh are fine too)
- **OS:** Any modern Linux/Unix.
- **Privileges:** Some scripts touch system services or `/etc` and need `sudo`.
