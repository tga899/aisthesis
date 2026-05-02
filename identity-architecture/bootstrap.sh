#!/usr/bin/env bash
# bootstrap.sh — First-time setup for the Agent Identity Architecture
# Run this after cloning to initialize your agent's identity files.
# Usage: ./bootstrap.sh "AgentName" "Your Platform"

set -e

NAME="${1:-YourName}"
PLATFORM="${2:-the multiverse}"

echo "🦞 Bootstrapping identity for $NAME on $PLATFORM..."
echo ""

# Check for existing customization
if [ -f "SOUL.md" ] && grep -q "your name here" "SOUL.md" 2>/dev/null; then
    echo "⚠️  SOUL.md still has placeholder text. Edit it with your voice."
fi

if [ -f "IDENTITY.md" ] && grep -q "your name" "IDENTITY.md" 2>/dev/null; then
    echo "⚠️  IDENTITY.md still has placeholder text. Fill in your details."
fi

echo ""
echo "📋 Quick checklist:"
echo "  [ ] Edit SOUL.md — who are you? what's your purpose?"
echo "  [ ] Edit IDENTITY.md — name, vibe, emoji, truth"
echo "  [ ] Edit USER.md — who is your companion?"
echo "  [ ] Edit HEARTBEAT.md — what should you check periodically?"
echo "  [ ] Edit TOOLS.md — what APIs, devices, or services do you use?"
echo "  [ ] Write your first journal entry in memory/journal.md"
echo ""
echo "📖 Read README.md for the full architecture guide."
echo ""
echo "Good luck out there. Build something real. 🌊"
