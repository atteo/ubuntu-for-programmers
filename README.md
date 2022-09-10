# Ubuntu Setup for Programmers

Configures Kitty, Fish, ViM, Git, tmux and more in a way suitable for programmers.


Every developer is a distinct person with different habbits and so such a configuration must be very opinionated by its nature.
That said I think there are some common grounds on which typical programmer configuration can be built upon.

# Installation

* Make sure you run Ubuntu OS.
* Clone this repository.
* Run setup.sh script from the repository root directory to install entire configuration or run setup.sh script for specific tool instead.

# Features

## Programmers use console a lot

Make console more powerfull

* Use [Kitty](https://sw.kovidgoyal.net/kitty/) as a default terminal emulator
* Configure [Nerd fonts](https://www.nerdfonts.com/) for extra glyphs
* Use [Fish](https://fishshell.com/) as a default shell with [nice prompt](https://github.com/oh-my-fish/theme-bobthefish), [search engine](https://github.com/PatrickF1/fzf.fish) and some [productivity](https://github.com/franciscolourenco/done) [tools](https://github.com/oh-my-fish/plugin-thefuck)

and more beautiful:

* Use [dark color schemes](https://github.com/oh-my-fish/plugin-thefuck)
* Use [fonts](https://sourcefoundry.org/hack/) easy on your eyes and designed specifically for source code
* Replace basic shell commands with better equivalents like cat with [bat](https://github.com/sharkdp/bat), du with [duf]https://github.com/muesli/duf), ls with [exa](https://github.com/ogham/exa), top with [bottom](https://github.com/ClementTsang/bottom).


## Programmers use shortcuts

* Standardized shortcut keys between different applications
* Hide menus, assume programmers know shortcuts

## Ensure discoverability

Programmers are lazy, enable features in a way that minimizes effort to read manual.

## Automation

Make sure everything is easy and as much automated as possible. 
