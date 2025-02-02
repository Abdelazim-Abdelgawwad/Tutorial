---
title: "Introduction"
permalink: Introduction
---

# Introduction



**easyPARM** is a computational tool designed with four key functionalities:

### 1. Force Field Parameter Derivation for Metal-Containing Systems  
<div align="justify">easyPARM derives bond-stretching and bond-angle bending force field parameters for metal-containing molecular systems using the **Seminario method**. This ensures accurate parameter generation tailored for the **AMBER** software suite, based on the Hessian matrix produced by frequency calculation in **Gaussian, Orca,** or **GAMESS** software.</div>

### 2. Force Field Parameterization for Metalloproteins  
The tool facilitates the derivation of bond-stretching and bond-angle bending force field parameters for **metalloproteins** using the **Seminario method**. This capability streamlines the integration of these parameters into **protein force fields**.

### 3. AMBER Format Conversion to GROMACS or OpenMM  
easyPARM utilizes **ParmEd** to convert **AMBER-format files** into **GROMACS** or **OpenMM** formats, facilitating compatibility with other molecular dynamics engines.

### 4. Charge Restraints with REsP Fitting  
easyPARM supports the application of **charge restraints** on specific atoms using the **Restrained Electrostatic Potential (REsP) fitting** approach. This helps achieve a more accurate electrostatic potential around the molecule while keeping the charge distribution physically meaningful.

With these capabilities, **easyPARM** is an efficient tool for accurately modeling **metal-containing systems**, ensuring both structural and electrostatic precision.

---

## Authors & License  
The **easyPARM** code was written by **Abdelazim M. A. Abdelgawwad** under the supervision of **Dr. Antonio Francés-Monerris**.  

This code (**version 3.00**) is **free software**: you can redistribute it and/or modify it under the **GNU Lesser General Public License (LGPL) Version 2.1, February 1999**.

---

## 1.1 Key Features  
- Generates parameters for **metal-containing** and **metalloprotein** systems using a combination of the **General AMBER Force Field (GAFF)** and missing parameters for bond stretching and angle bending involving **metals and coordinating atoms** using the **Seminario method**.  
- Capable of generating parameters for **entire structures in non-metal systems** using **GAFF or AMBER**.  
- Outputs essential files (**frcmod, pdb, mol2, and lib**) for initiating simulations or preparing metal-containing systems.

---

## 1.2 Citation  
If you use the **easyPARM** code, please cite the following reference:

> **Abdelgawwad AMA, Francés-Monerris A.**  
> *easyPARM: Automated, Versatile, and Reliable Force Field Parameters for Metal-Containing Molecules with Unique Labeling of Coordinating Atoms.*  
> **ChemRxiv. 2024;** doi: [10.26434/chemrxiv-2024-f8wp4](https://doi.org/10.26434/chemrxiv-2024-f8wp4)


