# Razor54 Overlay

This is a personal Gentoo overlay repository containing various ebuilds for packages not available in the main Gentoo repository or customized versions of existing packages. The repository is actively maintained and updated with new ebuilds as needed.

## Contents

- **Zen Browser:** Ebuilds for Zen Browser (currently in beta).
- **Brother Printer Drivers:** Ebuilds for Brother printer and scanner drivers (currently in development).
- **Other Packages:** Additional ebuilds for various software packages, including experimental and customized versions.

## Branches

- **main:** The main branch contains stable and tested ebuilds.
- **dev:** The development branch includes experimental ebuilds and those under active development (e.g., Brother printer drivers).

## Installation

To add this overlay to your Gentoo system, you can use `eselect repository` or `layman`. Here's how to do it with `eselect repository`:

`eselect repository add razor54 git https://github.com/razor54/razor54-overlay.git`


## Usage

After adding the overlay, you can install packages using Portage:

`emerge --ask <package-name>`


## Contributing

Contributions are welcome! If you find any issues or have suggestions for new ebuilds, please open an issue or submit a pull request.

## License

The ebuilds in this repository are distributed under the [BSD-3-Clause license](https://opensource.org/licenses/BSD-3-Clause).
