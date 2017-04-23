# LuaSweeper
## The game
This is a Minesweeper game with a constant board with three difficulties. The difficulty can be chosen at the start of the game. It features quirky graphics, amazing sound effects, and local high scores per difficulty. Every part was made by me, including the graphics and sound effects. Enjoy!

## Running the game
There is a standalone web version built with [love.js](https://github.com/TannerRogalsky/love.js), which can be found at [minesweeper.kalis.me](http://minesweeper.kalis.me).

Alternatively, it can be built locally into a standalone application through the [love2d build instructions](https://www.love2d.org/wiki/Game_Distribution), or run locally through the [love2d getting started instructions](https://www.love2d.org/wiki/Getting_Started).

## Screenshots
<img src="https://i.imgur.com/s9CPIz1.png" width="24.5%"/> <img src="https://i.imgur.com/mI79q8C.png" width="24.5%"/> <img src="https://i.imgur.com/l2Je4rY.png" width="24.5%"/> <img src="https://i.imgur.com/e5yEC6Q.png" width="24.5%"/>

## The history
This Minesweeper game was originally made in a week for a first year University assignment.
It uses Lua and the Löve2d framework.

As you can imagine, the initial code was all over the place. Having said that, all the functionality that you would expect from a Minesweeper game was there (including persistent local highscores).

However, I wanted to see if I could make the code more modular (it just had a Cell and a Button class, and the code really needed to be pulled apart), more maintanable (800 lines of code for all kinds of things in a single file isn't fun), and using more well-known patterns and techniques, like Unit Testing and Gamestates (although I have to give myself credit for the initial gamestate implementation, which consisted of a string for the state, and lots of if statements in the code).

## How I refactored the code
All functionality that is in the game today was there when I handed in my assignment back in 2014. However, since then, the underlying codebase has changed a lot.

### File structure
As it turns out, having all your files in a the same top-level folder gets unmanagable, with just a ```main.lua``` and a ```conf.lua``` to worry about, the necessity doesn't really arise, but even then, all the asset files get difficult to handle.

So first off the assets had to be moved to their own folder, which cleaned up pretty well, but as the refactoring went on, more and more code files emerged, which led to the file structure as it is today:

* assets/
  * audio/
  * graphics/
* lib/
* spec/
* src/
  * ui/
* states/
* main.lua
* conf.lua

### Class Model
Like I said, when I started, there were two classes: the Button and the Cell. These were the only ones that were mandatory for the assignment, and since I was pretty crunched on time, these were the only ones I implemented. In the refactoring I decided to take on a new Class Model with the initial code pulled apart, and more abstractions in the classes. In this way most of the functionality lies under abstractions in the classes, so that the gamestates can have more of a controlling role.

Within the model I opted for a Game Singleton, which contains all GameObjects and game variables. This singleton is then passed around through the gamestates. While not ideal, this is an improvement over the global variables from the initial code.

![Class Diagram](http://yuml.me/3195ff75.svg)

Most of the game functionality lies within the Board class, as well as some in the Cell. The UI class contains labels and buttons to interact with.

### Gamestates
For implementing Gamestates I used the existing [hump.gamestate](http://hump.readthedocs.io/en/latest/gamestate.html) library. In the old gamestate implementation, it was easy to use the same code for multiple game states, since it was just a matter of changing the if-statement around the code-block. This wasn't in the slightest bit a readable codebase, so with the new Gamestates it is clear to see what each gamestate does and is responsible for. Some parts of the code are executed by multiple gamestates alike, which makes for some duplicate code. Luckily, the new Class Model shifts a lot of the responsibilities to the core game classes (mainly the Board class), so that this new implementation offers a lot of maintainability and readability while not sacrificing much on DRYness of the code.

![State Machine](http://i.imgur.com/A3DrWVy.png)

### Unit Tests
For Unit Testing I usd the [busted](http://olivinelabs.com/busted/) library. I only started testing after writing all the code for the initial assigment, as well as after the refactoring (woops, that's not TDD). Manual testing took a lot of time, and in hindsight, Unit Testing should have startd sooner, or at least some form of assisted manual testing could have saved a lot of time. At least I did get quite proficient at playing at playing Minesweeper along the way!

### What's next
The main goals for the future are full test coverage for the project. Besides that the UI should be refactored to be somewhat more dynamic and less hard-coded. Both for the regular UI, but also very much so for the Highscores class, as this is just a big mess. Besides that, I might revisit this some time in the future to see if further improvements could be made. For now, though, I am content.
