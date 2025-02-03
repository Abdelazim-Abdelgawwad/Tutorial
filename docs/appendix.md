---
layout: default
title: "Appendix"
nav_order: 8
permalink: Appendix 
---

# <strong>Appendix</strong>

<p align="justify">

## <strong>Example for Generating the Required Files</strong>

### <strong>4.1 GAUSSIAN Input</strong>
When using Gaussian to generate the required files, note that the choice of the level of theory is up to the user and is not mandatory to match the examples provided. Follow the steps below:

### <strong>4.1.1 Structure Optimization</strong>
First, optimize the molecular structure. Upon completion, you will obtain the optimized structure in <code>.xyz</code> format. Once this step is complete, proceed to the next step.
```bash
%mem=30GB
%nproc=24
%chk=output.chk
#p B3LYP/def2tzvp symmetry=none opt scf=(MaxCycle=60,xqc)
int(ultrafinegrid) iop(7/33=1)
#Comment
charge multiplicity
coordinates
```

### <strong>4.1.2 Frequency Calculation</strong>
Use the optimized structure to perform a single-point frequency calculation. Upon completion, you will obtain the following files:
- **Optimized Structure (.xyz):** Contains the final geometry of the optimized structure.
- **Checkpoint File (.chk):** Stores data from the frequency calculation, including the Hessian matrix and other important information.
- **Gaussian Output (.log):** Contains Hessian matrix and other important information.
```bash
%mem=30GB
%nproc=24
%chk=output.chk
#p B3LYP/def2tzvp symmetry=none scf=(MaxCycle=60,xqc)
freq(noraman) int(ultrafinegrid) iop(7/33=1)
#Comment
charge multiplicity
coordinates
```

### <strong>4.1.3 Charge Calculation Using the RESP Method</strong>
Next, calculate the molecular charge using the MK method in Gaussian. This step will produce the charge output in the <code>.log</code> file.
```bash
%mem=30GB
%nproc=24
#p B3LYP/gen pseudo=read SCF=tight Pop=(mkuff) iop(6/33=2)
iop(6/42=6) iop(6/50=1)
#Comment
charge multiplicity
coordinates
C N H 0
6-31G*
****
Ru 0
SDD
****
Ru 0
SDD
output.resp
output.resp
```

### <strong>4.2 ORCA Input</strong>
When using Orca to generate the required files, the choice of the level of theory is flexible and does not need to match the examples provided. Follow the steps below:

### <strong>4.2.1 Structure Optimization</strong>
First, perform a structure optimization of the molecule. Upon successful completion, you will obtain the optimized structure in <code>.xyz</code> format. Once this step is complete, proceed to the next step.
```bash
!B3LYP 6-31G* RI-SOMF(1X) defgrid2 KDIIS TIGHTSCF Opt
%pal nprocs 24
end
%basis
NEWGTO Pt "SDD" END
NewECP Pt "SDD" end
end
%scf MaxIter 1000 end
%maxcore 5000
* xyz 1 1
Coordinates
*
```

### <strong>4.2.2 Frequency Calculation and Charge Calculation with the CHELPG or RESP Method</strong>
1. Run a Single-Point Frequency Calculation using the optimized structure.
2. **Output Files:** Upon completion, you will obtain the following files:
   - **Optimized Structure (.xyz):** Contains the final geometry of the optimized structure.
   - **Charge File (.log):** Contains the calculated charges based on the CHELPG method.
   - **Hessian File (.hess):** Contains the Hessian matrix from the frequency calculation.
   - **ESP Charge (.vpot):** Contains the calculated ESP charges based on the CHELPG method. This output can be used by easyPARM to calculate the RESP charges.
```bash
!B3LYP 6-31G* RI-SOMF(1X) defgrid1 KDIIS TIGHTSCF Freq
%pal nprocs 24
end
%basis
NEWGTO Pt "SDD" END
NewECP Pt "SDD" end
end
%scf MaxIter 1000 end
! CHELPG
%maxcore 5000
* xyz charge multiplicity
Coordinates
*
```
</p>
