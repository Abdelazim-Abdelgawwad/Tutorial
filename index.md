# Tutorial: Parameterizing Metalloproteins using easyPARM

Welcome to this tutorial on parameterizing metalloproteins using **easyPARM**. This guide will walk you through the steps required to set up and use easyPARM for metalloprotein parameterization.

---

## Contact Information
- **Email**: {{ site.email }}
- **University**: {{ site.university }}
- **Institute**: {{ site.institute }}
- **Research Group**: [{{ site.group }}]({{ site.group_link }})

---

## Table of Contents
1. [Introduction](#introduction)
2. [Installation](#installation)
3. [Preparing Input Files](#preparing-input-files)
4. [Running easyPARM](#running-easyparm)
5. [Analyzing Results](#analyzing-results)
6. [Conclusion](#conclusion)

---

## Introduction
Metalloproteins are proteins that contain metal ions as part of their structure. Parameterizing these proteins for molecular dynamics simulations can be challenging due to the complex interactions between the metal ions and the protein. **easyPARM** is a tool designed to simplify this process.

---

## Installation
To get started with easyPARM, follow these steps:

1. **Download easyPARM**:
   - Visit the [easyPARM GitHub repository](https://github.com/easyPARM) and download the latest release.
   
2. **Install Dependencies**:
   - Ensure you have Python 3.x installed.
   - Install the required Python packages using pip:
     ```bash
     pip install numpy scipy
     ```

3. **Set Up easyPARM**:
   - Extract the downloaded easyPARM package and add it to your system's PATH.

---

## Preparing Input Files
Before running easyPARM, you need to prepare the following input files:

- **Protein Structure File**: A PDB file of your metalloprotein.
- **Metal Ion Parameters**: A file containing the force field parameters for the metal ion.
- **Configuration File**: A YAML file specifying the simulation parameters.

[Download Example Configuration File](/Tutorial/files/config.yml)

---

## Running easyPARM
Once your input files are ready, you can run easyPARM using the following command:

```bash
easyparm config.yml
