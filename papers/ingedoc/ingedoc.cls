% Document class for the IngeDoc Conference
%
% Copyright (c) 2012-13 Stephane GALLAND <stephane.galland@utbm.fr> and
%                       Gillian Basso <gillian.basso@utbm.fr>
% 
% This program is free library; you can redistribute it and/or modify
% it under the terms of the GNU Lesser General Public License as
% published by the Free Software Foundation; either version 3 of the
% License, or any later version.
%
% This library is distributed in the hope that it will be useful, but
% WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
% Lesser General Public License for more details.
%
% You should have received a copy of the GNU Lesser General Public
% License along with this library; see the file COPYING.  If not,
% write to the Free Software Foundation, Inc., 59 Temple Place - Suite
% 330, Boston, MA 02111-1307, USA.
\gdef\@ingedoc@class@version{2013/11/28}
\NeedsTeXFormat{LaTeX2e}[1995/12/01]
\ProvidesClass{ingedoc}[\@ingedoc@class@version]

\typeout{Using the IngeDoc Paper Style version \@ingedoc@class@version.}
\typeout{It was written by Stephane GALLAND <stephane.galland@utbm.fr>}
\typeout{and Gillian BASSO <gillian.basso@utbm.fr>}

%-----------------------------------
% Options and global definitions
%-----------------------------------

% Condition that indicates if the document is a draft
\newif\ifingedoc@utbmfont

% Condition that indicates if the names of the authors should be blinded
\newif\ifingedoc@blind

% Condition that indicates the frame are displayed.
\newif\ifingedoc@framed
\ingedoc@framedfalse%

% Condition that indicates the language (english or french).
\newif\ifingedoc@english
\ingedoc@englishtrue%

% Condition that indicates if the lettrine should be used
\newif\ifingedoc@lettrine

% Options to pass to the article class
\PassOptionsToClass{10pt}{article}

% [french] option
\DeclareOption{french}{%
  \ingedoc@englishfalse%
}
% [francais] option
\DeclareOption{francais}{%
  \ingedoc@englishfalse%
}
% [english] option
\DeclareOption{english}{%
  \ingedoc@englishtrue%
}
% [draft] option
\DeclareOption{draft}{%
  \ingedoc@utbmfontfalse%
  \ingedoc@blindfalse%
}
% [submit] option
\DeclareOption{submit}{%
  \ingedoc@utbmfontfalse%
  \ingedoc@blindfalse%
}
% [blind] option
\DeclareOption{blind}{%
  \ingedoc@utbmfontfalse%
  \ingedoc@blindtrue%
}
% [final] option
\DeclareOption{final}{%
  \ingedoc@utbmfonttrue%
  \ingedoc@blindfalse%
}
% [lettrine] option
\DeclareOption{lettrine}{%
  \ingedoc@lettrinetrue%
}
% [nolettrine] option
\DeclareOption{nolettrine}{%
  \ingedoc@lettrinefalse%
}
% [framed] option
\DeclareOption{framed}{%
  \ingedoc@framedtrue%
}
% [thesansfont] option
\DeclareOption{thesansfont}{%
  \ingedoc@utbmfonttrue%
}
% [nothesansfont] option
\DeclareOption{nothesansfont}{%
  \ingedoc@utbmfontfalse%
}
% The other options are passed to the underlying class
\DeclareOption*{%
	\PassOptionsToClass{\CurrentOption}{article}%
}

% By default, execute the following options
\ExecuteOptions{submit,lettrine}
% Process the options given in the LaTeX document
\ProcessOptions*

% Backward language support
\ifingedoc@english%
	\PassOptionsToClass{english}{article}%
\else%
	\PassOptionsToClass{french}{article}%
\fi

% Load the 'article' class with proper options
\LoadClass{article}

% Prevent to load the babel package
\typeout{The package 'babel' will not be loaded due to}
\typeout{incompatibilities with the ingedoc class.}
\global\@namedef{ver@babel.sty}{}% a fake for a "loaded" package

