# Usage

asciinema cli is composed of multiple (sub)commands, similar to `git`,
`rails` or `brew`.

If you run `asciinema` with no arguments, help will be displayed showing all
available commands.

In addition to this, you can run any asciinema command with the `-h` switch
to display help about that specific command. For example, try running
`asciinema rec -h`. This will display a list of all of the options `rec`
command accepts, with their defaults.

## `rec`

__Record terminal session and upload it to asciinema.org site.__

This is the single most important command in asciinema, since it is how you
utilize this tool's main job.

By running `asciinema rec` you start a new recording session. The command
(process) that is recorded can be specified with `-c` option (see below), and
defaults to `$SHELL` which is what you want in most cases.

Recording finishes when you exit the shell (hit <kbd>Ctrl+D</kbd> or type
`exit`). If the recorded process is not a shell than recording finishes when
the process exits.

`ASCIINEMA_REC=1` is added to recorded process environment variables. This
can be used by your shell's config file (`.bashrc`, `.zshrc`) to alter the
prompt or play a sound when shell is being recorded.

Available options:

* `-c` - command to record (if none given a new shell instance is recorded)
* `--max-wait` - reduce recorded terminal inactivity to maximum of <max-wait> seconds (0 turns off)
* `-t` - set asciicast title (can be also set later, on the site)
* `-y` - upload immediately after shell exits, without asking for confirmation

## `auth`

__Assign local API token to asciinema.org account.__

Every machine you install asciinema recorder on you get a new unique API
token. This command is used to connect this local API token with your
asciinema.org account.

This command displays the URL you should open in your web browser. If you
never logged in to asciinema.org then your account will be automatically
created when opening the URL.

NOTE: it is __necessary__ to do this if you want to __edit or delete__ your
recordings on asciinema.org.

You can synchronize your `~/.asciinema/config` file (which keeps the API
token) across the machines but that's not necessary. You can assign new
tokens to your account from as many machines as you want.