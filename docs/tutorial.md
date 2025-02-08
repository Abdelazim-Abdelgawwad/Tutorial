---
layout: default
title: "Tutorial"
nav_order: 7
permalink: Tutorial
---

<!-- easyPARM Installation and Usage Guide -->
<p align="center">
  <img src="/Tutorial/logo/easyPARM3.png" alt="easyPARM Logo" width="500"/>
</p>

# Tutorial: Parameterization of Metalloproteins

## Overview
This tutorial provides a step-by-step guide for parameterizing a metalloprotein using **Gaussian** for QM calculations. The same workflow can be applied to **ORCA** and **GAMESS** as well. The example used throughout the tutorial is **1SP2 PDB** [1SP2.pdb](/Tutorial/example/1SP2/1SP2.pdb), a protein containing a zinc atom coordinated to **two cysteines** and **two histidines** amino acids, as shown in the figure below.

## 1. Preprocessing the PDB File
After downloading the PDB file from the [Protein Data Bank](https://www.rcsb.org/), preprocessing is necessary to ensure compatibility with **easyPARM** and molecular dynamics (MD) simulations.

### 1.1 Preprocessing Tools
You can use one of the following tools:
- [H++](http://newbiophysics.cs.vt.edu/H++)
- [Protein Prepare](https://open.playmolecule.org/tools/proteinprepare)

**Important Notes:**
- **H++** may remove the metal ion or non-standard residues. After using H++, manually add the missing metal and its linked non-standard residues if necessary.
- Protonation states of **histidine** and **cysteine** may not be correct after preprocessing. Verify the PDB file and make the necessary adjustments: cysteine is labeled as CYS but should be CYM, and the same applies to histidine. 
  - **Protonated form**: [protonated.pdb](/Tutorial/example/1SP2/protonated.pdb)
  - **Deprotonated form**: [deprotonated.pdb](/Tutorial/example/1SP2/deprotonated.pdb)
- Ensure no missing atoms in the structure.

Once the structure is corrected, save the final PDB file:
- **Final metalloprotein PDB**: [final_complex.pdb](/Tutorial/example/1SP2/protonated.pdb)

## 2. Generating the XYZ Structure with easyPARM
Run **easyPARM** and select **option 2**:

```shell
Select your option:
1- Generate molecular complex parameters
2- Generate metalloprotein .xyz structure
3- Convert AMBER parameters to OpenMM or GROMACS format
Enter your choice: 2
```
```shell
Please provide the metalloprotein pdb file: final_complex.pdb

XYZ Output: initial_structure.xyz
```
This step prepares the **XYZ file** [initial_structure.xyz](/Tutorial/example/1SP2/initial_structure.xyz) required for:
- **Optimization**
- **Frequency calculations**
- **Charge calculations**

## 3. QM calculation Outputs
- Optimized structure: [OPTIMIZED.xyz](/Tutorial/example/1SP2/optimized_structure.xyz)
- Frequency calculation log: [OPT_FREQ.log](/Tutorial/example/1SP2/opt_freq.log)
- Charge calculation log: [CHARGES.log](/Tutorial/example/1SP2/charges.log)
- Formatted checkpoint file: [COMPLEX.fchk](/Tutorial/example/1SP2/complex.fchk)

## 4. Generating Molecular Parameters with easyPARM
Run **easyPARM** again and select **option 1**:

```shell
Enter your choice: 1
```

This will prompt a series of configurations:

### 4.1 AMBER Configuration
Choose how to load AMBER:
- **Option 1**: Use currently loaded AMBER
- **Option 2**: Specify AMBER installation path

Since AMBER is already loaded, select **option 1**:
```shell
Enter your choice: 1
```

### 4.2 System Charge
The tool will request the total charge of the system:
```shell
Please provide the total charge: 0
```

### 4.3 Providing the Optimized Structure for the Seminario Method
Specify the optimized **XYZ geometry file**:
```shell
Please provide the optimized XYZ geometry file: OPTIMIZED.xyz
```

### 4.4 Charge Calculation Method
Choose a method from the menu:
```shell
Select the charge calculation method:
1- GAUSSIAN (RESP charges)
2- ORCA (CHELPG charges)
3- ORCA (RESP Charges)
4- GAMESS (RESP Charges)
5- GAMESS (GAMESS Fit Charges)
Enter your choice: 1
```

### 4.5 mol2 File Generation
Select the **charge output format**:
```shell
Please select the input format:
1- Gaussian Output (.log file)
2- RESP (.gesp file)
Enter your choice: 1
```

Select the **charge method**:
```shell
Please select the charge method (recommended: RESP):
1- RESP (resp)
2- Mulliken (mul)
3- ESP (esp)
4- AM1-BCC (bcc)
Enter your choice: 1
```

Select the **atom type**:
```shell
Please select the atom type:
1- AMBER Force Field (AMBER)
2- General AMBER Force Field (GAFF)
3- General AMBER Force Field (GAFF2)
Enter your choice: 2
```

Provide the charge output file:
```shell
Please provide the charge output file (e.g., .log, .gesp): CHARGES.log
```

### 4.6 Seminario Method Setup
Select the format for the Seminario method:
```shell
Please select the format you will provide:
1- Orca Output
2- Gaussian Output
3- Gaussian Checkpoint
4- Gaussian Formatted Checkpoint
5- Gamess Output
Enter your choice: 4
```

### 4.7 Metalloprotein Structure Confirmation
```shell
Does your structure belong to MetalloProtein? (y/n): y
```

Provide the **final metalloprotein PDB file**:
```shell
Please provide the metalloprotein PDB file: final_complex.pdb
```

## 5. Output Generation
Upon completion, easyPARM generates the following files:

### 5.1 Key Outputs
- **Mol2 files** (Residues & Metal):
  - [CY1.mol2](/Tutorial/example/1SP2/CY1.mol2)
  - [CY2.mol2](/Tutorial/example/1SP2/CY2.mol2)
  - [HI1.mol2](/Tutorial/example/1SP2/HI1.mol2)
  - [HI2.mol2](/Tutorial/example/1SP2/HI2.mol2)
  - [METAL.mol2](/Tutorial/example/1SP2/METAL.mol2)
- **Force Field Parameters:** [COMPLEX.frcmod](/Tutorial/example/1SP2/COMPLEX.frcmod)
- **Metalloprotein PDB:** [easyPARM_MetalloProtein.pdb](/Tutorial/example/1SP2/easyPARM_MetalloProtein.pdb)
- **Bond Information:** [Bond_Info.dat](/Tutorial/example/1SP2/Bond_Info.dat)
- **New Atom Type Definitions:** [Hybridization_Info.dat](/Tutorial/example/1SP2/Hybridization_Info.dat)

### 5.2 Explanation of Output Files
- `Mol2` files contain molecular structures of residues and metal.
- `COMPLEX.frcmod` contains the derived force field parameters.
- `easyPARM_MetalloProtein.pdb` is the final protein structure including the metal, for use in **tleap**.
- `Hybridization_Info.dat` defines new atom types and hybridization states.
- `Bond_Info.dat` lists metal-residue bonds, which must be manually added in **tleap**.

## 6. Atomic Charge Restraint (Optional)
The tool allows you to restrain atomic charges if needed. In this case, select **No**:
```shell
Would you like to restrain the charge on specific atoms? (Yes or No): N
```

## 7. Running tleap
Once parameters are generated, you can proceed with **tleap** to prepare the final topology and coordinate files. Use the appropriate tleap input file:
- **tleap input file**: [tleap.in](/Tutorial/example/1SP2/tleap.in)

This completes the parameterization of the metalloprotein.

---

