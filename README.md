# IC-Design-Scripting
This project automates the process of synthesizing and implementing verilog designs using Vivado in batch mode. It extracts relevant performance metrics, such as power consumption, timing delays, and logic utilization, and saves them in a structured CSV file for analysis. The project also detects any failure during synthesis/implementation and reports it, making sure it does not interfere with the script during performance metrics calculations.

## Detailed Explanation

### 1. Scanning and Listing Available Modules
The script first scans the `Modules` directory and lists all available modules:
```python
models = os.listdir("Modules")
```
This ensures all FPGA modules are considered for synthesis and implementation.

### 2. Creating a New Vivado Project
A new Vivado project is created in batch mode using the TCL script:
```python
os.system("vivado -mode batch -source tcl_create.tcl")
```
This initializes the FPGA design environment.

### 3. Adding Modules to the Project
Each module is added to the Vivado project using another TCL script:
```python
for mod in models:
    os.system(f"vivado -mode batch -source tcl_add.tcl -tclargs {mod}")
```
This ensures all required design files are properly included.

### 4. Running Synthesis and Implementation
For each module, synthesis and implementation are executed. Results are stored in `results/`:
```python
for filename in models:
    os.mkdir("results/" + filename[:-2])
    os.system("vivado -mode batch -source tcl_run.tcl -tclargs {}".format(filename))
```

Synthesis and implementation status is logged as follows:
```tcl
# logs the synthesis status of current module
set synth_fp [open "synth_status" w]
puts $synth_fp [get_property STATUS [get_runs synth_1]]
close $synth_fp

# logs the implementation status of the current module
set impl_fp [open "impl_status" w]
puts $impl_fp [get_property STATUS [get_runs impl_1]]
close $impl_fp
```

Errors are checked from status files:
```python
synth_file = open("synth_status", "r")
synth_status = synth_file.read().split()[-1]
if synth_status == "ERROR":
    print(f"Synthesis failed for {filename}")
    continue
```
Implementation is similarly validated.

### 5. Extracting Power, Timing, and Utilization Data
The script reads power, timing, and LUT utilization metrics from reports:
```python
file_types = ['power.txt', 'timing.txt', 'utilization.txt']
req_data = ['Total On-Chip Power', 'Data Path Delay', 'Slice LUTs']
```
For each module, it scans report files and extracts relevant numerical values:
```python
for data in data_files:
    for file in file_types:
        with open(f"results/{data}/{file}", 'r') as File:
            content = File.read()
```
Values are appended to lists for further processing.

### 6. Saving Data to CSV
The extracted values are structured in a Pandas DataFrame and saved:
```python
df = pd.DataFrame(Final_results, index=['Power', 'Delay', 'LUTs'])
df.columns = data_files
df.to_csv('Final_results.csv', index=True)
print(df)
```
This final step generates a CSV file summarizing the synthesis and implementation results.

## Output
- Results are stored in a folder named `results/`.
- A CSV file `Final_results.csv` is generated with power, delay, and LUT data.

### Resetting the workspace
If the workspace needs to be reset to the origin state (before running the script), this can be achieved using [renew_workspace](renew_workspace.ipynb)

