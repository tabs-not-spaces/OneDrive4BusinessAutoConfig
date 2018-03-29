# OneDrive4BusinessAutoConfig
Scripts required to deploy for silent auto config of OneDrive for Business

##Getting Started
You will need to deploy the included scripts via your delivery method of choice - confirmed working is Intune and SCCM. GPO may also work.

### Prerequisites
Make sure you have the latest OneDrive for Business sync client installed - it can be groove OR the new sync client.

###Installation
Using your delivery solution of choice, simply call powershell and run each script. Execution code examples are below

```
powershell.exe -executionPolicy Bypass -file ".\EnableAdal.ps1"
```
```
powershell.exe -executionPolicy Bypass -file ".\EnableAutoConfig.ps1"
```

##Deployment Notes
EnableAdal.ps1 needs to be run in the current user context
EnableAutoConfig.ps1 needs to be run as the system account context

