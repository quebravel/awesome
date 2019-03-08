# Configurando  `AWESOMEWM`

### Crie as seguintes pastas
```javascript
$ mkdir -p ~/.config/awesome/
```
```javascript
$ cp -rv /etc/xdg/awesome/rc.lua ~/.config/awesome/
```
```javascript
$ mkdir -p ~/.config/awesome/themes/
```
```javascript
$ sudo cp -rv /usr/share/awesome/themes/ 
~/.config/awesome/
``` 
### Setando Temas 

- Em rc.lua modifique o caminho;  
 ```lua
--{{{  
beautiful.init(awful.util.getdir("config") .. "/themes/default/theme.lua")  
}}}--
```

### Setando Papel de parede  
- Em theme.lua indique o caminho para o papel de parede;  
```lua
--{{{  
theme.wallpaper = "~/.config/awesome/themes/awesome-wallpaper.png"  
}}}--
```
### Remover Barras de `títulos`
```lua
--{{{  
properties = { titlebars_enable = false }  
}}}--
```
