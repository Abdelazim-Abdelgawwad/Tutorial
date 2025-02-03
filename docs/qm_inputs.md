---
layout: default
title: "QM Inputs"
nav_order: 8
permalink: QM Inputs 
---

<!-- easyPARM Installation and Usage Guide -->
<p align="center">
  <img src="/Tutorial/logo/easyPARM3.png" alt="easyPARM Logo" width="500"/>
</p>

# **QM inputs**

## **Example for Generating the Required Files**

## **1. GAUSSIAN Input**

### **1.1 Structure Optimization**

<p align="justify">
  First, optimize the molecular structure. Upon completion, you will obtain the optimized structure in <italic>.xyz</italic> format. Once this step is complete, proceed to the next step.

</p>

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

### **1.2 Frequency Calculation**
<p align="justify">
  Use the optimized structure to perform a single-point frequency calculation. Upon completion, you will obtain the following files:
</p>

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

## **2. ORCA Input**

### **2.1 Structure Optimization**
<p align="justify">
First, perform a structure optimization of the molecule. Upon successful completion, you will obtain the optimized structure in <italic>.xyz</italic> format. Once this step is complete, proceed to the next step.
</p>
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

## **3. GAMESS Input**

### **3.1 Structure Optimization**
<p align="justify">
First, optimize the molecular structure. Upon completion, you will obtain the optimized structure in <italic>.xyz</italic> format. Once this step is complete, proceed to the next step.
</p>
```bash
$SYSTEM MEMDDI=400 MWORDS=200 $END
$CONTRL DFTTYP=B3LYP RUNTYP=OPTIMIZE ICHARG=charge MULT=multiplicity $END
$STATPT NSTEP=1000 $END
$BASIS GBASIS=N31 NGAUSS=6 NDFUNC=1 $END
$DATA
Title
C1
coordinates
$END
```

### **3.2 Frequency Calculation**
Use the optimized structure to perform a single-point frequency calculation. Upon completion, you will obtain the following files:
- **Optimized Structure (.xyz):** Contains the final geometry of the optimized structure.
- **Gamess output (.log):** Contains frequency calculation and other important information.
- **Gamess output (.dat):** Contains Hessian matrix and other important information.
```bash
$SYSTEM MEMDDI=600 MWORDS=300 $END
$CONTRL DFTTYP=B3LYP RUNTYP=HESSIAN ICHARG=charge MULT=multiplicity SCFTYP=RHF $END
$BASIS GBASIS=N31 NGAUSS=6 NDFUNC=1 $END
$DATA
Title
C1
coordinates
$END
```

### **3.3 Charge Calculation Using the RESP or GAMESS Methods**

#### **Using RESP Method**
To calculate RESP charges, the ESP points must be obtained using the CONNOLLY option for the PTSEL keyword.
```bash
$SYSTEM MEMDDI=800 MWORDS=200 $END
$CONTRL DFTTYP=B3LYP ICHARG=charge MULT=multiplicity $END
$ELPOT IEPOT=1 WHERE=PDC $END
$PDC PTSEL=CONNOLLY CONSTR=NONE $END
$BASIS GBASIS=N31 NGAUSS=6 NDFUNC=1 $END
$DATA
Title
C1
coordinates
$END
```

#### **Using GAMESS Charge Fitting**
For GAMESS charge fitting, you can select one of the supported methods: GEODESIC, CONNOLLY, or CHELPG.
```bash
$SYSTEM MEMDDI=800 MWORDS=200 $END
$CONTRL DFTTYP=B3LYP ICHARG=charge MULT=multiplicity $END
$ELPOT IEPOT=1 WHERE=PDC $END
$PDC PTSEL=CONNOLLY CONSTR=CHARGE $END
$BASIS GBASIS=N31 NGAUSS=6 NDFUNC=1 $END
$DATA
Title
C1
coordinates
$END
```
<p align="justify">
  <strong>Note</strong> The basis set 6-31G* is suitable for metals like zinc (Zn). However, for heavier metals such as ruthenium (Ru) or platinum (Pt), it is recommended to use SBKJC or another basis set that includes an Effective Core Potential (ECP) for better accuracy.

</p>
