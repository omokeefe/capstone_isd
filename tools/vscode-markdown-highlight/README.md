# Markdown `==Highlight==`

A minimal VS Code extension that adds `==highlighted text==` syntax to the
built-in Markdown preview (`Ctrl+Shift+V` / the side-by-side preview). No
external dependencies — a single `markdown-it` inline rule.

`==like this==` renders as:

```html
<span style="background-color:#F4D03F;color:black;">like this</span>
```

## Install (one-time, per machine)

VS Code doesn't auto-load extensions from a workspace folder, so this has to
be installed into your user extensions once:

1. Open the Command Palette (`Ctrl+Shift+P`).
2. Run **Developer: Install Extension from Location...**
3. Select this folder: `tools/vscode-markdown-highlight` (the one containing
   `package.json`).
4. Reload the window when prompted.

That's it — open any `.md` file's preview and `==text==` will render
highlighted. Only affects the preview, not the raw editor text.

## Uninstall

Command Palette → **Extensions: Show Installed Extensions** → find
"Markdown ==Highlight==" → Uninstall.

## Customizing the color

Edit the `attrSet('style', ...)` line in `extension.js`, then reload the
window (no reinstall needed if you keep editing the same installed-from-location
copy — VS Code watches it for changes in dev mode, but to be safe just re-run
the install step above after edits).
