# TNT analysis

Analyse a dataset using Fitch parsimony under equal and implied weights in TNT

## Set up

- Copy the input file in TNT or NEXUS format into the `TNT` directory

- Open `tnt.run` with your favourite
  [text editor](https://notepad-plus-plus.org/downloads/)

- Enter the name of the input file in the line
  `proc ENTER_INPUT_FILENAME_HERE;`.
  For example this might end up reading `proc my_data.nex;`.

- Enter the name of the outgroup taxon in the line
  `outgroup ENTER_OUTGROUP_LABEL_HERE;`.
  For example this might end up reading `outgroup Homo_sapiens;`.

## Run analysis

### Interactively

- Download [TNT](https://www.lillo.org.ar/phylogeny/tnt/) and extract the folder
  `TNT-bin` to your computer

- Double-click the `tnt.run` file to run the script.
  If prompted to select a program with which to open the file, navigate to
  the `TNT-bin` folder you just created, and select `tnt.exe`.


### From the command line

- Download [TNT](https://www.lillo.org.ar/phylogeny/tnt/) and extract the folder
  `TNT-bin` to your computer

- Add the `TNT-bin` folder to your `PATH` system environment variable.
  - OR: copy the `tnt` executable from the `TNT-bin` directory to the `TNT`
  folder that contains this `README.md` file and `tnt.run`.

- At the command line / terminal, type `tnt tnt.run`.
