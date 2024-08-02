# Powertools

## Description
This project provides a set of PowerShell scripts for automating various tasks, including editing, creating new commands, and displaying help information. The scripts are organized in a modular fashion and can be executed based on the specified action.

### Benefits
* **Modular Design**: Easily extendable and maintainable due to its modular structure.
* **Automation**: Simplifies repetitive tasks, saving time and reducing errors.
* **Ease of Use**: Can be executed from anywhere by adding the scripts to the system's `Path`.
* **Customizable**: Users can add new commands and functionalities as needed.
* **Comprehensive Help**: Built-in help information for easy reference and usage.

### How it works
In this project, the terms "commands" and "scripts" refer to different aspects of the PowerShell automation setup.  

#### Commands:  
* Commands are specific actions that can be called using the powertools.ps1 script. These are defined by the -Action parameter and include run, edit, new, and help.
* Commands are essentially the high-level operations that users can request the script to execute.
* They are located under the `core/` folder.
* Examples: powertools.ps1 -Action edit or powertools.ps1 -Action new -CommandName MyCommand.

#### Scripts:  
* Scripts are the automated tasks that the user must implement. These scripts are located in the root directory and are executed based on the specified command.
* These scripts contain the detailed implementation of the tasks.
* They are located under the `scripts/` folder.
* Examples: isadmin.ps1, resetwifi.ps1, and backup.ps1 are scripts that implement specific automated tasks.

## Installation
### Requirements
* Powershell
* Visual Studio Code

### Steps
1. Clone the repository to your local machine.
2. Add the folder containing the scripts to your system's `PATH` environment variable to use the scripts from anywhere.

## Adding to PATH
1. Open the Start Search, type in "env", and select "Edit the user/system environment variables".
2. In the User/System Properties window, click on the "Environment Variables" button.
3. In the Environment Variables window, find the `Path` variable in the "System variables" section and select it. Click "Edit".
4. In the Edit Environment Variable window, click "New" and add the path to the folder containing your scripts.
5. Click "OK" to close all windows.

## Usage
The main script `powertools.ps1` accepts the following parameters:
* `-Action`: Specifies the action to perform. Some valid values are `run`, `edit`, `new`, and `help`.
* `-CommandName`: Specifies the name of the command when the `new` action is selected.

### Examples
* To create a new command: `powertools new <commandName>`
* To run a command: `powertools run <commandName>`
* To edit the folder: `powertools edit`
* To display help information: `powertools help`  
`powertools` can be replaced with `px` for a shorthand usage.

## File Structure
* Root directory : Contains user scripts and automations.
* `powertools.ps1`: Main script to execute actions.
* `core/`: Directory containing the core action commands.
* `scripts/`: Directory containing the user commands.
* `cmd-infos.json`: JSON file containing command names and descriptions.

## Miscellaneous

### Encoding
The project uses `windows1252` encoding for files. Ensure your editor is configured to use this encoding to avoid issues with special characters.

## Contributing
Feel free to submit issues or pull requests if you have suggestions or improvements.

### How to add a new core command
1. Create a new script in the `core/` directory.
2. Add the new command name to the `ValidateSet` attribute of the `$Action` parameter in the `powertools.ps1` script.
3. In the `powertools.ps1` script, add a new case for your command in the `switch` statement. Reference the new `.ps1` file that will be created in the `core/` folder.
4. Update the `cmd-infos.json` file with the new command name and description.

## License
This project is licensed under the MIT License. See the `LICENSE` file for details.
