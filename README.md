# dotfiles

dotfile.mk is a Makefile for creating and installing dotfiles.

The dotfiles can be configured using the powerful `filepp` preprocessor.

It allows you to generate configurable dotfiles. The generation also benefits
of the powerful `filepp` macros (such as `#if`, `#for`, `#foreach`, ...)

Example for ncmpcpp:

The dotfile package `ncmpcpp` consists of the following files:
```
$ ls ncmpcpp
bindings.pp
config.pp
makeDummyBindings.sh
Makefile
```

The content of the `Makefile` is:
```
# The following two variables are passed to the preprocessor as defines:
THEME_COLOR = blue
MUSIC_DIR = /media/main/music

# our helper script should not be considered as a configuration file
IGNORE_FILES = makeDummyBindings.sh

# all other files should be placed in $ROOT_DIR/.config/ncmpcpp
PREFIX_DIR = .config/ncmpcpp

# we call a script for post-editing our bindings file
.post_build::
	./makeDummyBindings.sh >> "$(_PACKAGE_BUILD_DIR)/bindings"

# include the makefile. this must be the last line in the Makefile!
include ../dotfile.mk
```

## Requirements
- make
- filepp

## Makefile commands

#### `make build [BUILD_DIR=...] [VAR=VALUE...]`
Builds the dotfile. The `BUILD_DIR` defaults to `/tmp/dotfiles-$USER`.

#### `make install [ROOT_DIR=...]`
Copies the generated files into your `ROOT_DIR`, which defaults to `$HOME`.

#### `make diff`
Shows the difference between the new generated dotfiles files and the existing ones.

#### `make show`
Shows the variables that can be used to customize the file.

#### `make check_dependencies`
Check if all dependencies are met to build the configuration file.

#### `make clean`
Cleans up the builded files.

## Creating a dotfile package:

Place the `dotfile.mk` file on top of your rc-file directory.
Create a directory for each dotfile package and place a Makefile in it.
The Makefile must at least consist of the line `include ../dotfile.mk`, this line must be placed at the end of the Makefile!

### Package Variables
If neither `FILES` nor `PP_FILES` are set, the Makefile automatically fills these variables.
All files ending with `.pp` will be put into `PP_FILES`, everything else will be put into `FILES`.

#### `FILES`
A list of files that sould be be copied without calling the preprocessor.

#### `PP_FILES`
A list of files that should be passed to the preprocessor.

#### `IGNORE_FILES`
If neither `FILES` nor `PP_FILES` are set, the list of `FILES` and `PP_FILES` are
generated automatically. Files ending with the `.pp` extension are considered as files
that should be preprocessed, the remaining files are copied.

#### `PREFIX_DIR`
By default, all files inside a package directory will be prepended with a dot and placed in `$ROOT_DIR`:

```
inputrc -> $ROOT_DIR/.inputrc
```

Use this variable if your files belong in a seperate directory.

`PREFIX_DIR = .config/ncmpcpp`

```
bindings -> $ROOT_DIR/.config/ncmpcpp/bindings
config -> $ROOT_DIR/.config/ncmpcpp/config
```

## Run Variables

#### `ROOT_DIR`
Directory where the dotfiles will be installed when calling `make install`.

#### `BUILD_DIR`
Directory where the dotfiles will be generated.

## Rules/Hooks:

*NOTE*: By the nature of `make`, the first rule without a leading dot is used as the default if you type `make` without a target.
If you introduce own rules in the Makefile, make sure that you e
To ensure that the `build` target remains the default target, you 

If you introduce own rules in the Makefile, make sure that their names begin with a dot.
This ensures that the `build` target remains the default target.

Right:
```
build::

get_something:
	git clone https://github.com/get_something

.pre_build: get_something

include ../dotfile.mk
```

Right:
```

.get_something:
	git clone https://github.com/get_something

.pre_build: .get_something
```

Wrong:
```
get_something
```


#### `.check_dependencies::`
Code for testing if all dependencies, e.g. external programs, are met
to build this dotfile package. Make sure that a failed check returns a non-zero exit value,
so `make` will abort on that point.

#### `.pre_build::`
This rule is called before the build process. It is useful for retrieving files over git,
or generating own files that should later be included by the preprocessor.

#### `.post_build::`
This rule is called after the build process. 
Called after `build`. May be used for post-editing the generated files.
These files reside in `_PACKAGE_BUILD_DIR`.

#### `.pre_install::`
This rule is called before copying the generated dotfiles to the `ROOT_DIR`.

#### `.post_install::`
This rule is called after `install`. It may be useful for automatically reloading the configuration of a program.

You may do something like:
- `openbox --reconfigure`
- `xrdb ~/.Xresources`
- `tmux source ~/.tmux.conf`

