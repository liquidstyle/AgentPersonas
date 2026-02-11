#!/bin/bash

# ============================================================================
#  ██████╗ ██████╗ ██╗███╗   ██╗██████╗      ██████╗██████╗ ███████╗██╗    ██╗
# ██╔════╝ ██╔══██╗██║████╗  ██║██╔══██╗    ██╔════╝██╔══██╗██╔════╝██║    ██║
# ██║  ███╗██████╔╝██║██╔██╗ ██║██║  ██║    ██║     ██████╔╝█████╗  ██║ █╗ ██║
# ██║   ██║██╔══██╗██║██║╚██╗██║██║  ██║    ██║     ██╔══██╗██╔══╝  ██║███╗██║
# ╚██████╔╝██║  ██║██║██║ ╚████║██████╔╝    ╚██████╗██║  ██║███████╗╚███╔███╔╝
#  ╚═════╝ ╚═╝  ╚═╝╚═╝╚═╝  ╚═══╝╚═════╝      ╚═════╝╚═╝  ╚═╝╚══════╝ ╚══╝╚══╝
#
# The Grind Crew - UNINSTALLER
# "Thanks for shredding with us." 🤘🛹
# ============================================================================

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Emoji helpers
GUITAR="🎸"
SKATEBOARD="🛹"
BEER="🍺"
ROCK="🤘"
CHECK="✅"
WAVE="👋"
TRASH="🗑️"

# ============================================================================
# Parse arguments
# ============================================================================

GLOBAL_INSTALL=false
FORCE=false

show_help() {
    echo ""
    echo "Usage: grindcrew-uninstall.sh [OPTIONS]"
    echo ""
    echo "Uninstall the Grind Crew development team from Claude Code."
    echo ""
    echo "Options:"
    echo "  -g, --global    Uninstall from ~/.claude/ (global installation)"
    echo "  -f, --force     Skip confirmation prompt"
    echo "  -h, --help      Show this help message"
    echo ""
    echo "By default, uninstalls from ./.claude/ in the current directory (local project)."
    echo ""
    echo "Examples:"
    echo "  ./grindcrew-uninstall.sh          # Uninstall from current project"
    echo "  ./grindcrew-uninstall.sh -g       # Uninstall globally"
    echo "  ./grindcrew-uninstall.sh -g -f    # Uninstall globally without confirmation"
    echo ""
}

while [[ $# -gt 0 ]]; do
    case $1 in
        -g|--global)
            GLOBAL_INSTALL=true
            shift
            ;;
        -f|--force)
            FORCE=true
            shift
            ;;
        -h|--help)
            show_help
            exit 0
            ;;
        *)
            echo -e "${RED}Unknown option: $1${NC}"
            show_help
            exit 1
            ;;
    esac
done

# ============================================================================
# Set target directories based on install type
# ============================================================================

if [ "$GLOBAL_INSTALL" = true ]; then
    CLAUDE_DIR="$HOME/.claude"
    INSTALL_TYPE="GLOBAL"
    INSTALL_LOCATION="~/.claude"
else
    CLAUDE_DIR="./.claude"
    INSTALL_TYPE="LOCAL"
    INSTALL_LOCATION="./.claude (current directory)"
fi

PERSONAS_DIR="$CLAUDE_DIR/grindcrew"
AGENTS_DIR="$CLAUDE_DIR/agents"
COMMANDS_DIR="$CLAUDE_DIR/commands"

# ============================================================================
# Check if installed
# ============================================================================

echo ""
echo -e "${PURPLE}============================================${NC}"
echo -e "${PURPLE}     THE GRIND CREW - UNINSTALLER         ${NC}"
echo -e "${PURPLE}============================================${NC}"
echo ""
echo -e "${CYAN}Uninstall type:${NC} ${YELLOW}${INSTALL_TYPE}${NC}"
echo -e "${CYAN}Location:${NC} ${YELLOW}${INSTALL_LOCATION}${NC}"
echo ""

# Check if the grindcrew directory exists
if [ ! -d "$PERSONAS_DIR" ]; then
    echo -e "${YELLOW}The Grind Crew doesn't appear to be installed at ${INSTALL_LOCATION}${NC}"
    echo -e "${CYAN}Nothing to uninstall.${NC}"
    echo ""
    exit 0
fi

# ============================================================================
# Confirmation
# ============================================================================

if [ "$FORCE" = false ]; then
    echo -e "${YELLOW}This will remove the following:${NC}"
    echo ""
    echo -e "  ${TRASH} Personas:  ${CYAN}${PERSONAS_DIR}/${NC}"
    echo -e "  ${TRASH} Agents:    ${CYAN}duke.md, riff.md, verse.md, crash.md, ink.md${NC}"
    echo -e "  ${TRASH} Commands:  ${CYAN}grind.md${NC}"
    echo ""
    read -p "Are you sure you want to uninstall? (y/N) " -n 1 -r
    echo ""

    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo ""
        echo -e "${CYAN}Uninstall cancelled. The crew lives to shred another day! ${ROCK}${NC}"
        echo ""
        exit 0
    fi
fi

echo ""
echo -e "${YELLOW}Removing Grind Crew...${NC}"

# ============================================================================
# Remove personas directory
# ============================================================================

echo -e "  ${TRASH} Removing personas..."
if [ -d "$PERSONAS_DIR" ]; then
    rm -rf "$PERSONAS_DIR"
    echo -e "     ${GREEN}${CHECK} Removed ${PERSONAS_DIR}${NC}"
else
    echo -e "     ${CYAN}(not found, skipping)${NC}"
fi

# ============================================================================
# Remove agent files (only grindcrew agents)
# ============================================================================

echo -e "  ${TRASH} Removing agents..."

AGENTS=("duke.md" "riff.md" "verse.md" "crash.md" "ink.md")
for agent in "${AGENTS[@]}"; do
    if [ -f "$AGENTS_DIR/$agent" ]; then
        rm -f "$AGENTS_DIR/$agent"
        echo -e "     ${GREEN}${CHECK} Removed $agent${NC}"
    else
        echo -e "     ${CYAN}$agent (not found, skipping)${NC}"
    fi
done

# ============================================================================
# Remove command files (only grindcrew commands)
# ============================================================================

echo -e "  ${TRASH} Removing commands..."

COMMANDS=("grind.md")
for cmd in "${COMMANDS[@]}"; do
    if [ -f "$COMMANDS_DIR/$cmd" ]; then
        rm -f "$COMMANDS_DIR/$cmd"
        echo -e "     ${GREEN}${CHECK} Removed $cmd${NC}"
    else
        echo -e "     ${CYAN}$cmd (not found, skipping)${NC}"
    fi
done

# ============================================================================
# Completion
# ============================================================================

echo ""
echo -e "${PURPLE}============================================${NC}"
echo -e "${GREEN}${WAVE} UNINSTALL COMPLETE ${WAVE}${NC}"
echo -e "${PURPLE}============================================${NC}"
echo ""
echo -e "${CYAN}The Grind Crew has been removed from ${INSTALL_LOCATION}${NC}"
echo ""
echo -e "${CYAN}To reinstall:${NC}"
if [ "$GLOBAL_INSTALL" = true ]; then
    echo -e "  ${YELLOW}./grindcrew-install.sh -g${NC}"
else
    echo -e "  ${YELLOW}./grindcrew-install.sh${NC}"
fi
echo ""
echo -e "${PURPLE}Thanks for shredding with us! ${ROCK}${SKATEBOARD}${BEER}${NC}"
echo ""
