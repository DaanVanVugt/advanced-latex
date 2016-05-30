---
title: Workshop Advanced Latex
author: Daan van Vugt, <daanvanvugt@gmail.com>
institute: TU/e
date: May 31, 2016
classoption: aspectratio=169
theme: metropolis
header-includes:
  - \makeatletter
  - \let\RequirePackage\original@RequirePackage
  - \let\usepackage\RequirePackage
  - \makeatother
  - \usepackage{mhchem}
  - \usepackage{tikz}
  - \usepackage{tikzpagenodes}
  - \usepackage{pgfplots}
  - \pgfplotsset{width=\textwidth,compat=newest}
  - \usepackage{gitdags}
  - \usepackage{dirtree}
  - \usepackage{listings}
  - \usepackage{xcolor-solarized}
  - \usepackage{graphicx}
  - \usepackage{booktabs}
  - \usepackage{gnuplottex}
  - \graphicspath{{images/}}
  - \lstset{language=[LaTeX]{TeX},basicstyle=\footnotesize, keywordstyle=\color{solarized-blue}, commentstyle=\color{solarized-red}}
  - \setbeamertemplate{navigation symbols}{}
  - \institute{Eindhoven University of Technology}
---

## Introduction
* LaTeX for physicists
* Next steps towards using LaTeX for nice documents and presentations
* Basic LaTeX knowledge (and working editor) assumed

## Agenda
\tableofcontents

# Structuring large documents
## Directory structure {.fragile}
\begin{columns}[T]
\begin{column}{.48\textwidth}
\dirtree{% spaces after . are important
.1 /. 
.2 document.tex. 
.2 mytue.sty. 
.2 Makefile. 
.2 img/. 
.3 tokamak.pdf. 
.3 stellarator.png. 
.3 lasers.tex.
.3 \ldots. 
.2 tex/. 
.3 title.tex. 
.3 intro.tex. 
.3 main\_part.tex. 
.3 conclusions.tex. 
.3 appendix.tex. 
.2 document.pdf. 
}%} comment only for vim highlighting
\end{column}%
\hfill%
\begin{column}{.48\textwidth}
\begin{itemize}
\item Clean directories
\item Easy to rearrange content
\item Smaller files are easier to oversee
\item Partial compilation is faster
\item Style, content and main document separate
\end{itemize}
\end{column}%
\end{columns}

## Splitting documents (input vs include)
* \\input{dir/file} acts as if the contents of file were typed here
* \\include{dir/file} does this, and forces a page break and creates a .aux file
* \\includeonly{filenames} in your preamble speeds up compilation
* \\include cannot be nested!
* .tex is optional in filename
* all paths are relative to main .tex file

## Example document {.fragile}
\begin{lstlisting}
\documentclass[12pt,a4paper]{report}
\usepackage{mytue}
\begin{document}

\include{tex/title}
\tableofcontents

\include{tex/intro}
\include{tex/main_part}
\include{tex/conclusions}

