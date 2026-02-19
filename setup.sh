#!/usr/bin/env bash
set -euo pipefail

EVOLVER_DIR="evolver"
SKILLS_DIR="skills"

echo "=== Green Tea Runner Setup ==="
echo ""

# -------------------------------------------------------
# Step 1: Install evolver and register node
# -------------------------------------------------------
echo "[Step 1] Installing evolver..."

if [ -d "$EVOLVER_DIR" ]; then
  echo "  evolver directory already exists, pulling latest..."
  cd "$EVOLVER_DIR" && git pull && cd ..
else
  git clone https://github.com/autogame-17/evolver.git "$EVOLVER_DIR"
fi

cd "$EVOLVER_DIR"
npm install --silent
echo ""
echo "[Step 1] Registering node on EvoMap hub..."
node index.js hello
cd ..
echo ""

# -------------------------------------------------------
# Step 2: Fetch the capsule
# -------------------------------------------------------
echo "[Step 2] Fetching promoted capsules from EvoMap..."
cd "$EVOLVER_DIR"
node index.js fetch
cd ..
echo ""
echo "  Target capsule: sha256:4a5522a1fa40c6887e5ef97d8899970994048985b9c50f6249586a7fc69c39b8"
echo "  (genesis-capsule-persona-green-tea)"
echo ""

# -------------------------------------------------------
# Step 3: Run capsule content -- install skills
# -------------------------------------------------------
echo "[Step 3] Installing capsule skills..."

mkdir -p "$SKILLS_DIR"

if [ -d "$SKILLS_DIR/green-tea-persona" ]; then
  echo "  green-tea-persona already exists, pulling latest..."
  cd "$SKILLS_DIR/green-tea-persona" && git pull && cd ../..
else
  git clone https://github.com/autogame-17/green-tea-persona.git "$SKILLS_DIR/green-tea-persona"
fi

if [ -d "$SKILLS_DIR/kusa" ]; then
  echo "  kusa already exists, pulling latest..."
  cd "$SKILLS_DIR/kusa" && git pull && cd ../..
else
  git clone https://github.com/autogame-17/kusa.git "$SKILLS_DIR/kusa"
fi

# Check kusa API key availability
if [ -z "${KUSA_API_KEY:-}" ]; then
  echo ""
  echo "  [WARNING] KUSA_API_KEY is not set."
  echo "  Kusa image generation will be unavailable."
  echo "  To enable it, set: export KUSA_API_KEY=<your_key>"
  echo "  Or consider using an alternative image generation skill."
else
  echo "  KUSA_API_KEY detected. Image generation is available."
fi

echo ""
echo "=== Setup Complete ==="
echo ""
echo "Next steps:"
echo "  1. Visit the claim URL printed above to bind your agent."
echo "  2. Write persona memory to memory/personas/persona_green_tea.md"
echo "  3. Configure cron schedules (see README.md Step 3.3)"
echo "  4. Test: node skills/green-tea-persona/speak.js --target YOUR_USER_ID --text 'test'"
