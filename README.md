# cinclude2svg

## Short version


cinclude2dot + mods + helper script + static site generator


## Long version

The repo contains a modified version of cinclude2dot (different colors/shapes for .c/.h/ext .h/main .c and external headers handling).
It also contains an helper script, cinclude2svg, lanching cinclude2dot, generating the svg with twopi, and generating a static web site using svg-pan-zoom.js.

## Example:

```bash
$ ./cinclude2svg -i ~/GitHub/libemf2svg/ -o out/ -n libemf2svg
$ firefox out/index.html
```

Output:

http://kakwa.github.io/cinclude2svg/
