\NeedsTeXFormat{LaTeX2e}[1999/12/01]
\ProvidesClass{nacv}[2022/12/03 v0.0.1 Not Another CV class]
\LoadClass{article}
% options
\RequirePackage{kvoptions}
\SetupKeyvalOptions{family=nacv,prefix=nacv@}
\DeclareStringOption[--]{datesep}
\DeclareStringOption[4em]{datewid}
\DeclareStringOption[1em]{dategap}
\DeclareStringOption[3cm]{margin}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ExecuteOptions{}
\ProcessKeyvalOptions*
\ProcessOptions\relax
% packages
\RequirePackage[nomarginpar,margin=\nacv@margin]{geometry}
\RequirePackage{enumitem}
\RequirePackage{calc}
\RequirePackage{fontawesome5}
% misc lengths
\setlength\parindent{0pt}
\setlength\parskip{0pt}
% date lengths
\newlength\nacv@w@date
\newlength\nacv@w@datesep
\newlength\nacv@w@dategap
\newlength\nacv@w@datex
\newlength\nacv@w@datexplus
\newlength\nacv@w@afterdatex
\newcommand{\nacv@w@update}[1]{%
  \setlength\nacv@w@datex{\dimexpr#1}%
  \setlength\nacv@w@datexplus{\dimexpr\nacv@w@datex+\nacv@w@dategap}%
  \setlength\nacv@w@afterdatex{\dimexpr\textwidth-\nacv@w@datexplus}}
\newcommand{\onedate}{\nacv@w@update{\nacv@w@date}}
\newcommand{\twodate}{\nacv@w@update{2\nacv@w@date+\nacv@w@datesep}}
\AtBeginDocument{%
  \setlength\nacv@w@date{\nacv@datewid}%
  \setlength\nacv@w@datesep{\widthof{\nacv@datesep}}%
  \setlength\nacv@w@dategap{\nacv@dategap}%
  \twodate}
% date boxes
\newcommand{\ifempty}[3]{\if\relax\detokenize{#1}\relax#2\else#3\fi}
\newcommand{\datestr}[2][]{\datestyle\strut%
  \ifempty{#1}{\hfill#2}{#1\hfill\nacv@datesep\hfill#2}}
\newcommand{\datebox}[3][]{%
  \parbox[t]{\nacv@w@datex}{\datestr[#1]{#2}}%
  \hskip\nacv@w@dategap%
  \parbox[t]{\nacv@w@afterdatex}{#3}\par}
% cv elements
\renewcommand{\@seccntformat}[1]{}
\newcommand{\default}[3][]{\par%
  \addvspace{\smallskipamount}\datebox[#1]{#2}{#3}\par}
\newcommand{\detail}[2][]{\par%
  \ifempty{#2}{}{\nopagebreak\datebox{}{#1#2}\par}}
\newcommand{\position}[4][]{\par%
  \addvspace{\medskipamount}\datebox[#1]{#2}{\textbf{#3}, #4}\par}
\newcommand{\funding}[4][]{\par%
  \addvspace{\medskipamount}\datebox[#1]{#2}{#3\hfill#4}\par}
% lists
\setlist{topsep=0pt,parsep=0pt,itemsep=\smallskipamount,labelwidth=1em}
\newlist{idemize}{itemize}{1}
\setlist[itemize]{label=\bulletsymbol,leftmargin=\labelwidth}
\setlist[idemize]{label=\bulletsymbol,leftmargin=\nacv@w@datexplus+\labelwidth}
\newcommand{\ixem}[2][\bulletsymbol]{\par%
  \addvspace{\smallskipamount}\hskip\dimexpr#2-1em%
  \parbox{2em}{\hfill#1\hskip\labelsep\null}}
\newcommand{\idem}[1][\bulletsymbol]{\ixem[#1]{\nacv@w@datexplus}}
\newcommand{\ifem}[1][\bulletsymbol]{\ixem[#1]{0pt}}
% author info
\newcommand{\name}[2]{
  \gdef\nacv@name@first{#1}
  \gdef\nacv@name@last{#2}
}\name{(First)}{(Last)}
\renewcommand{\title}[1]{
  \gdef\nacv@title{#1}
}\title{(Title)}
% contact + socials
\newcommand{\nacv@contact}{}
\newcommand{\nacv@contact@icon}[3]{\g@addto@macro\nacv@contact{\nameiconlink{#1}{#2}{#3}\par}}
\newcommand{\icon}[1]{\parbox{1em}{\centering\faIcon{#1}}}
\newcommand{\nameiconlink}[3]{\href{#3}{#2~\icon{#1}}}
\newcommand{\dated}[2][calendar]{\nacv@contact@icon{#1}{#2}{}}
\newcommand{\email}[2][envelope]{\nacv@contact@icon{#1}{#2}{mailto:#2}}
\newcommand{\phone}[2][phone]{\nacv@contact@icon{#1}{#2}{tel:#2}}
\newcommand{\twitter}[2][twitter]{\nacv@contact@icon{#1}{#2}{https://twitter.com/#2}}
\newcommand{\github}[2][github]{\nacv@contact@icon{#1}{#2}{https://github.com/#2}}
\newcommand{\orcid}[2][orcid]{\nacv@contact@icon{#1}{#2}{https://orcid.org/#2}}
% maketitle
\renewcommand\maketitle{%
  \thispagestyle{empty}%
  \parbox[b]{0.65\textwidth}{%
    {\namestyle\nacv@name@first~\nacv@name@last\medskip\par}%
    {\titlestyle\nacv@title\par}}
  \parbox[b]{0.35\textwidth}{%
    \raggedleft\contactstyle\nacv@contact\par}%
  \bigskip\par}
% bib stuff
\RequirePackage[
  backend=biber,
  style=numeric,
  sorting=symt,
  defernumbers=true,
]{biblatex}
\DeclareSortingTemplate{symt}{
  \sort[direction=descending]{\field{sortyear}\field{year}}
  \sort[direction=descending]{\field{month}}
  \sort{\field{title}}}
\setlength{\biblabelsep}{1em}
\DeclareFieldFormat{labelnumberwidth}{\hfill#1\adddot}
\renewcommand{\mkbibnamegiven}[1]{\ifboolexpr{%
    test{\ifdefequal{\nacv@name@first}{\namepartgiven}} and
    test{\ifdefequal{\nacv@name@last} {\namepartfamily}}}
  {\mkbibbold{#1}}{#1}}
\renewcommand{\mkbibnamefamily}[1]{\ifboolexpr{%
    test{\ifdefequal{\nacv@name@first}{\namepartgiven}} and
    test{\ifdefequal{\nacv@name@last}{\namepartfamily}}}
  {\mkbibbold{#1}}{#1}}
\newcommand{\publications}[2][]{\nocite{#1}%
  \addvspace{\medskipamount}%
  \printbibliography[resetnumbers=true,heading=none,#2]}
% hooks
\newcommand{\datestyle}{\normalfont}
\newcommand{\contactstyle}{\normalsize}
\newcommand{\namestyle}{\huge}
\newcommand{\titlestyle}{\normalsize}
\newcommand{\bulletsymbol}{\textbullet}
\endinput
