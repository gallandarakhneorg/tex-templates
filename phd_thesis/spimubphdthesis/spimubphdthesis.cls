% Document class for the PhD thesis of the SPIM doctoral school (UB variante)
%
% Copyright (c) 2012-17 Stephane GALLAND <galland@arakhne.org>
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
\ProvidesClass{spimubphdthesis}[2017/10/13]

%%--------------------
%% Class options
\gdef\edspimphdthesisclasslanguage{french}
\gdef\edspim@phdthesis@class@options{book,nopubpage,nodocumentinfo,frontmatter}

\DeclareOption{english}{%
	\gdef\edspimphdthesisclasslanguage{english}%
}
\DeclareOption{french}{%
	\gdef\edspimphdthesisclasslanguage{french}%
}

\DeclareOption*{%
	\xdef\edspim@phdthesis@class@options{\edspim@phdthesis@class@options,\CurrentOption}%
	}
\ProcessOptions*\relax

%%--------------------
%% Load the document style
\expandafter\LoadClass[\edspimphdthesisclasslanguage,\edspim@phdthesis@class@options]{upmethodology-document}

%%--------------------
%% Load the base package
\RequirePackage{spimbasephdthesis}

%%--------------------
%% Use the style dedicated to PhD thesis from SPIM-UB
\UseExtension{spimubphdthesis}

\endinput
