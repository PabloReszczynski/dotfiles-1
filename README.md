# dotfiles

dotfile.mk is a Makefile for creating and installing dotfiles.

The dotfiles can be customized with the help of the powerful `filepp` preprocessor, which provides
also macros such as `#for`, `#foreach`, `#substr` or even plain perl code.

## Requirements
- make
- filepp

## Makefile commands

#### `make build [BUILD_DIR=<BUILD_DIR>] [<VAR>=<VALUE> ...]`
Generates the dotfile. The `BUILD_DIR` defaults to `/tmp/dotfiles-$USER`.

#### `make install [ROOT_DIR=<ROOT_DIR>]`
Copies the generated files into your `ROOT_DIR`, which defaults to `$HOME`.

#### `make diff`
Shows the difference between the new generated dotfiles in `BUILD_DIR` and the existing ones in `ROOT_DIR`.

#### `make show`
Shows the variables that can be used to customize the dotfiles.

#### `make check_dependencies`
Check if all dependencies are met to build the dotfiles.

#### `make clean`
Cleans up the generated dotfiles inside `BUILD_DIR`.

## Creating a dotfile package:

Create a new directory for the dotfile package and place a `Makefile` in it.
The last line of the `Makefile` must include the `package.mk` file.

### Package Variables

#### `FILEPP_PREFIX`
By default, macros are recognized by the hash sign (`#ifdef ... #endif`).
Using this variable you can change the prefix to something else, for example
when you are generating shell scripts. (see also the `-kc` option in `filepp(1)`)

#### `FILEPP_INCLUDE`
A list of include dirs for `filepp`.

#### `FILEPP_MODULES`
A list of modules that `filepp` should also load.

#### `FILEPP_FLAGS`
Custom flags that should be passed to `filepp`

#### `FILES` / `PP_FILES`
`FILES` holds the list of files that should be copied without calling the preprocessor.

`PP_FILES` holds the list of files that should be passed to the preprocessor.

If neither `FILES` nor `PP_FILES` are set, the Makefile automatically fills these variables.
Files ending with `.pp` will be put into `PP_FILES`, everything else will be put into `FILES`.

#### `IGNORE_FILES`
A list of files that sould be ignored if the file list is generated automatically.

#### `PREFIX_DIR`
By default, all files inside a package directory will be prepended with a dot and placed in `$ROOT_DIR`.
For example the file `inputrc` will become `$ROOT_DIR/.inputrc`

Use this variable if your dotfiles reside in a subdirectory.

```
PREFIX_DIR = .config/ncmpcpp

bindings.pp -> $ROOT_DIR/.config/ncmpcpp/bindings
config.pp   -> $ROOT_DIR/.config/ncmpcpp/config
```

### Helper variables

The following variables are also available in the Makefile and are exported into the environment:

#### `_PACKAGE_NAME`
This variable holds the name of the package, which is the directory name.

#### `_PACKAGE_BUILD_DIR`
This variable points to the package build dir (which is `BUILD_DIR/_PACKAGE_NAME`).

#### `_TEMP_DIR`
Use this directory if your package needs to deal with temporary files.

### Package Rules/Hooks:

**NOTE**: By the nature of `make`, the first rule without a leading dot is used as the default if you type `make` without a target.
If you introduce own rules, make sure that these rules begin with a dot. This ensures that `build` remains the default target.

#### `.check_dependencies::`
Code for testing if all dependencies, e.g. external programs, are met
to build this dotfile package. Make sure that a failed check returns a non-zero exit value,
so `make` will abort on that point.

#### `.pre_build::`
This rule is called before the build process. It is useful for retrieving files over git
or generating own files that should later be included by the preprocessor.

#### `.post_build::`
This rule is called after the build process. 
May be used for post-editing the generated files, residing in `_PACKAGE_BUILD_DIR`.

#### `.pre_install::`
This rule is called before copying the generated dotfiles to the `ROOT_DIR`.

#### `.post_install::`
This rule is called after `install`. It may be useful for automatically reloading the configuration of a program.

You may do something like:
- `openbox --reconfigure`
- `xrdb ~/.Xresources`
- `tmux source ~/.tmux.conf`

### Examples

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

# the files should be placed in $ROOT_DIR/.config/ncmpcpp
PREFIX_DIR = .config/ncmpcpp

# we call a script for post-editing our bindings file
.post_build::
	./makeDummyBindings.sh >> "$(_PACKAGE_BUILD_DIR)/bindings"

# include the makefile. this must be the last line!
include ../dotfile.mk
```