%-----------------------------------
% Include LaTeX packages
%-----------------------------------
\RequirePackage{ifthen}
\RequirePackage[sc]{mathpazo}
\RequirePackage[T1]{fontenc}
\RequirePackage{lettrine}
\RequirePackage{vmargin}
\RequirePackage{color}
\RequirePackage{xstring}
\RequirePackage{enumitem}
\RequirePackage{eso-pic}
\RequirePackage{picture}
\RequirePackage{xcolor}
\RequirePackage{geometry}
\RequirePackage{xspace}

%-----------------------------------
% Define size page
%-----------------------------------
\geometry{papersize={123mm,180mm}}

%-----------------------------------
% Font macros for The Sans font
%-----------------------------------
% Configuration for a document using 10pt standard.
% 6	\tiny
% 8	\scriptsize
% 9	\small
% 10	\normalsize
% 12	\large
% 14	\Large
% 16	\LARGE
% 19	\huge
% 23	\Huge
\let\FontsizeSix\tiny
\let\FontsizeEight\scriptsize
\let\FontsizeNine\small
\let\FontsizeTen\normalsize
\let\FontsizeTwelve\large
\let\FontsizeFourteen\Large
\let\FontsizeSixteen\LARGE
\let\FontsizeNineteen\huge
\let\FontsizeTwentyThree\Huge

\ifingedoc@utbmfont%
	\DeclareRobustCommand{\TheSansPlain}{\usefont{T1}{fz0}{m}{n}\selectfont}
	\DeclareRobustCommand{\TheSansBold}{\usefont{T1}{fz1}{b}{n}\selectfont}
	\DeclareRobustCommand{\TheSansBoldCaps}{\usefont{T1}{fz3}{b}{sc}\selectfont}
	\DeclareRobustCommand{\TheSansCaps}{\usefont{T1}{fz3}{m}{sc}\selectfont}
	\DeclareRobustCommand{\TheSansSemiBoldItalic}{\usefont{T1}{fz2}{b}{it}\selectfont}
	\DeclareRobustCommand{\TheSansLight}{\usefont{T1}{fz4}{l}{n}\selectfont}
\else
	\DeclareRobustCommand{\TheSansPlain}{\normalfont\sffamily}
	\DeclareRobustCommand{\TheSansBold}{\normalfont\sffamily\bfseries}
	\DeclareRobustCommand{\TheSansBoldCaps}{\normalfont\sffamily\bfseries\scshape}
	\DeclareRobustCommand{\TheSansCaps}{\normalfont\sffamily\scshape}
	\DeclareRobustCommand{\TheSansSemiBoldItalic}{\normalfont\sffamily\bfseries\itshape}
	\DeclareRobustCommand{\TheSansLight}{\normalfont\sffamily}
\fi

\newcommand{\textthesansplain}[1]{%
	\bgroup\TheSansPlain#1\egroup%
}
\newcommand{\textthesansbold}[1]{%
	\bgroup\TheSansBold#1\egroup%
}
\newcommand{\textthesansboldcaps}[1]{%
	\bgroup\TheSansBoldCaps#1\egroup%
}
\newcommand{\textthesanscaps}[1]{%
	\bgroup\TheSansCaps#1\egroup%
}
\newcommand{\textthesanssemibolditalic}[1]{%
	\bgroup\TheSansSemiBoldItalic#1\egroup%
}
\newcommand{\textthesanslight}[1]{%
	\bgroup\TheSansLight#1\egroup%
}

%-----------------------------------
% Colors
%-----------------------------------
% Define the 80% of black color
\definecolor{black80}{rgb}{0.3,0.3,0.3}

%-----------------------------------
% Text Styles
%-----------------------------------
\let\textmd\textthesanslight

\ifingedoc@english%
	\let\emph\textit
\else
	\let\emph\textbf
\fi

