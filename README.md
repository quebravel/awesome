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
# Configurando `rc.lua`
### Setando Temas 

- Em rc.lua modifique o caminho;  
 ```lua
--{{{  
beautiful.init(awful.util.getdir("config") .. "/themes/default/theme.lua")  
--}}}
```

### Setando `Papel de parede`  
- Em theme.lua indique o caminho para o papel de parede;  
```lua
--{{{  
theme.wallpaper = "~/.config/awesome/themes/awesome-wallpaper.png"  
--}}}
```
### Remover Barras de `títulos`
```
--{{{  
properties =  titlebars_enable = false 
--}}}
```
# Mudando temas
### Pesonalizando o tema `awesomewm4+`  
- Instale os pacotes  `firefox` `scrot`  `xsel`  

- Se você deseja criar um tema personalizado, copie este arquivo para...  

```javascript
cp -rv /usr/share/awesome/themes/ ~/.config/awesome/  
```
- e substitua:  

> beautiful.init(awful.util.get_themes_dir() .. "**default**/theme.lua")  
- por:  
```lua
beautiful.init(awful.util.get_themes_dir("config") .. "zenburn/theme.lua")
```
# Dotfiles com arquivos já configurados

[Meus awesomewm dotfiles](https://github.com/quebravel/awesome)
- no arquivo há discas de onde encontrar mais módulos. 
