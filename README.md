# Slab PCB
The circuitboard and schematics for the Slab keyboard project. [Firmware here](https://github.com/headblockhead/slab-firmware).

## Supplies
### PCB
- Solder
- Soldering Iron (Preferably with a wedge shape tip when soldering SMD)
- Desoldering Braid (lifesaver for SMD soldering by hand)
- Flux Pen (Can help with soldering SMD components)
- ['Adjustable Helping Hand with Magnifying Glass'](https://www.amazon.co.uk/01902-Adjustable-Magnifying-Soldering-Alligator/dp/B000P42O3C?th=1) or other magnification solution
- Good lighting! - A very bright light or sunlight through a window. Dim lighting only makes soldering harder.
- Electronics tweezers (Good for holding parts steady)
### Project (TODO: relocate theese)
- Keyswitches
- Keycaps
- 3D printer (For the case)
- M3 screws (length currently undecided)
- This circuitboard (I used JLCPCB)
- Materials from the BOM (I used LCSC)

## BOM
| Part Usage | Part Number | LCSC Number | # Needed | # Suggested | Cost/Unit ($) | Cost/Total ($) | Relative soldering difficulty / 5 | Notes
|---|---|---|---|---|---|---|---|---|
|Logic level shifter|SN74AHCT125PWR|C36365|1|10|$0.1934|$1.93|4|Order more spares if new to SMD soldering|
|I²C IO expander|PCA9555PW|C128392|1|6|$1.1774|$7.06|5|Order more spares if new to SMD soldering|
|Addresable RGB LEDs|SK6812MINI-E|C5378731|90|110|$0.1276|$14.04|3|Easy to burn out if soldered too hot/rough|
|I²C pullup resistors|Generic: 1206 2.2kΩ resistor|C17948|2|100|$0.0028|$0.28|2||
|Decoupling capcaitors|Generic: 1206 10uF capacitor|C513774|92|120|$0.0248|$2.98|2|Careful: Easy to accidently order the wrong size|
|Rotary encoder with switch|EC11E15244B2|C470754|1|2|$1.7755|$3.55|1|Order more if you want - these are great!|
|Key diodes|Generic: SOD-123 diode|C393516|75|100|$0.0115|$1.15|3||
|I²C OLED 128x32|SSD1306|C5248081|1|3|$2.0128|$6.04|2|Useful in other projects + headers required.|
|Kailh hotswap MX switch sockets|CPG151101S11-16|C5156480|75|80|$0.1243|$7.94|1||
|**TOTAL**|||338|531||$44.97|||

## Used libraries
### External
- [marbastlib](https://github.com/ebastler/marbastlib)
### Included
- [CustomFootprints.pretty](CustomFootprints.pretty/)
- [CustomSymbols](CustomSymbols.kicad_sym)
