# IT Scripts

A tiny, portable collection of **POSIX sh** scripts for everyday tasks.  
No dependencies beyond a standard Unix-like environment.

---

## Quick start

### Run locally
```bash
git clone https://github.com/Franky5831/IT-Scripts.git
cd IT-Scripts
```

---

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

> More scripts are on the way - feel free to propose one via an issue or PR.

---

## Philosophy
- **Portable first**: prefer POSIX sh; keep dependencies standard.
- **Readable**: clear naming, comments for non-obvious logic.
- **Safe by default**: fail fast; ask before destructive actions.

---

## How to test (Docker)
This repo includes a Dockerfile so you can try scripts in a clean, disposable container - great for testing without changing your host.
```bash
# Build the container
docker build -t script-tester .

# Run the container
docker run -it --rm script-tester
# If a script exposes a port (e.g., Apache), publish it
docker run -it --rm -p 8080:8080 script-tester
```

---

If this repo saved you time, a ⭐ helps others find it - and encourages contributors to jump in!
