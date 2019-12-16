# barns.dev macOS dotfiles

## Intro

### Hey folks, my name's Barns Anderson, a full stack engineer working with startups

These are my dotfiles that I sync between my work and personal accounts. Please feel free to clone and use them in your own setups.

## How to use this repo

1. Sign into your preferred Git-based service.
2. Clone or fork this repo, I would defo recommend forking so you can start your own customisations with dotfiles.

    ❗️ Everywhere in this repo I assume that you have cloned or forked to `$HOME/_src/z_dotfiles/`

3. If you fork do make your repo public to continue sharing, 😊
4. Symbolically link (symlink) the files in this repo back to where they need to be on the system, see below for these locations:

    1. `zshrc`, this should be to your $HOME directory:

        ```sh
        ln -fns $HOME/_src/z_dotfiles/dotfiles/zshrc $HOME/.zshrc
        ```

    2. `.config/brewfile/Brewfile`, this should be the same path in your $HOME directory:

        ```sh
        ln -fns $HOME/_src/z_dotfiles/dotfiles/.config/brewfile/Brewfile $HOME/.config/brewfile/Brewfile
        ```

    MORE TO FOLLOW!
