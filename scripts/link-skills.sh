#!/usr/bin/env bash
set -euo pipefail

# Symlink every non-deprecated skill folder into a flat directory the user can
# browse or import into a .kiro/steering/ workspace. Pass the destination as
# the first argument; defaults to $HOME/.local/share/skills-engineers/.

REPO="$(cd "$(dirname "$0")/.." && pwd)"
DEST="${1:-$HOME/.local/share/skills-engineers}"

# If $DEST is a symlink that resolves into this repo, we'd end up writing the
# per-skill symlinks back into the repo's own skills/ tree. Detect and bail
# out instead of polluting the working copy.
if [ -L "$DEST" ]; then
  resolved="$(readlink -f "$DEST")"
  case "$resolved" in
    "$REPO"|"$REPO"/*)
      echo "error: $DEST is a symlink into this repo ($resolved)." >&2
      echo "Remove it (rm \"$DEST\") and re-run; the script will recreate it as a real dir." >&2
      exit 1
      ;;
  esac
fi

mkdir -p "$DEST"

find "$REPO/skills" -name SKILL.md -not -path '*/node_modules/*' -not -path '*/deprecated/*' -print0 |
while IFS= read -r -d '' skill_md; do
  src="$(dirname "$skill_md")"
  name="$(basename "$src")"
  target="$DEST/$name"

  if [ -e "$target" ] && [ ! -L "$target" ]; then
    rm -rf "$target"
  fi

  ln -sfn "$src" "$target"
  echo "linked $name -> $src"
done

echo
echo "Done. Each linked folder under $DEST contains a SKILL.md."
echo "To consume one in a Kiro workspace, copy or symlink its SKILL.md into"
echo "<workspace>/.kiro/steering/ (consider 'inclusion: manual' so it is invoked by name,"
echo "then reference it from chat as #<skill-slug>)."
