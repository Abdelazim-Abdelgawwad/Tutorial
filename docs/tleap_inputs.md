---
layout: default
title: "Tleap Inputs"
nav_order: 5
permalink: Tleap Inputs
---

<!-- easyPARM Installation and Usage Guide -->
<p align="center">
  <img src="/Tutorial/logo/easyPARM3.png" alt="easyPARM Logo" width="500"/>
</p>

### Tleap Inputs
<p align="justify">
The following examples demonstrate Tleap input configurations for preparing metal complexes and metalloprotein systems using AMBER 22. These templates provide a general framework and should be tailored to your specific system.
</p>

#### **Metal Complex Input Example**
This example corresponds to complex 7 from the original article describing the code:
```bash
source leaprc.gaff
source leaprc.water.tip3p
source leaprc.protein.ff19SB
loadamberparams frcmod.ionsjc_tip3p

# Define hybridization
addAtomTypes {
 { "Ru" "Ru" "sp3" }
 { "C1" "C" "sp3" }
 { "C2" "C" "sp3" }
 { "C3" "C" "sp3" }
 { "C4" "C" "sp3" }
 { "C5" "C" "sp3" }
 { "C6" "C" "sp3" }
 { "N1" "N" "sp3" }
 { "N2" "N" "sp3" }
}

# Load force field for metal complex
loadamberparams COMPLEX.frcmod
loadoff COMPLEX.lib

# Load protein + metal complex
mol = loadpdb "HB1.pdb"

# Save vacuum files
savepdb mol HB1_vacuum.pdb
saveamberparm mol HB1_vacuum.prmtop HB1_vacuum.inpcrd

# Solvate the system
solvateoct mol TIP3PBOX 10.0
check mol charge
addions mol Na+ 0.
addions mol Cl- 0

# Save solvated files
savepdb mol HB1_solvated.pdb
saveamberparm mol HB1_solvated.prmtop HB1_solvated.inpcrd
quit
```

#### **Metalloprotein Input Example**
This example illustrates the setup for a metalloprotein system:
```bash
source leaprc.gaff
source leaprc.protein.ff19SB
source leaprc.water.tip3p
loadamberparams frcmod.ionsjc_tip3p

# Define hybridization
addAtomTypes {
 { "Zn" "Zn" "sp3" }
 { "s1" "S" "sp3" }
 { "s2" "S" "sp3" }
 { "n3" "N" "sp3" }
 { "n4" "N" "sp3" }
}

# Load force field for residues and metal
loadamberparams COMPLEX.frcmod

# Load residues and metal
CY1 = loadmol2 "CY1.mol2"
CY2 = loadmol2 "CY2.mol2"
HI1 = loadmol2 "HI1.mol2"
HI2 = loadmol2 "HI2.mol2"
mol = loadmol2 "METAL.mol2"
PRO1 = loadpdb "easyPARM_MetalloProtein.pdb"

# Define metal coordination bonds
bond PRO1.32.Zn1 PRO1.5.SG
bond PRO1.32.Zn1 PRO1.10.SG
bond PRO1.32.Zn1 PRO1.23.NE2
bond PRO1.32.Zn1 PRO1.27.NE2

# Link adjacent residues
bond PRO1.5.N PRO1.4.C
bond PRO1.5.C PRO1.6.N
bond PRO1.10.N PRO1.9.C
bond PRO1.10.C PRO1.11.N
bond PRO1.23.N PRO1.22.C
bond PRO1.23.C PRO1.24.N
bond PRO1.27.N PRO1.26.C
bond PRO1.27.C PRO1.28.N

# Save vacuum files
savepdb mol 1SP2_vacuum.pdb
saveamberparm mol 1SP2_vacuum.prmtop 1SP2_vacuum.inpcrd

# Solvate the system
solvateoct PRO1 TIP3PBOX 10.0
check PRO1 charge
addions PRO1 Cl- 0.
addions PRO1 Na+ 0.

# Save solvated files
saveamberparm PRO1 1SP2_solvated.prmtop 1SP2_solvated.inpcrd
savepdb PRO1 1SP2_solvated.pdb
quit
```

### Notes:
1. Ensure the `frcmod` and `mol2` files for your metal-containing residues are correctly generated using `easyPARM`.
2. Modify the hybridization section based on the `Hybridization_Info.dat` file.
3. Adjust metal coordination bonds according to the `Bond_Info.dat` file.
4. For solvated systems, modify the box dimensions and ion addition steps as needed.

