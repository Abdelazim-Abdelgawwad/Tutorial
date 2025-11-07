---
layout: default
title: "Parameterizing a Complex Fe4S4 Cluster in Metalloproteins (AMBER Format)"
parent: "Tutorial"
nav_order: 4
permalink:  /Tutorial/multicenter
---

<!-- easyPARM Installation and Usage Guide -->
<p align="center">
  <img src="/Tutorial/logo/easyPARM3.png" alt="easyPARM Logo" width="500"/>
</p>

# Tutorial: Parameterization of Multi-metal Metalloproteins center.

## Overview
This tutorial provides a detailed, step-by-step guide for parameterizing a **multi-metal metalloprotein** using **Gaussian** for QM calculations. The same workflow can also be applied when using **ORCA** and **GAMESS** as quantum-chemistry software. As an example, we will use [**1TV8.pdb**](/Tutorial/example/1tv8/1tv8.pdb), a protein containing a **Fe4S4 cluster** with **S-adenosylmethionine (SAM)**, as a ligand. This protein consists of a dimer, but in this tutorial, we will focus on one monomer since the procedure is identical for both. 

Note:- This tutorial can be applied to any other similar systems.

<p align="center">
  <img src="/Tutorial/example/1tv8/1TV8.bmp" alt="1TV8 protein" width="350"/>
</p>

## Parameterization Challenges and Strategy

This tutorial highlights the capabilities of **easyPARM** by demonstrating how to parameterize a complex metalloprotein structure. The main challenges include:

1. **Multi-Metal System:** The protein contains two Fe4S4 clusters in one monomer linked to the protein through cysteine residues. 
2. Non-standard residues such as **S-adenosylmethionine** (**SAM**) and **Dithiothreitol** **(DTT)** coordinate the metal.

This workflow ensures accurate force field parameters for multi-metal systems, making it easier to simulate metalloproteins with complex coordination environments.

## Important steps

To generate accurate parameters and force fields, follow each instruction carefully. 

