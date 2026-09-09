// Adds ==highlighted text== syntax to VS Code's built-in Markdown preview.
// Renders as <span style="background-color:#F4D03F;color:black;">highlighted text</span>.

function highlightRule(state, silent) {
  const marker = 0x3d; // '='
  const start = state.pos;

  if (state.src.charCodeAt(start) !== marker || state.src.charCodeAt(start + 1) !== marker) {
    return false;
  }

  const max = state.posMax;
  let pos = start + 2;
  let found = false;

  while (pos < max - 1) {
    if (state.src.charCodeAt(pos) === marker && state.src.charCodeAt(pos + 1) === marker) {
      found = true;
      break;
    }
    pos++;
  }

  if (!found || pos === start + 2) {
    return false;
  }

  if (!silent) {
    const content = state.src.slice(start + 2, pos);
    const openToken = state.push('highlight_open', 'span', 1);
    openToken.attrSet('style', 'background-color:#F4D03F;color:black;');

    const textToken = state.push('text', '', 0);
    textToken.content = content;

    state.push('highlight_close', 'span', -1);
  }

  state.pos = pos + 2;
  return true;
}

function highlightPlugin(md) {
  md.inline.ruler.before('emphasis', 'highlight', highlightRule);
}

module.exports = {
  activate() {
    return {
      extendMarkdownIt(md) {
        return md.use(highlightPlugin);
      },
    };
  },
};