%-----------------------------------
% Page size and margins
%-----------------------------------
\setpapersize[portrait]{custom}{123mm}{180mm}
\setmargnohfrb{.5cm}{.5cm}{.5cm}{.5cm}
% The following macros add a frame box around the text
% to ensure that the copy/paste in publishing tools
% Get the correct size of the document
\newcommand\ShowFramePicture{%
  \begingroup
    \normalcolor\thicklines%
    \ifingedoc@framed
    %\AtTextLowerLeft{%
    %  \put(\LenToUnit{-.5cm},\LenToUnit{-.5cm}){%
    %	\framebox(\LenToUnit{\paperwidth},\LenToUnit{\paperheight}){}}}%
    \AtTextLowerLeft{%
      \begingroup\fboxsep=0pt%
      \fcolorbox{red}{white}{\makebox(\LenToUnit{\textwidth},\LenToUnit{\textheight}){}}%
      \endgroup}%
    \else
    \AtTextLowerLeft{%
      \begingroup\fboxsep=0pt%
      \fcolorbox{white}{white}{\makebox(\LenToUnit{\textwidth},\LenToUnit{\textheight}){}}%
      \endgroup%
    }%
    \fi
  \endgroup
}
\AddToShipoutPicture{\ShowFramePicture}

%-----------------------------------
% Interline
%-----------------------------------
%\linespread{1.10} % Palatino needs more leading (space between lines)

%-----------------------------------
% Indentation of paragraphs
%-----------------------------------
\setlength{\parindent}{5mm}

%-----------------------------------
% Sectioning
%-----------------------------------
\let\ingedoc@origin@sect\@sect
\let\ingedoc@origin@ssect\@ssect

% Redefine the section with the proper layout
\renewcommand{\section}{
	%\@startsection{nom}{niveau}{indentation}{présép.}{postsép.}{style}
	\@startsection{section}{1}{0pt}{6mm \@plus -1ex}{3mm \@plus.2ex}{\TheSansBoldCaps\FontsizeTwelve}}

% Redefine the subsection with the proper layout
\renewcommand{\subsection}{
	%\@startsection{nom}{niveau}{indentation}{présép.}{postsép.}{style}
	\@startsection{subsection}{2}{0pt}{2mm \@plus -1ex}{1mm \@plus.2ex}{\TheSansSemiBoldItalic\FontsizeTwelve}}

% Redefine the subsubsection with the proper layout
\renewcommand{\subsubsection}{
	%\@startsection{nom}{niveau}{indentation}{présép.}{postsép.}{style}
	\@startsection{subsubsection}{3}{5mm}{1mm \@plus -1ex}{.1mm \@plus.2ex}{\normalfont\bfseries}}

% Paragraphs are not allowed
\renewcommand{\paragraph}[2][1]{
	\@latex@error{\string\paragraph is not allowed for Ingedoc}}

% Subparagraphs are not allowed
\renewcommand{\subparagraph}[2][1]{
	\@latex@error{\string\subparagraph is not allowed for Ingedoc}}

