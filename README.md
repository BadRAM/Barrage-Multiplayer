# Barrage-Multiplayer

## What is this?
This was made to provide stable, bug free multiplayer in Kerbal Space Program, though it works for other games too. Just about any game that stores it's save data as files on your computer should work.

## How does it work?
Barrage is a script that automates save synchronization through a git repo. When you start the script, it downloads the latest state of the saved game and then locks the git repository in your name, so that nobody else can play. Once you're done, it uploads the changes you made and unlocks the repository.

## Client Setup Instructions:
1. Make sure you have git installed, and logged in to the appropriate repo host
2. Clone this repository into a memorable place on your computer. Documents is appropriate. (Do not clone [the original Barrage-Multiplayer](https://github.com/BadRAM/Barrage-Multiplayer) repo, clone your game host's repo)
3. Navigate to the cloned directory in terminal. (use [git bash](https://git-scm.com/downloads) on windows) Run `bash start.bash`, it should exit early and tell you to edit settings.config
4. In settings.cfg, enter your desired username and full path to *save* folder. Example: `GAMEDIR="C:\Users\Name\Games\Kerbal-Space-Program\saves"`
5. Run `bash start.bash` again. If everything's worked it should say "Save locked and loaded! You may now load the game."

## Host Setup Instructions:
1. Fork this repository, [the original Barrage-Multiplayer](https://github.com/BadRAM/Barrage-Multiplayer) repo
2. Move the save file you want to sync into the repo directory. Make a new save file if necessary.
3. Open start.bash and change `SAVENAME="NAME-OF-SAVE-FILE"` to reflect the name of the file you copied
4. In README.md, change client setup instruction 2 to remove the disclaimer. update instruction 4's example to reflect the save file directory of the game you're targeting
5. Follow client setup instructions 3-5
