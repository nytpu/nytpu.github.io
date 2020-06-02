# automated timer for photo printing
**WARNING:** This project was put together in around five hours in one day in
late March using whatever I had lying around, so it can't be referred to as
anything like *well engineered* or *optimised*, so be warned.

<figure>
<figcaption>See it in action:</figcaption>
<video style="width:100%;" controls>
<source src="../video/74926323-5b73-4f23-b4be-27e26e2e2da4.webm" type="video/webm">
Your browser does not support WebM or the video tag.
</video>
</figure>

## introduction
I do a lot of film photography, mostly black & white so I can develop and print
myself (Color film and prints require a temperature of [37.8°C±0.15°][1], and I
don't have any way to reliably temperature control water other than mixing hot
and cold water and hoping I get it right, so I don't even bother). I have a
makeshift darkroom in my basement, but the main thing I was lacking was a good
timer, and I'm particularly prone to mess up exposure time when manually
turning my enlarger on and off. I saw that they have [enlarger timers][2], but
they are prohibitively expensive and they would be literally trivial to build.
I've had 2 of these [switchable power relays][bom-5] for a while, and had been
itching for a project that uses one, and this was the perfect opportunity. I
decided to expand the scope so that it could time every aspect of printing, for
the convenience and automation that I clamber for in everything that I do
often.

## design
I decided that I would make it with an Arduino for ease of slapping it
together, and I had an LCD going unused that would be perfect for displaying
time, etc. However, I knew I'd have to turn off the blue-white backlight of the
LCD when actually printing, but luckily I had a red LED bar graph around. I
tested it to make sure it was safe printing by just having all of the LEDs on
it turned on while printing a photo, and it worked. With the relay already
picked out, I just had to come up with a way to actually be able to customize
the timers. I settled for a DIP switch to enter in stuff in binary, as I didn't
have any other way of conveniently getting numbers into an Arduino.

## bill of materials
This is everything I personally used, but feel free to substitute parts,
because everything here was just stuff I had and wasn't using for anything
else. I also linked to the first place I found it, not necessarily the best or
cheapest place to get it.

* 1x [Arduino Uno or bigger (need every single I/O pin on the Uno)][bom-1]
* 1x Barrel jack power supply with wall plug for Uno
* 1x [DIP Switch, Rocker, 8 Switches, SPST][bom-2]
* 1x [Serial Enabled LCD][bom-3]
* 1x [10 Segment LED Bar Graph - Red][bom-4]
* 1x [Switchable Power Relay][bom-5]
* 1x Any normally open SPST momentary pushbutton of your choice
* 10x 2.2kΩ Resistors
* 1x Solderless breadboard of an appropriate size (at minimum **larger than**
	the [normal size][bom-6])  
	OR a solderable protoboard of an appropriate size
* An inordinate number of jumper wires of your choice
* 2x Very long jumper wires, long enough to reach from the Arduino to the power
	relay.

## construction
With all of the parts gathered together, I started slapping them together into
a workable form as quickly and easily as possible. Pulled out the largest
unused breadboard I had so I didn't have to worry about space, wrote down which
I/O pins would do what, then realized that I didn't have enough.

…sigh

<div class="picture-left">
<figure>
<a href="../img/95ce422c-e102-4caf-ac42-8774f9922eca.jpg" target="_blank">
<img src="../img/95ce422c-e102-4caf-ac42-8774f9922eca.jpg" 
	title="much terrible wow" alt="terrible wiring setup" />
</a>
<figcaption>
terrible picture for a self-proclaimed photographer.<br/>
the red and black wires coming in from the bottom go to the power relay.
</figcaption>
</figure>
</div>

So, I could either order an LED driver or I could just figure out a way to save
I/O pins. Can I cut one of the bar graph LEDs? No, it'd be nice to keep all ten
of them, even though they're most of what's eating up my pins. Next step: move
the LCD Serial from SoftwareSerial to hardware serial pins. There, saved two
pins, as long as I'm careful to not mess with the LCD serial while uploading
new sketches. Cut one of the DIP switches, so I have seven switches + one
select button, saved another, but I need just *one* more. Is there a way to
have a TX only serial? I only use TX for the LCD, but using serial RX
initialized to pin 0 prevents me from using it as a normal pin. After some
research, I found SendOnlySoftwareSerial, exactly what I was looking for! After
moving the LCD TX to pin two so it's not on hardware serial, I can then hook up
the relay control and as many of the DIP switches as I can fit.

Okay, with the pin issues sorted, I proceeded to wire up everything. After my
brightness test with the bar graph I decided to slightly dim them with 2.2kΩ
resistors, because even though they weren't bright enough to mess with the
print, they were just a little too bright for my taste when looking at them in
the dark.

## pin layout
I was going to put this in an actual circuit CAD program but that would have
taken longer than this whole project took to build, and the layout is rather
simple and can be devised by my pictures and this diagram alone.

The final pin layout is:

| pin # | connected to |
|:-----:|:------------ |
|  0 | One side of power relay |
|  1 | DIP switch 1 |
|  2 | LCD TX |
|  3 | DIP switch 2 |
|  4 | DIP switch 3 |
|  5 | DIP switch 4 |
|  6 | DIP switch 5 |
|  7 | DIP switch 6 |
|  8 | DIP switch 7 |
|  9 | Select button |
| 10 | Bar graph + 1 |
| 11 | Bar graph + 2 |
| 12 | Bar graph + 3 |
| 13 | Bar graph + 4 |
| A0 | Bar graph + 5 |
| A1 | Bar graph + 6 |
| A2 | Bar graph + 7 |
| A3 | Bar graph + 8 |
| A4 | Bar graph + 9 |
| A5 | Bar graph + 10 |

Bar graph - 1–10 → 2.2kΩ resistor 1–10 → GND  
Other side of DIP switches 1–7 → GND  
Other side of Select button → GND  
Other side of power relay → GND  
LCD + → 5v  
LCD - → GND

## programming
[Get the code here][3]

<div class="picture-left">
<figure>
<a href="../img/30001327-a064-4704-8d2f-91d8761d0ba4.png" target="_blank">
<img src="../img/30001327-a064-4704-8d2f-91d8761d0ba4.png" 
	title="i code badly sometimes" alt="very inefficient code" />
</a>
<figcaption>
i'm sure that it's literally impossible to make this code any better.
</figcaption>
</figure>
</div>

Like with the hardware, I slapped the code together. I originally adapted code
from another project that I haven't written about yet, where there's a global
variable for the current program mode, and in the loop it `switch`es through
the modes (like a [Finite-state machine][4]), but it kind of got out of hand
with the number of modes and I never bothered to refactor it into something
that makes more sense. It works, and it's not like it needs to be super
efficient because a few extra ms delay doesn't matter in anything but the
actual timers themselves.

The modes are cycled through using the Select button. I actually turn on the
relay when it is first turned on, to allow for manual switching of the enlarger
to view negatives, get it sized and focused, etc. I also turn off the LCD for
that time as well to make it easier to see as the LCD can be quite bright. Then
I switch into the modes to set the values for each of the timers. 

If the input is set to 0, then it will preserve the last used value (even
through power cycles thanks to the Arduino's EEPROM!) to allow for easy
repetition of the same times. All of them are inputted in seconds except for
the fixing time, as I fix for 4–5 minutes and since I can't use all the DIP
switches I can only go up to 255 seconds, which means that I can't go higher
than 4.25 minutes. Fixing doesn't need to any more accurate than the minute for
me anyway, so I'll leave it like that. I also decided to exclude adding in a
wash timer, as I don't usually time my washes any more than "it's been over xx
minutes" and I usually start developing another image while the last one is
being washed, and I don't want to have to wait around for a wash timer to end.

After all the timers are set (or preserved) I then turn off the LCD backlight
and prepare for exposing the frame. Pressing Select again begins exposure, and
then continue to press Select to move through all the timers, where it then
loops back to the beginning.

## still to do
I don't really plan on working on this project more, as it works perfectly fine
for my purposes, but if I do decide to continue, this is what I'll probably be
doing (in order):

1. Replace the small pushbutton for select with a [Jeopardy-button–like
	thing][todo-1] so I can click to the next mode without having to have
	someone else press it or drag around the whole contraption with me.
2. Add an [LED Controller][todo-2] to free up I/O pins to make it easier to
	code and build and so I can use all of the switches on the DIP.
3. Turn it into an Arduino shield or PCB so it doesn't look all ugly on a
	breadboard and is much more compact.
4. Add a 10-digit keypad (probably could rip it out of an old phone or
	something) to make entering specific values easier.

[1]: https://imaging.kodakalaris.com/sites/uat/files/wysiwyg/pro/chemistry/z131.pdf
[2]: https://www.youtube.com/watch?v=Ug9vKaNP3Xo
[3]: https://gist.github.com/nytpu/753158379559c04b7728f9998a10473d
[4]: https://en.wikipedia.org/wiki/Finite-state_machine

[bom-1]: https://store.arduino.cc/usa/arduino-uno-rev3
[bom-2]: https://www.newark.com/alcoswitch-te-connectivity/5435640-5/switch-dip-8-position-spst-raised/dp/52K3775
[bom-3]: https://www.sparkfun.com/products/10097
[bom-4]: https://www.sparkfun.com/products/9935
[bom-5]: https://www.sparkfun.com/products/14236
[bom-6]: https://upload.wikimedia.org/wikipedia/commons/thumb/7/73/400_points_breadboard.jpg/1200px-400_points_breadboard.jpg

[todo-1]: https://www.jeopardy.com/sites/default/files/styles/article_image_960_/public/files/image//Assets/jeopardy/images/s34_jbuzz/september/signaling-device/sd_buzzer3_840x473.gif
[todo-2]: https://www.mouser.com/ProductDetail/Maxim-Integrated/MAX7219CNG%2B?qs=1THa7WoU59Gme2Z0GeVXUQ%3D%3D
