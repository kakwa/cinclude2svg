#!/bin/sh

help(){
  cat <<EOF
usage: `basename $0` <args>

<description>

arguments:
  <options>
EOF
  exit 1
}

while getopts ":hi:o:n:" opt; do
  case $opt in
    h)  help;;
    i)  IN="$OPTARG";;
    o)  OUT="$OPTARG";;
    n)  NAME="$OPTARG";;
    \?) echo "Invalid option: -$OPTARG" >&2 ;help; exit 1 ;;
    :)  echo "Option -$OPTARG requires an argument." >&2; help; exit 1;;
  esac
done

[ -z "$IN" ] && help
[ -z "$OUT" ] && help
[ -z "$NAME" ] && NAME=`basename $IN`

mkdir -p $OUT
perl `dirname $0`/cinclude2dot --groups --src $IN >$OUT/source.dot
lines=`wc -l $OUT/source.dot | sed 's/\ .*//'`
size=`echo $lines | awk '{print sqrt($1) * 800 / sqrt(100000)}'`
echo $size
#twopi -Gnodesep=300 -Goverlap=true  -Gsize="$size,$size" -Tsvg $OUT/source.dot -o $OUT/graph.svg
#neato -Gnodesep=300 -Goverlap=true  -Gsize="$size,$size" -Tsvg $OUT/source.dot -o $OUT/graph.svg
twopi -Gnodesep=300 -Goverlap=scale  -Gsize="$size,$size" -Tsvg $OUT/source.dot -o $OUT/graph.svg
cp -r `dirname $0`/svg-pan-zoom/dist/* $OUT/

cat >$OUT/index.html <<EOF
<!DOCTYPE html>
<html>
  <head>
    <script src="./svg-pan-zoom.js"></script>
    <title>Dep Graph for $NAME:</title>
  </head>

  <body>
    <h2>Dep Graph for $NAME:</h2>
    <div class="controls" style="display: block; margin-left: auto; margin-right: auto; width: 300px">
      <button id="zoom-in">Zoom in</button>
      <button id="zoom-out">Zoom out</button>
      <button id="reset">Reset</button>
    </div>
    <object id="demo-graph" type="image/svg+xml" data="graph.svg" style="height:auto; width:auto; max-width: 90%; height: 800px; display: block; margin-left: auto; margin-right: auto; border:1px solid black; ">Your browser does not support SVG</object>
    <script>
      // Don't use window.onLoad like this in production, because it can only listen to one function.
      window.onload = function() {
        var panZoom = svgPanZoom('#demo-graph', {
          zoomEnabled: true,
          maxZoom: 1000,
          zoomScaleSensitivity: 0.4,
          dblClickZoomEnabled: false,
          controlIconsEnabled: false
        });

        document.getElementById('zoom-in').addEventListener('click', function(ev){
          ev.preventDefault()

          panZoom.zoomIn()
        });

        document.getElementById('zoom-out').addEventListener('click', function(ev){
          ev.preventDefault()

          panZoom.zoomOut()
        });

        document.getElementById('reset').addEventListener('click', function(ev){
          ev.preventDefault()

          panZoom.reset()
        });
      };
    </script>

  </body>

</html>
EOF


