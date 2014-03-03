% Document class for the HDR of the SPIM doctoral school (UFC variante)
%
% Copyright (c) 2013-14 Stephane GALLAND <galland@arakhne.org>
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

%%--------------------
%% Declare the LaTeX class
\NeedsTeXFormat{LaTeX2e}[1995/12/01]
\ProvidesClass{spimufchdr}[2014/03/03]

%%--------------------
%% Class options
\gdef\edspimhdrclasslanguage{french}
\gdef\edspim@hdr@class@options{book,nopubpage,nodocumentinfo,frontmatter}

\DeclareOption{english}{%
	\gdef\edspimhdrclasslanguage{english}%
}
\DeclareOption{french}{%
	\gdef\edspimhdrclasslanguage{french}%
}

\DeclareOption*{%
	\xdef\edspim@hdr@class@options{\edspim@hdr@class@options,\CurrentOption}%
	}
\ProcessOptions*\relax

%%--------------------
%% Load the document style and packages
\expandafter\LoadClass[\edspimhdrclasslanguage,\edspim@hdr@class@options]{upmethodology-document}
\RequirePackage{multibib}
\RequirePackage{eurosym}

%%--------------------
%% Check for the correct version of tex-upmethodology
\@ifclasslater{UPMVERSION}{2014/03/02}{}{\@latex@error{You must install a version of tex-upmethodology greater or equal to 20140303}\@eha}

