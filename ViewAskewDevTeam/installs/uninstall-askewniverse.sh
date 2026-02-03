#!/bin/bash

# ============================================================================
# ASKEWNIVERSE DEVELOPMENT TEAM UNINSTALLER
# Removes the Askewniverse team from Claude Code
# ============================================================================

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
PURPLE='\033[0;35m'
NC='\033[0m' # No Color

# Emoji
THUMBSUP="👍"
CHECK="✅"
WAVE="👋"

# ============================================================================
# Parse arguments
# ============================================================================

GLOBAL_INSTALL=false
FORCE=false

show_help() {
    echo ""
    echo "Usage: uninstall-askewniverse.sh [OPTIONS]"
    echo ""
    echo "Uninstall the Askewniverse Development Team from Claude Code."
    echo ""
    echo "Options:"
    echo "  -g, --global    Uninstall from ~/.claude/ (global installation)"
    echo "  -f, --force     Skip confirmation prompt"
    echo "  -h, --help      Show this help message"
    echo ""
    echo "By default, uninstalls from ./.claude/ in the current directory (local project)."
    echo ""
    echo "Examples:"
    echo "  ./uninstall-askewniverse.sh          # Uninstall from current project"
    echo "  ./uninstall-askewniverse.sh -g       # Uninstall from global"
    echo "  ./uninstall-askewniverse.sh -g -f    # Uninstall global, no confirmation"
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

PERSONAS_DIR="$CLAUDE_DIR/askewniverse"
AGENTS_DIR="$CLAUDE_DIR/agents"
COMMANDS_DIR="$CLAUDE_DIR/commands"

# ============================================================================
# Confirmation prompt
# ============================================================================

echo ""
echo -e "${PURPLE}==============================================${NC}"
echo -e "${PURPLE}  ASKEWNIVERSE DEVELOPMENT TEAM UNINSTALLER  ${NC}"
echo -e "${PURPLE}==============================================${NC}"
echo ""
echo -e "${CYAN}Uninstall type:${NC} ${YELLOW}${INSTALL_TYPE}${NC}"
echo -e "${CYAN}Location:${NC} ${YELLOW}${INSTALL_LOCATION}${NC}"
echo ""

if [ "$FORCE" = false ]; then
    echo -e "${YELLOW}This will remove the Askewniverse Development Team.${NC}"
    echo -e "${YELLOW}The following will be deleted:${NC}"
    echo -e "  - ${PERSONAS_DIR}/ (personas)"
    echo -e "  - Askewniverse agent files from ${AGENTS_DIR}/"
    echo -e "  - Askewniverse command files from ${COMMANDS_DIR}/"
    echo ""
    read -p "Are you sure you want to continue? (y/N) " -n 1 -r
    echo ""
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo -e "${CYAN}Uninstall cancelled.${NC}"
        exit 0
    fi
    echo ""
fi

# ============================================================================
# Remove files
# ============================================================================

echo -e "${CYAN}Removing Askewniverse files...${NC}"

# Remove personas directory
if [ -d "$PERSONAS_DIR" ]; then
    rm -rf "$PERSONAS_DIR"
    echo -e "  ${CHECK} Removed ${PERSONAS_DIR}/"
else
    echo -e "  ${YELLOW}Personas directory not found (already removed?)${NC}"
fi

# Remove agent files (only Askewniverse-specific ones)
ASKEW_AGENTS=(
    "buddy-christ.md"
    "bethany.md"
    "dante.md"
    "randal.md"
    "jay.md"
    "silent-bob.md"
    "brodie.md"
    "ts.md"
    "alyssa.md"
    "holden.md"
    "metatron.md"
    "rufus.md"
)

for agent in "${ASKEW_AGENTS[@]}"; do
    if [ -f "$AGENTS_DIR/$agent" ]; then
        rm -f "$AGENTS_DIR/$agent"
        echo -e "  ${CHECK} Removed agents/$agent"
    fi
done

# Remove command files (only Askewniverse-specific ones)
ASKEW_COMMANDS=(
    "askew.md"
    "bethany.md"
    "dante.md"
    "randal.md"
    "jay.md"
    "silent-bob.md"
    "brodie.md"
    "ts.md"
    "alyssa.md"
    "holden.md"
    "metatron.md"
    "rufus.md"
)

for cmd in "${ASKEW_COMMANDS[@]}"; do
    if [ -f "$COMMANDS_DIR/$cmd" ]; then
        rm -f "$COMMANDS_DIR/$cmd"
        echo -e "  ${CHECK} Removed commands/$cmd"
    fi
done

# ============================================================================
# Complete
# ============================================================================

echo ""
echo -e "${PURPLE}==============================================${NC}"
echo -e "${GREEN}${THUMBSUP} ASKEWNIVERSE TEAM UNINSTALLED ${THUMBSUP}${NC}"
echo -e "${PURPLE}==============================================${NC}"
echo ""
echo -e "${CYAN}The Askewniverse Development Team has been removed.${NC}"
echo -e "${CYAN}To reinstall:${NC}"
if [ "$GLOBAL_INSTALL" = true ]; then
    echo -e "  ${YELLOW}./install-askewniverse.sh -g${NC}"
else
    echo -e "  ${YELLOW}./install-askewniverse.sh${NC}"
fi
echo ""
echo -e "${PURPLE}\"I'm not even supposed to be here today.\" ${WAVE}${NC}"
echo ""