### 1. Preprocessing the PDB File
After downloading the PDB file from the [Protein Data Bank](https://www.rcsb.org/), preprocessing is necessary to ensure compatibility with **easyPARM** and molecular dynamics (MD) simulations.

### 1.1 Preprocessing Tools
We will use the following tool:
- [H++](http://newbiophysics.cs.vt.edu/H++) to prepare the system [**1TV8.pdb**](/Tutorial/example/1tv8/1tv8.pdb). After using **H++**, you will notice that the metal and its non-standard residues are removed, leaving only standard residues in the output file [**prepared.pdb**](/Tutorial/example/1tv8/protonated.pdb).

**Important Notes:**
- Protonation states of residues linked to the metal, such as **histidine** and **cysteine**, may not be correct after preprocessing. Verify the PDB file and make necessary adjustments:
  - **Cysteine (CYS)** should be renamed **CYM**, with the hydrogen linked to sulfur (HG) removed.
  - **Protonated form**: [protonated.pdb](/Tutorial/example/1tv8/protonated.pdb)
  - **Deprotonated form**: [deprotonated.pdb](/Tutorial/example/1tv8/deprotonated.pdb)

### 1.2 Manual Preparation 
> **Warning:** This step is essential to simplify the parameterization process.

#### Step 1. 
Once you have the deprotonated PDB (and removed the second monomer, keeping only the first one), check if your metal center is coordinated to **non-standard residues**. If it does not, return to the standard *metalloprotein parameterization tutorial* [case 1](metalloprotein.md). In this example, the non-standard residues linked to the metals are **SAM** and **DTT**. Since they come from the crystal structure, their **hydrogens are missing**.  

1. [**SAM.pdb**](/Tutorial/example/1tv8/SAM.pdb)
2. [**DTT.pdb**](/Tutorial/example/1tv8/DTU.pdb)

Then, use **reduce** from AmberTools to add the missing hydrogen:
```shell
reduce -i DTT.pdb -o DTT_h.pdb
reduce -i SAM.pdb -o SAM_h.pdb
```

then add the new non-standard residues to the deprotonated PDB. 

Once you finish this step, move to step 2.

#### Step 2.

Because we have two clusters of Fe4S4 (in case of having more, repeat the same procedure), you need to visualize the deprotonated PDB to determine which non-standard residue is linked to which Fe4S4 cluster (or your metal if you have another system). In our case, after visualizing the system, it can be seen that SAM is linked to the first FE4S4, and DTT is linked to the second FE4S4 in the PDB. So now you can create two copies of the deprotonated PDB. 

For example, [Model1](/Tutorial/example/1tv8/MODEL1.pdb) and [Model2](/Tutorial/example/1tv8/MODEL2.pdb). Then you just need to keep only one cluster in each model. Therefore, 

```shell
cp deprotonated.pdb Model1.pdb 
cp deprotonated.pdb Model2.pdb 
```

Model 1 should include the first Fe4S4 cluster together with SAM, while Model 2 should include the second Fe4S4 cluster with DTT. If there are additional clusters or metal centers, create separate models so that each metal center can be parameterized independently..

> **Note:** Each file contains exactly a protein structure with one FE4S4 cluster. Do not combine multiple clusters or independent metals into a single protein file.

## Next Steps
After creating these files, proceed to the parameterization stage as described in the following section.

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
Please provide the metalloprotein pdb file: Model1.pdb, then Model2.pdb
XYZ Output: initial_structure.xyz
```
Rename the output file:
```shell
mv initial_structure.xyz initial_structure1.xyz
```

Repeat this for **Model2.pdb** to obtain:
1. [**initial_structure1.xyz**](/Tutorial/example/1tv8/initial_structure_1.xyz)
2. [**initial_structure2.xyz**](/Tutorial/example/1tv8/initial_structure_2.xyz)

After generating the initial structure file, the next steps are **Optimization**, **Frequency calculation**, and **Charge calculation**, using the desired QM software. 

WARNING. Before running any calculation, always visualize the *.xyz* file to verify that the entire structure is correct.
Ensure that all hydrogens are properly added, and confirm that no unwanted hydrogens remain on residues such as CYS, HID, or any other amino acids coordinated to the metal center. For example, after visualizing the *.xyz* file, we observed that one hydrogen attached to sulfur in DTT needed to be removed because this sulfur was coordinated to the metal.
(This correction was applied in Model2.pdb.)

Once you have confirmed that the structure is correct, proceed with the QM calculation.

---

## 3. QM Calculation Outputs
### 3.1 Model 1
- Gaussian input: [**OPT_FREQ1.com**](/Tutorial/example/1tv8/opt_complex1.com)
- Optimized structure: [**OPTIMIZED1.xyz**](/Tutorial/example/1tv8/OPTIMIZED1.xyz)
- Frequency calculation log: [**OPT_FREQ1.log**](/Tutorial/example/1tv8/opt_freq_1.log) (This file cannot be uploaded due to its excessive size)
- Charge calculation log: [**CHARGES1.log**](/Tutorial/example/1tv8/charges_1.log)
- Formatted checkpoint file: [**COMPLEX1.fchk**](/Tutorial/example/1tv8/COMPLEX1.zip) 
### 3.2 Model 2
- Gaussian input: [**OPT_FREQ2.com**](/Tutorial/example/1tv8/opt_complex2.com)
- Optimized structure: [**OPTIMIZED2.xyz**](/Tutorial/example/1tv8/OPTIMIZED2.xyz)
- Frequency calculation log: [**OPT_FREQ2.log**](/Tutorial/example/1tv8/opt_freq_3.log) (This file cannot be uploaded due to its excessive size)
- Charge calculation log: [**CHARGES2.log**](/Tutorial/example/1tv8/charges_2.log)
- Formatted checkpoint file: [**COMPLEX2.fchk**](/Tutorial/example/1tv8/COMPLEX2.zip) 

## 4. Generating Molecular Parameters with easyPARM

**Important Notes:**
1. We will parameterize each cluster one by one, starting with **Model 1**, and finishing with **Model 2**.
2. It is **highly recommended** to select the option **Change Residue ID** to assign a unique residue ID for each heme C.

Both non-interactive and interactive modes can be used. In this tutorial, the first one is used. 

The input for the non-interactive mode is available in the [non-interactive section](noninteractive.md). You will need to adapt it according to your system and your QM software. 

In our case, this is the input file [PARAM.input](/Tutorial/example/1tv8/PARAAM.input)

In this case, we need to specify the charge output, the formatted checkpoint, and the optimized structure.
We also select the Metalloprotein System and provide the Model1.pdb file.
Additionally, we assign a name for the residue, which in this example is 1FE.

## 5. Output Generation
Upon completion, easyPARM generates the following files:

### 5.1 Key Outputs
- **Mol2 files** (Residues & Metal):
  - [CY1.mol2](/Tutorial/example/1tv8/CY1.mol2)
  - [CY2.mol2](/Tutorial/example/1tv8/CY2.mol2)
  - [CY3.mol2](/Tutorial/example/1tv8/CY3.mol2)
  - [1FE.mol2](/Tutorial/example/1tv8/1FE.mol2)
- **Force Field Parameters:** [COMPLEX_1FE.frcmod](/Tutorial/example/1tv8/COMPLEX_1FE.frcmod)
- **Library:** [COMPLEX.lib](/Tutorial/example/1tv8/COMPLEX.lib)
- **Metalloprotein PDB:** [easyPARM_MetalloProtein_1FE.pdb](/Tutorial/example/1tv8/easyPARM_MetalloProtein_1FE.pdb)
- **Bond Information:** [Bond_Info_1FE.dat](/Tutorial/example/1tv8/Bond_Info_1FE.dat)
- **New Atom Type Definitions:** [Hybridization_Info_1FE.dat](/Tutorial/example/1tv8/Hybridization_Info_1FE.dat)

### 5.2 Modifications for the Next Step
Copy the PDB output file:
```shell
cp easyPARM_MetalloProtein_1FE.pdb temp.pdb
```

We first generate a copy of the PDB file created by easyPARM. Open [temp.pdb](/Tutorial/example/1tv8/temp.pdb), locate the Fe4S4 cluster corresponding to the selected residue ID (1FE), and move the metal atoms (Fe1, Fe2, Fe3 and Fe4) line to a new file:
- [**reference.pdb**](/Tutorial/example/1tv8/ref.pdb)

We do not want to keep the previous metal in temp.pdb, because we will add the new Fe4S4 cluster to parametrize it as well.

Next, open temp.pdb and Model2.pdb and copy Fe4S4 and DTT (in general, you copy the metal and its linked non-standard residue).

At this stage, we have:
1. [**temp.pdb**](/Tutorial/example/1tv8/temp.pdb): Contains protein, and second cluster with DTT.
2. [**reference.pdb**](/Tutorial/example/1tv8/ref.pdb): Contains the metal atoms (Fe1, Fe2, Fe3 and Fe4) of the first cluster.

> ⚠️ **Caution:**
> If you rerun parameterization for the same cluster, **delete all previous easyPARM outputs** first.
> The program may reuse old files and affect the new parameter generation.

For the second cluster, run `easyPARM` again using your preferred mode. In this example, we will continue with the **non-interactive mode**.

In this case, you must provide the **charge output**, the **formatted checkpoint file**, and the **optimized structure**. Since we are dealing with a metalloprotein system, select the **metalloprotein mode** and include the `temp.pdb` file. Assign a suitable residue name — here, we use **2FE**. The input used for the non-interactive mode [PARAM2.input](/Tutorial/example/1tv8/PARAAM2.input)

---

## 5. Output Generation

Upon completion, `easyPARM` produces the following key output files:

### 5.1 Key Outputs

* **Mol2 Files** (Residues & Metal):

  * [CY4.mol2](/Tutorial/example/1tv8/CY3.mol2)
  * [CY5.mol2](/Tutorial/example/1tv8/CY4.mol2)
  * [CY6.mol2](/Tutorial/example/1tv8/CY5.mol2)
  * [2FE.mol2](/Tutorial/example/1tv8/2FE.mol2)
* **Force Field Parameters:** [COMPLEX_2FE.frcmod](/Tutorial/example/1tv8/COMPLEX_2FE.frcmod)
* **Library File:** [COMPLEX.lib](/Tutorial/example/1tv8/COMPLEX.lib)
* **Metalloprotein PDB:** [easyPARM_MetalloProtein_2FE.pdb](/Tutorial/example/1tv8/easyPARM_MetalloProtein_2FE.pdb)
* **Bond Information:** [Bond_Info_2FE.dat](/Tutorial/example/1tv8/Bond_Info_2FE.dat)
* **New Atom Type Definitions:** [Hybridization_Info_2FE.dat](/Tutorial/example/1tv8/Hybridization_Info_2FE.dat)

---

After obtaining the metalloprotein PDB file generated by `easyPARM` — in this case, `easyPARM_MetalloProtein_2FE.pdb` — rename it to your final working structure:

```bash
cp easyPARM_MetalloProtein_2FE.pdb easyPARM_MetalloProtein_Final.pdb
```

Next, transfer the metal atoms (**Fe1**, **Fe2**, **Fe3**, and **Fe4**) from `reference.pdb` into the correct residue ID within `easyPARM_MetalloProtein_Final.pdb`.
Make sure that each atom is placed precisely in the same spatial position from which it was originally removed.

The resulting [easyPARM_MetalloProtein_Final.pdb](/Tutorial/example/1tv8/easyPARM_MetalloProtein_Final.pdb) is now ready to be used in **tleap**.

---

## 6. Running tleap

With all parameters prepared, proceed with **tleap** to generate the final topology (`.prmtop`) and coordinate (`.inpcrd`) files.

### **Streamlined Metalloprotein Library Integration**

The latest version of `easyPARM` supports **automatic generation of a metalloprotein library file**, which removes the need to handle multiple parameter files manually.
The generated **COMPLEX.lib** file can be directly loaded in `tleap`:

```bash
loadoff COMPLEX.lib
```

Using this approach:

* You **do not need** the `Hybridization_Info.dat` file.
* You **do not need** to load each `.mol2` file manually.
* The metalloprotein setup is now **simpler**, **faster**, and **fully automated**.

---

### **tleap Input File**

Use the following tleap input file as a reference for building your system:

* **tleap input file:** [tleap.in](/Tutorial/example/1tv8/tleap.in)

## 7. Molecular Dynamics Simulation

<p align="center">
  <img src="/Tutorial/example/1tv8/simulation.gif" alt="simulation protein" width="400"/>
</p>

---
This completes the **metalloprotein parameterization process**, ensuring that your system is correctly defined and ready for further preparation and molecular dynamics simulations.
