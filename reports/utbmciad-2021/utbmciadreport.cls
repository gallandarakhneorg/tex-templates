% Document class for the reports of the Multiagent Group
%
% Copyright (c) 2013-22 Stephane GALLAND <galland@arakhne.org>
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
\ProvidesClass{utbmciadreport}[2022/02/10]

%%--------------------
%% Global conditions
\newif\ifshowCIADlogo\showCIADlogotrue
\newif\ifshowICARTSlogo\showICARTSlogotrue
\newif\ifshowSayenslogo\showSayenslogotrue
\newif\ifshowUTBMlogo\showUTBMlogotrue
\newif\ifshowUBFClogo\showUBFClogofalse
\newif\ifshowUBFCmemberlogo\showUBFCmemberlogotrue
\newif\ifshowUTlogo\showUTlogotrue
\newif\ifshowDocRefOnFront\showDocRefOnFronttrue
\newif\ifshowDocRefOnBack\showDocRefOnBacktrue
\newif\ifshowContactOnBack\showContactOnBacktrue

%%--------------------
%% Class options
\gdef\utbmciadreportclasslanguage{english}
\gdef\utbmciad@class@options{}

\DeclareOption{english}{%
	\gdef\utbmciadreportclasslanguage{english}%
}
\DeclareOption{french}{%
	\gdef\utbmciadreportclasslanguage{french}%
}

\DeclareOption{doclogo}{\global\showCIADlogotrue}
\DeclareOption{nodoclogo}{\global\showCIADlogofalse}

\DeclareOption{ciadlogo}{\global\showCIADlogotrue}
\DeclareOption{nociadlogo}{\global\showCIADlogofalse}

\DeclareOption{icartslogo}{\global\showICARTSlogotrue}
\DeclareOption{noicartslogo}{\global\showICARTSlogofalse}

\DeclareOption{sayenslogo}{\global\showSayenslogotrue}
\DeclareOption{nosayenslogo}{\global\showSayenslogofalse}

\DeclareOption{utbmlogo}{\global\showUTBMlogotrue}
\DeclareOption{noutbmlogo}{\global\showUTBMlogofalse}

\DeclareOption{ubfclogo}{\global\showUBFClogotrue}
\DeclareOption{noubfclogo}{\global\showUBFClogofalse}

\DeclareOption{ubfcmemberlogo}{\global\showUBFCmemberlogotrue}
\DeclareOption{noubfcmemberlogo}{\global\showUBFCmemberlogofalse}

\DeclareOption{utlogo}{\global\showUTlogotrue}
\DeclareOption{noutlogo}{\global\showUTlogofalse}

\DeclareOption{docrefonfront}{\global\showDocRefOnFronttrue}
\DeclareOption{nodocrefonfront}{\global\showDocRefOnFrontfalse}

\DeclareOption{docrefonback}{\global\showDocRefOnBacktrue}
\DeclareOption{nodocrefonback}{\global\showDocRefOnBackfalse}

\DeclareOption{contactonback}{\global\showContactOnBacktrue}
\DeclareOption{nocontactonback}{\global\showContactOnBackfalse}

\DeclareOption*{%
	\xdef\utbmciad@class@options{\utbmciad@class@options,\CurrentOption}%
	}
\ProcessOptions*\relax

%%--------------------
%% Load the document style
\expandafter\LoadClass[\utbmciadreportclasslanguage\utbmciad@class@options]{upmethodology-document}

%%--------------------
%% Check for the correct version of tex-upmethodology
\@ifclasslater{UPMVERSION}{2021/07/01}{}{\@latex@error{You must install a version of tex-upmethodology greater or equal to 20210701}\@eha}

%%--------------------
%% Use the style dedicated to the report of the multiagent group
\UseExtension{utbmciad}

%%--------------------
%% Force the name of the bibliographie for French
\AtBeginDocument{
	\ifthenelse{\equal{\utbmciadreportclasslanguage}{french}}{%
		\renewcommand{\refname}{Bibliographie}%
		\renewcommand{\listtablename}{Liste des tables}%
	}{}
}

\endinput
