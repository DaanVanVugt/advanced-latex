---
title: Workshop Advanced Latex
author: Daan van Vugt, <daanvanvugt@gmail.com>
institute: TU/e
date: May 31, 2016
classoption: aspectratio=169
theme: metropolis
header-includes:
  - \usepackage{gitdags}
  - \usepackage{dirtree}
  - \usepackage{listings}
  - \lstset{language=tex,basicstyle=\footnotesize}
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

## Example style file {.fragile}
\begin{lstlisting}
\ProvidesPackage{mytue}
\newcommand{\dd}[3][\mathrm{d}]{\frac{{#1}{#2}}{{#1}{#3}}} % derivatives
\newcommand{\e}[1]{\ensuremath{\cdot10^{#1}}} % exponents

\usepackage[english]{babel}
\usepackage{amsmath} % for eqref, multline
\usepackage[pdfusetitle]{hyperref}
\usepackage{booktabs} % pretty tables
\usepackage{graphicx}
\graphicspath{{./img/}} 

\usepackage[labelfont=bf,textfont=it]{caption} % pretty captions
\usepackage{siunitx}
\sisetup{seperr} % seperate the error from the number with a +- sign
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
## Version control
* Absolute necessity when collaborating on code
* Extremely useful for personal projects also
* Avoid files like analysis_v3_Daan_FINAL_2.m
* Use history to find bugs faster
* Automatic external backup when using remotes

## Git
* Most popular version control system
* Git manages changes to a tree of files over time
* Excellent integration with many sites and services (Github, GitLab, Bitbucket)

## How does it work?
\begin{figure}
  \begin{tikzpicture}
  \path[use as bounding box] (0,-2.5) rectangle(10.5,2.5);
  \gitDAG[grow right sep = 2em]{ A };
  \end{tikzpicture}
\end{figure}

## Creating commits
\begin{figure}
  \begin{tikzpicture}
  \path[use as bounding box] (0,-2.5) rectangle(10.5,2.5);
  \gitDAG[grow right sep = 2em]{ A -- B };
  \end{tikzpicture}
\end{figure}

## Branches and tags
\begin{figure}
  \begin{tikzpicture}
  \path[use as bounding box] (0,-2.5) rectangle(10.5,2.5);
  \gitDAG[grow right sep = 2em]{ A -- B };
  % Tag reference
  \gittag
  [v0p1]       % node name
  {v0.1}       % node text
  {above=of A} % node placement
  {A}          % target
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
  % Tag reference
  \gittag
  [v0p1]       % node name
  {v0.1}       % node text
  {above=of A} % node placement
  {A}          % target
  % Branch
  \gitbranch
  {master}     % node name and text
  {above=of B} % node placement
  {B}          % target
  % Remote
  \gitremotebranch
  {origin/master} % node name and text
  {above=of master} % node placement
  {master}
  % HEAD reference
  \gitHEAD
  {above=of origin/master} % node placement
  {origin/master}          % target
  \end{tikzpicture}
\end{figure}

## Conflicts
\begin{figure}
  \begin{tikzpicture}
  \path[use as bounding box] (0,-2.5) rectangle(10.5,2.5);
  \gitDAG[grow right sep = 2em]{
  A -- B -- { C, D -- E, }
  };
  % Tag reference
  \gittag
  [v0p1]       % node name
  {v0.1}       % node text
  {above=of A} % node placement
  {A}          % target
  % Remote branch
  \gitremotebranch
  [origmaster]    % node name
  {origin/master} % node text
  {above=of C}    % node placement
  {C}             % target
  % Branch
  \gitbranch
  {master}     % node name and text
  {above=of E} % node placement
  {E}          % target
  % HEAD reference
  \gitHEAD
  {above=of master} % node placement
  {master}          % target
  \end{tikzpicture}
\end{figure}

## Merging
\begin{figure}
  \begin{tikzpicture}
  \path[use as bounding box] (0,-2.5) rectangle(10.5,2.5);
  \gitDAG[grow right sep = 2em]{
  A -- B -- { C, D -- E} -- F
  };
  % Tag reference
  \gittag
  [v0p1]       % node name
  {v0.1}       % node text
  {above=of A} % node placement
  {A}          % target
  % Remote branch
  \gitremotebranch
  [origmaster]    % node name
  {origin/master} % node text
  {above=of C}    % node placement
  {C}             % target
  % Branch
  \gitbranch
  {master}     % node name and text
  {above=of F} % node placement
  {F}          % target
  % HEAD reference
  \gitHEAD
  {above=of master} % node placement
  {master}          % target
  \end{tikzpicture}
\end{figure}


## What can I use it for?
Anything text-based!

* Code (MATLAB example follows)
* Papers (Example with Overleaf later)
* Presentations (like this one, see source at \url{https://github.com/exteris/git-for-scientists})

## How to use git with your MATLAB project
* Install git, \url{https://git-scm.com/downloads}
* Include git.m in your project, \url{https://github.com/slayton/matlab-git}
* Create a repository with `git init`
* Stage your files with `git add *.m`
* Create your first commit with `git commit -m "Commit message"`

## How to use git to collaborate on papers
Using Overleaf (only free online editor with unlimited private projects)

1. Create a Project on Overleaf
2. Find the Git Link for your Project (share link, www $\to$ git)
3. Clone your Project with Git
4. Edit your Project and Commit your Changes
5. Push your Changes to Overleaf

\tiny{Steps from \url{https://www.overleaf.com/blog/195}}

## How can I learn it?
1. 15 minute tutorial: \url{https://try.github.io}
2. Just Try It\texttrademark{} and google or ask if you have any problems

Other resources:

* \url{http://nyuccl.org/pages/gittutorial/}
* A Quick Introduction to Version Control with Git and GitHub, PLoS Computational Biology, doi:10.1371/journal.pcbi.1004668 (copies available after the talk)

# Citations and reference managers

# Miscellaneous
## (Re)newcommand
## Units
## Chemical formulas
## Symbols
## Pretty equations
## PDF tricks

# Try it yourself

# -- Break --

# Diagrams, graphs, code and tables
# Presentations and posters
# Try it yourself
