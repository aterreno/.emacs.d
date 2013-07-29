## Emacs installation

To get started with emacs

- `brew update`
- `brew install emacs --cocoa`
- `ln -s /usr/local/Cellar/emacs/24.2/Emacs.app /Applications/`

You can't run emacs from the terminal. Go to the applications folder and run it from there, put it in your dock.

## Setup

Emacs config lives in ~/.emacs.d. This emacs config has a few bells and whistles.

- `cd ~`
- `git clone git@github.com:MailOnline/.emacs.d.git`

As of `6d6c6f2b1630ae1af636ca06bec5410a1b5805ec`, we no longer use git submodules. If you're using a revision prior to this, you need to:

- `cd .emacs.d`
- `git submodule init`
- `git submodule update`

Enjoy.

## Alternatives

If you don't like this emacs, checkout `https://github.com/technomancy/emacs-starter-kit` or `https://github.com/overtone/emacs-live` or roll your own from scratch borrowing as you go!
