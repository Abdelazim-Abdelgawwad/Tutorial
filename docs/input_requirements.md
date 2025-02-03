---
layout: default
title: "Input Requirements"
nav_order: 4
permalink: Input Requirements
---

<!-- easyPARM Installation and Usage Guide -->
<p align="center">
  <img src="/Tutorial/logo/easyPARM3.png" alt="easyPARM Logo" width="500"/>
</p>

# <strong>Input Requirements<strong>

To successfully run <strong>easyPARM<strong>, the following input files are required:

## **1. Hessian Matrix Files**
The Hessian matrix is essential for force field parameter derivation. It can be provided in one of the following formats:

- **Checkpoint File (`.chk`)**: Contains the Hessian matrix from a Gaussian frequency calculation.
- **Formatted Checkpoint File (`.fchk`)**: Similar to `.chk`, but in a human-readable format.
- **Gaussian Output File (`.log`)**: Contains the Hessian matrix from a single-point frequency calculation. Ensure the input file includes the keyword:
  
  ```
  iop(7/33=1)
  ```
  
- **Orca Output File (`.hess`)**: Stores the Hessian matrix from a single-point frequency calculation performed in Orca.
- **GAMESS Output File (`.dat`)**: Stores the Hessian matrix from a single-point frequency calculation performed in GAMESS.

## **2. Optimized Molecular Structure**
- **XYZ Format (`.xyz`)**: This file contains the optimized molecular geometry of the system.

## **3. Charge Output Files**
Charge output files contain electrostatic potential (ESP) charge distributions. Supported formats include:

- **Gaussian Charge Output**
  - **RESP Charges** (`.log`)
- **Orca Charge Output**
  - **CHELPG Charges** (`.out`)
  - **RESP Charges** (`.vpot`)
- **GAMESS Charge Output**
  - **RESP Charges** (`.dat`)
  - **GAMESS Charges** (`.log`)

These input files ensure smooth operation of **easyPARM** and accurate force field parameter derivation.

---


