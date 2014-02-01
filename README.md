# Isoterrain 1.0

Isoterrain project was made as semestral work in PV097 course at Faculty of Informatics, Masaryk University, Brno. It was inspired by Timothy J. Reynolds low-poly isometric islands. The Isoterrain application generates random, infinite and living terrains.

## Requirements

Project was createn in Processing, version 2.1. For running the project Java 7 is required.

## Controls

Application can be controlled using keyboard.

- `Arrow`: Movement
- `I`: Infographics about maps
- `H`: Show/hide help
- `S`: Save to PNG
- `E`: Export fo configuration to TXT
- `0-9`: Select layer
- `M/L`: Bigger/smaller miagnitude of selected layer
- `U/D`: Move selected layer up and down
- `RGBA`: Change color of selected layer
- `T`: Turn on/off and selects top cutoff of selected layer
- `Z`: Turn on/off and selects bottom cutoff of selected layer
- `O/P`: Move selected cutoff up/down


# Uživatelská příručka pro aplikaci Isoterrain
*Matěj Kašpar Jirásek, v2014-01-20*

Projekt prezentuje výřez z náhodně generované, nekonečné, živoucí krajiny. Tato krajina je zobrazená v málo polygonech, aby dávala najevo svoji virtuální podstatu. Na generování krajiny využívám především Perlinův šum. Uživatel má možnost živoucím terénem se pohybovat a za běhu měnit jeho parametry. Mým cílem je nejen export pěkných vizuálních výtvorů, ale i zážitek ponoření uživatele do nekonečných náhodných krajin. Uživatelské rozhraní je velmi minimální (pouze textové), aby co nejméně narušovalo výstup. Projekt je inspirován dílem vizuálního umělce Timothy J. Reynoldse.

## Požadavky pro rozběhnutí aplikace

Projekt byl vytvořen v jazyce Processing, verze 2.1. Pro rozběhnutí projektu je potřeba mít nainstalované prostředí Java verze 7.

## Ovládání aplikace

Celá aplikace se ovládá pomocí klávesnice. Následuje popis možností

- `Šipky`: Pohyb po mapě
- `I`: Zobrazení infografiky o mapě
- `H`: Zobrazení nápovědy
- `S`: Uložení obrázku ve formátu PNG
- `E`: Export současných parametrů do .txt
- `0-9`: Výběr aktuální vrstvy
- `M/L`: Větší/menší rozsah hodnot aktuálně vybrané vrstvy
- `U/D`: Posouvání aktuálně vybrané vrstvy nahoru/dolů
- `RGBA`: Změna složek barvy aktuálně vybrané vrstvy
- `T`: Zapne/Vypne a vybere vrchní ořez aktuálně vybrané vrstvy
- `Z`: Zapne/Vypne a vybere spodní ořez aktuálně vybrané vrstvy
- `O/P`: Zvětší/Zmenší vybraný ořez aktuálně vybrané vrstvy

## Konfigurace

Konfigurace je uložena po stisknutí tlačítka `E`. Pokud chcete načíst vlastní konfiguraci, umístěte do složky s aplikací soubor `config.txt`. Když nebude toto umístění fungovat, přidejte soubor do domovského adresáře právě přihlášeného uživatele. Pokud bude tento soubor validní, tak se místo defaultních vrstev načtou vrstvy z tohoto souboru.

### Vzorová konfigurace

Takto vypadá konfigurace vygenerovaná bez jakýchkoli změn parametrů.

	Time=56.632595
	Position=67.28607,84.86561
	---
	Water
	Offset=215.87689,198.29736
	Magnitude=20.0
	Height=-25.0
	Color=42,186,178,180
	Scale=0.5
	Cutoffs=false,false
	Cut values=0.0,0.0
	---
	Hills
	Offset=67.28607,84.86561
	Magnitude=150.0
	Height=-100.0
	Color=236,246,122,255
	Scale=0.3
	Cutoffs=true,false
	Cut values=100.0,0.0
	---
	Mountains
	Offset=67.336075,84.91561
	Magnitude=300.0
	Height=-150.0
	Color=173,57,44,255
	Scale=0.3
	Cutoffs=true,false
	Cut values=160.0,0.0
	---
	Snow
	Offset=67.38607,84.96561
	Magnitude=500.0
	Height=-200.0
	Color=220,220,220,255
	Scale=0.3
	Cutoffs=true,false
	Cut values=215.0,0.0

## Tvorba/Úprava konfiguračního souboru

První dva řádky nám poskytují globální proměnné. Na prvním řádku je uložen interní globální čas aplikace, ovlivňující cyklus dní a nocí. Na druhém řádků je aktuální pozice na mapě (offset v perlinově funkci). Řádky v konfiguraci není možno prohazovat. Hodnoty jsou desetinná čísla s tečkou.

	Time=56.632595
	Position=67.28607,84.86561

### Vrstvy terénu v konfiguračním souboru

Po globálních proměnných následují vrstvy, kterých může být nula až deset. Řádky u vrstvy opět není možno prohazovat. Formát takové vrstvy vypadá následovně (tři pomlčky pro oddělení vrstev musí být obsaženy):

	---
	Hills
	Offset=67.28607,84.86561
	Magnitude=150.0
	Height=-100.0
	Color=236,246,122,255
	Scale=0.3
	Cutoffs=true,false
	Cut values=100.0,0.0

Pro lepší pochopopení zde s popisem (v reálném konfiguračním souboru by nemělo být nic navíc):

	---
	Hills

Popisek vrstvy.

	Offset=67.28607,84.86561

Pozice na mapě.

	Magnitude=150.0

Násobek hodnoty Perlinovy funkce.

	Height=-100.0

Základní výška vrstvy.

	Color=236,246,122,255

