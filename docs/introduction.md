---
title: "Introduction"
permalink: Introduction
---
<!-- Option 2: Using relative path with baseurl -->
<p align="center">
  <img src="/Tutorial/logo/easyPARM3.png" alt="easyPARM Logo" width="400"/>
</p>

# Introduction

<strong>easyPARM</strong> is a computational tool designed with four key functionalities:  

### **1. Force Field Parameter Derivation for Metal-Containing Systems**  
<p align="justify">
easyPARM derives bond-stretching and bond-angle bending force field parameters for metal-containing molecular systems using the <strong>Seminario method</strong>. This ensures accurate parameter generation tailored for the <strong>AMBER</strong> software suite, based on the Hessian matrix produced by frequency calculation in <strong>Gaussian, Orca,</strong> or <strong>GAMESS</strong> software.
</p>  

### **2. Force Field Parameterization for Metalloproteins**  
<p align="justify">
The tool facilitates the derivation of bond-stretching and bond-angle bending force field parameters for <strong>metalloproteins</strong> using the <strong>Seminario method</strong>. This capability streamlines the integration of these parameters into <strong>protein force fields</strong>.
</p>  

### **3. AMBER Format Conversion to GROMACS or OpenMM**  
<p align="justify">
easyPARM utilizes <strong>ParmEd</strong> to convert <strong>AMBER-format files</strong> into <strong>GROMACS</strong> or <strong>OpenMM</strong> formats, facilitating compatibility with other molecular dynamics engines.
</p>  

### **4. Charge Restraints with REsP Fitting**  
<p align="justify">
easyPARM supports the application of <strong>charge restraints</strong> on specific atoms using the <strong>Restrained Electrostatic Potential (REsP) fitting</strong> approach. This helps achieve a more accurate electrostatic potential around the molecule while keeping the charge distribution physically meaningful.
</p>  

---

## **Authors & License**  
<p align="justify">
The <strong>easyPARM</strong> code was written by <strong>Abdelazim M. A. Abdelgawwad</strong> under the supervision of <strong>Dr. Antonio Francés-Monerris</strong>.  
</p>

<p align="justify">
This code (<strong>version 3.00</strong>) is <strong>free software</strong>: you can redistribute it and/or modify it under the <strong>GNU Lesser General Public License (LGPL) Version 2.1, February 1999</strong>.
</p>

---

## **1.1 Key Features**  
<p align="justify">
- Generates parameters for <strong>metal-containing</strong> and <strong>metalloprotein</strong> systems using a combination of the <strong>General AMBER Force Field (GAFF)</strong> and missing parameters for bond stretching and angle bending involving <strong>metals and coordinating atoms</strong> using the <strong>Seminario method</strong>.  

- Capable of generating parameters for <strong>entire structures in non-metal systems</strong> using <strong>GAFF or AMBER</strong>.  

-Outputs essential files (<strong>frcmod, pdb, mol2,</strong> and <strong>lib</strong>) for initiating simulations or preparing metal-containing systems.
</p>

---

## **1.2 Citation**  
<p align="justify">
If you use the <strong>easyPARM</strong> code, please cite the following reference:  
</p>

> <strong>Abdelgawwad AMA, Francés-Monerris A.</strong>  
> <em>easyPARM: Automated, Versatile, and Reliable Force Field Parameters for Metal-Containing Molecules with Unique Labeling of Coordinating Atoms.</em>  
> <strong>ChemRxiv. 2024;</strong> doi: [10.26434/chemrxiv-2024-f8wp4](https://doi.org/10.26434/chemrxiv-2024-f8wp4)
