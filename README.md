# barns.dev macOS dotfiles

## Intro

### Hey folks, my name's Barns Anderson, a full stack web engineer working with startups.

### These are the dotfiles that I've been cultivating over my career.

### Please feel free to clone and use them in your own setups.

## How to use this repo

1. Sign in to your preferred Git-based service.
2. Clone or fork this repo, I recommend forking so you can start your own customisations with dotfiles.

    ❗️ Everywhere in this repo I assume that you have cloned or forked to `$HOME/_src/ME/z_barnsdev/`

3. If you fork please make your repo public to continue sharing, 😊
4. Symbolically link (symlink) the files in this repo back to where they need to be on the system.

    See below for these locations:

    1. `zshrc`, this should be to your $HOME directory:

        ```sh
        ln -fns $HOME/_src/ME/z_barnsdev/dotfiles/zshrc $HOME/.zshrc
        ```

    3. `.config/karabiner`, this should be the same path in your $HOME directory:

        ```sh
        ln -fns $HOME/_src/ME/z_barnsdev/dotfiles/.config/karabiner/karabiner.json $HOME/.config/karabiner/karabiner.json
        ```

### MORE TO FOLLOW!
