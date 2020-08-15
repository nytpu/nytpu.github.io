making a gba game part 1: learning, planning and designing sprites

The most up-to-date code is available in the repo: <https://tildegit.org/nytpu/game>

## introduction and choosing a console
Around November 2019, I decided that I wanted to make a game on a retro
console! Something that I've wanted to do for a while, but have never actually
done. I have experience programming older systems, and my first instinct was to
write it in TMS9900 Assembly on my TI-99/4A, and I've written basic to
moderately advanced *programs* on it, but [looking at the palette][1], limited
number of sprites—16 TOTAL, not just on one scanline!—and the [annoying 256
bytes of directly addressable ram][2] while [hiding 16KiB of memory behind the
VDP][3] makes it *really* bad for games [unless you're a genius programmer and
hardware hacker with lots of time.][4]

With the TI-99/4A out, the *obvious* next logical system to choose is the Game
Boy (I only chose it because it was the only other retro system with a flash
cart I had lying around other than a TI CC-40, which, while being a very
interesting system, and shows TI's transition from home computing to
calculators, [is not good for games][5]). However, I didn't know a lick of Game
Boy assembly, and, upon researching, there seems to be no accurate reference
other than the [GB Pan Docs][6] and not one accurate finished tutorial, nor any
books other than Nintendo's development manual. I realized that trying to learn
GB assembly using pure reference manuals while jumping right into making an
ambitious game, while doable, was probably not a good idea.

I really wanted to write it in assembly, because I'm a crazy person, but the
only other system I had lying around was a GBA, but I didn't have a flash cart
for it. I picked up a relatively cheap [EZ Flash Omega][8] and I was good on
that front. Now, armed with a flash cart, I decided that I would lose my dream
of writing a game in assembly and would just write in C for the GBA, because,
while I didn't know GBA programming, I know embedded programming and C, so it
wouldn't take much to learn about the GBA, plus there's an [excellent
tutorial][7] that I could run through before actually getting started on the
game. And, I could always write the functions that needed to be optimized the
most in assembly still anyway.

