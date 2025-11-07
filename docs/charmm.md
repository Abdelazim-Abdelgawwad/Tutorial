---
layout: default
title: "Parameterization of Metal Complexes (CHARMM Format)"
parent: "Tutorial"
nav_order: 5
permalink: /Tutorial/charmm/
---

<!-- easyPARM Installation and Usage Guide -->
<p align="center">
  <img src="/Tutorial/logo/easyPARM3.png" alt="easyPARM Logo" width="500"/>
</p>

# Tutorial: Parameterization of Metal Complexes (CHARMM Format)

## Overview  

This tutorial provides a step-by-step guide to parameterizing a metal complex and generating CHARMM-format parameters using **Gaussian** for quantum mechanical (QM) calculations. The same workflow can be applied when using **ORCA** and **GAMESS** as quantum-chemistry software  

As an example, this tutorial uses a [**ruthenium complex**](/Tutorial/example/Ru/COMPLEX.pdb), where a ruthenium atom is coordinated by six nitrogen atoms, as illustrated in the figure below.  
<p align="center">
  <img src="/Tutorial/example/Ru/RU2.bmp" alt="Ru complex" width="200"/>
</p>

### Important Considerations  

1. The code generates CHARMM parameters based on GAFF atom types. It initially assigns a GAFF atom type and maps it to the closest equivalent in **CGenFF**, iteratively refining the assignment until it determines the most suitable CHARMM atom type.  
   
