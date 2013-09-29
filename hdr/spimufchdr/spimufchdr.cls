% Document class for the HDR of the SPIM doctoral school (UFC variante)
%
% Copyright (c) 2013 Stephane GALLAND <galland@arakhne.org>
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
\ProvidesClass{spimufchdr}[2013/09/29]

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
\@ifclasslater{UPMVERSION}{2013/09/29}{}{\@latex@error{You must install a version of tex-upmethodology greater or equal to 20130929}\@eha}

%%--------------------
%% Utility functions
\newcommand{\eme}{\textsup{\`eme}}
\newcommand{\parbreak}{\par\vspace{\parsep}\mbox{}}

%%--------------------
%% Force the name of the bibliographie for French
\AtBeginDocument{
	\ifthenelse{\equal{\edspimhdrclasslanguage}{french}}{%
		\renewcommand{\refname}{Bibliographie}%
		\renewcommand{\listtablename}{Liste des tables}%
		\newcommand{\publicationlistname}{Liste des publications}%
	}{%
		\newcommand{\publicationlistname}{List of publications}%
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
\newcommand{\hdrpublicationlist}{%
	\chapter{\publicationlistname}\label{chap:hdrpublicationlist}%
	\global\let\oldthebibliography\thebibliography%
	\renewcommand{\thebibliography}[2][]{%
		\global\let\oldchapter\chapter%
		\renewcommand{\chapter}[3][]{\section{####3}}%
		\oldthebibliography{##1}%
		\global\let\chapter\oldchapter%
	}%
	\hdr@publicationlist%
	\global\let\thebibliography\oldthebibliography%
}
\newif\ifhdr@hasmissednumberof
\hdr@hasmissednumberoffalse
\newcommand{\declarebiblio}[4][hdr]{%
	\expandafter\newcites{#2}{#3}%
	\csname bibliographystyle#2\endcsname{#1}%
	\protected@xdef\hdr@publicationlist{%
		\hdr@publicationlist%
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
%% Output a project description.
%% {title}{budget}{start}{end}{partners}{goals}{roles}
\newcommand{\projectdesc}[7]{
	\textbf{#1}, #2\euro\ (#3--#4)
	\begin{itemize}
	\item\textit{Partenaires:} #5.
	\item\textit{Objectifs:} #6.
	\item\textit{Rôle dans le projet:} #7.
	\end{itemize}
}

%%--------------------
%% Output a project description.
%% {title}{budget}{start}{end}{partners}{goals}{roles}
\newcommand{\projectdescstar}[7]{
	\textbf{#1}, #2\euro\ (#3--#4)
	\begin{itemize}
	\item\textit{Partenaire:} #5.
	\item\textit{Objectifs:} #6.
	\item\textit{Mon rôle dans le projet:} #7.
	\end{itemize}
}

%%--------------------
%% Output a project description.
%% {title}{start}{end}{funder}{partners}{goals}{roles}
\newcommand{\projectdescnat}[7]{
	\textbf{#1}, (#2--#3)
	\begin{itemize}
	\item\textit{Financement:} #4.
	\item\textit{Partenaires:} #5.
	\item\textit{Objectifs:} #6.
	\item\textit{Mon rôle dans le projet:} #7.
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