## planning and learning about the gba
With my console picked out, it was now time to formalize my ideas and plans for
my game (still untitled because I'm bad at that), but first, I needed to learn
about the GBA, it's capabilities, and what I would be likely able to program on
it with my ability. Preferably have some practice writing stuff for it too, so
I could jump right into making it after planning it out.

So, I started reading through the [tonc tutorial][7], and ran through each
section, and tried to make a demo utilizing everything I learned at the end of
each section ("Basics", "Extended", etc.).

However, I decided to take a little break after "Extended" and get a head start
on planning, and start working on the graphics for the game. I had tons of
ideas bouncing around my head and I wanted to write them down, organize them,
and formalize them before I forgot anything.

I [just replayed Squirm][9], so a lot of the ideas I have (primarily the color
palettes) are inspired by it. My main first ideas were to have a series of
zones ("worlds"), that are connected together à la Metroid. The main world is
to be a hub, that is designed with a primarily greyscale, dark color scheme. It
is primarily rock themed, and will try to capture a cave-like feel. The primary
obstacles will be platforming sections around spikes and other physical
obstacles. All of the other worlds aren't going to connect to each other, and
will only be connected to the hub, for simplicity of programming, and for
enforcing some form of linearity.

The next world (although I may rearrange them later) is a "fire" or "lava"
world (I call it fire), that is obviously orange-red themed. The main surface
will be sort-of brick themed, but more flat, more akin to lightly textured
stone. The main obstacle will be lava, possibly flowing or mobile, and will
have unkillable fireball "enemies" also.

The next world may be a water world, but I may change it to a castle or similar
themed world. However, the main world that I'm excited for will be the final or
second-to-final world, and will initially be cheerful and brightly themed, and
be meadow-like. However, after a short distance, it will slowly transition to a
brown, dead, corrupted color palette, and will become cavernous, with difficult
enemies and obstacles.

The rest of the game is yet to be determined, but, as each world will be fairly
long, and I don't necessarily want the game itself to be very long, these
worlds may very well be sufficient.

## spriting
The most current artwork is available on the art branch: <https://tildegit.org/nytpu/game/src/branch/art/art>

Now we get to where I am now, where I'm designing the sprites for each world. I
started out by pulling up [coolors][10] and using the palette generator to find
a background and foreground color that I liked for the world I'm designing.
After finding those, I copied the hex codes into the gradient palette generator
to get a gradient of 6 colors that I then imported back into the normal palette
generator to touch up. While on the GBA I can have 16 colors per palette, I
prefer to use fewer colors because I'm not very good at pixel art, and using
fewer colors makes it easier and helps enforce a style. For the overworld
palette, I started out generating a nice green palette in the same way I did
previously, but added a sky-blue background on top of the 6 green colors, and
added 3 additional "accent" colors, that I'll use for flowers and things. Then
I duplicated the green palette and messed with the saturation and brightness
until I got the brown colors I wanted. I then manually changed shades for each
color, touching them up until it was how I wanted. The only thing is I'm going
to have to clamp the colors into the GBA's colorspace, so we'll see how that
goes.

<img src="https://tildegit.org/nytpu/game/raw/branch/art/art/overworld/overworld_good_palette.png" alt="Overworld 'Good' Palette" title="can't you just read the title underneath the palette? it says 'overworld good palette'" />
<img src="https://tildegit.org/nytpu/game/raw/branch/art/art/overworld/overworld_decaying_palette.png" alt="Overworld 'Corrputed' Palette" title="i just went over this last title text, just read under the image or the alt text, you don't need to be here." />

Once I got the palette all generated for the world I was looking on, I then
started working on the base ground tile (`<world>_ground` in the repo). I
decided on using 16x16px tiles because 8x8px was way too constricting. Once I
got that how I wanted, I copied it into the tilemap 9 times into a square, and
3 more times into a line. I then added borders how I wanted. For the overworld,
I don't have to make different tiles for the "good" and "corrupted" variations,
because I can just toggle the palette in software and it will automatically
change the colors. However, I will still export the image in both palettes to
ensure that it is viewable in both variants. I continued working on the other
tiles in much the same way, and am still working on this process for all of the
worlds.

<p class="image">
<img src="https://tildegit.org/nytpu/game/raw/branch/art/art/hub/hub_tilemap_5x.png" title="i'm really proud of the texture in this" />
work-in-progress tilemap for the hub
</p>

## the future
I still have to finish up tiles, and then work on sprites, but I also should
work on sound and music too. However, the only experience I have with sound is
with LSDj on the Game Boy, and even then I barely understand GB audio. I get
the feeling I may be relegated to the digital audio channels for the GBA, but
even then I probably will work on sound dead last, the most I may do is write
in dummy functions for actions so sound could be called later. I'm probably
going to finish up the hub sprites then start coding in core game logic and the
game loop.

## conclusion
Hopefully my next post will be significantly shorter, but I had a lot of
introduction to get through, and a lot to write about because I only decided to
write a chronological dev log now, when I was previously planning on writing
one complete overview when I was completely done (although I still plan on
doing that). Check out the repo linked at the beginning of this post to see my
current progress, although I don't push until I make a major commit.

[1]: http://www.mainbyte.com/ti99/hardware/chips/tms9918a.html
[2]: https://archive.org/details/tibook_fundamentals-of-ti994a-assembly-language/page/n63/mode/2up
[3]: https://archive.org/details/tibook_fundamentals-of-ti994a-assembly-language/page/n65/mode/2up
[4]: https://www.harmlesslion.com/text/Dragons%20Lair%20on%20the%20TI-99_4A.pdf
[5]: https://en.wikipedia.org/wiki/Texas_Instruments_Compact_Computer_40
[6]: https://gbdev.io/pandocs/
[7]: http://www.coranac.com/tonc/text/toc.htm
[8]: https://www.ezflashomega.com/products/EZ-Flash-Omega.html
[9]: https://tilde.team/~nytpu/blog/playing-with-the-steam-controller.html
[10]: https://coolors.co/

tags: gbagame