Barva rozložená do RGBA prvků (0-255).

	Scale=0.3

Vzdálenost mezi dvěma vzorky z Perlinovy funkce.

	Cutoffs=true,false

Hodnoty říkající zda je zapnutý spodní a horní ořez.

	Cut values=100.0,0.0

Hodnoty spodního a horního ořezu.

Vrstva 0 je vždy vrstvou pohyblivou.

## Ukázky

### Aplikace se zapnutou nápovědou a infografikou

![Aplikace se zapnutou nápovědou a infografikou](example_ui.png)

### Default configuration

![Classic configuration](classic.png)

	Time=58.34304
	Position=197.38326,-2.632732
	---
	Water
	Offset=291.7152,291.7152
	Magnitude=20.0
	Height=-25.0
	Color=42,186,178,180
	Scale=0.5
	Cutoffs=false,false
	Cut values=0.0,0.0
	---
	Hills
	Offset=197.38326,-2.632732
	Magnitude=150.0
	Height=-100.0
	Color=236,246,122,255
	Scale=0.3
	Cutoffs=true,false
	Cut values=100.0,0.0
	---
	Mountains
	Offset=197.43326,-2.5827322
	Magnitude=300.0
	Height=-150.0
	Color=173,57,44,255
	Scale=0.3
	Cutoffs=true,false
	Cut values=160.0,0.0
	---
	Snow
	Offset=197.48325,-2.532732
	Magnitude=500.0
	Height=-200.0
	Color=220,220,220,255
	Scale=0.3
	Cutoffs=true,false
	Cut values=215.0,0.0

### Volcanoes

![Sopečnatý terén](volcanoes.png)

	Time=215.65913
	Position=103.75135,160.70026
	---
	Lava
	Offset=1078.2957,1078.2957
	Magnitude=20.0
	Height=45.0
	Color=95,0,5,250
	Scale=0.5
	Cutoffs=false,false
	Cut values=0.0,0.0
	---
	Floor
	Offset=103.75135,160.70026
	Magnitude=150.0
	Height=65.0
	Color=0,10,5,255
	Scale=0.3
	Cutoffs=false,true
	Cut values=100.0,0.0
	---
	Volcanoes
	Offset=103.801346,160.75026
	Magnitude=445.0
	Height=-195.0
	Color=0,0,5,255
	Scale=0.3
	Cutoffs=true,false
	Cut values=270.0,0.0
	---
	Magma
	Offset=103.85135,160.80026
	Magnitude=500.0
	Height=-200.0
	Color=145,5,0,255
	Scale=0.3
	Cutoffs=true,false
	Cut values=265.0,0.0

### Shallow

![Shallow](shallow.png)

	Time=191.4628
	Position=192.22195,78.166695
	---
	Water
	Offset=874.90857,893.0499
	Magnitude=30.0
	Height=-25.0
	Color=42,186,178,250
	Scale=0.5
	Cutoffs=false,false
	Cut values=0.0,0.0
	---
	Sandstones
	Offset=192.22195,78.166695
	Magnitude=150.0
	Height=0.0
	Color=236,246,122,255
	Scale=0.3
	Cutoffs=true,false
	Cut values=75.0,0.0
	---
	Rocks
	Offset=192.27196,78.21669
	Magnitude=300.0
	Height=-40.0
	Color=173,57,44,255
	Scale=0.3
	Cutoffs=true,false
	Cut values=120.0,70.0
	---
	Sand
	Offset=192.32196,78.26669
	Magnitude=20.0
	Height=55.0
	Color=240,240,150,255
	Scale=0.3
	Cutoffs=true,false
	Cut values=215.0,0.0

### Desert

![Desert](desert.png)

	Time=285.22583
	Position=192.22195,78.166695
	---
	Underground water
	Offset=1350.7043,1413.4845
	Magnitude=30.0
	Height=125.0
	Color=25,105,205,255
	Scale=0.5
	Cutoffs=false,false
	Cut values=0.0,0.0
	---
	Sand
	Offset=874.90857,893.0499
	Magnitude=30.0
	Height=-150.0
	Color=240,220,50,255
	Scale=0.5
	Cutoffs=false,false
	Cut values=0.0,0.0
	---
	Sandstone
	Offset=874.90857,893.0499
	Magnitude=50.0
	Height=-100.0
	Color=210,170,20,255
	Scale=0.5
	Cutoffs=false,false
	Cut values=0.0,0.0
	---
	Mud
	Offset=874.90857,893.0499
	Magnitude=65.0
	Height=-30.0
	Color=70,65,0,255
	Scale=0.5
	Cutoffs=false,false
	Cut values=0.0,0.0
	---
	Dark mud
	Offset=874.90857,893.0499
	Magnitude=75.0
	Height=45.0
	Color=65,75,10,255
	Scale=0.5
	Cutoffs=false,false
	Cut values=0.0,0.0
	---
	Stone
	Offset=874.90857,893.0499
	Magnitude=30.0
	Height=155.0
	Color=30,30,35,255
	Scale=0.5
	Cutoffs=false,false
	Cut values=0.0,0.0
	---
	Rock
	Offset=874.90857,893.0499
	Magnitude=30.0
	Height=295.0
	Color=10,10,10,255
	Scale=0.5
	Cutoffs=false,false
	Cut values=0.0,0.0


## Example

![Isoterrain example](https://31.media.tumblr.com/dec20df6111190b9eead953c411e2988/tumblr_mxeu4zOMoR1s14nrdo2_r1_500.png)

## Links

- My portfolio: http://mkj.is
- Course information: https://is.muni.cz/predmet/fi/podzim2013/PV097?lang=en
- Inspiration by Timothy J. Reynolds: http://dribbble.com/shots/767412-Island-Map

