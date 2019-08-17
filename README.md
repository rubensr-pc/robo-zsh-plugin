# robo-zsh-plugin

`robo-zsh-plugin` is a zsh plugin for
[Robo](http://robo.li), based on https://github.com/shengyou/robo-zsh-plugin. It has been largely rewritten to perform more completions and to not require robo installation using a get_robo command - as long as you have `robo` in your PATH,
this should be fine.

## Installation

### oh-my-zsh

1. In the command line, change to `oh-my-zsh` plugins directory:

    ```console
    $ take ~/.oh-my-zsh/custom/plugins
    ```

2. Clone the repository into a new directory called `robo`:

    ```console
    git clone https://github.com/rubensr-pc/robo-zsh-plugin.git robo
    ```

3. Include `robo` plugin to your .zshrc file along with other plugins:

    ```zsh
    ...
    plugins=(osx brew git laravel codeception robo)
    ...
    ```

4. Restart your terminal application.

### [zgen](https://github.com/tarjoilija/zgen)

If you're using [zgen](https://github.com/tarjoilija/zgen):

1. Add `zgen load shengyou/robo-zsh-plugin` to your `.zshrc` along with your other `zgen load` commands.
2. `rm ${ZGEN_INIT}/init.zsh && zgen save`

### [Antigen](https://github.com/zsh-users/antigen)

If you're using [Antigen](https://github.com/zsh-users/antigen):

1. Add `antigen bundle rubensr-pc/robo-zsh-plugin` to your `.zshrc` where you've listed your other plugins.
2. Close and reopen your Terminal/iTerm window to **refresh context** and use the plugin. Alternatively, you can run `antigen bundle shengyou/robo-zsh-plugin` in a running shell to have antigen load the new plugin immediately & temporarily.

### [zplug](https://github.com/zplug/zplug)

zplug "rubensr-pc/robo-zsh-plugin"

## TODO

* Include command descriptions in completion
* Include command parameters in completion