% Format of the titles for all the sections with a number
\ifingedoc@utbmfont\else
\gdef\@sect#1#2#3#4#5#6[#7]#8{%
	\ifthenelse{\equal{#2}{1}}{%
		\ingedoc@origin@sect{#1}{#2}{#3}{#4}{#5}{#6}[#7]{\uppercase{#8}}%
	}{%
		\ingedoc@origin@sect{#1}{#2}{#3}{#4}{#5}{#6}[#7]{#8}%
	}
}
\fi

% Format of the titles for all the sections without a number
\gdef\@ssect#1#2#3#4#5{%
	\ingedoc@origin@ssect{#1}{#2}{#3}{#4}{#5}%
}

% Format of the number of a section.
\gdef\@seccntformat#1{%
	{\csname the#1\endcsname.\ }%
}

%-----------------------------------
% Macro \affiliation{text}
%-----------------------------------
% All the affiliations
\def\@affiliation{}
% The number of the institute in affiliations
\newcounter{ingedoc@institution}
% Format the number of the institute in affiliations
\newcommand{\@makeaffiliationlabel}[1]{%
	\ensuremath{^{#1}}%
}
% TeX condition that indicates if there is multiple affiliations
\newif\ifingedoc@hasmultipleaffiliations
\ingedoc@hasmultipleaffiliationsfalse
% Macro to save the affiliations
\newcommand{\affiliation}[1]{%
	\noexpandarg%
	\IfSubStr{#1}{\and}{\ingedoc@hasmultipleaffiliationstrue}{\ingedoc@hasmultipleaffiliationsfalse}%
	\fullexpandarg%
	\gdef\@affiliation{#1}%
}
% Macro to output the affiliations with the proper layout
\newcommand{\affiliationname}{%
	\begingroup%
	\parindent=0pt%
	\parskip=0pt%
	% Reset the counter of institutions
	\setcounter{ingedoc@institution}{1}%
	% Override the \and macro to increment the institution
	% counter and add a new line
	\renewcommand{\and}{%
		\unskip\global\stepcounter{ingedoc@institution}%
		\par\noindent\ignorespaces%
		\@makeaffiliationlabel{\theingedoc@institution}%
	}%
	% Ouput the affiliation
	\ignorespaces\noindent\ifingedoc@hasmultipleaffiliations\@makeaffiliationlabel{\theingedoc@institution}\ignorespaces\fi\@affiliation\unskip%
	\endgroup%
}

%-----------------------------------
% Macro to add authors
%-----------------------------------
\gdef\@author{}
\renewcommand{\author}[2][]{%
	\gdef\@author{#2}%
}

%-----------------------------------
% Paper title
%-----------------------------------
% Macro to output the footnote marks
% when they are used in the author's list.
\def\@fnsymbol#1{%
	\ifcase#1\or%
		\dagger\or%
		\ddagger\or%
		\dagger\dagger\or%
		\ddagger\ddagger\or%
		\star\or%
		{\star\star}\or%
		{\star\star\star}\or%
		\mathchar "278\or%
		\mathchar "27B\orM
		\|%
	\else\@ctrerr%
	\fi\relax}

% Margin between the top of the page and the first
% line of the title
\newlength{\ingedoc@titlemargin}
\setlength{\ingedoc@titlemargin}{39mm}
\addtolength{\ingedoc@titlemargin}{-16pt}
% Box to save the authors and the affiliation, for blinding
\newsavebox{\ingedoc@blinded@header}
% Temp variables
\newlength{\ingedoc@length@reserveda}
% Macro to output the title, the author, and
% the affiliation with the proper layout
\renewcommand{\maketitle}{%
	\begin{flushright}%
		\newcommand{\email}[1]{\footnote{##1}}
		\newcommand{\inst}[1]{\unskip\@makeaffiliationlabel{##1}}
		\renewcommand{\and}{\unskip,\ignorespaces\ }
		\renewcommand\thefootnote{\ensuremath{\@fnsymbol\c@footnote}}%
		\mbox{}\vspace{\ingedoc@titlemargin}\\[-1ex]%
		\textthesansbold{\FontsizeSixteen\@title}\\[3mm]%
		\ifingedoc@blind%
			\setlength{\ingedoc@length@reserveda}{\linewidth}%
			\savebox{\ingedoc@blinded@header}{\parbox{\ingedoc@length@reserveda}{\begin{flushright}
				\textthesansbold{\FontsizeTwelve\textcolor{black80}{\@author}}\\[2mm]%
				\textthesansbold{\FontsizeNine\textcolor{black80}{\affiliationname}}\\[3mm]%
			\end{flushright}}}%
			\settoheight{\ingedoc@length@reserveda}{\usebox{\ingedoc@blinded@header}}%
			\fbox{\parbox{\linewidth}{%
			\vspace*{.5\ingedoc@length@reserveda}%
			\begin{flushright}\textthesansbold{\FontsizeTwelve Blind Review}\end{flushright}
			\vspace*{.5\ingedoc@length@reserveda}}}%
		\else%
			\begin{flushright}
				\textthesansbold{\FontsizeTwelve\textcolor{black80}{\@author}}\\[2mm]%
				\textthesansbold{\FontsizeNine\textcolor{black80}{\affiliationname}}\\[3mm]%
			\end{flushright}
		\fi%
	\end{flushright}%
	\setcounter{footnote}{0}%
	\vspace{.5cm}%
}

%-----------------------------------
% Thanks
%-----------------------------------
% Define the name of the "thanks" section
\ifingedoc@english
  \gdef\thanksname{Acknowledgements}
\else
  \gdef\thanksname{Remerciements}
\fi
% Macro to save the thanks.
\gdef\@thanks{}
\renewcommand{\thanks}[1]{%
	\gdef\@thanks{#1}%
}

%-----------------------------------
% Footnotes
%-----------------------------------
\renewcommand\footnoterule{\noindent\rule{25mm}{.25pt}}
\renewcommand{\@makefntext}[1]{%
	{\textthesanslight{\FontsizeEight\thefootnote\hspace{6mm}#1}}
}

%-----------------------------------
% Floats
%-----------------------------------

% Bold face in floats
\ifingedoc@utbmfont
	\global\let\ingedoc@float@text@bf\textthesansbold
	\global\let\ingedoc@float@text@plain\TheSansPlain
\else
	\global\let\ingedoc@float@text@bf\textbf
	\global\let\ingedoc@float@text@plain\relax
\fi

% Macro for formating the tabular's titles.
\newcommand{\tabletitle}[1]{%
	\mbox{}\hfill{\footnotesize{\ingedoc@float@text@bf{#1}}}\hfill\mbox{}%
}

% Redefine the figure environment
\let\ingedoc@origin@figure\figure
\let\ingedoc@origin@endfigure\endfigure
\renewenvironment{figure}[1][ht]{%
	\ingedoc@origin@figure[#1]\begin{center}%
	\vspace{1ex}%
}{%
	\end{center}\ingedoc@origin@endfigure%
}%

% Margins in the floats
\setlength{\textfloatsep}{2mm}
\setlength{\floatsep}{2mm}
\setlength{\intextsep}{0mm}

% Layout of the captions of the floats (figures, tables...)
\renewcommand{\@makecaption}[2]{%
	\vspace{-1ex}%
	\begin{center}%
		\ingedoc@float@text@bf{\FontsizeNine {#1}.~{#2}}%
	\end{center}%
}

% Redefine the table environment
\let\ingedoc@origin@table\table
\let\ingedoc@origin@endtable\endtable
\renewenvironment{table}[1][ht]{%
	\ingedoc@origin@table[#1]\begin{center}%
	\vspace{2ex}\footnotesize\ingedoc@float@text@plain%
}{%
	\end{center}\ingedoc@origin@endtable%
}%

%-----------------------------------
% Itemize, description and enumerates
%-----------------------------------
\setitemize{label={--},topsep=0pt,leftmargin=3.5mm,parsep=0pt,partopsep=0pt,itemsep=0pt,listparindent=0pt}
\setitemize[1]{leftmargin=9mm}

\setenumerate{topsep=0pt,leftmargin=6mm,parsep=0pt,partopsep=0pt,itemsep=0pt}
\setenumerate[1]{leftmargin=10mm,topsep=0pt,parsep=0pt,partopsep=0pt,itemsep=0pt}

\setdescription{topsep=0pt,parsep=0pt,partopsep=0pt,itemsep=0pt}

%-----------------------------------
% Abstract
%-----------------------------------
\ifingedoc@english%
\gdef\abstractname{Abstract}
\else
\gdef\abstractname{R\'esum\'e}
\fi
% TeX condition that indicates if an abstract was defined
\newif\ifingedoc@hasabstract
\ingedoc@hasabstractfalse
% The save box is here to store the abstract text in memory
\newsavebox{\ingedoc@abstract@box}
% The environment to define an abstract.
% The text of the abstract is put inside the save box.
\renewenvironment{abstract}{%
	\global\ingedoc@hasabstracttrue%
	\lrbox{\ingedoc@abstract@box}\begin{minipage}{.9\textwidth}%
	\normalfont\normalsize%
}{%
	\end{minipage}%
	\endlrbox%
}
% Macro to output the abstract and the keywords with the
% proper layout
\newcommand{\makeabstract}{%
	\ifingedoc@hasabstract%
		\begin{center}%
		\begin{minipage}{.9\textwidth}%
		\normalfont\normalsize%
		\textthesansbold{\ifingedoc@english\abstractname:\else\abstractname~:\fi} \\[2mm]%
		\usebox{\ingedoc@abstract@box} \\[2mm]%
		\ifthenelse{\equal{{\@keywords}}{{}}}{}{%
			\normalfont\normalsize%
			\textthesansbold{\ifingedoc@english\keywordsname: \else\keywordsname~: \fi}\\%
			\noindent\@keywords%
		}%
		\end{minipage}%
		\end{center}\vspace{.5cm}%
	\fi%
}

%-----------------------------------
% Keywords
%-----------------------------------
% Definition of the name of the "keyword" section
\ifingedoc@english
  \gdef\keywordsname{Keywords}
\else
  \gdef\keywordsname{Mots-cl\'es}
\fi
% Macro to save the keywords
\newcommand{\keywords}[1]{%
	\gdef\@keywords{#1}%
}

%-----------------------------------
% Bibliography
%-----------------------------------
\ifingedoc@english%
\gdef\refname{References}
\else
\gdef\refname{R\'ef\'erences}
\fi

% Default style is plain
\bibliographystyle{alpha}

% Redefine the bibliography macro to be sure that
% the bibliography section will be put at the end
% of the paper.
\let\ingedoc@bibliography\relax
\let\ingedoc@origin@bibliography\bibliography
\renewcommand{\bibliography}[1]{%
	\gdef\ingedoc@bibliography{\ingedoc@origin@bibliography{#1}}%
}

% Change the font of the text of the bibliography entries
\let\ingedoc@origin@bibitem\bibitem
\renewcommand{\bibitem}[2][]{%
	\ingedoc@origin@bibitem{#2}\TheSansLight\FontsizeEight%
}

% Change the font of the numbers of the bibliography entries
\let\ingedoc@origin@biblabel\@biblabel
\renewcommand{\@biblabel}[1]{%
	\textthesanslight{\FontsizeEight\ingedoc@origin@biblabel{#1}}%
}

% Override the bibliography environment to provide the
% correct title for the bibliography section
\let\ingedoc@origin@thebibliography\thebibliography
\let\ingedoc@origin@endthebibliography\endthebibliography
\renewenvironment{thebibliography}[1]{%
	\begingroup%
	\let\ingedoc@origin@refname\refname%
	\renewcommand{\refname}{\FontsizeEight\textthesansbold{\ingedoc@origin@refname}}%
	\ingedoc@origin@thebibliography{1}%
}{%
	\ingedoc@origin@endthebibliography%
	\endgroup%
}

%-----------------------------------
% Document Level
%-----------------------------------
\AtBeginDocument{%
	% Put the title
	\maketitle%
	% Put the abstract
	\makeabstract
	% Avoid usage of macros in the document
	\gdef\maketitle{}%
	\renewenvironment{abstract}{\@latex@error{You must put the 'abstract' environment into the preamble of your document}}{}%
	\renewcommand{\keywords}{\@latex@error{You must put the '\keywords' macro into the preamble of your document}}%
	% General configuration of the document.
	\sloppy%
	\pagestyle{empty}%
	\thispagestyle{empty}%
}

\AtEndDocument{
	% Add the "Reference" section if the \bibliography macro was called
	\ingedoc@bibliography%
	% Add the "thanks" section if specified in the document
	\ifthenelse{\equal{{\@thanks}}{{}}}{}{%
		\section*{\FontsizeEight\textthesansbold\thanksname}%
		\TheSansLight\FontsizeEight\@thanks%
	}%
}

%-----------------------------------
% Automatic Lettrine
%-----------------------------------
% Test if the "lettrine" option was given to the document class
\ifingedoc@lettrine

% The following macro put its parameter into a lettrine with the
% proper layout
\gdef\ingedoc@MakeLettrine@lettrine#1{%
	\lettrine[findent=.5mm,nindent=0pt,ante={\hspace{5mm}}]{\uppercase{#1}}{}%
}

% Macro that contains the string "the letter"
\gdef\ingedoc@MakeLettrine@letterstr{\string t\string h\string e\space\string l\string e\string t\string t\string e\string r}

% Macro that contains the string "the character"
\gdef\ingedoc@MakeLettrine@characterstr{\string t\string h\string e\space\string c\string h\string a\string r\string a\string c\string t\string e\string r}

% Macros to search for the first letter in its second parameter
% and put it in a lettrine.
% First parameter: are the macros to ignore and put back before
%                  the lettrine. The value of this parameter will
%                  evolve during the recursive calls.
% Second parameter: TeX give the token following the macro in
%                   this parameter (because the macros is always
%                   invoked with only one explicit parameter).
\newcommand{\ingedoc@MakeLettrine}[2]{%
	% Detect the meaning of the second parameter.
	\edef\ingedoc@reserveda{\meaning#2}%
	% Test if the meaning string contains "the letter"
	\edef\ingedoc@reservedb{\noexpand\in@{\ingedoc@MakeLettrine@letterstr}{\ingedoc@reserveda}}%
	\ingedoc@reservedb%
	\ifin@%
		% The meaning indicates that the second parameter
		% is a letter. It may be put in the lettrine.
		% The macro \ingedoc@reserveda is defined to avoid
		% to consume the tokens written in this recursive
		% macro. This temp macro is invoked at the end of
		% this recursive macro. In this way it will consume
		% the token that are available in the document core.
		\gdef\ingedoc@reserveda{#1\ingedoc@MakeLettrine@lettrine{#2}}%
	\else%
		% Test if the meaning string contains "the character"
		\edef\ingedoc@reservedb{\noexpand\in@{\ingedoc@MakeLettrine@characterstr}{\ingedoc@reserveda}}%
		\ingedoc@reservedb%
		\ifin@%
			% The meaning indicates that the second parameter
			% is a character. It may be put in the lettrine.
			% The macro \ingedoc@reserveda is defined to avoid
			% to consume the tokens written in this recursive
			% macro. This temp macro is invoked at the end of
			% this recursive macro. In this way it will consume
			% the token that are available in the document core.
			\gdef\ingedoc@reserveda{#1\ingedoc@MakeLettrine@lettrine{#2}}%
		\else%
			% The meaning indicates that the second parameter
			% is not a letter nor a character.
			% It may be put back before the lettrine without
			% change.
			% The macro \ingedoc@reserveda is defined to avoid
			% to consume the tokens written in this recursive
			% macro. This temp macro is invoked at the end of
			% this recursive macro. In this way it will consume
			% the token that are available in the document core.
			\gdef\ingedoc@reserveda{\ingedoc@MakeLettrine{#1#2}}%
		\fi%
	\fi%
	\ingedoc@reserveda%
}
% Override \begin{document}\end{document} for enabling the
% automatic lettrine
\let\ingedoc@document\document
\let\ingedoc@enddocument\enddocument
\renewenvironment{document}{%
	\ingedoc@document\ignorespaces\ingedoc@MakeLettrine{}%
}{%
	\ingedoc@enddocument%
}

\fi

\endinput
