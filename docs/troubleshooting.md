---
layout: default
title: "Troubleshooting"
nav_order: 7
permalink: /docs/Troubleshooting
---

<!-- easyPARM Installation and Usage Guide -->
<p align="center">
  <img src="/Tutorial/logo/easyPARM3.png" alt="easyPARM Logo" width="500"/>
</p>

# <strong>Troubleshooting Metal Issues in Tleap</strong>

<p align="justify">

## <strong>1. Using .mol2 and .frcmod Files to Generate Libraries</strong>
When using <code>.mol2</code> and <code>.frcmod</code> files in Tleap, metals may not have their connectivity and atomic numbers correctly assigned. To avoid this issue, it is recommended to use the pre-generated <code>.lib</code> and <code>.frcmod</code> files, which include all the necessary data for proper parameterization.

Your Tleap script should include the following commands:
```bash
loadamberparams COMPLEX.frcmod
loadoff COMPLEX.lib
```
After generating the <code>prmtop</code> file, check the <code>%FLAG ATOMIC_NUMBER</code> section to ensure that the atomic numbers of metals are correctly assigned. This is particularly important for metalloproteins, as the atomic number for metals may sometimes be incorrectly recorded as <code>-1</code>.
</p>

<p align="justify">

## <strong>2. Handling Metals with High Coordination Numbers</strong>
If your system includes a metal with a coordination number greater than 8, you may encounter the following warning when generating the <code>prmtop</code> file in Tleap:
```bash
Bond: Maximum coordination exceeded on A<Co1 23>
-- setting atoms pert=true overrides default limits
```
This warning indicates that the metal exceeds the default bond limit of 8 in AmberTools, causing some metal bonds to be omitted in the generated <code>prmtop</code> file, leading to incorrect results.

<strong>Solution:</strong>
To resolve this issue, increase the maximum bond limit in the AmberTools source code:

1. Navigate to the AmberTools source directory:
   ```bash
   cd $AMBER_HOME/AmberTools/src/leap/src/leap
   ```
2. Edit the <code>atom.h</code> file to increase the bond limit. By default, the maximum number of bonds is set to 8:
   ```c
   /* maximum 8 bonds out of each atom */
   #define MAXBONDS 8
   ```
3. Change <code>8</code> to the desired number of bonds.
4. Recompile Amber to apply the changes, allowing Tleap to recognize the new <code>MAXBONDS</code> limit.

</p>

