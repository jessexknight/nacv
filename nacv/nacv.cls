%%
%% This is file `nacv.cls',
%% generated with the docstrip utility.
%%
%% The original source files were:
%%
%% nacv.dtx  (with options: `class')
%% 
%% LaTeX2e document class for CV (curriculum vitae)
%% that provides four basic features:
%% a column for dates,
%% bulleted items without the environment,
%% some commands for listing publications from a BibTeX file, and
%% some commands for listing contact info using fontawesome icons.
%% 
%% Copyright (c) 2024 Jesse Knight <jesse.x.knight@protonmail.com>
%% 
%% This work may be distributed and/or modified under the conditions of
%% the LaTeX Project Public Licence, either version 1.3c of this licence
%% or (at your option) any later version.
%% The latest version of this licence is in
%%     http://www.latex-project.org/lppl.txt
%% and version 1.3c or later is part of all distributions of LaTeX
%% version 2005/12/01 or later.
%% 
%% This work has the LPPL maintenance status "maintained".
%% 
%% The Current Maintainer of this work is
%% Jesse Knight <jesse.knight@mail.utoronto.ca>.
%% 
%% This work consists of the files:
%% - README
%% - nacv.dtx
%% - nacv.ins
%% - nacv.pdf (derived user manual)
%% - nacv.cls (derived class file)
%% 
%% To generate nacv.cls (class file), run: pdflatex nacv.ins
%% To generate nacv.pdf (documentation), run: pdflatex nacv.dtx
%% To use the class, make nacv.cls visible to your LaTeX distribution,
%% by placing nacv.cls either in your working directory,
%% or in your texmf tree, perhaps: $texmf/tex/latex/nacv/nacv.cls
%% and the documentation: $texmf/doc/latex/nacv/nacv.pdf
%% 
%% See version history on GitHub:
%% [https://github.com/jessexknight/nacv]
%% 
\NeedsTeXFormat{LaTeX2e}[1999/12/01]
\ProvidesClass{nacv}
[2024/10/20 v0.2.3 Not Another CV class]
\RequirePackage{kvoptions}
\SetupKeyvalOptions{family=nacv,prefix=nacv@}
\DeclareStringOption[0ex]{itemsep}
\DeclareStringOption[--]{datesep}
\DeclareStringOption[4em]{datewid}
\DeclareStringOption[1em]{dategap}
\DeclareStringOption[35mm]{margin}
\DeclareStringOption[numeric]{bibstyle}
\DeclareBoolOption[true]{bibnamebold}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ExecuteOptions{}
\ProcessKeyvalOptions*
\ProcessOptions\relax
\LoadClass{article}
\RequirePackage[nomarginpar,margin=\nacv@margin]{geometry}
\RequirePackage{calc}
\RequirePackage{fontawesome5}
\setlength\parindent{0pt}
\setlength\parskip{0pt}
\newlength\nacv@w@itemsep
\setlength\nacv@w@itemsep{\nacv@itemsep}
\newlength\nacv@w@date
\newlength\nacv@w@datesep
\newlength\nacv@w@dategap
\newlength\nacv@w@datex
\newlength\nacv@w@contentx
\newcommand{\nacv@w@update}[1]{%
  \setlength\nacv@w@datex{\dimexpr#1}%
  \setlength\nacv@w@contentx{\dimexpr\linewidth-\nacv@w@datex-\nacv@w@dategap}}
\newcommand{\nodate}{\nacv@w@update{-\nacv@w@dategap}}
\newcommand{\onedate}{\nacv@w@update{\nacv@w@date}}
\newcommand{\twodate}{\nacv@w@update{2\nacv@w@date+\nacv@w@datesep}}
\AtBeginDocument{%
  \setlength\nacv@w@date{\nacv@datewid}%
  \setlength\nacv@w@datesep{\widthof{\nacv@datesep}}%
  \setlength\nacv@w@dategap{\nacv@dategap}%
  \twodate}
\newcommand{\ifempty}[3]{\if\relax\detokenize{#1}\relax#2\else#3\fi}
\newcommand{\nacv@datestr}[2]{%
  \ifempty{#1}{\hfill#2}{#1\hfill\nacv@datesep\hfill#2}}
\newcommand{\nacv@datebox}[3]{%
  \ifdim\nacv@w@datex<0pt\hskip\nacv@w@datex\fi%
  \parbox[t]{\nacv@w@datex}{\datestyle{\nacv@datestr{#1}{#2}}\par}%
  \hskip\nacv@w@dategap%
  \parbox[t]{\nacv@w@contentx}{\contentstyle{#3}\par}}
\newcommand{\dated}[4][\nacv@w@itemsep]{\par%
  \addvspace{#1}\nacv@datebox{#2}{#3}{#4}\par}
\renewcommand{\bullet}[1][\nacv@w@itemsep]{\par%
  \addvspace{#1}\hskip\dimexpr\nacv@w@datex+\nacv@w@dategap%
  {\bulletsymbol}\hskip\labelsep\ignorespaces}
\newcommand{\name}[2]{
  \gdef\nacv@name@given{#1}
  \gdef\nacv@name@family{#2}}
\name{(First)}{(Last)}
\renewcommand{\title}[1]{
  \gdef\nacv@title{#1}}
\title{(Title)}
\newcommand{\nacv@contact@list}{}
\newcommand{\nacv@icon}[1]{%
  \parbox{1em}{\centering\small\ifempty{#1}{~}{\faIcon{#1}}}}
\newcommand{\nacv@iconlink}[3]{%
  \ifempty{#1}{#3~\nacv@icon{#2}}{\href{#1#3}{#3~\nacv@icon{#2}}}}
\newcommand{\contact}[3][]{%
  \g@addto@macro\nacv@contact@list{\nacv@iconlink{#1}{#2}{#3}\par}}
\newcommand{\lrboxes}[2]{%
  \parbox[t]{\textwidth}{#1\par}%
  \hspace{-\textwidth}%
  \parbox[t]{\textwidth}{\raggedleft#2\par}}
\renewcommand{\maketitle}{%
  \thispagestyle{empty}%
  \lrboxes{%
    {\namestyle{\nacv@name@given~\nacv@name@family}}\par%
    \addvspace{1ex}%
    {\titlestyle{\nacv@title}}\par}
    {\contactstyle{\nacv@contact@list}\par}}
\RequirePackage[
  backend=biber,
  sorting=symd,
  style=\nacv@bibstyle,
  defernumbers=true,
]{biblatex}
\DeclareSortingTemplate{symd}{
  \sort[direction=descending]{\field{sortyear}\field{year}}
  \sort[direction=descending]{\field{month}}
  \sort[direction=descending]{\field{day}}}
\newcommand{\nacv@mkbibname}[1]{\ifthenelse{%
  \equal{\nacv@name@given}{\namepartgiven} \AND
  \equal{\nacv@name@family}{\namepartfamily} \AND
  \boolean{nacv@bibnamebold}}%
  {\mkbibbold{#1}}{#1}}
\let\mkbibnamegiven\nacv@mkbibname
\let\mkbibnamefamily\nacv@mkbibname
\setlength{\biblabelsep}{\labelsep}
\DeclareFieldFormat{labelnumberwidth}{#1\adddot\hfill}
\newcommand{\publications}[2][]{\nocite{#1}\par%
  \addvspace{\nacv@w@itemsep}%
  \printbibliography[resetnumbers=true,heading=none,#2]}
\AtEndOfClass{\ifx\ver@hyperref\relax%
  \hypersetup{pdftitle={CV},pdfauthor={\nacv@name@first\ \nacv@name@last}}%
  \relax\else\newcommand{\href}[2]{#2}\fi}
\renewcommand{\@seccntformat}[1]{}
\newcommand{\datestyle}[1]{\strut#1}
\newcommand{\contentstyle}[1]{\strut#1}
\newcommand{\namestyle}[1]{\huge#1}
\newcommand{\titlestyle}[1]{#1}
\newcommand{\contactstyle}[1]{#1}
\newcommand{\bulletsymbol}{\textbullet}
\endinput
%%
%% End of file `nacv.cls'.
