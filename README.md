# mineru-pdf-batch-runner
A Windows batch script for running MinerU on a PDF file using a specified Conda environment, with logging and error handling.
# MinerU PDF Batch Runner

A Windows batch script to run [MinerU](https://github.com/opendatalab/MinerU) on a specified PDF file.  
The script automatically activates a given Conda environment, prompts the user for a PDF file path, runs MinerU, and saves logs in the same directory as the PDF.

## Features
- Activates a Conda environment located at a custom path (`d:\MinerU` by default)
- Accepts PDF file path via user input or drag-and-drop
- Automatically sets the output folder to the PDF’s directory
- Creates a detailed log file with timestamps
- Handles errors gracefully

## Requirements
- Windows 10/11
- [Anaconda / Miniconda](https://docs.conda.io/en/latest/) installed
- MinerU installed in the target Conda environment
- `magic-pdf` CLI command available in the environment

## Usage
1. Clone this repository:
   ```bash
   git clone https://github.com/<your-username>/mineru-pdf-batch-runner.git
