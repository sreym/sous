SouS
====

SouS (Source Slides) is a jQuery plugin. It give you HTML showcase for step by step demonstration of source code editing.
This product was made by inspiration of [LaTeX Beamer](http://en.wikipedia.org/wiki/Beamer_(LaTeX)).
You can see similar processing with hidable and unhidable elements.

It's based on
-----------
1. [jQuery](http://jquery.com)
2. [highlight.js](http://highlightjs.readthedocs.org/) - the best at current moment library for highlighting source code.
It's not necessary but it's rather good idea to use it to make you source slides look nicer.
3. [Twitter Bootstrap](http://twitter.github.com/bootstrap/) - it's simpler to choose cooked CSS for making your HTML-pages
not so ugly as it possible. But it's not neccessary though.
4. [CoffeeScript](http://coffeescript.org/) - if you want to commit changes into this repository you need to 
write it on this horrible language. 

You can use libraries for code highlighting and
styling that you prefer or any other libraries that gives you needed features. 

How to use it?
--------------
Clone project to your files and change file index.html.

You should write your code into <code>&lt;pre id="source"&gt;&lt;code&gt;...&lt;/code&gt;&lt;/pre&gt;.

When your code will be ready just surrond some of parts of it with next construction: 
<code>&lt;span class="srcdemoX-Y"&gt;...&lt;/span&gt;</code>, where <code>X</code> is number of beginning slide
and <code>Y</code> is number of ending slide. You can skip <code>X</code> or <code>Y</code> 
that will be conform to 0 and infinity respectively.

Also you can put your notes into <code>&lt;div id="leftcol"&gt;...&lt;/div&gt;</code>. This notes will appear in slides
that conform to classes of your apeearing spans.

