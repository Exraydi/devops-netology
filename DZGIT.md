
1. git show aefea - Показывает полную информацию об кормите, в т.ч. и комментарий 

aefead2207ef7e2aa5dc81a34aedf0cad4c32545
 Update CHANGELOG.md


2. git show 85024d3 

Показывает полную информацию об кормите, в т.ч. и теги 

v0.12.23

3.

git show b8d720
commit b8d720f8340221f2146e4e4870bf2ee0bc48f2d5
Merge: 56cd7859e 9ea88f22f

Это кормит мерж. После мержа указаны 2 предка этого коммета 

56cd7859e 9ea88f22f


4. git log v0.12.23..v0.12.24 --oneline

Выводим лог в промежутке между тегами 


33ff1c03b (tag: v0.12.24) v0.12.24
b14b74c49 [Website] vmc provider links
3f235065b Update CHANGELOG.md
6ae64e247 registry: Fix panic when server is unreachable
5c619ca1b website: Remove links to the getting started guide's old location
06275647e Update CHANGELOG.md
d5f9411f5 command: Fix bug when using terraform login on Windows
4b6d06cc5 Update CHANGELOG.md
dd01a3507 Update CHANGELOG.md
225466bc3 Cleanup after v0.12.23 release

5. 
git log  -S"func providerSource(" --oneline -  В логах ищем совпадение по названию функции

8c928e835 main: Consult local directories as potential mirrors of providers
 
6.  git log  -S"globalPluginDirs" --oneline - В логах ищем все вхождения названия функции 

35a058fb3 main: configure credentials from the CLI config file
c0b176109 prevent log output during init
8364383c3 Push plugin discovery down into command package

7. git log  -S"synchronizedWriters" --oneline -   Ищем все коммиты  по названию фнкции. 
git show 5ac311e2a - открываем первый кормит 

Author: Martin Atkins <mart@degeneration.co.uk>


