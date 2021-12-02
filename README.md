# vim-find

```
:Find <string|pattern>
```

File name under cursor will be searched if no argument is passed to find.


## configuration

| Setting              | Default                   | Details
| ---------------------|---------------------------|----------
| g:find_binary        | find                      | path to find command
| g:find_opt           | . -name                   | option for find command

## Installation
Install Dein, according to its instructions.  
Add the following text to your vimrc.  

```vim
call dein#begin()
  call call dein#add('HayatoDoi/vim-find')
call dein#end()
```

Restart Vim, and run the :call dein#install() statement to install your plugins.

## License
These codes are licensed under MIT.

## Author
[HayatoDoi](https://github.com/HayatoDoi)

