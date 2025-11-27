---
layout: default
title: "QM Inputs"
nav_order: 6
permalink: QM Inputs 
---

<!-- easyPARM Installation and Usage Guide -->
<p align="center">
  <img src="/Tutorial/logo/easyPARM3.png" alt="easyPARM Logo" width="500"/>
</p>

# **QM inputs**

## Note
<p align="justify">
For metalloprotein systems, users should select Option 2 in the easyPARM menu and provide the prepared metalloprotein PDB file.
This option automatically extracts the correct initial structure, which can then be used in the desired QM software for optimization, frequency, and charge calculations.
</p>  
Please refer to the tutorial section for specific instructions corresponding to your [metalloprotein case](tutorial.md).

<p align="justify"> For metal complexes, users can proceed directly with the optimization, frequency, and charge calculations on the full structure. </p>  

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
### **1.3 Charge Calculation Using the RESP Method**
Next, calculate the molecular charge using the MK method in Gaussian. This step will produce the charge output in the .log file.

```bash
%mem=30GB 
%nproc=24 #p 
B3LYP/gen pseudo=read SCF=tight Pop=(mkuff) iop(6/33=2) iop(6/42=6) iop(6/50=1)
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

### **2.2 Frequency Calculation and Charge Calculation with the CHELPG or RESP Method**
1.	Run a Single-Point Frequency Calculation using the optimized structure.
2.	Output Files: Upon completion of the calculation, you will obtain the following files:
- **Optimized Structure (.xyz)**: Contains the final geometry of the optimized structure.
- **Charge File (.log)**: Contains the calculated charges based on the CHELPG method.
- **Hessian File (.hess)**: Contains the Hessian matrix from the frequency calculation.
- **ESP charge (.vpot)**: Contains the calculated ESP charges based on the CHELPG method. This output can be used by easyPARM to calculate the RESP charges.

```bash
!B3LYP 6-31G*  RI-SOMF(1X) defgrid1 KDIIS TIGHTSCF Freq
%pal nprocs 24
end
%basis
NEWGTO  Pt "SDD" END
NewECP Pt "SDD" end
end
%scf MaxIter 1000 end
! CHELPG # You can use ! CHELPG or RESP if you have the newest version of ORCA
%maxcore 5000
* xyz charge multiplicity
Coordinates
*
````
<p align="justify"> The release of <strong>ORCA 6.0</strong> introduces built-in support for RESP charge fitting via the <code>!RESP</code> keyword. Building on this, <strong>easyPARM v4.10</strong> now allows users to select charge fitting using either <strong>CHELPG</strong> or <strong>RESP</strong> directly through ORCA, or alternatively, to provide an electrostatic potential (<code>.vpot</code>) and calculate RESP charges with easyPARM. </p> <p align="justify"> It is important to note that charges obtained from ORCA and those computed via easyPARM may differ slightly, since the fitting procedures are not identical. </p>

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
<p align="justify">
To calculate RESP charges, the ESP points must be obtained using the <strong>CONNOLLY</strong> option for the <strong>PTSEL</strong> keyword.
</p>

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
<p align="justify">
For GAMESS charge fitting, you can select one of the supported methods: <strong>GEODESIC</strong>, <strong>CONNOLLY</strong>, or <strong>CHELPG</strong>.
</p>

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
