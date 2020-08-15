making a gba game part 2: getting the things onto the screen

The most up-to-date code is available in the repo: <https://tildegit.org/nytpu/game>

## finishing up first-stage character design
I left off my last post with unfinished sprites and tilemaps. They're still
unfinished now, but I still needed to finish up the basics and get the player
character sprite designed before I could continue work on other aspects. I got
the basic ground and one obstacle for the hub designed, and all I needed was
the player character before I could get started coding. The problem is, I had
plenty of ideas for other NPCs in the game, but literally no idea what the
player character should look like. However, through sheer luck, I was randomly
doodling in [Aseprite][1] (my preferred sprite editor, although there's [no
tilemap editor yet][2]) and drew a strange little outline, and it looked pretty
good. "Maybe this will be another NPC" I thought. But, after cleaning it up and
turning the random colors I picked into a palette, it looked really good (at
least to other pixel art things I've done before). I christened him Schnoz for
his huge schnoz, and decided that since it's the only character I've actually
designed so far, that he was going to be the main character. Adding a second
frame for a simple animation (see! I'm not so inexperienced that I don't know
about the wonders of XOR for animations). I decided that he looked like a
dolphin and added a blowhole and changed his colors to be more blue-grey to
match a dolphin's. I tried to add a tail, but I just couldn't get it to look
good, and it looks good enough without it anyway. Just ignore the fact that
since he's a dolphin his schnoz isn't actually a nose at all. 

<div class="image">
<div style="display:inline-block;">
<img src="https://tildegit.org/nytpu/game/raw/commit/27605ea61bbdcad4e25a6a67258043159168ceca/art/characters/schnoz_5x.gif" style="height:30%;max-width:100%;"/>
Original Schnoz
</div>
<div style="display:inline-block;height:30%;">
<img src="https://tildegit.org/nytpu/game/raw/branch/art/art/characters/schnoz_5x.gif" style="height:30%;max-width:100%;"/>
Schnoz the Dolphin
</div>
</div>

## getting it to something the gba understands
This section title may be a little on the nose, but it's exactly what I needed
to do next. I have all these <strike>beautiful</strike> okay sprites and
tilemaps, but how do I get a modern image format into the GBA? Well, there's a
tool called [grit][3]—written by cearn, who also wrote [tonclib][4]—that
converts images to either `.c` and `.h` files or into another of a range of
binary formats depending on how you want to work with the data in the GBA. I
already knew that I wanted to use the [Game Boy File System][5] because working
with a bunch of `.c` files that contain your data is a pain especially if the
data is compressed and you have to use the GBA BIOS to decompress it, so I
simply fired up grit and had it convert the images into plain LZ77-compressed
binary files that I then shoved into a GBFS tarball and added it to the ROM.
With that good, I managed to get it to read and decompress the files from GBFS
with relative ease, and now I was finally able to pull out my tonc knowledge
that I spent all that time learning last blog post. Loading the tilemap data,
tile data, and character tiles into the right spots, then flipping the right
switches, and adding basic input methods to scroll the background, and voilà,
things were displayed and I could look around the map by moving the screen, and
the first actual version, [v0.1.0][6], was released.

<div style="text-align:center;">
See v0.1.0 in action:
<video style="width:100%;" controls>
<source src="https://www.nytpu.com/video/d2d76614-fd97-4e72-85e6-698f475dd460.webm" type="video/webm">
Your browser does not support WebM or the video tag.
</video>
</div>

## creating some semblance of an actual game
With stuff actually working, I hurriedly got Schnoz displayed and moving around
with the arrow keys. However, then came a part which was more difficult than I
thought. I wanted the background to scroll when Schnoz reached the outer ¼ of
the screen, but for the background to stop scrolling when it reached the edges
of the map. I still haven't figured out how to do it without using [these `if`
statements][7]. I still think that I might wrap it in it's own function
somehow, but I deliberately didn't break out anything yet. However, with Schnoz
now being able to levitate around the screen and ghost through objects,
[v0.2.0][8] was completed. The next order of business is to add gravity (easy)
then add collisions with the terrain (difficult), so we'll see how that goes.

<div style="text-align:center;">
See v0.2.0 in action:
<video style="width:100%;" controls>
<source src="https://www.nytpu.com/video/3959702e-c0fe-49ab-ac80-033eb3d390f0.webm" type="video/webm">
Your browser does not support WebM or the video tag.
</video>
</div>

[1]: https://github.com/aseprite/aseprite
[2]: https://github.com/aseprite/aseprite/issues/977
[3]: http://www.coranac.com/projects/#grit
[4]: http://www.coranac.com/projects/tonc/
[5]: https://pineight.com/gba/#gbfs
[6]: https://tildegit.org/nytpu/game/src/tag/v0.1.0
[7]: https://tildegit.org/nytpu/game/src/tag/v0.2.0/src/main.c#L68-L82
[8]: https://tildegit.org/nytpu/game/src/tag/v0.2.0

tags: gbagame
