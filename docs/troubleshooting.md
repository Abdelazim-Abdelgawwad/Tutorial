---
layout: default
title: "Troubleshooting"
nav_order: 11
permalink: Troubleshooting 
---

<!-- easyPARM Installation and Usage Guide -->
<p align="center">
  <img src="/Tutorial/logo/easyPARM3.png" alt="easyPARM Logo" width="500"/>
</p>

# <strong>Troubleshooting<strong>

## <strong>1. Using .mol2 and .frcmod Files to Generate Libraries</strong>
<p align="justify">
When using <code>.mol2</code> and <code>.frcmod</code> files in Tleap, metals may not have their connectivity and atomic numbers correctly assigned. To avoid this issue, it is recommended to use the pre-generated <code>.lib</code> and <code>.frcmod</code> files, which include all the necessary data for proper parameterization.
</p>
Your Tleap script should include the following commands:
```bash
loadamberparams COMPLEX.frcmod
loadoff COMPLEX.lib
```
<p align="justify">
After generating the <code>prmtop</code> file, check the <code>%FLAG ATOMIC_NUMBER</code> section to ensure that the atomic numbers of metals are correctly assigned. This is particularly important for metalloproteins, as the atomic number for metals may sometimes be incorrectly recorded as <code>-1</code>.
</p>

## <strong>2. Handling Metals with High Coordination Numbers</strong>
<p align="justify">
If your system includes a metal with a coordination number greater than 8, you may encounter the following warning when generating the <code>prmtop</code> file in Tleap: 
</p>
```bash
Bond: Maximum coordination exceeded on A<Co1 23>
-- setting atoms pert=true overrides default limits
```
<p align="justify">
This warning indicates that the metal exceeds the default bond limit of 8 in AmberTools, causing some metal bonds to be omitted in the generated <code>prmtop</code> file, leading to incorrect results.
</p>
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

## <strong>3. Resolving Atom Mismatch Errors in Metalloprotein Parameterization</strong> 

If you encounter the following error while generating parameters for a metalloprotein system:  

```bash
Error processing files: Number of atoms mismatch: Structure has 91, MOL2 has 63
```  

This error occurs because the structure used during optimization, frequency, and charge calculations is incorrect—it lacks the necessary capping atom.  

### Solution:  
To fix this issue, use **Option 2** in the **easyPARM** menu to generate the correct structure. Alternatively, you can manually add the capping atom, though **Option 2** is strongly recommended for accuracy.  

## <strong>4. Error: Bad Substitution in Bash Script</strong>
<p align="justify">
When running the <code>./easyPARM</code> script, you may encounter errors like the following:
</p>

```
./01_easyPARM.sh: line 782: ${metalloprotein_choice,,}: bad substitution
./01_easyPARM.sh: line 811: ${charmm_FF,,}: bad substitution
```

<p align="justify">
This error occurs because the script is using the Bash-specific lowercase conversion operator <code>${variable,,}</code>, which is not supported in older Bash versions or other shells.
</p>

### <strong>Solution: Updating the Shebang Line</strong>
<p align="justify">
The most effective solution is to modify the shebang line at the beginning of the script to ensure it uses a compatible Bash version:
</p>

```bash
# Change this:
#!/bin/bash

# To this:
#!/usr/bin/env bash
```

<p align="justify">
This change ensures that the system will use the most appropriate version of Bash available in the environment, rather than the one specifically located at <code>/bin/bash</code>, which may be outdated.
</p>

### <strong> Alternative Solutions</strong>
<p align="justify">
If changing the shebang doesn't resolve the issue, you can try:
</p>

Upgrading your Bash version to 4.0 or newer


### <strong>Verification</strong>
<p align="justify">
After implementing the fix, the script should properly handle the case conversion for <code>metalloprotein_choice</code> and <code>charmm_FF</code> variables, allowing it to generate the CHARMM files correctly.
</p>

<p align="justify">
Confirm the fix worked by ensuring that all subsequent functionalities, such as residue name changes and parameter file generation, complete without errors.
</p>

---

## <strong>5. `sed -i` Command on macOS</strong>

<p align="justify">  
On macOS, the <code>sed</code> command always expects a backup suffix when using the <code>-i</code> option. If no suffix is provided, the command will fail. To resolve this, you must provide an empty string <code>''</code> after <code>-i</code>.  
</p>  

Incorrect usage:

```bash
sed -i "1s/.*/$first_line/" "$RUN_DIR/esp.in"
```

Correct usage (with empty string as suffix):

```bash
sed -i'' "1s/.*/$first_line/" "$RUN_DIR/esp.in"
```

<p align="justify"> ✅ This problem has been resolved in <strong>easyPARM v4.10</strong>, so there is no need to manually add the backup suffix in the latest version. </p>


``` 
This version improves clarity, flow, and formatting while making the solution more actionable. Let me know if you need further refinements! 🚀
```
