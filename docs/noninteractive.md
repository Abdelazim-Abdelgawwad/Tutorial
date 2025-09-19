---
layout: default
title: "Non-Interactive Mode"
nav_order: 4
permalink: Non-Interactive Mode
---

<p align="center">
  <img src="/Tutorial/logo/easyPARM3.png" alt="easyPARM Logo" width="500"/>
</p>

# <strong>Non-Interactive Mode<strong>

## Installation

### 1. Downloading easyPARM

Ensure you have the latest version that supports non-interactive mode by cloning the repository from GitHub:

```bash
git clone https://github.com/Abdelazim-Abdelgawwad/easyPARM.git
```

### 2. Non-Interactive Mode Overview

Thanks to Floris Löffler for suggesting the implementation of a non-interactive mode, which is particularly useful when processing multiple structures to save time. The code can now run in either non-interactive or interactive mode depending on how it's submitted.

## Using Non-Interactive Mode

To use non-interactive mode, create an input configuration file with your system parameters and submit the code as shown below.

### Sample Input Configuration File

```bash
# easyPARM Input Configuration File
# Modify this template for your specific needs

# Basic Configuration
PARAMETERIZE = 1                 # Generate molecular parameters (1 = yes)
AMBER_CONFIG = 1                 # AMBER configuration (1 = loaded AMBER, 2 = AMBER path)
#AMBER_PATH = /path/to/AMBER     # For AMBER_CONFIG = 2 
CHARGE = 1                       # Total charge of the molecule
MULTIPLICITY = 1                 # Spin multiplicity of the molecule
STRUCTURE_FILE = OPTIMIZED.xyz   # Optimized molecular structure file name

# Charge Calculation Method
# 1 = RESP (GAUSSIAN), 2 = CHELPG/RESP (ORCA), 3 = RESP (ORCA), 
# 4 = RESP (GAMESS), 5 = GAMESS CHARGES, 6= PSI4 (RESP)
CHARGE_METHOD = 6

# PSI4 controls whether to run a new calculation:
#   ON  -> run calculation (not done yet)
#   OFF -> skip calculation (already done)
PSI4 = ON

# Parameters for charge calculation
# These parameters depend on your CHARGE_METHOD selection

# RESP (GAUSSIAN) specific parameters (only needed if CHARGE_METHOD = 1)
INPUT_FORMAT = 1                 # 1 = .log file, 2 = .gesp file
METHOD = 1                       # 1 = RESP, 2 = Mulliken, 3 = ESP, 4 = AM1-BCC

# Required for all charge methods
ATOM_TYPE = 3                    # 1 = AMBER, 2 = GAFF, 3 = GAFF2

#CHARGE_OUTPUT = resp_charges.dat    # Charge output file (.log, .out, .vpot, or .dat)

# Quantum Mechanics Output Format
# 1 = Orca Output, 2 = Gaussian Output, 3 = Gaussian Checkpoint, 
# 4 = Gaussian Formatted Checkpoint, 5 = Gamess Output, 6= PSI4 Output
QM_OUTPUT = 6

# QM output files based on QM_OUTPUT selection
# Uncomment the appropriate options for your QM_OUTPUT value

# GAUSSIAN_OUTPUT = output.log   # For QM_OUTPUT = 2
# ORCA_OUTPUT = output.out       # For QM_OUTPUT = 1
# ORCA_HESS = output.hess        # For QM_OUTPUT = 1
# CHK_FILE = output.chk          # For QM_OUTPUT = 3
# GAUSSIAN_CONFIG = 1            # For QM_OUTPUT = 3 (1 = loaded gaussian, 2 = GAUSSIAN PATH)
# GAUSSIAN_PATH = /path/to/g16   # For GAUSSIAN_CONFIG = 2
# FCHK_FILE = complex2.fchk      # For QM_OUTPUT = 4
# GAMESS_OUTPUT = output.dat     # For QM_OUTPUT = 5
# PSI4 SETTINGS For QM_OUTPUT = 6
# CPU = 24                       # Number of CPU cores to use
# MEMORY = 50GB                  # Amount of memory to use formats: 5GB, 500MB, 1000MB
# METHOD = B3LYP                 # Functional defaults to B3LYP
# BASIS_SET = 6-31G* ,DEF2-SVP   # Basis set specification (optional) defaults are: 6-31G* (non-metals), LANL2DZ (metals)

# Metalloprotein Configuration
METALLOPROTEIN = no              # Is this a metalloprotein? (yes/no)
# PDB_FILE = protein.pdb         # PDB file (only if METALLOPROTEIN = yes)

RESID_ID = no                    # Define residue ID? (yes/no)
# RESID_NAME = LIG               # Three-letter residue name (only if RESID_ID = yes)

# Force Field Configuration
CHARMM_FF = no                   # Generate CHARMM force field? (yes/no)

# Charge Restraints
CHARGE_RESTRAIN = no             # Apply charge restraints? (yes/no)
# NUM_ATOMS = 1                  # Number of atoms with charge restraints (only if CHARGE_RESTRAIN = yes)
# ATOM1 = 1 -0.834               # Atom number and charge value for restraint 1
# ATOM2 = 2 0.417                # Atom number and charge value for restraint 2
# CHARGE_FILE = output.vpot      # Charge file (.vpot, .log, .out, .dat)
```

Uncomment and modify the appropriate lines according to your system requirements. Once you have prepared your input file, you can run the code using one of the methods described below.

### Running the Script

#### Method 1: Direct Execution

To run `easyPARM.sh` directly:

1. Navigate to your working directory
2. Execute the script from the easyPARM directory:

```bash
../easyPARM.sh INPUT_NAME
```

> **⚠️ Important:** If any variable is missing in your input file, check the message that appears at the beginning of the execution.

#### Method 2: Using an Alias (Recommended)

To run easyPARM from any location in your terminal:

1. Create an alias by adding the following line to your `~/.bashrc` or `~/.bash_profile` file:

```bash
alias easyPARM='/full/path/to/easyPARM.sh'
```

2. Apply the changes:

```bash
source ~/.bashrc   # or source ~/.bash_profile
```

3. Now you can simply run:

```bash
easyPARM INPUT_NAME
```

## Important Notes

- If there is a problem with your input configuration, the code will automatically enter interactive mode
- If you don't provide an input file, the code will default to interactive mode
- Make sure to uncomment only the parameters relevant to your chosen configuration

For additional support, please consult the [GitHub Issues Page](https://github.com/Abdelazim-Abdelgawwad/easyPARM/issues) or contact the development team.
