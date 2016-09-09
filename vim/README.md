[![Stories in Ready](https://badge.waffle.io/koara-local/dotvim.png?label=ready&title=Ready)](https://waffle.io/koara-local/dotvim)
[![Build Status](https://travis-ci.org/koara-local/dotvim.svg?branch=master)](https://travis-ci.org/koara-local/dotvim)

dotvim
======

## Basic Installation
### via curl

```
curl -L https://raw.github.com/koara-local/dotvim/master/tools/install.sh | sh
```

### via wget

```
wget https://raw.github.com/koara-local/dotvim/master/tools/install.sh -O - | sh
```

## Update plugins

```
./update_plugin.sh
```

## Update plugins settings

### edit plugin setting
e.g. vim-gitgutter

```
vim ./plugin/vim-gitgutter/rc.vim
```
### update plugin settings list
update ./vimrc_plugin

```
./update_plugin_settings.sh
```

## Support
### syntax highlight + omni completion + other
+ c/c++
+ python
+ go
+ JavaScript
+ TypeScript

### syntax highlight + other
+ rust
+ json
+ markdown

### syntax highlight
+ qml
+ jade
+ glsl
+ opengl
+ opencl
+ CoffeeScript
