

# easyPARM Metalloprotein Parameterization

A comprehensive guide for parameterizing metalloproteins in molecular dynamics simulations.

## Table of Contents
1. [Introduction](#introduction)
2. [Installation](#installation)
3. [Preparing Input Files](#preparing-input-files)
4. [Running easyPARM](#running-easyparm)
5. [Analyzing Results](#analyzing-results)
6. [Conclusion](#conclusion)

## Introduction

<div style="text-align: justify;">
Metalloproteins are proteins that contain metal ions as essential components of their structure. Parameterizing these proteins for molecular dynamics simulations presents unique challenges due to the complex interactions between metal ions and protein structures. <strong>easyPARM</strong> is a specialized tool designed to streamline and simplify this parameterization process.
</div>

## Installation

Follow these steps to set up easyPARM on your system:

### 1. Download easyPARM
- Visit the [easyPARM GitHub repository](https://github.com/easyPARM)
- Download the latest release
- Extract the package to your desired location

### 2. Install Dependencies
Ensure you have the following prerequisites installed:
```bash
# Install Python 3.x if not already installed
# Install required packages
pip install numpy scipy pandas matplotlib
```

### 3. Configure Environment
Add easyPARM to your system PATH:
```bash
export PATH="/path/to/easyparm:$PATH"
```

## Preparing Input Files

### Required Files
1. **Protein Structure File**
   - PDB format
   - Clean structure with proper atom naming
   - Metal ion correctly positioned

2. **Metal Ion Parameters**
   - Force field parameters
   - Bonded and non-bonded interactions
   - Coordination geometry specifications

3. **Configuration File**
   Download our example configuration:
   [Example Configuration File](files/config.yml)

## Running easyPARM

Execute easyPARM using the following command:
```bash
easyparm -c config.yml -p protein.pdb -o output/
```
