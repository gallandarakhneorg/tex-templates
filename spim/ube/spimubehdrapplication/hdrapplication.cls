%
% Copyright (c) 2013-25 Stephane GALLAND <galland@arakhne.org>
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
\ProvidesClass{hdrapplication}[2025/04/26]

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
	\Set{citeprelabel}{Publications of the PhD Thesis}%
	\Set{citepostlabel}{Publications after the PhD Thesis}%

	\Set{citelabel_ACLb}{International or national ranked journals with selection committee}%
	\Set{citelabel_ACLNb}{International or national not-ranked journals with selection committee}%
	\Set{citelabel_ASCLb}{International or national journals without selection committee}%
	\Set{citelabel_CACTIb}{International conferences with selection committee}%
	\Set{citelabel_CACTNb}{National conferences with selection committee}%
	\Set{citelabel_CCOMb}{Oral communications without proceeding in international or national conference}%
	\Set{citelabel_CAFFb}{Posters in international or national conference}%
	\Set{citelabel_DOb}{Editor of books or journals}%
	\Set{citelabel_COSb}{Chapters in scientific books}%
	\Set{citelabel_CINVb}{Keynotes in international or national conferences}%
	\Set{citelabel_THb}{Theses}%
	\Set{citelabel_BREb}{Patents}%
	\Set{citelabel_PTb}{Publications for research transfer}%
	\Set{citelabel_ORb}{Research tools}%
	\Set{citelabel_OVb}{Books for scientific culture dissemination}%
	\Set{citelabel_COVb}{Chapters in a book for scientific culture dissemination}%
	\Set{citelabel_PVb}{Papers for scientific culture dissemination}%
	\Set{citelabel_PATb}{Artistic research productions}%
	\Set{citelabel_APb}{Other productions}%
}{%
	\Set{citeprelabel}{Publications de th\`ese}
	\Set{citepostlabel}{Publications post th\`ese}

	\Set{citelabel_ACLb}{Revues internationales ou nationales class\'ees et avec comit\'e de s\'election}%
	\Set{citelabel_ACLNb}{Revues internationales ou nationales non-class\'ees et avec comit\'e de s\'election}%
	\Set{citelabel_ASCLb}{Revues internationales ou nationales sans comit\'e de s\'election}%
	\Set{citelabel_CACTIb}{Conf\'erences internationales avec comit\'e de s\'election}%
	\Set{citelabel_CACTNb}{Conf\'erences nationales avec comit\'e de s\'election}%
	\Set{citelabel_CCOMb}{Communications orales sans actes dans des conf\'erences internationales ou nationales}%
	\Set{citelabel_CAFFb}{Posters dans des conf\'erences internationales ou nationales}%
	\Set{citelabel_DOb}{\'Editeur d'ouvrages ou de revues}%
	\Set{citelabel_COSb}{Chapitres dans des ouvrages scientifiques}%
	\Set{citelabel_CINVb}{Pr\'esentations pl\'eni\`eres dans des conf\'erences internationales ou nationales}%
	\Set{citelabel_THb}{Th\`eses}%
	\Set{citelabel_BREb}{Brevets et protection de logiciels}%
	\Set{citelabel_PTb}{Publications pour le transfert de recherche}%
	\Set{citelabel_ORb}{Outils pour la recherche}%
	\Set{citelabel_OVb}{Ouvrages de vulgarisation ou de diss\'emination scientifique}%
	\Set{citelabel_COVb}{Chapitres dans des ouvrages de vulgarisation ou de diss\'emination scientifique}%
	\Set{citelabel_PVb}{Articles de diss\'emination scientifique}%
	\Set{citelabel_PATb}{Productions artistiques de recherche}%
	\Set{citelabel_APb}{Autres productions}%
}

\Set{citelabel_ACLa}{\Get{citelabel_ACLb}}
\Set{citelabel_ACLNa}{\Get{citelabel_ACLNb}}
\Set{citelabel_ASCLa}{\Get{citelabel_ASCLb}}
\Set{citelabel_CACTIa}{\Get{citelabel_CACTIb}}
\Set{citelabel_CACTNa}{\Get{citelabel_CACTNb}}
\Set{citelabel_CCOMa}{\Get{citelabel_CCOMb}}
\Set{citelabel_CAFFa}{\Get{citelabel_CAFFb}}
\Set{citelabel_DOa}{\Get{citelabel_DOb}}
\Set{citelabel_COSa}{\Get{citelabel_COSb}}
\Set{citelabel_CINVa}{\Get{citelabel_CINVb}}
\Set{citelabel_THa}{\Get{citelabel_THb}}
\Set{citelabel_BREa}{\Get{citelabel_BREb}}
\Set{citelabel_PTa}{\Get{citelabel_PTb}}
\Set{citelabel_ORa}{\Get{citelabel_ORb}}
\Set{citelabel_OVa}{\Get{citelabel_OVb}}
\Set{citelabel_COVa}{\Get{citelabel_COVb}}
\Set{citelabel_PVa}{\Get{citelabel_PVb}}
\Set{citelabel_PATa}{\Get{citelabel_PATb}}
\Set{citelabel_APa}{\Get{citelabel_APb}}

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
		\expandafter\newcites{#2}{\Get{citelabel_#2}}%
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
		\expandafter\newcites{#2}{\Get{citelabel_#2}}%
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
	\section{\Get{citeprelabel}}%
	\hdrprepublicationlist%
	\section{\Get{citepostlabel}}%
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
