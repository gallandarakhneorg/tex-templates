%
% UTBM, IRTES  and SET logos and names are registered and owned by the
% "Universite de Technology of Belfort-Montbeliard".
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

\ProvidesClass{irtesbeamer}
   [2014/01/13 v10.0 Class for IRTES slides]

\LoadClassWithOptions{beamer}

\gdef\beamer@theme@irtes@class@babel@lang{english}

\DeclareOption*{%
	\expandafter\ifx\csname tr@ml@\CurrentOption\endcsname\relax\else%
		\xdef\beamer@theme@irtes@class@babel@lang{\CurrentOption}%
	\fi%
}
\ProcessOptions*

\expandafter\usepackage[\beamer@theme@irtes@class@babel@lang]{babel}

\usetheme{IRTES}

\endinput
