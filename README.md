# Configurando  `AWESOMEWM`

# Instalando configuração awesomewm personalizada

```shell
git clone --recurse-submodules -j8 https://github.com/quebravel/awesome.git ~/.config/awesome/
```

### Para usar awesomewm original crie as seguintes pastas
```shell
$ mkdir -p ~/.config/awesome/
```
```shell
$ cp -rv /etc/xdg/awesome/rc.lua ~/.config/awesome/
```
```shell
$ mkdir -p ~/.config/awesome/themes/
```
```shell
$ sudo cp -rv /usr/share/awesome/themes/ ~/.config/awesome/
```
# Configurando `rc.lua`
### Setando Temas 

```shell
vim -w ~/.config/awesome/rc.lua
```

- Em rc.lua modifique o caminho;  

```lua
beautiful.init(awful.util.getdir("config") .. "/themes/default/theme.lua")  
```

### Setando `Papel de parede`  
- Em theme.lua indique o caminho para o papel de parede;  

```lua
theme.wallpaper = "~/.config/awesome/themes/awesome-wallpaper.png"  
```
### Remover Barras de `títulos`
```lua
properties = { titlebars_enable = false }
```

# Mudando temas
### Pesonalizando o tema `awesomewm4+`  

- Instale os pacotes  `firefox` `scrot`  `xsel`  

- Se você deseja criar um tema personalizado, copie este arquivo para...  

```shell
cp -rv /usr/share/awesome/themes/ ~/.config/awesome/  
```
```shell
nano -w ~/.config/awesome/rc.lua
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
