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
\ProvidesClass{hdrapplication}[2014/04/04]

%%--------------------
%% Class options
\gdef\edspim@hdr@class@options{10pt,article,nopubpage,nodocumentinfo}

\DeclareOption*{%
	\xdef\edspim@hdr@class@options{\edspim@hdr@class@options,\CurrentOption}%
	}
\ProcessOptions*\relax

%%--------------------
%% Load the document style
\expandafter\LoadClass[\edspim@hdr@class@options]{upmethodology-document}
\RequirePackage{multibib}
\RequirePackage{eurosym}
\RequirePackage{fancyhdr}

%%--------------------
%% Force the names for French
\AtBeginDocument{
	\ifthenelse{\equal{\upmcurrentlang}{french}}{%
		\renewcommand{\refname}{Bibliographie}%
		\renewcommand{\listtablename}{Liste des tables}%
	}{}
}

%%--------------------
%% Section with a page break before.
\newcommand{\Section}[1]{\pagebreak\section{#1}}


\gdef\hdrapplication@projectdesc@label@funding{Financement\,:}
\gdef\hdrapplication@projectdesc@label@partners{Partenaires\,:}
\gdef\hdrapplication@projectdesc@label@partner{Partenaire\,:}
\gdef\hdrapplication@projectdesc@label@goals{Objectifs\,:}
\gdef\hdrapplication@projectdesc@label@myrole{Mon r\^ole dans le projet\,:}

%%--------------------
%% Output a project description.
%% {title}{budget}{start}{end}{partners}{goals}{roles}
\newcommand{\projectdesc}[7]{
	\textbf{#1}, #2\euro\ (#3--#4)
	\begin{itemize}
	\item\textit{\hdrapplication@projectdesc@label@partners} #5.
	\item\textit{\hdrapplication@projectdesc@label@goals} #6.
	\item\textit{\hdrapplication@projectdesc@label@myrole} #7.
	\end{itemize}
}

%%--------------------
%% Output a project description.
%% {title}{budget}{start}{end}{partners}{goals}{roles}
\newcommand{\projectdescstar}[7]{
	\textbf{#1}, #2\euro\ (#3--#4)
	\begin{itemize}
	\item\textit{\hdrapplication@projectdesc@label@partner} #5.
	\item\textit{\hdrapplication@projectdesc@label@goals} #6.
	\item\textit{\hdrapplication@projectdesc@label@myrole} #7.
	\end{itemize}
}

%%--------------------
%% Output a project description.
%% {title}{start}{end}{funder}{partners}{goals}{roles}
\newcommand{\projectdescnat}[7]{
	\textbf{#1}, (#2--#3)
	\begin{itemize}
	\item\textit{\hdrapplication@projectdesc@label@funding} #4.
	\item\textit{\hdrapplication@projectdesc@label@partners} #5.
	\item\textit{\hdrapplication@projectdesc@label@goals} #6.
	\item\textit{\hdrapplication@projectdesc@label@myrole} #7.
	\end{itemize}
}

%%--------------------
%% Include a scanned letter inside a frame box.
%% {path}
\newcommand{\includescannedletter}[1]{%
	\begin{center}%
		\fbox{\includegraphics[width=\linewidth]{#1}}%
	\end{center}%
	\pagebreak%
}

%%--------------------
%% Include a scanned document in the document.
%% {path}
\newcommand{\includescanneddocument}[1]{%
	\begin{center}%
		\includegraphics[width=\linewidth]{#1}%
	\end{center}%
	\pagebreak%
}

%%--------------------
%% Multibib definitions



\ifthenelse{\equal{\upmcurrentlang}{english}}{%
	\newcommand{\hdrapplication@cite@prelabel}{Publications of the PhD Thesis}%
	\newcommand{\hdrapplication@cite@postlabel}{Publications after the PhD Thesis}%
	\newcommand{\hdrapplication@cite@label@ICB}{International Conferences with Reading Committee}
	\newcommand{\hdrapplication@cite@label@NCB}{National Conferences with Reading Committee}
	\newcommand{\hdrapplication@cite@label@JA}{International Journals with Reading Committee}
	\newcommand{\hdrapplication@cite@label@CA}{Chapters of Book}
	\newcommand{\hdrapplication@cite@label@ICALN}{International Conferences with Reading Committee and published in Lecture Notes}
	\newcommand{\hdrapplication@cite@label@ICA}{International Conferences with Reading Committee}
	\newcommand{\hdrapplication@cite@label@NCA}{National Conferences with Reading Committee}
	\newcommand{\hdrapplication@cite@label@NCAW}{National Conferences without Reading Committee}
	\newcommand{\hdrapplication@cite@label@OA}{Other Publications}
}{%
	\newcommand{\hdrapplication@cite@prelabel}{Publications de th\`ese}
	\newcommand{\hdrapplication@cite@postlabel}{Publications post th\`ese}
	\newcommand{\hdrapplication@cite@label@ICB}{Conf\'erences internationales avec comit\'es de lecture}
	\newcommand{\hdrapplication@cite@label@NCB}{Conf\'erences nationales avec comit\'es de lecture}
	\newcommand{\hdrapplication@cite@label@JA}{Revues internationales avec comit\'es de lecture}
	\newcommand{\hdrapplication@cite@label@CA}{Chapitres de livres}
	\newcommand{\hdrapplication@cite@label@ICALN}{Conf\'erences internationales avec comit\'es de lecture et publi\'ees dans Lecture Notes}
	\newcommand{\hdrapplication@cite@label@ICA}{Conf\'erences internationales avec comit\'es de lecture}
	\newcommand{\hdrapplication@cite@label@NCA}{Conf\'erences nationales sans comit\'e de lecture}
	\newcommand{\hdrapplication@cite@label@NCAW}{Conf\'erences nationales sans comit\'e de lecture}
	\newcommand{\hdrapplication@cite@label@OA}{Autres publications}
}

\let\oldthebibliography\thebibliography
\gdef\thebibliography#1{%
	\global\let\oldsection\section%
	\gdef\section##1##2{\subsection{##2}}%
	\oldthebibliography{#1}%
	\global\let\section\oldsection%
}

\gdef\hdrprepublicationlist{}
\gdef\hdrpostpublicationlist{}
\newcommand{\declarebibliopre}[4][hdrapplication]{%
	\ifthenelse{\equal{a#3}{a}}{%
		\expandafter\newcites{#2}{\csname hdrapplication@cite@label@#2\endcsname}%
	}{%
		\expandafter\newcites{#2}{#3}%
	}%
	\csname bibliographystyle#2\endcsname{#1}%
	\protected@xdef\hdrprepublicationlist{%
		\hdrprepublicationlist%
		\protect\csname bibliography#2\endcsname{#4}%
	}%
}
\newcommand{\declarebibliopost}[4][hdrapplication]{%
	\ifthenelse{\equal{a#3}{a}}{%
		\expandafter\newcites{#2}{\@nameuse{hdrapplication@cite@label@#2}}%
	}{%
		\expandafter\newcites{#2}{#3}%
	}%
	\csname bibliographystyle#2\endcsname{#1}%
	\protected@xdef\hdrpostpublicationlist{%
		\hdrpostpublicationlist%
		\protect\csname bibliography#2\endcsname{#4}%
	}%
}

\newcommand{\hdrpublicationlist}{%
	\section{\hdrapplication@cite@prelabel}%
	\hdrprepublicationlist%
	\section{\hdrapplication@cite@postlabel}%
	\hdrpostpublicationlist%
}

%%--------------------
%% Underlining the author's name in bibliography
\newcommand{\hdrunderlineauthor}[2]{%
	\ifdocumentauthor{#1}{\underline{#2}}{#2}%
}

%%--------------------
%% Use the style dedicated to HDR application from SPIM-UTBM
\UseExtension{hdrapplication}

\endinput