%\declarehdr[subtitle]{title}{defense date}
\newcommand{\declarehdr}[3][] {
	\declaredocument{#2}{#1}{HDR-XXXX}%
	\Set{defensedate}{#3}%
	\initialversion{\makedate{11}{04}{2006}}{HDR}{\upmpublic}%
}

%\addjury[email]{firstname}{lastname}{type}{position}
\makeatletter
\newcommand{\edspim@hdr@protectnl}[1]{%
	\begingroup%
		\let\\\newline%
		\nohyphens{\Get{jurystyle}#1}%
	\endgroup%
}
\gdef\edspim@hdr@jurylist{}
\global\let\thejurytab\relax
\newcommand{\addjury}[5][]{%
	\global\protected@edef\edspim@hdr@jurylist{\edspim@hdr@jurylist\protect\protect\Get{jurystyle}\protect\protect\upmmakename{#2}{#3}{~} & \protect\edspim@hdr@protectnl{#4} & \protect\edspim@hdr@protectnl{#5} \protect\\}%
	\global\protected@edef\thejurytab{\protect\noindent\protect\begin{tabularx}{\Get{jurytabwidth}}{@{}llX@{}}\edspim@hdr@jurylist\protect\end{tabularx}}%
}

%\hdrpreparedin{university name}
\newif\ifhdrhaspreparedin
\hdrhaspreparedinfalse
\newif\ifhdrhaspreparedinmulti
\hdrhaspreparedinmultifalse
\gdef\thehdrpreparedin{}
\newcommand{\hdrpreparedin}[1]{%
	\ifhdrhaspreparedin%
		\global\hdrhaspreparedinmultitrue%
		\global\protected@edef\thehdrpreparedin{\thehdrpreparedin,\protect\\\protect{#1}}%
	\else%
		\global\hdrhaspreparedintrue%
		\global\protected@edef\thehdrpreparedin{\thehdrpreparedin\protect{#1}}%
	\fi%
}

%\addpartner[picture_options]{logo_picture}
\newif\ifpartnerlist
\partnerlistfalse
\gdef\thepartnerlist{}
\newcommand{\addpartner}[2][height=1cm]{%
	\ifpartnerlist%
		\protected@xdef\thepartnerlist{\thepartnerlist\protect\hfill\protect\includegraphics[#1]{#2}}%
	\else%
		\global\partnerlisttrue%
		\protected@xdef\thepartnerlist{\thepartnerlist\protect\includegraphics[height=1cm]{#2}}%
	\fi%
}

% Change the French labels
\let\edspim@hdr@tableofcontents\tableofcontents
\renewcommand{\tableofcontents}{%
	\ifthenelse{\equal{french}{\upmcurrentlang}}{\renewcommand{\contentsname}{Sommaire}}{}%
	\edspim@hdr@tableofcontents%
}

% Defense message
\Set{defensemessage}{Soutenue publiquement le \Get{defensedate} devant le Jury compos\'e de~:}

% \hdrabstract [lang]{text}
\newif\ifhdrmainabstract
\hdrmainabstractfalse
\newif\ifhdrminorabstract
\hdrminorabstractfalse
\gdef\hdrmainabstract{}
\gdef\hdrminorabstract{}
\gdef\hdrmainabstracttitle{R\'esum\'e~:}
\gdef\hdrminorabstracttitle{Abstract:}
\newcommand{\hdrabstract}[2][\upmcurrentlang]{%
	\ifthenelse{\equal{\upmcurrentlang}{#1}}{%
		\global\hdrmainabstracttrue%
		\gdef\hdrmainabstract{#2}%
		\setdocabstract{#2}%
		\ifthenelse{\equal{english}{#1}}{%
			\gdef\hdrmainabstracttitle{Abstract:}
		}{%
			\gdef\hdrmainabstracttitle{R\'esum\'e~:}
		}%
	}{%
		\global\hdrminorabstracttrue%
		\gdef\hdrminorabstract{#2}%
		\ifthenelse{\equal{english}{#1}}{%
			\gdef\hdrminorabstracttitle{Abstract:}
		}{%
			\gdef\hdrminorabstracttitle{R\'esum\'e~:}
		}%
	}%
}

% \hdrkeywords [lang]{keywords}
\newif\ifhdrmainkeywords
\hdrmainkeywordsfalse
\newif\ifhdrminorkeywords
\hdrminorkeywordsfalse
\gdef\hdrmainkeywords{}
\gdef\hdrminorkeywords{}
\gdef\hdrmainkeywordstitle{}
\gdef\hdrminorkeywordstitle{}
\newcommand{\hdrkeywords}[2][\upmcurrentlang]{%
	\ifthenelse{\equal{\upmcurrentlang}{#1}}{%
		\global\hdrmainkeywordstrue%
		\gdef\hdrmainkeywords{#2}%
		\ifthenelse{\equal{english}{#1}}{%
			\gdef\hdrmainkeywordstitle{Keywords:}
		}{%
			\gdef\hdrmainkeywordstitle{Mots-cl\'es~:}
		}%
	}{%
		\global\hdrminorkeywordstrue%
		\gdef\hdrminorkeywords{#2}%
		\ifthenelse{\equal{english}{#1}}{%
			\gdef\hdrminorkeywordstitle{Keywords:}
		}{%
			\gdef\hdrminorkeywordstitle{Mots-cl\'es~:}
		}%
	}%
}

%%--------------------
%% Utility functions
\newcommand{\eme}{\textsup{\`eme}}
\newcommand{\parbreak}{\par\vspace{\parsep}\mbox{}}

%%--------------------
%% Force the name of the bibliography for French
\AtBeginDocument{
	\ifthenelse{\equal{\edspimhdrclasslanguage}{french}}{%
		\renewcommand{\refname}{Bibliographie}%
		\renewcommand{\listtablename}{Liste des tables}%
		\newcommand{\publicationlistname}{Liste des publications de l'auteur}%
	}{%
		\newcommand{\publicationlistname}{List of the publications of the author}%
	}
}

%%--------------------
%% Underlining the author's name in bibliography
\newcommand{\hdrunderlineauthor}[2]{%
	\ifdocumentauthor{#1}{\underline{#2}}{#2}%
}

%%--------------------
%% Multibib
\gdef\hdr@publicationlist{}
\newcommand{\hdr@declarebiblio@header@filter}[1]{#1}
\newcommand{\hdrpublicationlist}[1][\publicationlistname]{%
	\chapter[#1]{\publicationlistname}\label{chap:hdrpublicationlist}%
	\global\let\oldthebibliography\thebibliography%
	\renewcommand{\thebibliography}[2][]{%
		\global\let\oldchapter\chapter%
		\global\let\oldmkboth\@mkboth%
		\global\renewcommand{\chapter}[2]{%
			\sectionfull{####2}{\expandafter\csname @refname@header@label@\hdr@declarebiblio@current\endcsname}%
			\global\renewcommand{\@mkboth}[2]{}%
		}%
		\oldthebibliography{##1}%
		\global\let\@mkboth\oldmkboth%
		\global\let\chapter\oldchapter%
	}%
	\hdr@publicationlist%
	\global\let\thebibliography\oldthebibliography%
}
\newcommand{\hdr@declarebiblio@setcurrent}[1]{%
	\gdef\hdr@declarebiblio@current{#1}%
}
\newif\ifhdr@hasmissednumberof
\hdr@hasmissednumberoffalse
\define@key{upmhdrdeclarebiblio}{style}{%
	\gdef\hdr@declarebiblio@style{#1}%
}
\define@key{upmhdrdeclarebiblio}{header}{%
	\gdef\hdr@declarebiblio@header{#1}%
}
\newcommand{\declarebiblio}[4][style=hdr]{%
	% Default option values
	\gdef\hdr@declarebiblio@style{hdr}%
	\global\let\hdr@declarebiblio@header\relax%
	% Parse options
	\upm@setkeys{upmhdrdeclarebiblio}{style}{#1}%
	% Declare cites
	\expandafter\newcites{#2}{#3}%
	\ifx\hdr@declarebiblio@header\relax
		\expandafter\gdef\csname @refname@header@label@#2\endcsname{\csname refname#2\endcsname}%
	\else%
		\expandafter\protected@xdef\csname @refname@header@label@#2\endcsname{\hdr@declarebiblio@header}%
	\fi%
	\expandafter\csname bibliographystyle#2\endcsname{\hdr@declarebiblio@style}%
	\expandafter\xdef\csname upm@declarebiblio@headertitle@#2\endcsname{\hdr@declarebiblio@header}%
	\protected@xdef\hdr@publicationlist{%
		\hdr@publicationlist%
		\protect\hdr@declarebiblio@setcurrent{#2}%
		\protect\csname bibliography#2\endcsname{#4}%
	}%
	\expandafter\newcounter{hdr@bibliotype@numberof@#2}%
	\expandafter\setcounter{hdr@bibliotype@numberof@#2}{0}%
	\expandafter\ifx\csname numberof#2\endcsname\relax%
		\global\@namedef{numberof#2}{\{\string?\}}%
		\global\hdr@hasmissednumberoftrue%
	\fi%
	\global\@namedef{addbiblio#2}{%
		\expandafter\addtocounter{hdr@bibliotype@numberof@#2}{1}%
		\@nameuse{nocite#2}%
	}%
	\AtEndDocument{%
		\expandafter\write\csname @auxout#2\endcsname{\string\gdef\string\numberof#2{\expandafter\arabic{hdr@bibliotype@numberof@#2}\xspace}}%
	}%
}
\AtEndDocument{%
	\ifhdr@hasmissednumberof%
		\@latex@warning@no@line{There were undefined references}%
	\fi%
}

%%--------------------
%% BibEntry
\newif\ifhdr@hasmissedbibentry
\hdr@hasmissedbibentryfalse
\newcommand*{\hdr@bibitem@c}[2]{{%
	\let\protect\@unexpandable@protect%
	\expandafter\gdef\csname @hdr@bibentry@#1\endcsname{#2\relax\relax}%
	\@bsphack%
	\immediate\write\@auxout{\string\newbibentry{#1}{\unexpanded{#2}}}%
	\@esphack%
}}
\newcommand*{\hdr@bibitem@b}[2]{%
	\bibitem{#1}{#2}\hdr@bibitem@c{#1}{#2}%
}
\newcommand*{\hdr@bibitem@a}[3][]{%
	\bibitem[#1]{#2}{#3}\hdr@bibitem@c{#2}{#3}%
}
\def\hdrbibitem{\@ifnextchar[\hdr@bibitem@a\hdr@bibitem@b}
\newcommand{\newbibentry}[2]{%
	\global\@namedef{@hdr@bibentry@#1}{#2}%
}
\newcommand{\bibentry}[1]{%
	\@ifundefined{@hdr@bibentry@#1}{\{\string?\}%
		\@latex@warning{Undefined bibliography entry '#1'.}%
		\global\hdr@hasmissedbibentrytrue%
	}{\@nameuse{@hdr@bibentry@#1}}%
}
\AtEndDocument{%
	\ifhdr@hasmissedbibentry%
		\@latex@warning@no@line{There were undefined references}%
	\fi%
}


%%--------------------
%% Output a project description.
%% {title}{budget}{start}{end}{partners}{goals}{roles}
\newcommand{\projectdesc}[7]{
	\textbf{#1}, #2\euro\ (#3--#4)
	\begin{itemize}
	\item\textit{\ifthenelse{\equal{\edspimhdrclasslanguage}{french}}{Partenaires :}{Partners:}} #5.
	\item\textit{\ifthenelse{\equal{\edspimhdrclasslanguage}{french}}{Objectifs :}{Goals:}} #6.
	\item\textit{\ifthenelse{\equal{\edspimhdrclasslanguage}{french}}{R\^ole dans le projet :}{Role in the project:}} #7.
	\end{itemize}
}

%%--------------------
%% Output a project description.
%% {title}{budget}{start}{end}{partners}{goals}{roles}
\newcommand{\projectdescstar}[7]{
	\textbf{#1}, #2\euro\ (#3--#4)
	\begin{itemize}
	\item\textit{\ifthenelse{\equal{\edspimhdrclasslanguage}{french}}{Partenaire :}{Partner:}} #5.
	\item\textit{\ifthenelse{\equal{\edspimhdrclasslanguage}{french}}{Objectifs :}{Goals:}} #6.
	\item\textit{\ifthenelse{\equal{\edspimhdrclasslanguage}{french}}{Mon r\^ole dans le projet :}{My role in the project:}} #7.
	\end{itemize}
}

%%--------------------
%% Output a project description.
%% {title}{start}{end}{funder}{partners}{goals}{roles}
\newcommand{\projectdescnat}[7]{
	\textbf{#1}, (#2--#3)
	\begin{itemize}
	\item\textit{\ifthenelse{\equal{\edspimhdrclasslanguage}{french}}{Financement :}{Funding:}} #4.
	\item\textit{\ifthenelse{\equal{\edspimhdrclasslanguage}{french}}{Partenaires :}{Partners:}} #5.
	\item\textit{\ifthenelse{\equal{\edspimhdrclasslanguage}{french}}{Objectifs :}{Goals:}} #6.
	\item\textit{\ifthenelse{\equal{\edspimhdrclasslanguage}{french}}{Mon r\^ole dans le projet :}{My role in the project:}} #7.
	\end{itemize}
}

%%--------------------
%% Default toc depth is: chapters, sections and subsections
\setcounter{tocdepth}{2}

%%--------------------
%% Use the style dedicated to PhD thesis from SPIM-UTBM
\UseExtension{spimufchdr}

%%--------------------
%% Style for boxed definitions
\colorlet{definitionbackground}{backtableheader!60}
\colorlet{definitionheaderforeground}{fronttableheader}
\colorlet{definitionborder}{gray!60}
\colorlet{definitiontextforeground}{black}

\endinput
