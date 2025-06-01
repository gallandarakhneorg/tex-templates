% Copyright (c) 2013-25 Stephane GALLAND <galland@arakhne.org>
%
% UTBM logo and name are registered and owned by the
% "Universite de Technologie de Belfort-Montbeliard".
%
% UBE logo and name are registered and owned by the
% "Universite Bourgogne Europe".
%
% CIAD logo and name are registered and owned by the
% "Laboratoire Connaissance et Intelligence Artificielle Distribuées".
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
%

\NeedsTeXFormat{LaTeX2e}[1995/12/01]

\ProvidesClass{ciadbeamer}
   [2025/06/01 Class for CIAD slides]

% 1) Add the option "aspectratio=169" at the beginning of the options
% 2) Save the full list of the options into \@classoptionslist@full
\xdef\@classoptionslist@full{\@nameuse{opt@\@currname.\@currext}}
\@namedef{opt@\@currname.\@currext}{aspectratio=169,\@classoptionslist@full}

% Load the beamer class with the options
\LoadClassWithOptions{beamer}

\gdef\beamer@theme@ciad@class@babel@lang{english}

\DeclareOption*{%
	\expandafter\ifx\csname tr@ml@\CurrentOption\endcsname\relax\else%
		\xdef\beamer@theme@ciad@class@babel@lang{\CurrentOption}%
	\fi%
}
\ProcessOptions*

\expandafter\usepackage[\beamer@theme@ciad@class@babel@lang]{babel}

% Force the Beamer theme to use the original class options' list
% (See also patch of \ProcessOptionsBeamer in beamerbasethemeCIAD.sty)
\let\@classoptionslist\@classoptionslist@full
\usetheme{CIAD}
\let\@classoptionslist\beamer@filteredclassoptionslist

\endinput
