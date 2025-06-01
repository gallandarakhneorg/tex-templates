% Document class for the HDR of the SPIM doctoral school (UBE variante)
%
% Copyright (c) 2012-25 Stephane GALLAND <galland@arakhne.org>
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
\ProvidesClass{spimubehdr}[2025/06/01]

%%--------------------
%% Class options
\newif\ifspimhdrnatbib\spimhdrnatbibtrue
\gdef\edspimhdrclasslanguage{french}
\gdef\edspim@hdr@class@options{book,nopubpage,nodocumentinfo,frontmatter}

\DeclareOption{english}{%
	\gdef\edspimhdrclasslanguage{english}%
}
\DeclareOption{french}{%
	\gdef\edspimhdrclasslanguage{french}%
}
\DeclareOption{natbib}{%
	\global\spimhdrnatbibtrue%
}
\DeclareOption{nonatbib}{%
	\global\spimhdrnatbibfalse%
}

\DeclareOption*{%
	\xdef\edspim@hdr@class@options{\edspim@hdr@class@options,\CurrentOption}%
	}
\ProcessOptions*\relax

\global\let\edspimphdthesisclasslanguage\edspimhdrclasslanguage

%%--------------------
%% Load the document style
\expandafter\LoadClass[\edspimhdrclasslanguage,\edspim@hdr@class@options]{upmethodology-document}

%%--------------------
%% Load the base package
\RequirePackage{spimbasephdthesis}

\ifspimhdrnatbib
	\RequirePackage{natbib}
\fi

%%--------------------
%% Use the style dedicated to HDR from SPIM-UBE
\UseExtension{spimubehdr}

%%--------------------
%% Force the definition for the CIAD laboratory
\newcommand{\ciadlaboratory}{%
	\resetlaboratories%
	\addlaboratory{Laboratoire Connaissance et Intelligence Artificielle Distribu\'ees (CIAD)}%
	\setlaboratorylogo{bigciadlogo}%
}

\endinput