2. The code uses the atomic charges provided by the user, whether from **RESP**, **CHELPG**, or other charge derivation schemes. However, note that the **CGenFF** charge scheme is specifically designed for the CHARMM force field and is generally more accurate. Despite this, **RESP** charges have been successfully used in CHARMM-based simulations, as demonstrated in [this study](https://doi.org/10.1021/acs.jcim.0c00346).  

### Recommendation  

Before proceeding with production simulations, it is highly recommended to validate the generated parameters. A common approach is to solvate the complex and perform a long molecular dynamics (MD) simulation to check for any unexpected behavior and assess structural stability. If any issues arise, you may need to refine the parameters or contact us for further assistance.  

We have tested these parameters on two different systems, and they performed well. However, given that **the parameters have not undergone systematic validation against CGenFF benchmarks and each system is unique**, independent validation remains essential. We encourage feedback and contributions to enhance the accuracy of the tool.

## 1. QM calculation Outputs
- Optimized structure: [OPTIMIZED.xyz](/Tutorial/example/Ru/OPTIMIZED.xyz)
- Frequency calculation log: [OPT_FREQ.log](/Tutorial/example/Ru/opt_freq.log)
- Charge calculation log: [CHARGES.log](/Tutorial/example/Ru/charges.log)
- Formatted checkpoint file: [COMPLEX.fchk](/Tutorial/example/Ru/complex2.fchk)

## 2. Generating Molecular Parameters with easyPARM
Run **easyPARM** and select **option 1**:

```shell
Enter your choice: 1
```

This will prompt a series of configurations:

### 2.1 AMBER Configuration
Choose how to load AMBER:
- **Option 1**: Use currently loaded AMBER
- **Option 2**: Specify AMBER installation path

Since AMBER is already loaded, select **option 1**:
```shell
Enter your choice: 1
```

### 2.2 System Charge
The tool will request the total charge of the system:
```shell
Please provide the total charge: 2
```

### 2.3 System Multiplicity
The tool will request the multiplicity of the system:
```shell
Please provide the total multiplicity: 1
```

### 2.4 Providing the Optimized Structure for the Seminario Method
Specify the optimized **XYZ geometry file**:
```shell
Please provide the optimized XYZ geometry file: OPTIMIZED.xyz
```

### 2.4 Charge Calculation Method
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

### 2.5 mol2 File Generation
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

### 2.6 Seminario Method Setup
Select the format for the Seminario method:
```shell
Please select the format you will provide:
1- Orca Output
2- Gaussian Output
3- Gaussian Checkpoint
4- Gaussian Formatted Checkpoint
5- Gamess Output
Enter your choice: 4

You've selected Gaussian formatted checkpoint

Please provide the formatted checkpoint file (.fchk): COMPLEX.fchk

```

### 2.7 Metalloprotein Structure Confirmation
```shell
Does your structure belong to MetalloProtein? (y/n): n
```

### 2.8 Change Residue ID 
```shell
Would you like to change the residue ID (Default= mol)? (y/n): y
Please provide the residue name: LIG
```

## 3. Output Generation
Upon completion, easyPARM generates the following files:

### 3.1 Key Outputs
- **Mol2 file** :
  - [COMPLEX.mol2](/Tutorial/example/Ru2/COMPLEX.mol2)
- **Force Field Parameters:** [COMPLEX.frcmod](/Tutorial/example/Ru2/COMPLEX.frcmod)
- **MetalComplex PDB:** [COMPLEX.pdb](/Tutorial/example/Ru2/COMPLEX.pdb)
- **New Atom Type Definitions:** [Hybridization_Info.dat](/Tutorial/example/Ru2/Hybridization_Info.dat)

### 3.2 Explanation of Output Files
- **`Mol2`** file contain molecular structures of residues and metal.
- **`COMPLEX.frcmod`** contains the derived force field parameters.
- **`COMPLEX.pdb`** is the final complex structure to be inlcuded in the whole system.
- **`Hybridization_Info.dat`** defines new atom types and hybridization states.

### 3.3 CHARMM Force Field Format Generation
The tool will prompt the user to generate the parameter file in CHARMM format:
```shell
Would you like to generate the CHARMM force field format? (y/n): y
```

#### 3.3.1 CHARMM Outputs
- **Force Field Parameters:** [`COMPLEX.prm`](/Tutorial/example/Ru2/COMPLEX.prm)
- **Metal Complex PDB:** [`COMPLEX.pdb`](/Tutorial/example/Ru2/COMPLEX.pdb)
- **Topology File:** [`Complex.top`](/Tutorial/example/Ru2/COMPLEX.top)

#### 3.3.2 Explanation of Output Files
- **`COMPLEX.prm`**: Contains the derived force field parameters, including those from CGenFF and the Seminario method.
- **`COMPLEX.pdb`**: Represents the final complex structure to be included in the complete system.
- **`COMPLEX.top`**: Stores atomic charges and necessary information required for generating the PSF file.

## 4. Atomic Charge Restraint (Optional)
The tool allows you to restrain atomic charges if needed. In this case, select **No**:
```shell
Would you like to restrain the charge on specific atoms? (Yes or No): N
```

## 5. Generate the PSF

Once the CHARMM parameters are generated, you can use **VMD** to prepare the PSF files, as demonstrated below.

### 5.1 Creating the PSF File

1. Open **VMD** and load your structure file (**COMPLEX.pdb**).
2. Navigate to **Extensions → Modeling → Automatic PSF Builder**.

<div align="center">
  <img src="/Tutorial/example/Ru2/1.png" alt="VMD" width="48%" style="display: inline-block; margin-right: 2%"/>
  <img src="/Tutorial/example/Ru2/2.png" alt="VMD" width="48%" style="display: inline-block"/>
</div>

3. In the **Automatic PSF Builder** window:
   - Remove any existing topology file entries one by one.
   - Click **Add** and select the topology file **COMPLEX.top**.
   - Click **Load Input Files**.
   - Select **Guess and Split Chains Using the Current Selections**.
   - Click **Create Chains**.

<div align="center">
  <img src="/Tutorial/example/Ru2/3.png" alt="VMD" width="48%" style="display: inline-block; margin-right: 2%"/>
  <img src="/Tutorial/example/Ru2/4.png" alt="VMD" width="48%" style="display: inline-block"/>
</div>

4. This process will generate the output files:
   - [**COMPLEX_autopsf.psf**](/Tutorial/example/Ru2/COMPLEX_autopsf.psf) 
   - [**COMPLEX_autopsf.pdb**](/Tutorial/example/Ru2/COMPLEX_autopsf.pdb)

<div align="center">
  <img src="/Tutorial/example/Ru2/5.png" alt="VMD" width="400"/>
</div>

Once you have the **PSF** and **PDB** files for your complex, along with the **PSF** and **PDB** files for other components such as membranes, lipids, or proteins, you can proceed to merging them in the next step.

### 5.2 Merging the PSF Files

1. Open **VMD**.
2. Navigate to **Extensions → Modeling → Merge Structures**.

<div align="center">
  <img src="/Tutorial/example/Ru2/6.png" alt="VMD" width="400"/>
</div>

3. Load the two different structures along with their respective **PSF** and **PDB** files.
4. Select **Merge** to combine them.

**Note:** It is recommended to perform the merging step on your local computer rather than on a cluster or server to avoid performance issues.

<div align="center">
  <img src="/Tutorial/example/Ru2/7.png" alt="VMD" width="500"/>
</div>


---

