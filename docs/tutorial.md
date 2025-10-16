---
layout: default
title: "Tutorial"
nav_order: 10
has_children: true
permalink: Tutorial
---

<!-- easyPARM Installation and Usage Guide -->
<p align="center">
  <img src="/Tutorial/logo/easyPARM3.png" alt="easyPARM Logo" width="500"/>
</p>

# Tutorial Overview

## Welcome to easyPARM Parameterization Guide

This tutorial provides a comprehensive walkthrough of parameterization techniques for metalloprotein and metal complex systems using easyPARM.

### Parameterization Workflow

Our tutorial is structured to guide you through the essential steps of computational parameter generation:

1. **Quantum Mechanical (QM) Calculations**
   - All calculations performed using Gaussian
   - Geometry optimization and frequency calculations
   - Charges calculations

All the input examples, you can find in the QM Inputs sections. 

2. **Parameter Generation**

### Subsection Navigation

For detailed guidance, please navigate to the specific subsections:

- **Parameterization of Metal Complexes**
  - Focuses on metal complex systems
  - Detailed protocols for different metal centers
  - Ruthenium complex example

- **Parameterization of Metalloproteins**
  - Focuses on metalloprotein systems
  - 1SP2 system example
  - 1RWJ system example


### 🔹 Important Information for Metalloprotein Systems

After preparing your system following the steps described in each tutorial subsection, please review the following notes.
If your system corresponds to a **metalloprotein**, you need to consider the specific cases described below.

## [Case 1](metalloprotein.md)

If your metalloprotein contains a metal linked **only to standard residues** from the protein, use **Option 2** from the **easyPARM** menu.
This will extract the metal center along with its coordinated residues. 
Next, proceed to the **QM Input** step to perform **optimization**, **frequency**, and **charge** calculations. 

---

## Case 2

If your metalloprotein contains a metal linked to both **standard and non-standard residues**, make sure that all non-standard residues have the correct hydrogen atoms (i.e., no missing hydrogens).

1. Extract **only the non-standard residue** (without the metal).
2. Use **reduce** from **AmberTools** to add any missing hydrogens.
3. Merge the corrected non-standard residue back into the metalloprotein PDB.
4. Run **easyPARM** and select **Option 2** to extract the metal center with its coordinated residues.
5. Proceed to **QM Input** for optimization, frequency, and charge calculations.

---

## [Case 3](multimetal.md)

If your metalloprotein contains a metal that is part of a **non-standard residue** and also linked to standard residues:

1. Ensure that the non-standard residue (including the metal) has the correct hydrogen atoms.
2. Manually extract this non-standard residue with the metal.
3. AUse **reduce** from **AmberTools** to add any missing hydrogens.
4. Merge it back with the metalloprotein PDB.
5. Then use **Option 2** of the **easyPARM** menu to extract the structure for QM calculations.

---

## [Case 4](multimetal.md)

If your metalloprotein contains a metal that is part of a **non-standard residue** and is linked to both **standard and other non-standard residues**:

1. Manually extract all non-standard residues into separate files.
2. Use **reduce** to add missing hydrogens to each of them.
3. Merge them back into the metalloprotein PDB.
4. Run **easyPARM** and select **Option 2** to extract the metal center for QM calculations.

---

## Case 5

If your metalloprotein contains **multiple metals forming a cluster** (e.g., metal-metal bonds) and these metals are linked to non-standard residues:

1. If the cluster requires hydrogens, extract it and use **reduce** to add them.
2. Add hydrogens to all associated non-standard residues as well.
3. Merge the corrected residues and cluster into the metalloprotein PDB.
4. Use **Option 2** of **easyPARM** to extract the initial structure for QM calculations.

---

### Final Note

The purpose of this section is to emphasize the **importance of correctly adding hydrogens** to all **non-standard residues**, whether they directly contain a metal or are coordinated to one. Proper hydrogenation ensures accuracy in subsequent **QM calculations** and **parameter derivation**.

### Support and Guidance

**Contact Email:** abdelazim.abdelgawwad@uv.es

Please include:
- Detailed problem description
- Computational input files
- Software version information

### Best Practices

- Maintain consistency in computational methods
- Document all computational details

## Getting Started

Select the appropriate subsection that matches your research focus and begin your parameterization journey.

**Last Updated:** March 2025
