---
layout: default
title: "Psi4 Support"
nav_order: 9
permalink: Psi4 Support
---

<p align="center">
  <img src="/Tutorial/logo/easyPARM3.png" alt="easyPARM Logo" width="500"/>
</p>

# <strong>Psi4 Support Mode</strong>

<p align="justify"> 
<strong>easyPARM v4.10</strong> now supports the <strong>Psi4 Open-Source Quantum Chemistry package</strong>.  
All you need is your .xyz structure file — easyPARM will handle the rest:  
<strong>geometry optimization, frequency analysis, RESP charge calculation,</strong>  
and parameter generation for your complex.  
</p>  

## <strong>Tutorial</strong>

### <strong>1. Installation</strong>

You need **Conda**, which is the easiest and most reliable way to install Psi4.  
You don’t need the full AMBER package — only **AmberTools**, which is available via Conda.  

```bash
# 1. Download miniconda
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh

# 2. Install miniconda
chmod +x Miniconda3-latest-Linux-x86_64.sh
./Miniconda3-latest-Linux-x86_64.sh

# 3. Initialize conda
source ~/miniconda3/etc/profile.d/conda.sh

# 4. Create Psi4 environment
conda create -n psi4env psi4 -c psi4

# 5. Activate environment
conda activate psi4env

# 6. Install AmberTools (only AmberTools is needed)
conda install conda-forge::ambertools

# 7. Install RESP method (Alenaizan’s implementation)
conda install resp -c psi4
conda install pytest

# 8. Install required packages
conda install periodictable biopython 
````

After installing all required packages, you are ready to run **easyPARM with Psi4 support**.

### <strong>2. Running easyPARM</strong>

It is recommended to run easyPARM in **non-interactive mode** to fully use Psi4 features.

In order to use the non-[interactive mode](noninteractive.md), check the dedicated section and prepare an input file for easyPARM.
This input must include variables related to Psi4, such as:

1. <strong>CHARGE\_METHOD</strong> and <strong>QM\_OUTPUT</strong> → set `= 6` for Psi4.
2. Additional Psi4-specific settings:

```bash
# PSI4 SETTINGS (QM_OUTPUT = 6)
CPU = 24                       # Number of CPU cores
MEMORY = 50GB                  # Memory allocation (e.g., 5GB, 500MB, 1000MB)
METHOD = B3LYP                 # Functional (default: B3LYP)
BASIS_SET = 6-31G*, DEF2-SVP   # Basis sets (default: 6-31G* for non-metals, LANL2DZ for metals)
```

A key control parameter is:

```bash
# PSI4 = ON  -> run a new calculation
# PSI4 = OFF -> skip (use existing outputs: resp_charges.dat, hessian.txt, optimized.xyz)
```

For example, if you have already run Psi4 once, you can reuse `resp_charges.dat`, `hessian.txt`, and `optimized.xyz` with `PSI4 = OFF` to avoid repeating the calculation.

### <strong>3. Execution Methods</strong>

#### <strong>Method 1 (Local)</strong>

Run directly:

```bash
/path/to/easyPARM.sh parameter.input
```

⚠️ Not recommended for large systems (may take significant time).

#### <strong>Method 2 (Cluster/PBS)</strong>

Submit via cluster scheduler (PBS example):

```bash
#!/bin/bash
#PBS -S /bin/bash
#PBS -m be
#PBS -u your_username
#PBS -N _easyPARM
#PBS -l nodes=qcexnod56:ppn=24

set -x
export HomeDir=$PBS_O_WORKDIR

# Scratch directory
export WORKDIR=/scr/your_username/${PBS_JOBID}_$JOB
export PSI_SCRATCH=$WORKDIR
mkdir -p $WORKDIR

# Activate Psi4 environment
source ~/miniconda3/etc/profile.d/conda.sh
conda activate psi4env

# Copy inputs
cp $HomeDir/your_structure.xyz $WORKDIR
cp $HomeDir/your_input $WORKDIR
cd $WORKDIR

# Run job
/path/to/easyPARM.sh your_input > $HomeDir/output.dat

# Copy results back
cp $JOB.log $HomeDir/
cp COMPLEX.* $HomeDir/
cp *.dat $HomeDir/
cp hessian.txt $HomeDir/

# Optional cleanup
#rm -rf $WORKDIR
exit
```

Modify this script according to your cluster configuration.

### <strong>4. Output Files</strong>

After completion, you will obtain both **AMBER parameter files** and **Psi4 results**:

1. `hessian.txt` – Hessian matrix (2nd derivatives of energy)
2. `resp_charges.dat` – RESP charges
3. `optimized.xyz` – Optimized geometry
4. `calculation_summary.txt` – Calculation summary (functional, basis set, CPUs, etc.)

These files can be reused with `PSI4 = OFF` to avoid recalculating.

### <strong>5. Advanced Modifications</strong>

If you are familiar with Psi4, you can modify calculation settings in **`PSI4.py`**:

The following options provide a balanced approach between computational cost and accuracy.
```python
# Psi4 calculation options
    psi4.set_options({
        'reference': 'UHF' if multiplicity > 1 else 'RHF',
        'scf_type': 'DF',
        'maxiter': 300,
        'guess': 'SAD',
        'e_convergence': 1e-8,
        'd_convergence': 1e-7,
        'g_convergence': 'GAU',
        'geom_maxiter': 300,
        'dft_nuclear_scheme': 'TREUTLER'
    })
```

Defaults use **DF method** and **GAU convergence** for balance cost and efficiency. You may adjust these parameters depending on your needs. For example, you could modify the auxiliary basis or use **GAU_TIGHT** or increase the threshold for energy and density convergence.

<p align="center">
  <strong>Please report any Psi4-related bugs — this is the first release with Psi4 support.</strong>
</p>


