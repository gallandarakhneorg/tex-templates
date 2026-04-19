# Presentation

`tex-templates` is a collection of LaTeX classes and styles for writing PhD dissertations, technical reports, slides and conference articles.

## Slides

`tex-templates` provides styles for creating slides with the Beamer tool.
- ["Connaissance et Intelligence Artificielle Distribuées" research laboratory](https://ciad-lab.fr) located at the [Université de Technologie Belfort Montbéliard](http://www.utbm.fr) and the [Université Bourgogne Europe](http://www.ube.fr) [[download]](./src/presentations/ciad-2025)

## PhD Theses

`tex-templates` provides the official styles for writing a PhD thesis in the following Universities:
- [Université de Technologie Belfort Montbéliard](http://www.utbm.fr) [[download part 1]](./src/spim/shared/sty) [[download part 2]](./src/spim/shared/bst) [[download part 3]](./src/spim/utbm/spimutbmphdthesis)
- [Université Bourgogne Europe](http://www.ube.fr) [[download part 1]](./src/spim/shared/sty) [[download part 2]](./src/spim/shared/bst) [[download part 3]](./src/spim/utbm/spimubephdthesis)
- [Université Marie et Louis Pasteur](http://www.umlp.fr) [[download part 1]](./src/spim/shared/sty) [[download part 2]](./src/spim/shared/bst) [[download part 3]](./src/spim/utbm/spimumlpphdthesis)

Examples for these PhD thesis styles may be found at: http://www.ciad-lab.fr/

## French Research Supervision Accreditation

`tex-templates` provides the unofficial template for preparing a French Research Supervision Accreditation (In French: Habilitation à diriger des recherches - HDR):
- Application document for [Université Bourgogne Europe](http://www.ube.fr) [[download part 1]](./src/spim/shared/sty) [[download part 2]](./src/spim/shared/bst) [[download part 3]](./src/spim/ube/spimubehdrapplication)
- HDR report for [Université Bourgogne Europe](http://www.ube.fr) [[download part 1]](./src/spim/shared/sty) [[download part 2]](./src/spim/shared/bst) [[download part 3]](./src/spim/ube/spimubehdr)

## Technical Reports

`tex-templates` provides the official template for writing the technical reports of the [CIAD Laboratory](https://ciad-lab.fr) at the [Université de Technologie Belfort-Montbéliard](http://www.utbm.fr)

- Technical or Scientific report style [[download]](./src/reports/utbmciad-2025)

## Conference Papers

`tex-templates` provides the template for the following conferences:
- IngéDoc at the [Université de Technologie Belfort-Montbéliard](http://www.utbm.fr) [[download]](./src/papers/ingedoc) (2016)

# Installation

1. For the reports, install the [`tex-upmethodology` collection of classes and packages](http://www.arakhne.org/tex-upmethodology) (also available on CTAN, and included in the major TeX distributions)
2. Copy the content of the current directory inside one of your `texmf` directories, usually `/usr/share/texmf/tex/latex/tex-templates` or `$HOME/.texmf` on Unix operating systems.
3. Update the LaTeX databases from the command line:

```bash
$> mktexlsr
$> update-updmap --quiet
```

## Author

Prof.Dr. Stéphane GALLAND

<http://www.arakhne.org/>  
<http://www.ciad-lab.fr/galland_stephane>

## License

- **All LaTeX source code** (everything in the `src/` directory) is licensed under
  the **GNU Lesser General Public License v3.0**.
- **The university and institution logos** (in the `logos/` directory) are not free software.
  They are included with permission of the university and institution and may be redistributed
  unchanged, but may not be modified. See `logos/LICENSE.logos` for details.