\appendix
\include{tex/appendix}
\end{document}
\end{lstlisting}
\footnote{See also \url{https://en.wikibooks.org/wiki/LaTeX/Modular_Documents}}

## Example style file {.fragile}
\begin{lstlisting}
\ProvidesPackage{mytue}
\newcommand{\dd}[3][\mathrm{d}]{\frac{{#1}{#2}}{{#1}{#3}}} % derivatives
\newcommand{\e}[1]{\ensuremath{\cdot10^{#1}}} % exponents

\usepackage[english]{babel}
\usepackage{amsmath} % for eqref, multline
\usepackage[pdfusetitle]{hyperref} % links in your pdf
\usepackage{booktabs} % pretty tables
\usepackage{graphicx}
\graphicspath{{./img/}} 

\usepackage[labelfont=bf,textfont=it]{caption} % pretty captions
\usepackage{siunitx}
\sisetup{seperr} % seperate the error from the number
\end{lstlisting}

## Example style file (2) {.fragile}
\begin{lstlisting}
% TU/e frontpage design
\usepackage[tmargin=2.5cm,bmargin=2.5cm,lmargin=2.75cm,rmargin=2cm]{geometry}
\usepackage[absolute]{textpos}
% Define the length in which 'textpos' calculates its distances
\setlength{\TPHorizModule}{1mm}
\setlength{\TPVertModule}{\TPHorizModule}
\usepackage{changepage}
\usepackage{verbatim}

% for fulltext citing
\usepackage[style=authoryear]{biblatex}
\renewcommand*\bibopenparen{[}
\renewcommand*\bibcloseparen{]}

% Page break before every section
\usepackage{titlesec}
\newcommand{\sectionbreak}{\clearpage}
\end{lstlisting}


# Version control and collaboration
## Options for collaborating on LaTeX documents
* Online editors: Overleaf / Authorea / Sharelatex
* Dropbox
* Version control: Git / Mercurial / SVN
\footnote{See also: \url{https://en.wikibooks.org/wiki/LaTeX/Collaborative_Writing_of_LaTeX_Documents}}

## Version control
* Absolute necessity when working with code
* Extremely useful for LaTeX as well
* Easily view changes between versions
* Go backwards and forwards in history
* Steep learning curve
* Online backup when using GitLab

## Git
* Most popular version control system
* Git manages changes to a tree of files over time
* Excellent integration with many sites and services (Github, GitLab\footnote{TU/e GitLab system coming soon!}, Bitbucket)

## How does it work? {.fragile}
\begin{columns}[T]
\begin{column}{.20\textwidth}
\begin{figure}
  \begin{tikzpicture}
  \gitDAG[grow right sep = 2em]{ A };
  \end{tikzpicture}
\end{figure}
\end{column}%
\hfill%
\begin{column}{.78\textwidth}
\begin{lstlisting}
commit cc9e12aa996cb4b098a10387ad5c812264bdba38
Author: Daan van Vugt <daanvanvugt@gmail.com>
Date:   Fri Sep 11 18\:18\:14 2015 +0200

    create initial version of gradB paper, derivation of theta only

 .gitignore   |   5 ++
 Makefile     |  31 ++++++++++++
 gradB.tex    | 120 ++++++++++++++++++++++++++++++++++++++++++++++
 img/Makefile |  22 +++++++++
 img/theta.nb | 332 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 510 insertions(+)
\end{lstlisting}
\end{column}%
\end{columns}

## Creating commits {.fragile}
\begin{figure}
  \begin{tikzpicture}
  \gitDAG[grow right sep = 2em]{ A -- B };
  \end{tikzpicture}
\end{figure}
\begin{lstlisting}
commit d945fe54d01f758e0e035f026f8c17fe05d4766a
Author: Daan van Vugt <daanvanvugt@gmail.com>
Date:   Mon Sep 21 15\:15\:37 2015 +0200

    add graph of tanh behaviour

 gradB.tex | 59 ++++++++++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 42 insertions(+), 17 deletions(-)
\end{lstlisting}

## Creating commits (2) {.fragile}
\begin{lstlisting}[language=bash]
git init . # Create the repository (.git directory)
git add document.tex tex/ img/ Makefile .gitignore mytue.sty # Add all files
git commit # Commits the first version. You will be asked to write a short description
\end{lstlisting}

## Branches
\begin{figure}
  \begin{tikzpicture}
  \path[use as bounding box] (0,-2.5) rectangle(10.5,2.5);
  \gitDAG[grow right sep = 2em]{ A -- B };
  % Branch
  \gitbranch
  {master}     % node name and text
  {above=of B} % node placement
  {B}          % target
  % HEAD reference
  \gitHEAD
  {above=of master} % node placement
  {master}          % target
  \end{tikzpicture}
\end{figure}

## Remotes and collaboration
\begin{figure}
  \begin{tikzpicture}
  \path[use as bounding box] (0,-2.5) rectangle(10.5,2.5);
  \gitDAG[grow right sep = 2em]{ A -- B };
  % Branch
  \gitbranch
  {master}     % node name and text
  {above=of B} % node placement
  {B}          % target
  % Remote
  \gitremotebranch
  {origin/master} % node name and text
  {above=of master} % node placement
  {master} % target

  \node[DAGref, fill = solarized-blue!20] (origin) at (8,2) {origin};
  \node[DAGref, fill = yellow!30] (me) at (7,0) {me};
  \node[DAGref, fill = yellow!30] (sam) at (9,0) {sam};
  \draw[DAGedge] (origin) -- (me);
  \draw[DAGedge] (origin) -- (sam);
  \end{tikzpicture}
\end{figure}

## Remotes and collaboration (2) {.fragile}
\begin{lstlisting}[language=bash]
git remote add origin git@github.com/Exteris/git-for-scientists.git # Create a remote
git push origin master # Push our master branch to origin
git pull # Get new changes from origin/master and merge them into our master branch
... # Do some work
git add * # add it
git commit # Create a new commit
... # Do more work
git add * # add it
git commit # Create a new commit
git push # Push this commit to origin
\end{lstlisting}

## Conflicts
\begin{figure}
  \begin{tikzpicture}
  \path[use as bounding box] (0,-2.5) rectangle(10.5,2.5);
  \gitDAG[grow right sep = 2em]{
  A -- B -- { C, D -- E, }
  };
  % Remote branch
  \gitremotebranch
  [origmaster]    % node name
  {origin/master} % node text
  {above=of C}    % node placement
  {C}             % target
  % Remote branch
  \gitremotebranch
  [sammaster]    % node name
  {sam/master} % node text
  {above=of origmaster}    % node placement
  {origmaster}             % target
  % Branch
  \gitbranch
  {master}     % node name and text
  {above=of E} % node placement
  {E}          % target
  \end{tikzpicture}
\end{figure}

## Merging
\begin{figure}
  \begin{tikzpicture}
  \path[use as bounding box] (0,-2.5) rectangle(10.5,2.5);
  \gitDAG[grow right sep = 2em]{
  A -- B -- { C, D -- E} -- F
  };
  % Remote branch
  \gitremotebranch
  [origmaster]    % node name
  {origin/master} % node text
  {above=of C}    % node placement
  {C}             % target
  % Remote branch
  \gitremotebranch
  [sammaster]    % node name
  {sam/master} % node text
  {above=of origmaster}    % node placement
  {origmaster}             % target
  % Branch
  \gitbranch
  {master}     % node name and text
  {above=of F} % node placement
  {F}          % target
  \end{tikzpicture}
\end{figure}


## How can I learn it?
* 15 minute tutorial: \url{https://try.github.io}

Other resources:

* \url{http://nyuccl.org/pages/gittutorial/}
* A Quick Introduction to Version Control with Git and GitHub, PLoS Computational Biology, doi:10.1371/journal.pcbi.1004668
* Hundreds of other git tutorials online


# Citations and reference managers
## Referencing literature in LaTeX
* Store references in a database (file.bib)
* Cite these references in a LaTeX document
* Always cite in the same style
* Commands for printing bibliography
* Usual in physics: [1], [2], [3-5]: AIP, ACS and IEEE styles

## Referencing literature in LaTeX with BibTex {.fragile}
\begin{columns}[T]
\begin{column}{.48\textwidth}
\begin{lstlisting}
\usepackage[natbib]{biblatex}
\addbibresource{references.bib}

\begin{document}
\citet{Huysmans2007} % text-style citation
\cite{Huysmans2007}

\printbibliography{}
\end{lstlisting}
\end{column}%
\hfill%
\begin{column}{.48\textwidth}
\begin{lstlisting}
@article{Huysmans2007,
author = {Huysmans, G.T.A. and Czarny, O.},
doi = {10.1088/0029-5515/47/7/016},
issn = {0029-5515},
journal = {Nucl. Fusion},
number = {7},
pages = {659--666},
title = {{MHD stability in X-point geometry:
simulation of ELMs}},
volume = {47},
year = {2007}
}
\end{lstlisting}
\end{column}%
\end{columns}

## Using reference managers
![Mendeley Desktop](mendeley.png)

## Options for reference managers
* Mendeley
* Paperpile
* Zotero
* Jabref
* Endnote
* Papership

Most of these can export BibTex files of your entire library

# Miscellaneous
## (Re)newcommand {.fragile}
Save yourself work by making commands for often-used symbols\footnote{See also: \url{https://en.wikibooks.org/wiki/LaTeX/Macros} for loops and conditionals}

\begin{lstlisting}
% Syntax: \(re)newcommand{cmd}[args][opt]{def}
% args = num arguments
% opt = optional default value for first argument
% def = text to expand
% examples:
\newcommand{\dd}[3][\mathrm{d}]{\frac{{#1}{#2}}{{#1}{#3}}} % derivatives
\newcommand{\e}[1]{\ensuremath{\cdot10^{#1}}} % exponents
\newcommand\bf[1]{\mathbf{#1}}
\newcommand{\dt}{{\Delta}t}
\renewcommand{\d}{\mathrm{d}}
\renewcommand{\b}[1]{\mathbf{#1}}
\newcommand{\B}{\mathbf{B}}
\end{lstlisting}

## Units with siunitx {.fragile}
* Pretty-print units
* Handles lists and errors as well

\begin{lstlisting}
\usepackage{siunitx}

\num{1+-2i} % 1 \pm 2i
\num{.3e45} % 0.3 * 10^45
\si{kg.m.s^{-1}}
\si{\kilogram\metre\per\second} % kg m s^-1
\SIlist{0.12;0.67;0.80}{\milli\metre} % 0.12 mm, 0.67 mm and 0.80 mm
\end{lstlisting}

See \url{http://ftp.snt.utwente.nl/pub/software/tex/macros/latex/contrib/siunitx/siunitx.pdf} for more info

## Chemical formulas with mhchem {.fragile}
* Typeset chemical formulae and equations easily
* Handles charges as well

\ce{CO2 + C -> 2 CO}\hfill\verb|\ce{C02 + C -> 2 CO}|

\ce{Sb2O3}\hfill\verb|\ce{Sb2O3}|

\ce{Y^99+}\hfill\verb|\ce{Y^99+}|

See \url{http://ftp.snt.utwente.nl/pub/software/tex/macros/latex/contrib/mhchem/mhchem.pdf} for more info

## Symbols
* Nice symbol list on \url{http://web.ift.uib.no/Teori/KURS/WRK/TeX/symALL.html}
* Detexify can recognize handwritten symbols: \url{http://detexify.kirelabs.org}

## Pretty equations {.fragile}
* Bracket balancing: use \verb|\left| and \verb|\right|. Example:

$(a+\frac{b^2}{c_j})d = \left(a+\frac{b^2}{c_j}\right)d$

* Use operators when possible (such as cos and exp)
* Use \verb|\align| for multiline equations
* Use \verb|\text| when adding words in equations and \verb|~| or \verb|\quad| for spacing

$50~apples < 51\quad\text{apples}$

* Read \url{https://en.wikibooks.org/wiki/LaTeX/Mathematics} for a full list and \url{https://en.wikibooks.org/wiki/LaTeX/Advanced_Mathematics} for even more


# Try it yourself
## Exercises
1. Clean up your document (or \url{http://daanvanvugt.nl/files/latex/doc-mess.zip}) for directory structure, style file and includes
2. Try git at \url{https://try.github.io} if you are new to git
3. Add citations to your document and try a reference manager (don't forget to commit)
4. Try to find 3 or more instances where a newcommand could simplify your document and add those (+commit)
5. Use the siunitx package for physical units and errors
6. Try mhchem if you have any element names
7. Look for your ugliest equation and make it easier on the eyes (+commit)
8. Drink coffee and relax
9. Optional: ask me questions about other issues you have with LaTeX

\footnote{Find this presentation at \url{http://daanvanvugt.nl/files/latex/presentation-part1.pdf}}

# -- Break --

## Agenda
\tableofcontents

# Presentations and posters
## The beamer package {.fragile}
* Use as \verb|\documentclass{beamer}| (with options like \verb|aspectratio=169|)
* Use \verb|\begin{frame}| and \verb|\frametitle{title}| to make slides and titles
* Compiles to a pdf
* Beamer themes can be used for styling. See \url{https://www.hartwork.org/beamer-theme-matrix/} for many many themes
* Mtheme is also pretty (this theme)
* See \url{https://en.wikibooks.org/wiki/LaTeX/Presentations} for more info

## Including movies in beamer presentations {.fragile}
\begin{lstlisting}
\usepackage{multimedia}
\newcommand{\fullframe}[1]{\begin{tikzpicture}[remember picture,overlay]
        \node[at=(current page.center)]{#1};
    \end{tikzpicture}}
\newcommand{\fullmovie}[1]{\fullframe{\movie[autostart,loop,externalviewer]{
    \includegraphics[width=\paperwidth]{#1.png}}{videos/#1.mkv}}}
\newcommand\blackbg{\textcolor{\black}{\rule{\paperwidth}{\paperheight}}}

% in your begin{frame}[plain]
\fullmovie{jet_plane_cut_marked}
\end{lstlisting}

## Poster templates (1)
![Beamerposter package groups some slides together](beamerposter.png)

## Poster templates (2) {.fragile}
\begin{columns}
\begin{column}{.40\textwidth}
\begin{tikzpicture}[remember picture, overlay]
\node[anchor=south west] at (current page.south west) {\includegraphics[height=0.9\paperheight]{fusionday.pdf}};
\end{tikzpicture}
\end{column}%
\hfill%
\begin{column}{.60\textwidth}
\begin{itemize}
\item TU/e style science posters using a documentclass
\item fusposter.cls at \url{http://daanvanvugt.nl/files/latex/fusposter.zip}
\item \verb|\documentclass[a1plus,blue]{fusposter}|
\item \verb|\topline{Name of event}|
\item \verb|\botline{Location --- Date}|
\item \verb|\department{Department of Applied Physics}|
\item \verb|\title{Title}|
\item \verb|\author{Authors...}|
\item Use \verb|\otherlogos{}| to set more logos
\end{itemize}
\end{column}%
\end{columns}

# Diagrams, graphs, tables and code
## Floats {.fragile}
* Containers of things that cannot be broken over a page: table, figure
* Positioning these can be tricky. Let LaTeX do it for you!
* See \url{https://en.wikibooks.org/wiki/LaTeX/Floats,_Figures_and_Captions} for info on floats

\begin{lstlisting}
\begin{figure}[htbp] % optional placement specifier
\includegraphics[width=\textwidth]{tokamak.pdf}
\caption{A tokamak fusion reactor}
\label{fig:tokamak}
\end{figure}
\end{lstlisting}

## Pretty (easy) tables {.fragile}
\begin{columns}%
\begin{column}{0.48\textwidth}
\begin{lstlisting}
\begin{tabular}{lllr}
\hline
0 & 1 & 2 & 3 \\ \hline
a & b & c & d \\
a & b & c & d \\\hline
\end{tabular}
\end{lstlisting}
\end{column}%
\hfill
\begin{column}{0.48\textwidth}
\begin{tabular}{lllr}
\hline
0 & 1 & 2 & 3 \\ \hline
a & b & c & d \\
a & b & c & d \\\hline
\end{tabular}
\end{column}%
\end{columns}
### Packages:
* Booktabs package for pretty tables
* Langtable package for multi-page tables
* Use \url{http://www.tablesgenerator.com/} to make things easier
* Excel2latex also works up to Excel 2010

## Including source code in documents {.fragile}
* Easy to do with \verb|\usepackage{listings}|
* Another option: \verb|\usepackage{minted}| (more difficult to run)
* Use: \verb|\begin{lstlisting} CODE \end{lstlisting}|
* Set options with \verb|\lstset{language=[LaTeX]{TeX}}|
* Other options: \verb|basicstyle=\footnotesize|
* \verb|keywordstyle=\color{blue}, commentstyle=\color{red}|
* Don't forget to include the git commit hash
* Read from a file: \verb|\lstinputlisting[language=Python]{source_filename.py}|

## Drawing diagrams with tikz {.fragile}
* Very powerful package for drawing diagrams
* All diagrams in this presentation are in tikz
* \verb|\usepackage{tikz}| first

\begin{columns}%
\begin{column}{0.48\textwidth}
\begin{lstlisting}
\begin{tikzpicture}
\draw[gray, thick] (-1,2) -- (2,-4);
\draw[gray, thick] (-1,-1) -- (2,2);
\filldraw[black] (0,0) circle (2pt)
  node[anchor=west] {Intersection point};
\end{tikzpicture}
\end{lstlisting}
\end{column}%
\hfill
\begin{column}{0.48\textwidth}
\begin{tikzpicture}
\draw[gray, thick] (-1,2) -- (2,-4);
\draw[gray, thick] (-1,-1) -- (2,2);
\filldraw (0,0) circle (2pt)
  node[anchor=west] {Intersection point};
\end{tikzpicture}
\end{column}%
\end{columns}

## Drawing diagrams with tikz (2) {.fragile}
\begin{columns}%
\begin{column}{0.48\textwidth}
\begin{lstlisting}
\begin{tikzpicture}
\fill[blue!50] (2.0,0) ellipse (1.0 and 0.5);
\filldraw[color=red!60, fill=red!5](-1,0) circle (1.0);
\draw[ultra thick, ->] (1.5,-3) arc (0:220:1);
\end{tikzpicture}
\end{lstlisting}
\end{column}%
\hfill
\begin{column}{0.48\textwidth}
\begin{tikzpicture}
\fill[blue!50] (2.0,0) ellipse (1.0 and 0.5);
\filldraw[color=red!60, fill=red!5](-1,0) circle (1.0);
\draw[ultra thick, ->] (1.5,-2.5) arc (0:220:1);
\end{tikzpicture}
\end{column}%
\end{columns}

See \url{https://nl.sharelatex.com/learn/TikZ_package} and many other pages about tikz

Especially \url{http://www.texample.net/tikz/examples/} contains many nice examples


## Tikz basics {.fragile}
### Drawing
* \verb|\draw|, \verb|\filldraw| and \verb|\fill| do what you expect
* \verb|\draw[options] (A) - (B) - (C);| draws a line from A to B to C
* \verb|\draw[options] (A) ellipse (1.0 and 0.5);| draws an ellipse centered on A

### Positions
* Positions can be given as coordinates (in units of 1cm), or as named points, or relative coordinates
* \verb|\path (x,y) coordinate (A);| assigns a coordinate to A
* \verb|\path (A) ++(dx,dy) coordinate (B);| assigns a relative coordinate to B


## Tikz basics (2) {.fragile}
### Options
* \verb|color=<color name>|, \verb|line width=<dimension>|, \verb|dash pattern=<pattern>|
* \verb|fill=<color name>|, \verb|rounded corners| and many more

### Nodes
* Nodes contain shape and text
* \verb|\path (0,0) node[draw,shape=circle] (v0) {$v_0$};| define a node named v0 with text $v_0$, drawn within a circle

### Further reading
See \url{https://en.wikibooks.org/wiki/LaTeX/PGF/TikZ} and \url{https://www.tug.org/pracjourn/2007-1/mertz/mertz.pdf}


## Drawing diagrams with inkscape
![Inkscape](inkscape.png)

## Exporting from inkscape to LaTeX
* Awesome vector graphics editor $\rightarrow$ nice images in your documents
* You can use $$ and LaTeX commands in inkscape text and it will be rendered by LaTeX
* Save a document as LaTeX + PSTricks macros
* Input the .tex document created by inkscape while in a figure environment


## Plotting with PGFplots {.fragile}
\input{3dplot}

## PGFplots resources
* \url{https://nl.sharelatex.com/learn/Pgfplots_package} for a good introduction
* \url{http://pgfplots.sourceforge.net/gallery.html} for many examples

## Matlab2tikz {.fragile}
* Create beautiful tikz plots from your matlab figures
* 4.9/5 stars on Mathworks file exchange
* \url{https://github.com/matlab2tikz/matlab2tikz}
* Create your plots in matlab, then call \verb|matlab2tikz('filename', 'height', '\figureheight', 'width', '\figurewidth');|\footnote{See \url{http://www.howtotex.com/packages/beautiful-matlab-figures-in-latex/} for a very simple tutorial}

## Matlab2tikz examples {.fragile}
\resizebox{!}{8cm}{\input{plots/tex/graphs/compare_psi.tex}}


## Gnuplot {.fragile}
\begin{figure}
\begin{gnuplot}[terminal=cairolatex,terminaloptions=color]
plot [0:2*pi] sin(x) title 'Sine', cos(x) title 'Cosine'
\end{gnuplot}
\end{figure}

## Source for gnuplot example {.fragile}
\begin{lstlisting}
\begin{gnuplot}[terminal=cairolatex,terminaloptions=color]
plot [0:2*pi] sin(x) title 'Sine', cos(x) title 'Cosine'
\end{gnuplot}
\end{lstlisting}


# Try it yourself
## Exercises
1. Create a simple presentation and/or poster and put your equations and sections on it
2. Create a smiley in tikz, compile it in a simple document and email it to <daanvanvugt@gmail.com>
3. Draw a simple tokamak using tikz and put it on your slides (+commit of course)
4. Plot a gaussian with pgfplots and put it on your slides
5. Download \url{http://daanvanvugt.nl/files/latex/plots.zip} and play with the examples
6. \textsc{MATLAB} users only: try recreating one of the plots from 5. with matlab2tikz
7. Make annotations in your graph with tikz

\footnote{Find this presentation at \url{http://daanvanvugt.nl/files/latex/presentation-full.pdf}}
