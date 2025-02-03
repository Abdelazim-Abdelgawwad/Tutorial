---
title: "Installation"
permalink: Installation
---
<p style="font-family:Courier New, monospace; font-size:16px;">
  This paragraph is in Courier New with size 16px.
</p>

<!-- easyPARM Installation and Usage Guide -->
<p align="center">
  <img src="/Tutorial/logo/easyPARM3.png" alt="easyPARM Logo" width="500"/>
</p>

# <strong>Installation and Usage Guide</strong>

## **1. Downloading easyPARM**
To download the easyPARM code, clone the repository from GitHub using the following command:

```bash
git clone https://github.com/Abdelazim-Abdelgawwad/easyPARM.git
```
Alternatively, you can visit the repository directly: [easyPARM GitHub Repository](https://github.com/Abdelazim-Abdelgawwad/easyPARM.git).

## **2. Installation**
### **2.1 Prerequisites**
To successfully install and run easyPARM, ensure that the following prerequisites are met:

- **Python 3 or higher:** easyPARM requires Python version 3 or above to function properly. Download the latest version from the [official Python website](https://www.python.org/downloads/).

- **Required Python Packages:**
  Install the necessary dependencies by running:
  
  ```bash
  pip install periodictable scipy biopython
  ```
  
  - `periodictable`: Provides access to the periodic table of elements, essential for metal-specific calculations.
  - `scipy`: Used for various numerical computations related to force fields and molecular mechanics.
  - `biopython`: Provides tools for computational biology, which may be required for certain functionalities in easyPARM.

### **2.2 Granting Execution Permissions**
If the installation files such as `.sh` scripts (e.g., `easyPARM.sh`, `01_easyPARM.sh`, `04_parmch2_frcmod.sh`, and `readit`) do not have executable permissions, update their permissions with:

```bash
chmod +x file_name
```
Replace `file_name` with the actual script name.

## **3. Running easyPARM**
Once the installation is complete, you can run easyPARM using one of the following methods:

### **3.1 Running the Script Directly**
Navigate to the directory where easyPARM is located and execute:

```bash
./easyPARM.sh
```

### **3.2 Setting Up an Alias for Easy Access**
To run easyPARM from any location in your terminal, create an alias by adding the following line to your `~/.bashrc` or `~/.bash_profile` file:

```bash
alias easyPARM='/full/path/to/easyPARM.sh'
```

After adding the alias, apply the changes by running:

```bash
source ~/.bashrc   # or source ~/.bash_profile
```

Now, you can simply run:

```bash
easyPARM
```

from any terminal location.

## **4. Troubleshooting**
### **4.1 Checking Dependencies**
If you encounter issues related to missing packages, reinstall the required dependencies:

```bash
pip install --upgrade periodictable scipy biopython
```

### **4.2 Debugging Execution Issues**
If the scripts fail to execute:
1. Ensure they have the correct permissions:
   
   ```bash
   chmod +x easyPARM.sh
   ```
   
2. Check for missing dependencies using:
   
   ```bash
   python3 -m pip check
   ```

For additional support, please consult the [GitHub Issues Page](https://github.com/Abdelazim-Abdelgawwad/easyPARM/issues) or contact the development team.
