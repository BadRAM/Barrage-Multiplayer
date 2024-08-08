# This script generates a non locking copy of the save in your game folder. Useful for planning missions, or checking world progress without participating.

# Change this when setting up a new succession game
SAVENAME="The-Original-Succ"

if [ ! -f "./settings.cfg" ]; then
	echo "settings.cfg missing! generating..."
	printf '%s\n' "GAMEDIR=\"path/to/game/saves\"" "USERNAME=\"YOUR USERNAME HERE\"" > settings.cfg
	echo "settings.cfg generated. Please edit appropriately"
	exit 1
fi

source ./settings.cfg

git pull

# =========
# MAIN BODY
# =========

# Create USERNAME.sci if it doesn't exist yet
if [ ! -f "./${USERNAME}.sci" ]; then
    cat sci.default > "${USERNAME}.sci"
    echo "${USERNAME}.sci not detected. Generating..."
fi

# copy save into game
BAKNUM=1
until [ ! -f "${GAMEDIR}/${SAVENAME}-Simulator-${BAKNUM}/persistent.sfs" ]; do 
    let "BAKNUM++"
done
cp -Rr "./${SAVENAME}" "${GAMEDIR}/${SAVENAME}-Simulator-${BAKNUM}"

# Undo changes we made to persistent.sfs so pull goes cleanly next time.
git reset --hard 

echo ""
echo "Simulator Save Created!"