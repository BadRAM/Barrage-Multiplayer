# Git based save game sharing script for succession games

# Change this when setting up a new succession game
SAVENAME="NAME-OF-SAVE-FILE"

if [ ! -f "./settings.cfg" ]; then
	echo "settings.cfg missing! generating..."
	printf '%s\n' "GAMEDIR=\"path/to/game/saves\"" "USERNAME=\"YOUR USERNAME HERE\"" > settings.cfg
	echo "settings.cfg generated. Please edit appropriately"
	exit 1
fi

source ./settings.cfg

git pull

# Check for lockfile
if [ -f "./locked.txt" ]; then
    cat ./locked.txt
    exit 1
fi

# create and push lockfile
echo "Savegame in use by ${USERNAME}" > ./locked.txt 
git add locked.txt
git commit -m "${USERNAME} Started session" && git push
 retVal=$?
if [ $retVal -ne 0 ]; then
	echo "Error detected while pushing lock commit."
    exit $retVal
fi

# move save into game
until mv "./${SAVENAME}" "${GAMEDIR}"
do 
    read -p "File move failed! press enter to retry." 
done

# inform user and wait for end of session
echo "Save locked and loaded! You may now load the game."
echo "When you've saved quit the game, write a short log of what you did and press enter."
read -p "> " LOG
read -p "Confirm game is closed and press enter to push to git and unlock for the next player"

# move save back
until mv "${GAMEDIR}/${SAVENAME}" "./"
do 
    read -p "File move failed! press enter to retry." 
done

# unlock
git rm ./locked.txt
# rm ./locked.txt

# commit changes
git add -A *
git commit -m "${USERNAME} Finished session - ${LOG}" && git push
retVal=$?
if [ $retVal -ne 0 ]; then
	echo "Error detected while pushing unlock commit. If you can't fix now, please inform the repo owner, or it will be stuck locked."
    exit $retVal
fi